Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLS_X0NuV6znpq0MYC0eKexKSR=oZ+ZtzG6Jx8uAVsEhg@mail.gmail.com>
References: <1334668699-18194-1-git-send-email-luiz.dentz@gmail.com>
	<CANT-zCUwerRVk4YJ2E58B8p-YvO2qUhBRV=WbMTp+o9Nz3_WEQ@mail.gmail.com>
	<CABBYNZLS_X0NuV6znpq0MYC0eKexKSR=oZ+ZtzG6Jx8uAVsEhg@mail.gmail.com>
Date: Wed, 18 Apr 2012 09:09:36 +0200
Message-ID: <CANT-zCU8Q=QP+=C9GDEoiyyWLNZKy35us1CAYmwyyBC0WgcvtA@mail.gmail.com>
Subject: Re: [PATCH obexd v2] client: Remove buffer based transfer
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Apr 17, 2012 at 4:44 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mikel,
>
> On Tue, Apr 17, 2012 at 4:51 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> Hi Luiz,
>>
>> On Tue, Apr 17, 2012 at 3:18 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> Simplify the code by using temporary files and eliminates reallocations.
>>> ---
>>> v2: Remove DEFAULT_BUFFER_SIZE define
>>>
>>>  client/ftp.c      |    8 +-
>>>  client/manager.c  |   18 +++-
>>>  client/map.c      |    9 +-
>>>  client/pbap.c     |   43 ++++++---
>>>  client/session.c  |   60 +++++++++----
>>>  client/session.h  |    5 +-
>>>  client/sync.c     |   35 +++++---
>>>  client/transfer.c |  247 +++++++++++++++++------------------------------------
>>
>> Would it be possible to split this cleanup in transfer.c into a separate patch?
>
> You mean first introduce the temporary file then remove buffer based?
> They probably conflict since the API needs changing thus affecting the
> rest.

OK if it's too difficult let's make it simple.

>
>>> +       g_markup_parse_context_parse(ctxt, contents, size, NULL);
>>
>> Is this exactly equivalent or are we fixing a bug here?
>
> They are equivalent, just saving some cpu cycles.

I still don't understand how strlen(buf)-1==size. There seems to be a
difference of -1.

>
>>> -       capabilities = obc_session_get_buffer(session, &size);
>>> -       if (size == 0)
>>> -               capabilities = "";
>>> +       perr = obc_session_get_contents(session, &contents, &size);
>>
>> I propose we rename this function to obc_session_read_contents(). This
>> makes it clearer what's going on, and it's less confusing when you
>> free the memory some lines later.
>
> This was name after g_file_get_contents which I was planning to use
> but dropped in the end.

Fair enough.

>>> -       buf = obc_session_get_buffer(session, &size);
>>> -       if (size == 0)
>>> -               buf = "";
>>> +       obc_session_get_contents(session, &contents, &size);
>>
>> We need to check for errors here.
>
> Yep, gonna fix it.
>
>
>>> -       return pull_vcard_listing(pbap, message, "", pbap->order, "",
>>> +       return pull_vcard_listing(pbap, message, NULL, pbap->order, "",
>>>                                ATTRIB_NAME, DEFAULT_COUNT, DEFAULT_OFFSET);
>>
>> How does this change relate to the patch?
>
> Its unrelated, gonna fix them.
>
>>> -int obc_session_put(struct obc_session *session, char *buf, const char *name)
>>> +int obc_session_put(struct obc_session *session, const char *buf, const char *name)
>>>  {
>>> +       char tmpname[] = { '/', 't', 'm', 'p', '/', 'o', 'b', 'e', 'x', '-',
>>> +                       'c', 'l', 'i', 'e', 'n', 't', 'X', 'X', 'X', 'X', 'X',
>>> +                       'X', '\0' };
>>
>> Is this a common approach? I would rather g_strdup from a #define.
>
> Well this avoid allocation and is suggested in the documentation.

In any case, we're also using mkstemp in transfer.c so it should be consistent.

>
>>>        struct obc_transfer *transfer;
>>>        const char *agent;
>>> +       int fd, err;
>>>
>>> -       if (session->obex == NULL) {
>>> -               g_free(buf);
>>> +       if (session->obex == NULL)
>>>                return -ENOTCONN;
>>> +
>>> +       fd = mkstemp(tmpname);
>>> +       if (fd < 0) {
>>> +               error("mkstemp(): %s(%d)", strerror(errno), errno);
>>> +               return -errno;
>>> +       }
>>
>> Can't we move this whole temporary-file creating code to transfer.c? I
>> would propose that, if an empty name is given to a transfer, it
>> automatically creates a file. Otherwise we have code duplication.
>
> It can be done, but note that this requires changes on transfer API to
> take the buffer to be copied to the temporary file, maybe I can create
> obc_transfer_set_contents as a counterpart of get_contents.

I don't like the idea of obc_transfer_set_contents too much.
obc_session_put will probably disappear once we move to the new D-Bus
API, so we shouldn't change the transfer API if possible.

As I said, couldn't we just use mkstemp internally in
obc_transfer_register when no name has been given? The resulting name
would be exposed through obc_transfer_get_filename(), and we could
open that file in obc_session_put(). This would require a patch
similar to what I proposed last week, "client: open transfer file
during creation".

By the way, I don't see why the new member "tmpname" is needed inside
obc_transfer. I would rather use "filename" always.

>
>>> +       if (lseek(transfer->fd, 0, SEEK_SET) < 0) {
>>> +               error("lseek(): %s(%d)", strerror(errno), errno);
>>> +               return -errno;
>>> +       }
>>> +
>>> +       *contents = g_malloc0(st.st_size + 1);
>>
>> Better use g_malloc instead and then manually add the final 0. Why
>> waste CPU cycles.
>
> This may not used only for text data, map messages being an example of that.

You are going to overwrite the buffer (except the last byte) during
read(), so you don't need to fill the buffer with zeros. There's no
difference if the buffer contains text or not.

>>> +
>>> +       if (read(transfer->fd, *contents, st.st_size) < 0) {
>>> +               error("read(): %s(%d)", strerror(errno), errno);
>>> +               g_free(*contents);
>>> +               return -errno;
>>> +       }

Cheers,
Mikel
