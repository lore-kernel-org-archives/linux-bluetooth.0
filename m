Return-Path: <cyrus@holtmann.org>
From: <james.steele@accenture.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <james.steele@accenture.com>
Subject: [PATCH v2 2/2] Adding SSP debug mode configuration to hciconfig.
Date: Wed, 28 Mar 2012 10:44:17 +0000
Message-ID: <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E11329@048-CH1MPN1-101.048d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Enabling configuration of Secure Simple Pairing Debug Mode with hciconfig.
---
 tools/hciconfig.8 |    6 ++++++
 tools/hciconfig.c |   25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

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

