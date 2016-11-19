Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: mcchou@chromium.org
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, josephsih@chromium.org,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH] monitor/rfcomm: Fix a potential memory access issue
Date: Fri, 18 Nov 2016 17:32:52 -0800
Message-Id: <1479519172-32499-1-git-send-email-mcchou@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Miao-chen Chou <mcchou@chromium.org>

Packed structs have a default alignment of 1. If address of a member
is taken, the pointer value could be unaligned. Unaligned memory accesses
can result in a crash in some architectures.
---
 monitor/rfcomm.c | 2 +-
 monitor/rfcomm.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index b32ad40..7c688af 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -106,7 +106,7 @@ struct rfcomm_rpn {
 	uint8_t xon;
 	uint8_t xoff;
 	uint16_t pm;
-} __attribute__ ((packed));
+} __attribute__ ((packed, aligned(2)));

 struct rfcomm_rls {
 	uint8_t dlci;
diff --git a/monitor/rfcomm.h b/monitor/rfcomm.h
index c157352..a8af484 100644
--- a/monitor/rfcomm.h
+++ b/monitor/rfcomm.h
@@ -77,4 +77,4 @@ struct rfcomm_pn {
 	uint16_t mtu;
 	uint8_t  max_retrans;
 	uint8_t  credits;
-} __attribute__((packed));
+} __attribute__((packed, aligned(2)));
--
2.8.0.rc3.226.g39d4020

