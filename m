Return-Path: <cyrus@holtmann.org>
Date: Tue, 13 Jul 2010 10:10:07 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Bluez 4.68 instant segfault
Message-ID: <20100713101007.6da560a1@susi.home.s3e.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'd say that this commit would justify an instant 4.69 release:

commit 86b16d8a63d8d6191533418dd1c38ce35c3fbf0a
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Mon Jul 12 23:59:34 2010 -0300

    Remove double g_option_context_free() call


Without that, "bluetoothd --udev" instant segfaults, while without --udev
it gets aborted by glibc due tot the double free ;)

Thanks,

	Stefan
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
