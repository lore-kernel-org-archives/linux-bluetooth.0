Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335783797-7430-1-git-send-email-jaganath.k@samsung.com>
References: <1335783797-7430-1-git-send-email-jaganath.k@samsung.com>
Date: Wed, 2 May 2012 15:44:03 +0300
Message-ID: <CABBYNZJOy_-t_vQ542c+t=Kht6HRHqs3jy7DR302f7M8FkCeXg@mail.gmail.com>
Subject: Re: [PATCH obexd 2/3] client: Wait for abort completion before
 Transfer.Cancel returns
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Mon, Apr 30, 2012 at 2:03 PM, Jaganath Kanakkassery
<jaganath.k@samsung.com> wrote:
> -       if (callback) {
> -               GError *err;
> +       dbus_message_unref(transfer->msg);
> +       transfer->msg = NULL;
>
> +       if (callback) {
>                err = g_error_new(OBC_TRANSFER_ERROR, -ECANCELED, "%s",
>                                                        strerror(ECANCELED));
>                callback->func(transfer, transfer->transferred, err,

This looks wrong, you should not overwrite the err if it is set as it
will leak, you probably should forward the err if not NULL or create a
new GError if abort was successful because either way we are going to
stop the transfer.

-- 
Luiz Augusto von Dentz
