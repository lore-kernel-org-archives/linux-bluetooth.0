Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJLgciDDAjppOYZpeQRrtX7zWyePRyg7Jr3sCGJ=9xz_g@mail.gmail.com>
References: <5069401d.e758420a.0377.6163@mx.google.com>
	<CAEd0BX9Mhz_SobzniiqXaXhEFC4gEaPfepubkY59TOpiCA+3ug@mail.gmail.com>
	<CABBYNZJLgciDDAjppOYZpeQRrtX7zWyePRyg7Jr3sCGJ=9xz_g@mail.gmail.com>
Date: Mon, 1 Oct 2012 14:35:26 +0530
Message-ID: <CAEd0BX-FANQzvTCL8WrW+YMMQNobPPMEhq1HVZrXs+r6c3k9Ng@mail.gmail.com>
Subject: Re: [PATCH] client: Add Message.MarkAsRead and Message.MarkAsDeleted
 implementation and documentation.
From: "Venkateswaran, Srinivasa Ragavan"
	<srinivasa.ragavan.venkateswaran@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 1, 2012 at 1:52 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Srinivasa,
>
> On Mon, Oct 1, 2012 at 10:14 AM, Venkateswaran, Srinivasa Ragavan
> <srinivasa.ragavan.venkateswaran@intel.com> wrote:
>> On Mon, Oct 1, 2012 at 12:33 PM,
>> <srinivasa.ragavan.venkateswaran@intel.com> wrote:
>>> From: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
>>>
>>> ---
>>>  client/map.c       |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>  client/transfer.c  |    3 +-
>>>  doc/client-api.txt |   11 +++++
>>>  3 files changed, 127 insertions(+), 2 deletions(-)
>>
>> Ignore this patch, this has a partial patch I was trying from Luiz.
>> Sorry for the mess, sent an updated one.
>>
>> -Srini.
>
> I just merged some fix last week so you would have to rebase your
> changes, but I got some suggestions:

Oh sorry, I will rebase with my updated patch after fixing the issues
mentioned below.

>
> 1. Use properties, so for setting delete/read the application should
> use SetProperty method and it can get the values with GetProperties
> and PropertyChanged to signal when the values has changed. (Note this
> may change if we add support to standard D-Bus Properties interface
> but the idea is the same just the interface change)

I'll do it as SetProperty ("read/deleted", true/false) . But I don't
see a support in MAP ('s spec) for getting a message status or being
notified for message update. If you can point me, I could do this also
and give a complete patch the Message object.

> 2. What is this filler byte and lseek for?

lseek was because, after just we write to the file, the read always
failed and I thought the position was the end of the file. I just seek
to the beginning of the file, it worked. I hope I didn't overlook
something.

> 3. We probably need to add support for non-body/apparam only PUT so we
> can pass NULL to filename. (maybe this is the reason for 2?)

For SetMessageStatus the spec mentioned that Body/End of Body,
specifying the filler byte 0x30 is mandatory. Quoting from the spec
below:
"To avoid PUT with empty Body leading to a 'delete' of the related message these
headers shall contain a filler byte. The value of this byte shall be
set to 0x30 (="0")."

If it wasn't for this, I would have updated PUT with support to empty
body. I assume, this is fine.

Thanks,
-Srini.

>
> --
> Luiz Augusto von Dentz
