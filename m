Return-Path: <cyrus@holtmann.org>
From: <james.steele@accenture.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <james.steele@accenture.com>
Subject: [PATCH hcidump v2 1/2] lib: Add HCI write SSP debug mode library
 function
Date: Wed, 28 Mar 2012 10:44:43 +0000
Message-ID: <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E1133F@048-CH1MPN1-101.048d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds a hci_write_simple_pairing_debug_mode function.
Also corrects the Testing OGF value to match the specification.
---
 lib/hci.c     |   28 ++++++++++++++++++++++++++++
 lib/hci.h     |    2 +-
 lib/hci_lib.h |    2 ++
 3 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 269c021..52f9b33 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -2735,6 +2735,34 @@ int hci_read_clock(int dd, uint16_t handle, uint8_t which, uint32_t *clock,
        return 0;
 }

+int hci_write_simple_pairing_debug_mode(int dd, uint8_t mode, int to)
+{
+       write_simple_pairing_debug_mode_cp cp;
+       write_simple_pairing_debug_mode_rp rp;
+       struct hci_request rq;
+
+       memset(&cp, 0, sizeof(cp));
+       cp.mode = mode;
+
+       memset(&rq, 0, sizeof(rq));
+       rq.ogf    = OGF_TESTING_CMD;
+       rq.ocf    = OCF_WRITE_SIMPLE_PAIRING_DEBUG_MODE;
+       rq.cparam = &cp;
+       rq.clen   = WRITE_SIMPLE_PAIRING_DEBUG_MODE_CP_SIZE;
+       rq.rparam = &rp;
+       rq.rlen   = WRITE_SIMPLE_PAIRING_DEBUG_MODE_RP_SIZE;
+
+       if (hci_send_req(dd, &rq, to) < 0)
+               return -1;
+
+       if (rp.status) {
+               errno = EIO;
+               return -1;
+       }
+
+       return 0;
+}
+
 int hci_le_set_scan_enable(int dd, uint8_t enable, uint8_t filter_dup, int to)
 {
        struct hci_request rq;
diff --git a/lib/hci.h b/lib/hci.h
index b68dbc2..1765655 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -1419,7 +1419,7 @@ typedef struct {
 #define WRITE_REMOTE_AMP_ASSOC_RP_SIZE 2

 /* Testing commands */
-#define OGF_TESTING_CMD                0x3e
+#define OGF_TESTING_CMD                0x06

 #define OCF_READ_LOOPBACK_MODE                 0x0001

diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index 725eb05..9555b5f 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -115,6 +115,8 @@ int hci_read_rssi(int dd, uint16_t handle, int8_t *rssi, int to);
 int hci_read_afh_map(int dd, uint16_t handle, uint8_t *mode, uint8_t *map, int to);
 int hci_read_clock(int dd, uint16_t handle, uint8_t which, uint32_t *clock, uint16_t *accuracy, int to);

+int hci_write_simple_pairing_debug_mode(int dd, uint8_t mode, int to);
+
 int hci_le_set_scan_enable(int dev_id, uint8_t enable, uint8_t filter_dup, int to);
 int hci_le_set_scan_parameters(int dev_id, uint8_t type, uint16_t interval,
                                        uint16_t window, uint8_t own_type,
--
1.7.0.4


________________________________
Subject to local law, communications with Accenture and its affiliates including telephone calls and emails (including content), may be monitored by our systems for the purposes of security and the assessment of internal compliance with Accenture policy.
______________________________________________________________________________________

www.accenture.com

