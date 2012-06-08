Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Andre Guedes <andre.guedes@openbossa.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC] Bluetooth: Fix using uninitialized option in RFCMode
Date: Fri, 8 Jun 2012 11:33:33 +0200
Message-ID: <1339148013-4956-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If remote device sends bogus RFC option with invalid length,
undefined options values are used. Fix this by using defaults when
remote misbehaves.

This also fixes the following warning reported by gcc 4.7.0:

net/bluetooth/l2cap_core.c: In function 'l2cap_config_rsp':
net/bluetooth/l2cap_core.c:3302:13: warning: 'rfc.max_pdu_size' may be used uninitialized in this function [-Wmaybe-uninitialized]
net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.max_pdu_size' was declared here
net/bluetooth/l2cap_core.c:3298:25: warning: 'rfc.monitor_timeout' may be used uninitialized in this function [-Wmaybe-uninitialized]
net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.monitor_timeout' was declared here
net/bluetooth/l2cap_core.c:3297:25: warning: 'rfc.retrans_timeout' may be used uninitialized in this function [-Wmaybe-uninitialized]
net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.retrans_timeout' was declared here
net/bluetooth/l2cap_core.c:3295:2: warning: 'rfc.mode' may be used uninitialized in this function [-Wmaybe-uninitialized]
net/bluetooth/l2cap_core.c:3266:24: note: 'rfc.mode' was declared here

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/l2cap_core.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f9bffe3..38e6ecc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3273,12 +3273,14 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
 
-		switch (type) {
-		case L2CAP_CONF_RFC:
-			if (olen == sizeof(rfc))
-				memcpy(&rfc, (void *)val, olen);
-			goto done;
-		}
+		if (type != L2CAP_CONF_RFC)
+			continue;
+
+		if (olen != sizeof(rfc))
+			break;
+
+		memcpy(&rfc, (void *)val, olen);
+		goto done;
 	}
 
 	/* Use sane default values in case a misbehaving remote device
-- 
on behalf of ST-Ericsson

