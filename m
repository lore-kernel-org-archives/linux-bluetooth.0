Return-Path: <cyrus@holtmann.org>
Message-ID: <52DCA7F7.7050704@oh.rr.com>
Date: Sun, 19 Jan 2014 23:37:11 -0500
From: Frank Praznik <frank.praznik@oh.rr.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@gmail.com>,
	David Herrmann <dh.herrmann@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Simon Wood <simon@mungewell.org>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [PATCH 3/3] input: Add DualShock 4 detection
References: <1390057034-7983-1-git-send-email-szymon.janc@gmail.com> <1390057034-7983-3-git-send-email-szymon.janc@gmail.com> <CANq1E4Tm2na1zVCdeDK5ihS0fQKCpJ10P0a+pTVUmcURTqCV9A@mail.gmail.com> <1572567.ZoR782tNKQ@athlon>
In-Reply-To: <1572567.ZoR782tNKQ@athlon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 1/18/2014 10:13, Szymon Janc wrote:
> Hi,
>
> On Saturday 18 January 2014 16:05:26 David Herrmann wrote:
>> Hi
>>
>> @Simon and Frank:
>> This patch might help fix your DS4 issues.
>>
>> Cheers
>> David
> Just for clarification, this does not add DS4 support, just detection for it
> in input server. There is some problem with getting SDP records from DS4 by
> bluetoothd (works with sdptool) which prevents idev from being created.
>
> I'm working on fixing this, but no ETA yet.
>
With this and the IMTU patch I was able to get my controller paired.  I 
played around with it and from watching the traffic in btmon, there are 
still two issues that are stopping full two way communications:

1. The Dualshock 4 sends communications to the host on PSM 19, but will 
only receive packets on PSM 17.  Currently the bluetooth stack is trying 
to send data to the controller on PSM 19 so the data packets still 
aren't reaching the it.

2. The hidp layer always assigns a report type of 0xA2 (HIDP_TRANS_DATA 
| HIDP_DATA_RTYPE_OUTPUT) to every HIDP_OUTPUT_REPORT.  The Dualshock 4 
only accepts reports with type 0x52 (HIDP_TRANS_SEND_REPORT | 
HIDP_DATA_RTYPE_OUTPUT).  I was able to work around this with a kludge 
in net/bluetooth/hidp/core.c to catch the Dualshock 4 packets and use 
the value that the controller wants, but I don't think anyone wants a 
device-specific hack in a core protocol file.  Unfortunately, there 
seems to be no elegant way to work around this.
