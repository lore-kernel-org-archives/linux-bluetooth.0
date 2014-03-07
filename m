Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bdaddr: Remove *_CP_SIZE defines
Message-Id: <20140307225545.E2760100887@puck.mtv.corp.google.com>
Date: Fri,  7 Mar 2014 14:55:45 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove *_CP_SIZE defines and use sizeof(cp) instead.
---
 tools/bdaddr.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/bdaddr.c b/tools/bdaddr.c
index ee9c01c..8356a8d 100644
--- a/tools/bdaddr.c
+++ b/tools/bdaddr.c
@@ -57,7 +57,6 @@ static int generic_reset_device(int dd)
 typedef struct {
 	bdaddr_t	bdaddr;
 } __attribute__ ((packed)) ericsson_write_bd_addr_cp;
-#define ERICSSON_WRITE_BD_ADDR_CP_SIZE 6
 
 static int ericsson_write_bd_addr(int dd, bdaddr_t *bdaddr)
 {
@@ -71,7 +70,7 @@ static int ericsson_write_bd_addr(int dd, bdaddr_t *bdaddr)
 	rq.ogf    = OGF_VENDOR_CMD;
 	rq.ocf    = OCF_ERICSSON_WRITE_BD_ADDR;
 	rq.cparam = &cp;
-	rq.clen   = ERICSSON_WRITE_BD_ADDR_CP_SIZE;
+	rq.clen   = sizeof(cp);
 	rq.rparam = NULL;
 	rq.rlen   = 0;
 
@@ -87,7 +86,6 @@ typedef struct {
 	uint8_t		flash_length;
 	uint8_t		flash_data[253];
 } __attribute__ ((packed)) ericsson_store_in_flash_cp;
-#define ERICSSON_STORE_IN_FLASH_CP_SIZE 255
 
 static int ericsson_store_in_flash(int dd, uint8_t user_id, uint8_t flash_length, uint8_t *flash_data)
 {
@@ -104,7 +102,7 @@ static int ericsson_store_in_flash(int dd, uint8_t user_id, uint8_t flash_length
 	rq.ogf    = OGF_VENDOR_CMD;
 	rq.ocf    = OCF_ERICSSON_STORE_IN_FLASH;
 	rq.cparam = &cp;
-	rq.clen   = ERICSSON_STORE_IN_FLASH_CP_SIZE;
+	rq.clen   = sizeof(cp);
 	rq.rparam = NULL;
 	rq.rlen   = 0;
 
@@ -199,7 +197,6 @@ static int csr_reset_device(int dd)
 typedef struct {
 	bdaddr_t	bdaddr;
 } __attribute__ ((packed)) ti_write_bd_addr_cp;
-#define TI_WRITE_BD_ADDR_CP_SIZE 6
 
 static int ti_write_bd_addr(int dd, bdaddr_t *bdaddr)
 {
@@ -213,7 +210,7 @@ static int ti_write_bd_addr(int dd, bdaddr_t *bdaddr)
 	rq.ogf    = OGF_VENDOR_CMD;
 	rq.ocf    = OCF_TI_WRITE_BD_ADDR;
 	rq.cparam = &cp;
-	rq.clen   = TI_WRITE_BD_ADDR_CP_SIZE;
+	rq.clen   = sizeof(cp);
 	rq.rparam = NULL;
 	rq.rlen   = 0;
 
@@ -227,7 +224,6 @@ static int ti_write_bd_addr(int dd, bdaddr_t *bdaddr)
 typedef struct {
 	bdaddr_t	bdaddr;
 } __attribute__ ((packed)) bcm_write_bd_addr_cp;
-#define BCM_WRITE_BD_ADDR_CP_SIZE 6
 
 static int bcm_write_bd_addr(int dd, bdaddr_t *bdaddr)
 {
@@ -241,7 +237,7 @@ static int bcm_write_bd_addr(int dd, bdaddr_t *bdaddr)
 	rq.ogf    = OGF_VENDOR_CMD;
 	rq.ocf    = OCF_BCM_WRITE_BD_ADDR;
 	rq.cparam = &cp;
-	rq.clen   = BCM_WRITE_BD_ADDR_CP_SIZE;
+	rq.clen   = sizeof(cp);
 	rq.rparam = NULL;
 	rq.rlen   = 0;
 
@@ -255,7 +251,6 @@ static int bcm_write_bd_addr(int dd, bdaddr_t *bdaddr)
 typedef struct {
 	bdaddr_t	bdaddr;
 } __attribute__ ((packed)) zeevo_write_bd_addr_cp;
-#define ZEEVO_WRITE_BD_ADDR_CP_SIZE 6
 
 static int zeevo_write_bd_addr(int dd, bdaddr_t *bdaddr)
 {
@@ -269,7 +264,7 @@ static int zeevo_write_bd_addr(int dd, bdaddr_t *bdaddr)
 	rq.ogf    = OGF_VENDOR_CMD;
 	rq.ocf    = OCF_ZEEVO_WRITE_BD_ADDR;
 	rq.cparam = &cp;
-	rq.clen   = ZEEVO_WRITE_BD_ADDR_CP_SIZE;
+	rq.clen   = sizeof(cp);
 	rq.rparam = NULL;
 	rq.rlen   = 0;
 
-- 
1.9.0.279.gdc9e3eb

