Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH] Fix strict aliasing issue
Date: Tue, 22 Mar 2011 13:19:02 +0100
Message-Id: <1300796342-17237-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adjust type of some variables to type used by the kernel.
It avoids some unexpected performance which may occur after violating
strict aliasing rule.
---
 lib/hci.h            |    4 ++--
 lib/hci_lib.h        |    6 +++---
 tools/hcisecfilter.c |   20 ++++++++++----------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index d2d4f77..a8e6c12 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -2268,8 +2268,8 @@ struct sockaddr_hci {
 #define HCI_CHANNEL_CONTROL	1
 
 struct hci_filter {
-	uint32_t type_mask;
-	uint32_t event_mask[2];
+	unsigned long type_mask;
+	unsigned long event_mask[2];
 	uint16_t opcode;
 };
 
diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index 725eb05..c0c43c2 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -163,17 +163,17 @@ char *lmp_featurestostr(uint8_t *features, char *pref, int width);
 
 static inline void hci_set_bit(int nr, void *addr)
 {
-	*((uint32_t *) addr + (nr >> 5)) |= (1 << (nr & 31));
+	*((unsigned long *) addr + (nr >> 5)) |= (1 << (nr & 31));
 }
 
 static inline void hci_clear_bit(int nr, void *addr)
 {
-	*((uint32_t *) addr + (nr >> 5)) &= ~(1 << (nr & 31));
+	*((unsigned long *) addr + (nr >> 5)) &= ~(1 << (nr & 31));
 }
 
 static inline int hci_test_bit(int nr, void *addr)
 {
-	return *((uint32_t *) addr + (nr >> 5)) & (1 << (nr & 31));
+	return *((unsigned long *) addr + (nr >> 5)) & (1 << (nr & 31));
 }
 
 /* HCI filter tools */
diff --git a/tools/hcisecfilter.c b/tools/hcisecfilter.c
index 9ad4ce0..4512baa 100644
--- a/tools/hcisecfilter.c
+++ b/tools/hcisecfilter.c
@@ -35,15 +35,15 @@
 
 int main(void)
 {
-	uint32_t type_mask;
-	uint32_t event_mask[2];
-	uint32_t ocf_mask[4];
+	unsigned long type_mask;
+	unsigned long event_mask[2];
+	unsigned long ocf_mask[4];
 
 	/* Packet types */
 	memset(&type_mask, 0, sizeof(type_mask));
 	hci_set_bit(HCI_EVENT_PKT, &type_mask);
 
-	printf("Type mask:        { 0x%02x }\n", type_mask);
+	printf("Type mask:        { 0x%02lx }\n", type_mask);
 
 	/* Events */
 	memset(event_mask, 0, sizeof(event_mask));
@@ -66,7 +66,7 @@ int main(void)
 	hci_set_bit(EVT_SYNC_CONN_CHANGED,			event_mask);
 	hci_set_bit(EVT_EXTENDED_INQUIRY_RESULT,		event_mask);
 
-	printf("Event mask:       { 0x%08x, 0x%08x }\n",
+	printf("Event mask:       { 0x%08lx, 0x%08lx }\n",
 					event_mask[0], event_mask[1]);
 
 	/* OGF_LINK_CTL */
@@ -81,7 +81,7 @@ int main(void)
 	hci_set_bit(OCF_READ_CLOCK_OFFSET,		ocf_mask);
 	hci_set_bit(OCF_READ_LMP_HANDLE,		ocf_mask);
 
-	printf("OGF_LINK_CTL:     { 0x%08x, 0x%08x, 0x%08x, 0x%02x }\n",
+	printf("OGF_LINK_CTL:     { 0x%08lx, 0x%08lx, 0x%08lx, 0x%02lx }\n",
 			ocf_mask[0], ocf_mask[1], ocf_mask[2], ocf_mask[3]);
 
 	/* OGF_LINK_POLICY */
@@ -90,7 +90,7 @@ int main(void)
 	hci_set_bit(OCF_READ_LINK_POLICY,		ocf_mask);
 	hci_set_bit(OCF_READ_DEFAULT_LINK_POLICY,	ocf_mask);
 
-	printf("OGF_LINK_POLICY:  { 0x%08x, 0x%08x, 0x%08x, 0x%02x }\n",
+	printf("OGF_LINK_POLICY:  { 0x%08lx, 0x%08lx, 0x%08lx, 0x%02lx }\n",
 			ocf_mask[0], ocf_mask[1], ocf_mask[2], ocf_mask[3]);
 
 	/* OGF_HOST_CTL */
@@ -124,7 +124,7 @@ int main(void)
 	hci_set_bit(OCF_READ_INQ_RESPONSE_TX_POWER_LEVEL,	ocf_mask);
 	hci_set_bit(OCF_READ_DEFAULT_ERROR_DATA_REPORTING,	ocf_mask);
 
-	printf("OGF_HOST_CTL:     { 0x%08x, 0x%08x, 0x%08x, 0x%02x }\n",
+	printf("OGF_HOST_CTL:     { 0x%08lx, 0x%08lx, 0x%08lx, 0x%02lx }\n",
 			ocf_mask[0], ocf_mask[1], ocf_mask[2], ocf_mask[3]);
 
 	/* OGF_INFO_PARAM */
@@ -137,7 +137,7 @@ int main(void)
 	hci_set_bit(OCF_READ_COUNTRY_CODE,		ocf_mask);
 	hci_set_bit(OCF_READ_BD_ADDR,			ocf_mask);
 
-	printf("OGF_INFO_PARAM:   { 0x%08x, 0x%08x, 0x%08x, 0x%02x }\n",
+	printf("OGF_INFO_PARAM:   { 0x%08lx, 0x%08lx, 0x%08lx, 0x%02lx }\n",
 			ocf_mask[0], ocf_mask[1], ocf_mask[2], ocf_mask[3]);
 
 	/* OGF_STATUS_PARAM */
@@ -148,7 +148,7 @@ int main(void)
 	hci_set_bit(OCF_READ_AFH_MAP,			ocf_mask);
 	hci_set_bit(OCF_READ_CLOCK,			ocf_mask);
 
-	printf("OGF_STATUS_PARAM: { 0x%08x, 0x%08x, 0x%08x, 0x%02x }\n",
+	printf("OGF_STATUS_PARAM: { 0x%08lx, 0x%08lx, 0x%08lx, 0x%02lx }\n",
 			ocf_mask[0], ocf_mask[1], ocf_mask[2], ocf_mask[3]);
 
 	return 0;
-- 
1.6.3.3

