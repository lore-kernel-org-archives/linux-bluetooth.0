Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools: Add "hciconfig pagetype" command
Message-Id: <20140507191001.8901C100802@puck.mtv.corp.google.com>
Date: Wed,  7 May 2014 12:10:01 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add "hciconfig pagetype" command so that Bluetooth adapter can be
easily configured to standard or interlaced page scan mode.
---
 lib/hci.c         | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/hci.h         | 17 +++++++++++++++--
 lib/hci_lib.h     |  2 ++
 tools/hciconfig.1 |  6 ++++++
 tools/hciconfig.c | 37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 005578a..dea38da 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -2236,6 +2236,57 @@ int hci_write_inquiry_mode(int dd, uint8_t mode, int to)
 	return 0;
 }
 
+int hci_read_page_scan_type(int dd, uint8_t *type, int to)
+{
+	read_page_scan_type_rp rp;
+	struct hci_request rq;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf    = OGF_HOST_CTL;
+	rq.ocf    = OCF_READ_PAGE_SCAN_TYPE;
+	rq.rparam = &rp;
+	rq.rlen   = READ_PAGE_SCAN_TYPE_RP_SIZE;
+
+	if (hci_send_req(dd, &rq, to) < 0)
+		return -1;
+
+	if (rp.status) {
+		errno = EIO;
+		return -1;
+	}
+
+	*type = rp.type;
+	return 0;
+}
+
+int hci_write_page_scan_type(int dd, uint8_t type, int to)
+{
+	write_page_scan_type_cp cp;
+	write_page_scan_type_rp rp;
+	struct hci_request rq;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.type = type;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf    = OGF_HOST_CTL;
+	rq.ocf    = OCF_WRITE_PAGE_SCAN_TYPE;
+	rq.cparam = &cp;
+	rq.clen   = WRITE_PAGE_SCAN_TYPE_CP_SIZE;
+	rq.rparam = &rp;
+	rq.rlen   = WRITE_PAGE_SCAN_TYPE_RP_SIZE;
+
+	if (hci_send_req(dd, &rq, to) < 0)
+		return -1;
+
+	if (rp.status) {
+		errno = EIO;
+		return -1;
+	}
+
+	return 0;
+}
+
 int hci_read_afh_mode(int dd, uint8_t *mode, int to)
 {
 	read_afh_mode_rp rp;
diff --git a/lib/hci.h b/lib/hci.h
index 0c94829..760b3fa 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -1070,10 +1070,23 @@ typedef struct {
 #define WRITE_INQUIRY_MODE_RP_SIZE 1
 
 #define OCF_READ_PAGE_SCAN_TYPE		0x0046
+typedef struct {
+	uint8_t		status;
+	uint8_t		type;
+} __attribute__ ((packed)) read_page_scan_type_rp;
+#define READ_PAGE_SCAN_TYPE_RP_SIZE 2
 
 #define OCF_WRITE_PAGE_SCAN_TYPE	0x0047
-	#define PAGE_SCAN_TYPE_STANDARD		0x00
-	#define PAGE_SCAN_TYPE_INTERLACED	0x01
+typedef struct {
+	uint8_t		type;
+} __attribute__ ((packed)) write_page_scan_type_cp;
+#define WRITE_PAGE_SCAN_TYPE_CP_SIZE 1
+typedef struct {
+	uint8_t		status;
+} __attribute__ ((packed)) write_page_scan_type_rp;
+#define WRITE_PAGE_SCAN_TYPE_RP_SIZE 1
+#define PAGE_SCAN_TYPE_STANDARD		0x00
+#define PAGE_SCAN_TYPE_INTERLACED	0x01
 
 #define OCF_READ_AFH_MODE		0x0048
 typedef struct {
diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index 50744c3..6be0030 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -94,6 +94,8 @@ int hci_read_inquiry_scan_type(int dd, uint8_t *type, int to);
 int hci_write_inquiry_scan_type(int dd, uint8_t type, int to);
 int hci_read_inquiry_mode(int dd, uint8_t *mode, int to);
 int hci_write_inquiry_mode(int dd, uint8_t mode, int to);
+int hci_read_page_scan_type(int dd, uint8_t *type, int to);
+int hci_write_page_scan_type(int dd, uint8_t type, int to);
 int hci_read_afh_mode(int dd, uint8_t *mode, int to);
 int hci_write_afh_mode(int dd, uint8_t mode, int to);
 int hci_read_ext_inquiry_response(int dd, uint8_t *fec, uint8_t *data, int to);
diff --git a/tools/hciconfig.1 b/tools/hciconfig.1
index 633ffa3..4f6dee1 100644
--- a/tools/hciconfig.1
+++ b/tools/hciconfig.1
@@ -168,6 +168,12 @@ slots and inquiry scan interval to
 .I int
 slots.
 .TP
+.BI pagetype " [type]"
+With no
+.IR type ,
+prints out the current page scan type. Otherwise, sets page scan type to
+.IR type .
+.TP
 \fBpageparms\fP [\fIwin\fP:\fIint\fP]
 With no
 .IR win : int ,
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 765d980..99c77e1 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -1463,6 +1463,42 @@ static void cmd_inq_parms(int ctl, int hdev, char *opt)
 	}
 }
 
+static void cmd_page_type(int ctl, int hdev, char *opt)
+{
+	int dd;
+
+	dd = hci_open_dev(hdev);
+	if (dd < 0) {
+		fprintf(stderr, "Can't open device hci%d: %s (%d)\n",
+						hdev, strerror(errno), errno);
+		exit(1);
+	}
+
+	if (opt) {
+		uint8_t type = atoi(opt);
+
+		if (hci_write_page_scan_type(dd, type, 2000) < 0) {
+			fprintf(stderr, "Can't set page scan type on hci%d: %s (%d)\n",
+						hdev, strerror(errno), errno);
+			exit(1);
+		}
+	} else {
+		uint8_t type;
+
+		if (hci_read_page_scan_type(dd, &type, 1000) < 0) {
+			fprintf(stderr, "Can't read page scan type on hci%d: %s (%d)\n",
+						hdev, strerror(errno), errno);
+			exit(1);
+		}
+
+		print_dev_hdr(&di);
+		printf("\tPage scan type: %s\n", type == PAGE_SCAN_TYPE_INTERLACED ?
+				"Interlaced Page Scan" : "Standard Page Scan");
+	}
+
+	hci_close_dev(dd);
+}
+
 static void cmd_page_parms(int ctl, int hdev, char *opt)
 {
 	struct hci_request rq;
@@ -1932,6 +1968,7 @@ static struct {
 	{ "inqdata",	cmd_inq_data,	"[data]",	"Get/Set inquiry data" },
 	{ "inqtype",	cmd_inq_type,	"[type]",	"Get/Set inquiry scan type" },
 	{ "inqparms",	cmd_inq_parms,	"[win:int]",	"Get/Set inquiry scan window and interval" },
+	{ "pagetype",	cmd_page_type,	"[type]",	"Get/Set page scan type" },
 	{ "pageparms",	cmd_page_parms,	"[win:int]",	"Get/Set page scan window and interval" },
 	{ "pageto",	cmd_page_to,	"[to]",		"Get/Set page timeout" },
 	{ "afhmode",	cmd_afh_mode,	"[mode]",	"Get/Set AFH mode" },
-- 
1.9.1.423.g4596e3a

