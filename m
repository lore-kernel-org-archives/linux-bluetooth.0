Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Aug 2015 16:16:49 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: Kalle Valo <kvalo@qca.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Missing firmware for AR3012 devices
Message-ID: <20150810211649.GB60315@ubuntu-hedt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kalle,

I'm hitting you up because it looks like you've supplied some firmware
for ath3k devices in the past.

Some new ath3k devices were recently enabled in the kernel [1], however
it looks like there's no firmware available under a license which would
allow distros to redistribute it. According to users at [2] the files
should be named AthrBT_0x11020100.dfu and ramps_0x11020100_40.dfu. Any
chance you or someone else at QCA could help get this into
linux-firmware?

Thanks,
Seth

[1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=7e730c7f3d1f39c25cf5f7cf70c0ff4c28d7bec7
[2] http://bugs.launchpad.net/bugs/1394368
