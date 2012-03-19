Return-Path: <cyrus@holtmann.org>
From: <james.steele@accenture.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <james.steele@accenture.com>
Subject: [PATCH] Adding SSP debug mode configuration to hciconfig.
Date: Mon, 19 Mar 2012 16:55:54 +0000
Message-ID: <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E01AC4@048-CH1MPN1-101.048d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: James Steele <james.steele@accenture.com>

Enabling configuration of the Secure Simple Pairing Debug Mode
with hciconfig. Includes supporting changes to the HCI library
functions.
---
 lib/hci.c         |   28 ++++++++++++++++++++++++++++
 lib/hci.h         |    2 +-
 lib/hci_lib.h     |    2 ++
 tools/hciconfig.8 |    6 ++++++
 tools/hciconfig.c |   25 +++++++++++++++++++++++++
 5 files changed, 62 insertions(+), 1 deletions(-)

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
index 887a860..5fab92d 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -1428,7 +1428,7 @@ typedef struct {
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
diff --git a/tools/hciconfig.8 b/tools/hciconfig.8
index 35956c4..88282f1 100644
--- a/tools/hciconfig.8
+++ b/tools/hciconfig.8
@@ -197,6 +197,12 @@ With no
 prints out the current Simple Pairing mode. Otherwise, sets Simple Pairing mode to
 .IR mode .
 .TP
+.BI sspdebug " <mode>"
+This command sets the Simple Pairing debug mode to
+.IR mode .
+Debug mode allows Bluetooth air sniffers to decode data when encryption is
+used.  As such enabling debug mode represents a security risk.
+.TP
 \fBaclmtu\fP \fImtu\fP:\fIpkt\fP
 Sets ACL MTU to
 to
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index f1458b9..72bd85f 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -1653,6 +1653,30 @@ static void cmd_ssp_mode(int ctl, int hdev, char *opt)
        }
 }

+
+static void cmd_ssp_debug(int ctl, int hdev, char *opt)
+{
+       int dd;
+       uint8_t mode;
+
+       if (!opt)
+               return;
+
+       dd = hci_open_dev(hdev);
+       if (dd < 0) {
+               fprintf(stderr, "Can't open device hci%d: %s (%d)\n",
+                                               hdev, strerror(errno), errno);
+               exit(1);
+       }
+
+       mode = atoi(opt);
+       if (hci_write_simple_pairing_debug_mode(dd, mode, 2000) < 0) {
+               fprintf(stderr, "Can't set Simple Pairing Debug mode on hci%d: %s (%d)\n",
+                               hdev, strerror(errno), errno);
+               exit(1);
+       }
+}
+
 static void print_rev_ericsson(int dd)
 {
        struct hci_request rq;
@@ -1920,6 +1944,7 @@ static struct {
        { "pageto",     cmd_page_to,    "[to]",         "Get/Set page timeout" },
        { "afhmode",    cmd_afh_mode,   "[mode]",       "Get/Set AFH mode" },
        { "sspmode",    cmd_ssp_mode,   "[mode]",       "Get/Set Simple Pairing Mode" },
+       { "sspdebug",   cmd_ssp_debug,  "<mode>",       "Set Simple Pairing Debug Mode" },
        { "aclmtu",     cmd_aclmtu,     "<mtu:pkt>",    "Set ACL MTU and number of packets" },
        { "scomtu",     cmd_scomtu,     "<mtu:pkt>",    "Set SCO MTU and number of packets" },
        { "putkey",     cmd_putkey,     "<bdaddr>",     "Store link key on the device" },
--
1.7.0.4

________________________________
Subject to local law, communications with Accenture and its affiliates including telephone calls and emails (including content), may be monitored by our systems for the purposes of security and the assessment of internal compliance with Accenture policy.
______________________________________________________________________________________

www.accenture.com

Subject to local law, communications with Accenture and its affiliates including telephone calls and emails (including content), may be monitored by our systems for the purposes of security and the assessment of internal compliance with Accenture policy.
______________________________________________________________________________________

www.accenture.com

