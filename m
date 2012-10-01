Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAEd0BX-FANQzvTCL8WrW+YMMQNobPPMEhq1HVZrXs+r6c3k9Ng@mail.gmail.com>
References: <5069401d.e758420a.0377.6163@mx.google.com>
	<CAEd0BX9Mhz_SobzniiqXaXhEFC4gEaPfepubkY59TOpiCA+3ug@mail.gmail.com>
	<CABBYNZJLgciDDAjppOYZpeQRrtX7zWyePRyg7Jr3sCGJ=9xz_g@mail.gmail.com>
	<CAEd0BX-FANQzvTCL8WrW+YMMQNobPPMEhq1HVZrXs+r6c3k9Ng@mail.gmail.com>
Date: Mon, 1 Oct 2012 13:04:01 +0300
Message-ID: <CABBYNZ+a78oE5OviAC47h71FhtKW9zZxK1zONEn9QC3-bqByNg@mail.gmail.com>
Subject: Re: [PATCH] client: Add Message.MarkAsRead and Message.MarkAsDeleted
 implementation and documentation.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Venkateswaran, Srinivasa Ragavan"
	<srinivasa.ragavan.venkateswaran@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 1, 2012 at 12:05 PM, Venkateswaran, Srinivasa Ragavan
<srinivasa.ragavan.venkateswaran@intel.com> wrote:
>> 1. Use properties, so for setting delete/read the application should
>> use SetProperty method and it can get the values with GetProperties
>> and PropertyChanged to signal when the values has changed. (Note this
>> may change if we add support to standard D-Bus Properties interface
>> but the idea is the same just the interface change)
>
> I'll do it as SetProperty ("read/deleted", true/false) . But I don't
> see a support in MAP ('s spec) for getting a message status or being
> notified for message update. If you can point me, I could do this also
> and give a complete patch the Message object.

Yep, it is not in the spec, but it doesn't mean we should not have
support for getting updates asynchronously as signals because
different processes can change the properties and in future if this is
added in the spec we already have support for them, besides it is
consistent with overall use of properties.

>> 2. What is this filler byte and lseek for?
>
> lseek was because, after just we write to the file, the read always
> failed and I thought the position was the end of the file. I just seek
> to the beginning of the file, it worked. I hope I didn't overlook
> something.

Yep, it is actually a bug so could you please have it in a separate patch?

>> 3. We probably need to add support for non-body/apparam only PUT so we
>> can pass NULL to filename. (maybe this is the reason for 2?)
>
> For SetMessageStatus the spec mentioned that Body/End of Body,
> specifying the filler byte 0x30 is mandatory. Quoting from the spec
> below:
> "To avoid PUT with empty Body leading to a 'delete' of the related message these
> headers shall contain a filler byte. The value of this byte shall be
> set to 0x30 (="0")."
>
> If it wasn't for this, I would have updated PUT with support to empty
> body. I assume, this is fine.

Yep, very strange requirement to be honest but I guess the author was
afraid the OBEX parser would trigger delete of the message if no body
was found, anyway sending 0x30 is mandatory so we should include as
you did. Still I think the proper way to support this is to have
obc_transfer_put supporting NULL filename, in that case the caller
need to provide the contents which should be stored in a temporary
which is automatically removed (transfer_open already takes care of
this).


-- 
Luiz Augusto von Dentz
