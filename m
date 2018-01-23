Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Thomas Green <TGreen2@Sorenson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: apple keyboard
Date: Tue, 23 Jan 2018 22:55:09 +0000
Message-ID: <C2BC44D770753C45AAAC42695FB5BE02012572ED98@SLC-EXMB01.CORP.SRELAY.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All,

I have a Bluetooth apple keyboard that I'm trying to use.  The keyboard pai=
rs and connects just fine, but the custom apple driver hid_apple.ko is neve=
r loaded.  I can

modprobe hid_apple

and it loads and works fine.  Where in the driver initialization code shoul=
d I look to find out why the available driver isn't being loaded automatica=
lly?  I'm on bluez 5.48

Tom
