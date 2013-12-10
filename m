Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 10 Dec 2013 20:39:41 +0100
Message-ID: <CAD=nrE_R6h++1AofwTHoHjRT=YOc1VPUaic7AYO_jbh6Eb_koQ@mail.gmail.com>
Subject: Unknown option 'pin_helper
From: "valent.turkovic@gmail.com" <valent.turkovic@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
on OpenWrt latest version of bluez-utils is still 3.36 and when I add
pin_helper to hcid.conf file I see this error when starting hcid
daemon:

# hcid -n
hcid[1063]: Bluetooth HCI daemon
hcid[1063]: Unknown option 'pin_helper' line 26


Should bluez-utils 3.36 have support for pin_helper by default? I have
checked source code of OpenWrt and can't find any patch that disables
pin_helper.

What could the issue here?
