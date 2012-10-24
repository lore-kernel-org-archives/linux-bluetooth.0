Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 05:55:13 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [bluetooth:master 12/33] net/bluetooth/l2cap_core.c:4495:6:
 sparse: symbol 'l2cap_physical_cfm' was not declared. Should it be static?
Message-ID: <508863c1.QTbySMnQ9kj6jDZz%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_508863c1.hXVUHLD8io6lzHNcBjixCB1b9bGsF5XCDNpXYAFKNsZSFIIT"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.

--=_508863c1.hXVUHLD8io6lzHNcBjixCB1b9bGsF5XCDNpXYAFKNsZSFIIT
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Mat,

FYI, there are new sparse warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   77220c6582477e696e3f3a53634fb1bd73128e95
commit: 8eb200bd2f1c772dcb7f108f690ef03b054be04e [12/33] Bluetooth: Handle physical link completion

+ net/bluetooth/l2cap_core.c:4495:6: sparse: symbol 'l2cap_physical_cfm' was not declared. Should it be static?

Please consider folding the attached diff :-)

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation

--=_508863c1.hXVUHLD8io6lzHNcBjixCB1b9bGsF5XCDNpXYAFKNsZSFIIT
Content-Type: text/x-diff;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="make-it-static-8eb200b.diff"

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 898529d..24285e5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4492,7 +4492,7 @@ static void l2cap_do_move_cancel(struct l2cap_chan *chan, int result)
 	l2cap_ertm_send(chan);
 }
 
-void l2cap_physical_cfm(struct l2cap_chan *chan, int result, u8 local_amp_id,
+static void l2cap_physical_cfm(struct l2cap_chan *chan, int result, u8 local_amp_id,
 			u8 remote_amp_id)
 {
 	BT_DBG("chan %p, result %d, local_amp_id %d, remote_amp_id %d",

--=_508863c1.hXVUHLD8io6lzHNcBjixCB1b9bGsF5XCDNpXYAFKNsZSFIIT--
