Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334756834-19770-1-git-send-email-luiz.dentz@gmail.com>
References: <1334756834-19770-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 19 Apr 2012 11:24:11 +0200
Message-ID: <CANT-zCWLxhwuPYV8MOVHGGPLeksJjBGf-n2VTVTF1p_Fg8CTEQ@mail.gmail.com>
Subject: Re: [PATCH obexd v3] client: Remove buffer based transfer
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

<snip>

> -       g_markup_parse_context_parse(ctxt, buf, strlen(buf) - 1, NULL);
> +       g_markup_parse_context_parse(ctxt, contents, size, NULL);

I still think the removal of "-1" should be done is a separate patch,
but ok it might not very important.

<snip>

> @@ -1075,15 +1077,23 @@ int obc_session_put(struct obc_session *session, char *buf, const char *name)
>                                                        agent, NULL,
>                                                        name, NULL,
>                                                        NULL);
> -       if (transfer == NULL) {
> -               g_free(buf);
> +       if (transfer == NULL)
>                return -EIO;
> -       }
>
> -       obc_transfer_set_buffer(transfer, buf);
> +       err = obc_transfer_set_file(transfer, contents, size);
> +       if (err < 0)
> +               goto fail;
>
> -       return session_request(session, transfer, session_prepare_put,
> -                                                               NULL, NULL);
> +       err = session_request(session, transfer, session_prepare_put, NULL,
> +                                                                       NULL);
> +       if (err < 0)
> +               goto fail;

The error-handling here is wrong because session_request() already
calls obc_transfer_unregister() in case of error.

<snip>

> @@ -61,13 +61,11 @@ struct obc_transfer {
>        char *agent;            /* Transfer agent */
>        char *path;             /* Transfer path */
>        gchar *filename;        /* Transfer file location */
> +       char *tmpname;          /* Transfer temporary location */

I think we should avoid having one more name here. If we need to know
if the file needs to be removed, a bool would be enough. And we can
probably make it even without that flag, with an early call to
remove() while the file is still open.

<snip>

> -int obc_transfer_get(struct obc_transfer *transfer)
> +static int transfer_open(struct obc_transfer *transfer, int flags, mode_t mode)

Can we perhaps rename it to transfer_open_file() instead?

>  {
>        GError *err = NULL;
> -       GObexPacket *req;
> -       GObexDataConsumer data_cb;
> -       GObexFunc complete_cb;
> -       GObexResponseFunc rsp_cb = NULL;
> -
> -       if (transfer->xfer != 0)
> -               return -EALREADY;
> +       int fd;
>
> -       if (transfer->type != NULL &&
> -                       (strncmp(transfer->type, "x-obex/", 7) == 0 ||
> -                       strncmp(transfer->type, "x-bt/", 5) == 0)) {
> -               rsp_cb = get_buf_xfer_progress;
> -       } else {
> -               int fd = open(transfer->filename ? : transfer->name,
> -                               O_WRONLY | O_CREAT, 0600);
> +       if (transfer->filename != NULL) {
> +               fd = open(transfer->filename, flags, mode);
>                if (fd < 0) {
>                        error("open(): %s(%d)", strerror(errno), errno);
>                        return -errno;
>                }
> -               transfer->fd = fd;
> -               data_cb = get_xfer_progress;
> -               complete_cb = xfer_complete;
> +               goto done;

An empty line is missing before the goto, right?

> +       }
> +
> +       fd = g_file_open_tmp("obex-clientXXXXXX", &transfer->tmpname, &err);
> +       if (fd < 0) {
> +               error("g_file_open_tmp(): %s", err->message);
> +               return -EFAULT;
>        }
>
> +done:
> +       transfer->fd = fd;
> +       return fd;
> +}
> +
> +int obc_transfer_get(struct obc_transfer *transfer)
> +{
> +       GError *err = NULL;
> +       GObexPacket *req;
> +       int perr;
> +
> +       if (transfer->xfer != 0)
> +               return -EALREADY;
> +
> +       perr = transfer_open(transfer, O_WRONLY | O_CREAT, 0600);

I think we need O_TRUNC here, but that would also require a separate
patch to fix it in the original version.

<snip>

> -int obc_transfer_set_file(struct obc_transfer *transfer)
> +int obc_transfer_set_file(struct obc_transfer *transfer, const char *contents,
> +                                                               size_t size)

Minor nitpicking: shouldn't we use the <boolean, GError**> style for
this kind of functions?

I think we said we would start using it for the new APIs, so maybe
it's time to do so progressively.

>  {
> -       int fd;
> +       int err;
>        struct stat st;
>
> -       fd = open(transfer->filename, O_RDONLY);
> -       if (fd < 0) {
> -               error("open(): %s(%d)", strerror(errno), errno);
> -               return -errno;
> +       err = transfer_open(transfer, O_RDONLY, 0);
> +       if (err < 0)
> +               return err;
> +
> +       if (contents != NULL) {
> +               ssize_t w = write(transfer->fd, contents, size);

This is not going to work because of O_RDONLY. And you can't use
WRONLY either because this function is used for put operations.

In general, I think is not a good idea to get obc_transfer_set_file()
involved in this patch. This function should disappear once we open
the files during creation.

Using obc_transfer_set_contents() would be better, as you initially
suggested. But first it would be convenient to have the "v1 08/11:
client: open transfer file during creation" patch, which as was posted
in the mailing list depends on several other patches in that series,
but if you agree with this idea I can send the relevant ones again,
specially to avoid patch 07/11 which now wouldn't make sense.

Cheers,
Mikel
