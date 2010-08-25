Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:33:44 +0800
Message-ID: <AANLkTi=9ZstLVG9-Axahg0qTQqE9bTzhVJsRi+kHYrtw@mail.gmail.com>
Subject: [PATCH 08/22] Add struct l2cap_conf_efs for configuration process
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From dc02dc170ea5bc4106e49307e57fafca57afbc9c Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Sun, 22 Aug 2010 23:49:37 +0800
Subject: [PATCH 08/22] Add struct l2cap_conf_efs for configuration process.

---
 include/net/bluetooth/l2cap.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a1931ae..4bbc1ff 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -241,6 +241,15 @@ struct l2cap_conf_rfc {
 	__le16     max_pdu_size;
 } __attribute__ ((packed));

+struct l2cap_conf_efs {
+	__u8       id;
+	__u8       service_type;
+	__le16     max_sdu_size;
+	__le32     sdu_inter_time;
+	__le32     access_latency;
+	__le32     flush_timeout;
+} __attribute__ ((packed));
+
 #define L2CAP_MODE_BASIC	0x00
 #define L2CAP_MODE_RETRANS	0x01
 #define L2CAP_MODE_FLOWCTL	0x02
-- 
1.6.3.3
