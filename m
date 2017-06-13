Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Convert btsnoop-formatted btmon log
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+icZUVXZZ+SB4_NC6i9YvL7uNOvO3ajB-vCjVBbDVSVNP20Gw@mail.gmail.com>
Date: Tue, 13 Jun 2017 14:42:21 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9BBC19B7-3669-420E-BEFD-960F3B55819E@holtmann.org>
References: <CA+icZUX4hfATOSWuy4H0dcnH6yDZh4YjtnOeFhCLh5V=N1g2DQ@mail.gmail.com>
 <399DB679-8A27-4607-A93E-C62BBE727911@holtmann.org>
 <CA+icZUVXZZ+SB4_NC6i9YvL7uNOvO3ajB-vCjVBbDVSVNP20Gw@mail.gmail.com>
To: sedat.dilek@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sedat,

>>> I have applied two patches from bluetooth-next...
>>> 
>>> Bluetooth: Send HCI Set Event Mask Page 2 command only when needed
>>> Bluetooth: btbcm: Read controller features during configuration
>>> 
>>> ...against the official Debian/stretch kernel v4.9.30.
>>> 
>>> And grabbed a trace-log via 'btmon -w trace.log'.
>>> 
>>> When doing a...
>>> 
>>> btmon --read btmom-w_bcm20702_bth-next-fixed.BTSnoop-v1
>>> 
>>> ...I cannot see the lines with "Broadcom Read Controller Features".
>>> 
>>> What am I doing wrong?
>> 
>> you need a btmon from git that is capable of decoding it.
>> 
> 
> OK, I see.
> The 2nd patch is not helpful for me on Debian/stretch when I need to
> upgrade my userspace.

it also does not hurt since btmon will include it in the trace.

>> < HCI Command: Vendor (0x3f|0x006e) plen 0
>>> HCI Event: Command Complete (0x0e) plen 12
>>      Vendor (0x3f|0x006e) ncmd 1
>>        Status: Success (0x00)
>>        07 00 00 00 00 00 00 00
>> 
>> Otherwise you are just seeing this.
>> 
>>> How can I convert that BTsnoop-v1 binary log-file?
>>> Let's say ASCII.
>> 
>> btmon -r trace.log > trace.txt
>> 
> 
> Thanks, that worked.
> 
>>> More precisely I wanted to investigate if the list of local-supported
>>> HCI event commands matches/dismatches the list shown from the
>>> firmware.
>> 
> 
> Is there a general approach for this thought than using
> HCI_QUIRK_BROKEN_LOCAL_COMMANDS workaround (example patch from [1])?

That patch is just complicated and leads to tons of maintenance of USB vendor/product information. I want to avoid that as much as possible. Also declaring local commands as broken will cause other problems along the line. Essentially you degrade yourself to a Bluetooth 1.2 dongle.

Regards

Marcel

