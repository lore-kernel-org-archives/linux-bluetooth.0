Return-Path: <cyrus@holtmann.org>
From: Lu Ran <hephooey@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: New Broadcom chip in W510
Date: Fri, 19 Nov 2010 01:08:24 -0500
References: <201009190926.51131.hephooey@gmail.com>
In-Reply-To: <201009190926.51131.hephooey@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201011190108.24344.hephooey@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have made some progress today, appearently 28 is ENOSPC, meaning the usb 
host controller does not have enough bandwidth for the device. Indeed when I 
unplug my usb mouse I can have playback (mic is still missing with ENOSPC). Is 
there a way to reduce the package size from btusb, the mouse is the only 
device I can remove, there are a internal camera and figure print reader always 
connected.

-- 
Best Regards,
LR

On Sunday 19 September 2010 09:26:51 Lu Ran wrote:
> Hi all,
> 
> I am having trouble to make my headset work in my new W510, it works fine
> in an T61, with has almost identical software and setup with the new W510.
> The only difference is I am now using a pure 64 bit system, while the old
> T61 is a 32 bit one, and the bluetooth chip is different. the id of the
> chip in T61 is 0A5C:2110, while W510 has a chip from Broadcom with id
> 0A5C:217F. I noticed there is a SCO fix for 0A5C:2110 in btusb.c. I tried
> to copy the line and change the id to 0A5C:217F, but nothing changes. The
> headset can pair with the laptop with no problem, but there seems to be no
> data transmition. And I get a lot error messages in dmesg output like
> this:
> 
> btusb_submit_isoc_urb: hci0 urb ffff880060136e00 submission failed (28)
> 
> and
> 
> btusb_send_frame: hci0 urb ffff8801320e1a00 submission failed
> 
> the output of "hciconfig hci0 version" is
> 
> hci0:   Type: BR/EDR  Bus: USB
>         BD Address: 70:F3:95:34:2F:29  ACL MTU: 1021:8  SCO MTU: 64:8
>         HCI Version: 2.1 (0x4)  Revision: 0x168
>         LMP Version: 2.1 (0x4)  Subversion: 0x4203
>         Manufacturer: Broadcom Corporation (15)
> 
> And the output of "lsusb -v" is in the attachment. I will try to provide
> any other information you need to analyse the problem.
