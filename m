Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC] Bluetooth: BNEP protocol & multicast filter ioctl
Date: Tue, 19 Jun 2012 18:45:58 +0200
Message-Id: <1340124359-9510-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is a follow up after this proposal
http://thread.gmane.org/gmane.linux.bluez.kernel/25919/focus=25920

and Marcel's last comment about ioctls.
http://thread.gmane.org/gmane.linux.bluez.kernel/25987

I simply added the ioctls to setup BNEP protocol and multicast filters.
One ioctl for each type of filters, because filters can be disabled in .config.

Let me know what you think.

Regards,
Frédéric

Frédéric Dalleau (1):
  Bluetooth: BNEP protocol & multicast filter ioctl

 net/bluetooth/bnep/bnep.h |   16 ++++++++++++++++
 net/bluetooth/bnep/core.c |   30 ++++++++++++++++++++++++++++++
 net/bluetooth/bnep/sock.c |   30 ++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

-- 
1.7.9.5

