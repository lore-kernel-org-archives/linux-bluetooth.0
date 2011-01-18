Return-Path: <cyrus@holtmann.org>
From: Alan Ott <alan@signal11.us>
To: Jiri Kosina <jkosina@suse.cz>,
	Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	"David S. Miller" <davem@davemloft.net>, Alan Ott <alan@signal11.us>,
	Michael Poole <mdpoole@troilus.org>,
	Eric Dumazet <eric.dumazet@gmail.com>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Cc: Alan Ott <alan@signal11.us>
Subject: [PATCH v5 0/4] Adding HID Feature Report Support to hidraw
Date: Tue, 18 Jan 2011 03:04:36 -0500
Message-Id: <1295337880-12452-1-git-send-email-alan@signal11.us>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds Feature Report support for USB and Bluetooth HID devices
through hidraw.

The first two patches prepare the bluetooth side for the change.
	a. Make sure the hidp_session() thread is started before
	   device's probe() functions are called.
	b. Wait for ACK/NAK on sent reports, and return proper
	   error codes.
The third patch is the hidraw core and USB changes.
The fourth patch is the Bluetooth changes.

Thanks to Antonio Ospite and Bill Good for providing testing and feedback.


Alan Ott (4):
  bt hidp: Move hid_add_device() call to after hidp_session() has
    started.
  bt hidp: Wait for ACK on Sent Reports
  HID: Add Support for Setting and Getting Feature Reports from hidraw
  Bluetooth hidp: Add support for hidraw HIDIOCGFEATURE and
    HIDIOCSFEATURE

 drivers/hid/hidraw.c          |  106 +++++++++++++++++++-
 drivers/hid/usbhid/hid-core.c |   35 +++++++
 include/linux/hid.h           |    3 +
 include/linux/hidraw.h        |    3 +
 net/bluetooth/hidp/core.c     |  214 ++++++++++++++++++++++++++++++++++++++---
 net/bluetooth/hidp/hidp.h     |   15 +++
 6 files changed, 355 insertions(+), 21 deletions(-)
