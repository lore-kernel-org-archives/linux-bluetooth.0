Return-Path: <cyrus@holtmann.org>
Message-ID: <55488DB1.2080503@gmail.com>
Date: Tue, 05 May 2015 12:30:25 +0300
From: Dmitry Tunin <hanipouspilot@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: No firmware for some AR3012 chips
References: <554504B2.1050404@gmail.com>
In-Reply-To: <554504B2.1050404@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Look here too
http://ubuntuforums.org/showthread.php?t=2276803

It seems that some chips do not report fw_version right

02.05.2015 20:09, Dmitry Tunin пишет:
> Hi,
> 
> Please look at https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1024884
> 
> It looks like ath3k is looking for some different firmware files.
> AthrBT_0x11020100.dfu
> ramps_0x11020100_40.dfu
> 
> Linux-firmware does not contain these files. It must be some new version of the firmware.
> And should a patch for this device is sent?
> 
> Regards,
> 
> Dmitry
> 
