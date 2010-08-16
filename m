Return-Path: <cyrus@holtmann.org>
From: Alan Ott <alan@signal11.us>
To: Jiri Kosina <jkosina@suse.cz>,
	Stefan Achatz <erazor_de@users.sourceforge.net>,
	Antonio Ospite <ospite@studenti.unina.it>,
	Alexey Dobriyan <adobriyan@gmail.com>, Tejun Heo <tj@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@suse.de>, Alan Ott <alan@signal11.us>,
	Marcel Holtmann <marcel@holtmann.org>,
	Stephane Chatty <chatty@enac.fr>,
	Michael Poole <mdpoole@troilus.org>,
	"David S. Miller" <davem@davemloft.net>,
	Bastien Nocera <hadess@hadess.net>,
	Eric Dumazet <eric.dumazet@gmail.com>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Cc: Alan Ott <alan@signal11.us>
Subject: [PATCH v4 0/2] Get and Set Feature Reports on HIDRAW (USB and Bluetooth)
Date: Mon, 16 Aug 2010 16:20:57 -0400
Message-Id: <1281990059-3562-1-git-send-email-alan@signal11.us>
In-Reply-To: <1281442367.12579.206.camel@localhost.localdomain>
References: <1281442367.12579.206.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

This is version 4. Built against 2.6.35+ revision 320b2b8de12698 .

Alan Ott (2):
  HID: Add Support for Setting and Getting Feature Reports from hidraw
  Bluetooth: hidp: Add support for hidraw  HIDIOCGFEATURE  and
    HIDIOCSFEATURE

 drivers/hid/hidraw.c          |  105 ++++++++++++++++++++++++++++++++++++--
 drivers/hid/usbhid/hid-core.c |   37 +++++++++++++-
 include/linux/hid.h           |    3 +
 include/linux/hidraw.h        |    3 +
 net/bluetooth/hidp/core.c     |  114 +++++++++++++++++++++++++++++++++++++++--
 net/bluetooth/hidp/hidp.h     |    8 +++
 6 files changed, 260 insertions(+), 10 deletions(-)
