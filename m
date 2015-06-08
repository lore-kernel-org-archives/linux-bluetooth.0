Return-Path: <cyrus@holtmann.org>
From: Simon Wood <simon@mungewell.org>
To: linux-bluetooth@vger.kernel.org
Cc: simon@mungewell.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] bccmd - add ability to read ADC
Date: Mon,  8 Jun 2015 12:04:20 -0600
Message-Id: <1433786660-2169-1-git-send-email-simon@mungewell.org>
In-Reply-To: <06F67222-BAF1-455D-A4B8-4560FE84EE69@holtmann.org>
References: <06F67222-BAF1-455D-A4B8-4560FE84EE69@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Some BlueCore devices are equipped with an 'Analogue In' pin which is
internally connected to a MUX and ADC. This patch adds the ability to
control the MUX and read the ADC.

The ADC is also connected internal to a temp sensor, which can also be
read via this method.

The (only) MUX values expected to be used are:
1  Internal 1V25 reference
16 BlueCore01b pin Test_A; BlueCore2-External pin AIO0
17 BlueCore01b pin Test_B; BlueCore2-External pin AIO1
36 Chip’s internal temperature (change) sensor. BlueCore2-ROM and later only.

The MUX can also select other (undocumented) test points.

Example usage
--
$ ./bccmd -t HCI -d hci1 adc 17
ADC value from Mux 0x11 : 0x0054 (valid)
$ ./bccmd -t HCI -d hci1 adc 1
ADC value from Mux 0x01 : 0x00b2 (valid)

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 tools/bccmd.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 tools/csr.h   |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/tools/bccmd.c b/tools/bccmd.c
index 7cce426..64c5f56 100644
--- a/tools/bccmd.c
+++ b/tools/bccmd.c
@@ -1040,6 +1040,47 @@ static int cmd_pscheck(int transport, int argc, char *argv[])
 	return 0;
 }
 
+static int cmd_adc(int transport, int argc, char *argv[])
+{
+	uint8_t array[8];
+	uint16_t mux, value;
+	int err;
+
+	OPT_HELP(1, NULL);
+
+	if (!strncasecmp(argv[0], "0x", 2))
+		mux = strtol(argv[0], NULL, 16);
+	else
+		mux = atoi(argv[0]);
+
+	// Request an ADC read from a particular mux'ed input
+	memset(array, 0, sizeof(array));
+	array[0] = mux & 0xff;
+	array[1] = mux >> 8;
+
+	err = transport_write(transport, CSR_VARID_ADC, array, 2);
+	if (err < 0) {
+		errno = -err;
+		return -1;
+	}
+
+	// sleep, then read result
+	usleep(50000);
+	err = transport_read(transport, CSR_VARID_ADC_RES, array, 8);
+	if (err < 0) {
+		errno = -err;
+		return -1;
+	}
+
+	mux = array[0] | (array[1] << 8);
+	value = array[4] | (array[5] << 8);
+
+	printf("ADC value from Mux 0x%02x : 0x%04x (%s)\n", mux, value,
+					array[2] == 1 ? "valid" : "invalid");
+
+	return 0;
+}
+
 static struct {
 	char *str;
 	int (*func)(int transport, int argc, char *argv[]);
@@ -1070,6 +1111,7 @@ static struct {
 	{ "psread",    cmd_psread,    NULL,                  "Read all PS keys"               },
 	{ "psload",    cmd_psload,    "<file>",              "Load all PS keys from PSR file" },
 	{ "pscheck",   cmd_pscheck,   "<file>",              "Check PSR file"                 },
+	{ "adc",       cmd_adc,       "<mux>",               "Read ADC value of <mux> input"  },
 	{ NULL }
 };
 
diff --git a/tools/csr.h b/tools/csr.h
index 8b94d7b..cc245a5 100644
--- a/tools/csr.h
+++ b/tools/csr.h
@@ -39,6 +39,7 @@
 #define CSR_VARID_BT_CLOCK			0x2c00	/* uint32 */
 #define CSR_VARID_PS_NEXT			0x3005	/* complex */
 #define CSR_VARID_PS_SIZE			0x3006	/* complex */
+#define CSR_VARID_ADC_RES			0x3007	/* complex */
 #define CSR_VARID_CRYPT_KEY_LENGTH		0x3008	/* complex */
 #define CSR_VARID_PICONET_INSTANCE		0x3009	/* complex */
 #define CSR_VARID_GET_CLR_EVT			0x300a	/* complex */
@@ -62,6 +63,7 @@
 #define CSR_VARID_CANCEL_PAGE			0x4012	/* valueless */
 #define CSR_VARID_PS_CLR			0x4818	/* uint16 */
 #define CSR_VARID_MAP_SCO_PCM			0x481c	/* uint16 */
+#define CSR_VARID_ADC				0x4829	/* uint16 */
 #define CSR_VARID_SINGLE_CHAN			0x482e	/* uint16 */
 #define CSR_VARID_RADIOTEST			0x5004	/* complex */
 #define CSR_VARID_PS_CLR_STORES			0x500c	/* complex */
-- 
2.1.4
