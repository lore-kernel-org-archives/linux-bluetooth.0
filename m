Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKxOd-1VEvQvj-KmSzTxyAXdJtz14kGDn8Qh8LNbrhyiw@mail.gmail.com>
References: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1337591234-24919-6-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZKxOd-1VEvQvj-KmSzTxyAXdJtz14kGDn8Qh8LNbrhyiw@mail.gmail.com>
Date: Mon, 21 May 2012 13:40:27 +0200
Message-ID: <CANT-zCWa_U+0fh6de1yMvZLp4xhZfuLoiNNWdi8d93He-Sf0XA@mail.gmail.com>
Subject: Re: [PATCH obexd v0 05/12] client-doc: Replace SendFiles with SendFile
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, May 21, 2012 at 11:33 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mikel,
>
> On Mon, May 21, 2012 at 12:07 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>
>> Now that OPP sessions exist, sending multiple files can be achieved with
>> consecutive calls to SendFile. Note that within a session the pending
>> operations will be queued and sequentially executed.
>> ---
>>  doc/client-api.txt |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/doc/client-api.txt b/doc/client-api.txt
>> index 32caa17..de726a8 100644
>> --- a/doc/client-api.txt
>> +++ b/doc/client-api.txt
>> @@ -65,9 +65,9 @@ Service               org.openobex.client
>>  Interface      org.openobex.ObjectPush
>>  Object path    [variable prefix]/{session0,session1,...}
>>
>> -Methods                void SendFiles(array{string} files)
>> +Methods                void SendFile(string sourcefile)
>>
>> -                       Send one or multiple local files to the remote device.
>> +                       Send one local file to the remote device.
>>
>>                void PullBusinessCard(string targetfile)
>>
>> --
>> 1.7.7.6
>
> Perhaps it is a good idea to return the transfer object here, so the
> application can track the progress and cancel it which is the whole
> point of not having multiple files so we can do this properly.

It is a good idea indeed, but I was planning to do this in a later
patch along with the rest of the API, for example PullBusinessCard.
Most of the D-Bus interfaces will need such a transition in fact.

In addition, this change does make some sense on its own, since it
maps better to the OBEX spec. IIRC SendFiles was there to avoid
creating one session per transfer, but this is no longer a problem
once OPP is wrapped in a session type. It also allows to have a
asynchronous call, so the client can wait until the transfer is
finished.

So I can merge both changes but I would rather keep them separated, so
we can have more consistent APIs after each step.

Cheers,
Mikel
