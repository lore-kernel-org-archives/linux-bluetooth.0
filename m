Return-Path: <cyrus@holtmann.org>
From: Tracey Dent <tdent48227@gmail.com>
To: davem@davemloft.net
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	sjur.brandeland@stericsson.com,
	socketcan@hartkopp.net,
	urs.thuermann@volkswagen.de,
	socketcan-core@lists.berlios.de,
	sage@newdream.net,
	ceph-devel@vger.kernel.org,
	wang840925@gmail.com,
	jlayton@redhat.com,
	kaber@trash.net,
	pekkas@netcore.fi,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	netfilter@vger.kernel.org,
	samuel@sortiz.org,
	Tracey Dent <tdent48227@gmail.com>
Subject: [PATCH 01/17] Net: bluetooth: Makefile: Remove deprecated kbuild goal definitions
Date: Sun, 21 Nov 2010 20:03:12 -0500
Message-Id: <1290387808-2239-2-git-send-email-tdent48227@gmail.com>
In-Reply-To: <1290387808-2239-1-git-send-email-tdent48227@gmail.com>
References: <1290387808-2239-1-git-send-email-tdent48227@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Changed Makefile to use <modules>-y instead of <modules>-objs
because -objs is deprecated and not mentioned in
Documentation/kbuild/makefiles.txt.

Signed-off-by: Tracey Dent <tdent48227@gmail.com>
---
 net/bluetooth/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index d1e433f..7ca1f46 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -10,4 +10,4 @@ obj-$(CONFIG_BT_BNEP)	+= bnep/
 obj-$(CONFIG_BT_CMTP)	+= cmtp/
 obj-$(CONFIG_BT_HIDP)	+= hidp/
 
-bluetooth-objs := af_bluetooth.o hci_core.o hci_conn.o hci_event.o hci_sock.o hci_sysfs.o lib.o
+bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o hci_sock.o hci_sysfs.o lib.o
-- 
1.7.3.2.245.g03276
