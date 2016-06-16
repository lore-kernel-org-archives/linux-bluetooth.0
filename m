Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 98021] Broadcom 43341 sdio bluetooth module is not recognized.
Date: Thu, 16 Jun 2016 15:21:11 +0000
Message-ID: <bug-98021-62941-PmuRkm3p74@https.bugzilla.kernel.org/>
In-Reply-To: <bug-98021-62941@https.bugzilla.kernel.org/>
References: <bug-98021-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=98021

--- Comment #4 from Francesco Bonanno <mibofra@frozenbox.org> ---
Hello, after some time I have started to work again with the my asus t200ta. I
have the bluetooth module working now!

https://github.com/LGSInnovations/edison-yocto-image/raw/master/edison-image-edison-ext4/etc/firmware/bcm43341.hcd
this is the firmware used to get it working (I've originally unpacked it from
the intel edison image, anyway I have found this repository where it is pushed
already, so you can take the firmware here for tests)

After I have discovered that the bcm43341 (at least on my t200ta and with linux
4.7rc3) is seen as a bcm43341B0 on /dev/ttyS4

[ 1251.074780] Bluetooth: hci1: BCM: chip id 82
[ 1251.074792] Bluetooth: hci1: BCM43341B0 (002.001.014) build 0000

So I have put the firmware under /lib/firmware/brcm/BCM43341B0.hcd where
btattach is looking for it and after I have launched it with:

"btattach --bredr /dev/ttyS4 -P bcm" as root, and it is working without issues!

I have put the command under /etc/rc.local as workaround, however I imagine
that you will find a better solution to have it recognised automatically by the
kernel. 

I hope all this will be usefull!

-- 
You are receiving this mail because:
You are the assignee for the bug.
