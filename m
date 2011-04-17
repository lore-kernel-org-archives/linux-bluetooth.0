Return-Path: <cyrus@holtmann.org>
From: Maciej Rutecki <maciej.rutecki@gmail.com>
Reply-To: maciej.rutecki@gmail.com
To: Gottfried Haider <gottfried.haider@gmail.com>
Subject: Re: [Regression] Bluetooth pairing does not work anymore in 2.6.39-rc3 (works in 2.6.38.3)
Date: Sun, 17 Apr 2011 20:40:21 +0200
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
References: <BANLkTi=LvyZ+7BHfVL849pztfvsYaVM4SQ@mail.gmail.com>
In-Reply-To: <BANLkTi=LvyZ+7BHfVL849pztfvsYaVM4SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201104172040.21852.maciej.rutecki@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I created a Bugzilla entry at 
https://bugzilla.kernel.org/show_bug.cgi?id=33482
for your bug report, please add your address to the CC list in there, thanks!

On sobota, 16 kwietnia 2011 o 18:38:59 Gottfried Haider wrote:
> Hello,
> 
> I am having problems pairing bluetooth devices in 2.6.39. Scanning
> works fine (hcitool scan), but when I try to pair a device using
> "bluez-simple-agent hci0 $MAC", I receive the following error message:
> "Creating device failed: org.bluez.Error.Failed: Input/output error"
> 
> The same command reliably works on a 2.6.38.3 kernel with pretty much
> the same config.
> 
> According to lsusb, I have a Broadcom Bluetooth Controller with ID
> 0a5c:217f. I don't see anything related in either of the dmesgs.
> My lspci output is here: http://sukzessiv.net/x120e/
> Userspace is an up-to-date Ubuntu 11.04 beta (with bluez 4.91).
> 
> If there are any debugging steps that I could do or patches to try or
> revert, let me know. Unfortunately I can't do a proper bisect since
> the machine is a netbook type.
> 
> cheers,
> gohai
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Maciej Rutecki
http://www.maciek.unixy.pl
