Return-Path: <cyrus@holtmann.org>
Message-ID: <52DE99CA.8030305@gmail.com>
Date: Tue, 21 Jan 2014 11:01:14 -0500
From: Frank Praznik <frank.praznik@gmail.com>
MIME-Version: 1.0
To: David Herrmann <dh.herrmann@gmail.com>,
	Simon Wood <simon@mungewell.org>
CC: Frank Praznik <frank.praznik@oh.rr.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 0/1] HIDP: Add a special case for the Dualshock 4
References: <5ddfeed2ae259064d50f6b08eb15cf5f.squirrel@mungewell.org> <CANq1E4Ruo6C9gFbv=ZdtmVmvYC61UFW1AR+C_LVUEA3xj9iO9A@mail.gmail.com>
In-Reply-To: <CANq1E4Ruo6C9gFbv=ZdtmVmvYC61UFW1AR+C_LVUEA3xj9iO9A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 1/21/2014 03:26, David Herrmann wrote:
> Hi
>
> On Tue, Jan 21, 2014 at 3:00 AM,  <simon@mungewell.org> wrote:
>>> This adds a special case in the HIDP core for the Dualshock 4
>> controller.
>>> The controller only recognizes output reports with the report type 0x52
>> and only accepts reports sent via the ctrl channel.
>>
>> Which part of the system is 'at fault' here, is it simply the DS4 behaving
>> incorrectly or that Bluez is not picking up some data or that 'we' are
>> just the incorrect method to send the data (in the hid-sony kernel
>> driver)?
> No-one is at fault. Well, strictly speaking the DS4 is, as it has to
> accept SET_REPORT and asynchronous OUTPUT_REPORTs, but it doesn't.
> That's quite common. What we actually want is HIDP to provide to
> functions, one to call SET_REPORT and one to do the async
> OUTPUT_REPORT is currently does.
>
> I implemented this some time ago here:
>    http://cgit.freedesktop.org/~dvdhrm/linux/log/?h=hid
>
> Maybe it's time to get that merged. But that hack here is ugly and not
> the way to go.
>
> Thanks
> David
Believe me, I know that my hack is ugly :).  The raw_request 
functionality in your repo is exactly what is needed in this scenario.  
I have the Bluetooth work on the Sony driver module done, so now it's 
just a matter of waiting on if or when this gets merged.
