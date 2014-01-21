Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5ddfeed2ae259064d50f6b08eb15cf5f.squirrel@mungewell.org>
References: <5ddfeed2ae259064d50f6b08eb15cf5f.squirrel@mungewell.org>
Date: Tue, 21 Jan 2014 09:26:59 +0100
Message-ID: <CANq1E4Ruo6C9gFbv=ZdtmVmvYC61UFW1AR+C_LVUEA3xj9iO9A@mail.gmail.com>
Subject: Re: [PATCH 0/1] HIDP: Add a special case for the Dualshock 4
From: David Herrmann <dh.herrmann@gmail.com>
To: Simon Wood <simon@mungewell.org>
Cc: Frank Praznik <frank.praznik@oh.rr.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Tue, Jan 21, 2014 at 3:00 AM,  <simon@mungewell.org> wrote:
>> This adds a special case in the HIDP core for the Dualshock 4
> controller.
>> The controller only recognizes output reports with the report type 0x52
> and only accepts reports sent via the ctrl channel.
>
> Which part of the system is 'at fault' here, is it simply the DS4 behaving
> incorrectly or that Bluez is not picking up some data or that 'we' are
> just the incorrect method to send the data (in the hid-sony kernel
> driver)?

No-one is at fault. Well, strictly speaking the DS4 is, as it has to
accept SET_REPORT and asynchronous OUTPUT_REPORTs, but it doesn't.
That's quite common. What we actually want is HIDP to provide to
functions, one to call SET_REPORT and one to do the async
OUTPUT_REPORT is currently does.

I implemented this some time ago here:
  http://cgit.freedesktop.org/~dvdhrm/linux/log/?h=hid

Maybe it's time to get that merged. But that hack here is ugly and not
the way to go.

Thanks
David

>
> I noticed that the BT HID spec notes a 'HID control' channel in the
> example descriptor in table 5.3.3 as 'Parameter 0'.
>
> The DS4 gives this in it's SDP report
> --
>         Attribute 0x0004 - ProtocolDescriptorList
>                 Sequence
>                         Sequence
>                                 UUID16 0x0100 - L2CAP
>                                 UINT16 0x0011 <---------- 'HDI Control' PSM 17
>                         Sequence
>                                 UUID16 0x0011 - HIDP
> --
>
> Shouldn't Bluez be remembering this and sending accesses to this PSM in
> the appropriate mode?
>
> Just looking to fix the problem where it really exists, without just
> working around specifically for the DS4.
>
> Simon
>
>
