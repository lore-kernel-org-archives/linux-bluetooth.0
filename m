Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] Fix trivial coding style issues on pointer declarations and casting
Date: Tue, 21 Aug 2012 11:49:24 -0400
Message-Id: <1345564164-15930-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Avoid using C++ style pointer declarations like "char* ptr", as most
BlueZ code uses "char *ptr".
---

This is a very trivial patch, but changes are so small that it was worthy to
fix.

I avoided touching tools/ubcsp.c because it has even more coding style issues.


 audio/gstavdtpsink.h     |    2 +-
 audio/gstsbcutil.h       |    8 ++++----
 lib/sdp.c                |    4 ++--
 profiles/input/sixpair.c |    6 +++---
 test/l2test.c            |    4 ++--
 tools/hciattach.h        |    2 +-
 tools/hciattach_ti.c     |   22 +++++++++++++---------
 tools/ppporc.c           |    2 +-
 tools/rfcomm.c           |    4 ++--
 9 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/audio/gstavdtpsink.h b/audio/gstavdtpsink.h
index eb998ac..4862e7f 100644
--- a/audio/gstavdtpsink.h
+++ b/audio/gstavdtpsink.h
@@ -84,7 +84,7 @@ gboolean gst_avdtp_sink_set_device_caps(GstAvdtpSink *sink,
 guint gst_avdtp_sink_get_link_mtu(GstAvdtpSink *sink);
 
 void gst_avdtp_sink_set_device(GstAvdtpSink *sink,
-		const gchar* device);
+		const gchar *device);
 
 void gst_avdtp_sink_set_transport(GstAvdtpSink *sink,
 		const gchar *transport);
diff --git a/audio/gstsbcutil.h b/audio/gstsbcutil.h
index 5e47119..962532f 100644
--- a/audio/gstsbcutil.h
+++ b/audio/gstsbcutil.h
@@ -59,16 +59,16 @@ gint gst_sbc_parse_mode_to_sbc(const gchar *mode);
 const gchar *gst_sbc_parse_allocation_from_sbc(gint alloc);
 gint gst_sbc_parse_allocation_to_sbc(const gchar *allocation);
 
-GstCaps* gst_sbc_parse_caps_from_sbc(sbc_t *sbc);
+GstCaps *gst_sbc_parse_caps_from_sbc(sbc_t *sbc);
 
-GstCaps* gst_sbc_util_caps_fixate(GstCaps *caps, gchar** error_message);
+GstCaps *gst_sbc_util_caps_fixate(GstCaps *caps, gchar **error_message);
 
 void gst_sbc_util_set_structure_int_param(GstStructure *structure,
-			const gchar* field, gint field_value,
+			const gchar *field, gint field_value,
 			GValue *value);
 
 void gst_sbc_util_set_structure_string_param(GstStructure *structure,
-			const gchar* field, const gchar* field_value,
+			const gchar *field, const gchar *field_value,
 			GValue *value);
 
 gboolean gst_sbc_util_fill_sbc_params(sbc_t *sbc, GstCaps *caps);
diff --git a/lib/sdp.c b/lib/sdp.c
index 497a058..fcbe593 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -193,7 +193,7 @@ static char *string_lookup(struct tupla *pt0, int index)
 	return "";
 }
 
