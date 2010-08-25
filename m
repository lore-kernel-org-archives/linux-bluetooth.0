Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Aug 2010 06:31:03 +0800
Message-ID: <AANLkTinv2DQ9E3T3atmxgnyPsVTLMx0xsA6Yu55FStta@mail.gmail.com>
Subject: [PATCH 05/22] Add two new configuration items id of efs&wfs
From: haijun liu <liuhaijun.er@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From b891acaee7f0b77daa2e3f1ba201c76604bf4594 Mon Sep 17 00:00:00 2001
From: haijun.liu <haijun.liu@atheros.com>
Date: Sun, 22 Aug 2010 23:39:40 +0800
Subject: [PATCH 05/22] Add two new configuration items id of efs&wfs.

---
 include/net/bluetooth/l2cap.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0d48e61..fe95a63 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -223,6 +223,8 @@ struct l2cap_conf_opt {
 #define L2CAP_CONF_QOS		0x03
 #define L2CAP_CONF_RFC		0x04
 #define L2CAP_CONF_FCS		0x05
+#define L2CAP_CONF_EFS		0x06
+#define L2CAP_CONF_EWS		0x07

 #define L2CAP_CONF_MAX_SIZE	22

-- 
1.6.3.3
