Return-Path: <cyrus@holtmann.org>
From: Jesse Sung <jesse.sung@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 resend 0/2] broadcom patchram firmware loader
Date: Thu,  4 Oct 2012 15:30:45 +0800
Message-Id: <1349335847-1615-1-git-send-email-jesse.sung@canonical.com>
In-Reply-To: <cover.1347959921.git.jesse.sung@canonical.com>
References: <cover.1347959921.git.jesse.sung@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wen-chien Jesse Sung <jesse.sung@canonical.com>

There is an user space firmware loading tool which can be found at
http://marc.info/?l=linux-bluetooth&m=132039175324993&w=2

This tool requires hci device to do the firmware loading, but this
may cause some race condition between patchram tool and bluetoothd
or something that also works on hci interface.

Also it needs some hooks to make firmware loads after bootup, s3,
s4, rfkill, and device hotplug events. Implement this loader in kernel
module would make things more easier.

Wen-chien Jesse Sung (2):
  Introduced a load_firmware callback to struct hci_dev
  broadcom patchram firmware loader

 drivers/bluetooth/btusb.c        |   75 +++++++++++++++++++++++++++++++++++++-
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |    2 +
 3 files changed, 76 insertions(+), 2 deletions(-)

-- 
1.7.9.5