-static char *string_lookup_uuid(struct tupla *pt0, const uuid_t* uuid)
+static char *string_lookup_uuid(struct tupla *pt0, const uuid_t *uuid)
 {
 	uuid_t tmp_uuid;
 
@@ -4677,7 +4677,7 @@ int sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf)
 			goto fail;
 		}
 		for (r = p->data, j = 0; r; r = r->next, j++) {
-			sdp_data_t *data = (sdp_data_t*)r->data;
+			sdp_data_t *data = (sdp_data_t *)r->data;
 			dtds[j] = &data->dtd;
 			switch (data->dtd) {
 			case SDP_URL_STR8:
diff --git a/profiles/input/sixpair.c b/profiles/input/sixpair.c
index 5c50a58..c47e01a 100644
--- a/profiles/input/sixpair.c
+++ b/profiles/input/sixpair.c
@@ -44,7 +44,7 @@ show_master (libusb_device_handle *devh, int itfnum)
 	res = libusb_control_transfer (devh,
 				       LIBUSB_ENDPOINT_IN | LIBUSB_REQUEST_TYPE_CLASS | LIBUSB_RECIPIENT_INTERFACE,
 				       0x01, 0x03f5, itfnum,
-				       (void*) msg, sizeof(msg),
+				       (void *) msg, sizeof(msg),
 				       5000);
 
 	if (res < 0) {
@@ -67,7 +67,7 @@ get_bdaddr (libusb_device_handle *devh, int itfnum)
 	res = libusb_control_transfer (devh,
 				       LIBUSB_ENDPOINT_IN | LIBUSB_REQUEST_TYPE_CLASS | LIBUSB_RECIPIENT_INTERFACE,
 				       0x01, 0x03f2, itfnum,
-				       (void*) msg, sizeof(msg),
+				       (void *) msg, sizeof(msg),
 				       5000);
 
 	if (res < 0) {
@@ -109,7 +109,7 @@ set_master_bdaddr (libusb_device_handle *devh, int itfnum, char *host)
 	res = libusb_control_transfer (devh,
 				       LIBUSB_ENDPOINT_OUT | LIBUSB_REQUEST_TYPE_CLASS | LIBUSB_RECIPIENT_INTERFACE,
 				       0x09, 0x03f5, itfnum,
-				       (void*) msg, sizeof(msg),
+				       (void *) msg, sizeof(msg),
 				       5000);
 
 	if (res < 0) {
diff --git a/test/l2test.c b/test/l2test.c
index f66486d..d31be10 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -175,7 +175,7 @@ static float tv2fl(struct timeval tv)
 	return (float)tv.tv_sec + (float)(tv.tv_usec/1000000.0);
 }
 
-static char *ltoh(unsigned long c, char* s)
+static char *ltoh(unsigned long c, char *s)
 {
 	int c1;
 
@@ -199,7 +199,7 @@ static char *ltoh(unsigned long c, char* s)
 	return s;
 }
 
-static char *ctoh(char c, char* s)
+static char *ctoh(char c, char *s)
 {
 	char c1;
 
diff --git a/tools/hciattach.h b/tools/hciattach.h
index a24dbc4..1b23ad7 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -44,7 +44,7 @@
 #define HCI_UART_RESET_ON_INIT	1
 #define HCI_UART_CREATE_AMP	2
 
-int read_hci_event(int fd, unsigned char* buf, int size);
+int read_hci_event(int fd, unsigned char *buf, int size);
 int set_speed(int fd, struct termios *ti, int speed);
 
 int texas_init(int fd, int *speed, struct termios *ti);
diff --git a/tools/hciattach_ti.c b/tools/hciattach_ti.c
index 158e568..b57c6b7 100644
--- a/tools/hciattach_ti.c
+++ b/tools/hciattach_ti.c
@@ -109,10 +109,10 @@ struct bts_action_serial {
 	uint32_t flow_control;
 }__attribute__ ((packed));
 
-static FILE *bts_load_script(const char* file_name, uint32_t* version)
+static FILE *bts_load_script(const char *file_name, uint32_t *version)
 {
 	struct bts_header header;
-	FILE* fp;
+	FILE *fp;
 
 	fp = fopen(file_name, "rb");
 	if (!fp) {
@@ -141,8 +141,8 @@ errclose:
 	return NULL;
 }
 
-static unsigned long bts_fetch_action(FILE* fp, unsigned char* action_buf,
-				unsigned long buf_size, uint16_t* action_type)
+static unsigned long bts_fetch_action(FILE *fp, unsigned char *action_buf,
+				unsigned long buf_size, uint16_t *action_type)
 {
 	struct bts_action action_hdr;
 	unsigned long nread;
@@ -169,7 +169,7 @@ static unsigned long bts_fetch_action(FILE* fp, unsigned char* action_buf,
 	return nread * sizeof(uint8_t);
 }
 
-static void bts_unload_script(FILE* fp)
+static void bts_unload_script(FILE *fp)
 {
 	if (fp)
 		fclose(fp);
@@ -237,7 +237,7 @@ static int brf_set_serial_params(struct bts_action_serial *serial_action,
 	return 0;
 }
 
-static int brf_send_command_socket(int fd, struct bts_action_send* send_action)
+static int brf_send_command_socket(int fd, struct bts_action_send *send_action)
 {
 	char response[1024] = {0};
 	hci_command_hdr *cmd = (hci_command_hdr *) send_action->data;
@@ -267,7 +267,8 @@ static int brf_send_command_socket(int fd, struct bts_action_send* send_action)
 	return 0;
 }
 
-static int brf_send_command_file(int fd, struct bts_action_send* send_action, long size)
+static int brf_send_command_file(int fd, struct bts_action_send *send_action,
+								long size)
 {
 	unsigned char response[1024] = {0};
 	long ret = 0;
@@ -296,7 +297,8 @@ static int brf_send_command_file(int fd, struct bts_action_send* send_action, lo
 }
 
 
-static int brf_send_command(int fd, struct bts_action_send* send_action, long size, int hcill_installed)
+static int brf_send_command(int fd, struct bts_action_send *send_action,
+						long size, int hcill_installed)
 {
 	int ret = 0;
 	char *fixed_action;
@@ -320,7 +322,9 @@ static int brf_do_action(uint16_t brf_type, uint8_t *brf_action, long brf_size,
 	switch (brf_type) {
 	case ACTION_SEND_COMMAND:
 		DPRINTF("W");
-		ret = brf_send_command(fd, (struct bts_action_send*) brf_action, brf_size, hcill_installed);
+		ret = brf_send_command(fd,
+					(struct bts_action_send *) brf_action,
+					brf_size, hcill_installed);
 		break;
 	case ACTION_WAIT_EVENT:
 		DPRINTF("R");
diff --git a/tools/ppporc.c b/tools/ppporc.c
index ca44b40..5dad679 100644
--- a/tools/ppporc.c
+++ b/tools/ppporc.c
@@ -204,7 +204,7 @@ static void usage(void)
 	printf("Usage:\tppporc <bdaddr> [channel]\n");
 }
 
-int main(int argc, char** argv)
+int main(int argc, char **argv)
 {
 	struct sigaction sa;
 	int fd, err, opt;
diff --git a/tools/rfcomm.c b/tools/rfcomm.c
index add9f3b..e8bdd0f 100644
--- a/tools/rfcomm.c
+++ b/tools/rfcomm.c
@@ -223,14 +223,14 @@ static int release_all(int ctl)
 	return 0;
 }
 
-static void run_cmdline(struct pollfd *p, sigset_t* sigs, char *devname,
+static void run_cmdline(struct pollfd *p, sigset_t *sigs, char *devname,
 			int argc, char **argv)
 {
 	int i;
 	pid_t pid;
 	char **cmdargv;
 
-	cmdargv = malloc((argc + 1) * sizeof(char*));
+	cmdargv = malloc((argc + 1) * sizeof(char *));
 	if (!cmdargv)
 		return;
 
-- 
1.7.9.5

