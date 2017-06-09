Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [Linux-4.9.30] Broadcom BCM20702 bluetooth in ThinkPad-T530 not
 usable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+icZUUD92VO52MtynBBQFFPxWkj=pvhm0yDkMYNamvVG4ry9Q@mail.gmail.com>
Date: Fri, 9 Jun 2017 18:11:05 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <1083ECDC-2292-4372-B85D-DA551EB3FB38@holtmann.org>
References: <CA+icZUWf1EyPJDOTO-xos=QwQ0DWLOg3goiSX_X2C01QpVqU1w@mail.gmail.com>
 <D83A359C-829A-4DBC-B5CE-1B077CE6B0E4@holtmann.org>
 <CA+icZUUD92VO52MtynBBQFFPxWkj=pvhm0yDkMYNamvVG4ry9Q@mail.gmail.com>
To: sedat.dilek@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sedat,

>>> I have some problems using my BCM20702 adapter on my Debian/stretch
>>> 9.0 AMD64 system with Linux v4.9.30 on a ThinkPad-T530 notebook.
>>> 
>> 
>> can you run “btmon -w trace.log” and attach that log. I think that I know what is going on, but I want to confirm this.
>> 
> 
> attached is a 2nd hcidump and the requested trace.log.

so here is the problem:

< HCI Command: Set Event Mask Page 2 (0x03|0x0063) plen 8
        Mask: 0x0000000000000000
> HCI Event: Command Complete (0x0e) plen 4
      Set Event Mask Page 2 (0x03|0x0063) ncmd 1
        Status: Unknown HCI Command (0x01)

This controller just does not support this command. Problem is that earlier it told us it did.

< HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
> HCI Event: Command Complete (0x0e) plen 68
      Read Local Supported Commands (0x04|0x0002) ncmd 1
        Status: Success (0x00)
        Commands: 162 entries
          ...
          Set Event Mask Page 2 (Octet 22 - Bit 2)
          ...

Can you provide the output of /sys/kernel/debug/usb/devices that relates to this USB dongle.

I posted a RFC patch that you might want to try. If that works, I just need to include a proper commit message. If it works, please send also the btmon -w trace.log for success part.

Regards

Marcel

