Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 11/25] android/hog: Add guards to the callbacks
Date: Tue,  9 Dec 2014 16:11:33 +0100
Message-Id: <1418137907-16981-12-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It might happen that there is ongoing gatt operation for HOG but HOG is
already disconnected. Let's check that before processing callback
---
 android/hog.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/android/hog.c b/android/hog.c
index 80bcc2e..8823f21 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -111,6 +111,15 @@ struct report {
 	uint8_t			*value;
 };
 
+static bool hog_is_connected(struct bt_hog *hog)
+{
+	if (hog && hog->attrib)
+		return true;
+
+	info("hog: HoG disconnected!");
+	return false;
+}
+
 struct gatt_request {
 	unsigned int req_id;
 	struct bt_hog *hog;
@@ -132,6 +141,9 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 	uint8_t *buf;
 	int err;
 
+	if (!hog_is_connected(hog))
+		return;
+
 	if (len < ATT_NOTIFICATION_HEADER_SIZE) {
 		error("Malformed ATT notification");
 		return;
@@ -170,6 +182,9 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 	struct report *report = user_data;
 	struct bt_hog *hog = report->hog;
 
+	if (!hog_is_connected(hog))
+		return;
+
 	if (status != 0) {
 		error("Write report characteristic descriptor failed: %s",
 							att_ecode2str(status));
@@ -199,6 +214,9 @@ static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
 {
 	struct report *report = user_data;
 
+	if (!hog_is_connected(report->hog))
+		return;
+
 	if (status != 0) {
 		error("Error reading CCC value: %s", att_ecode2str(status));
 		return;
@@ -212,6 +230,9 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 {
 	struct report *report = user_data;
 
+	if (!hog_is_connected(report->hog))
+		return;
+
 	if (status != 0) {
 		error("Read Report Reference descriptor failed: %s",
 							att_ecode2str(status));
@@ -241,6 +262,9 @@ static void discover_external_cb(uint8_t status, GSList *descs,
 {
 	struct bt_hog *hog = user_data;
 
+	if (!hog_is_connected(hog))
+		return;
+
 	if (status != 0) {
 		error("Discover external descriptors failed: %s",
 							att_ecode2str(status));
@@ -275,6 +299,9 @@ static void discover_report_cb(uint8_t status, GSList *descs,
 	struct report *report = user_data;
 	struct bt_hog *hog = report->hog;
 
+	if (!hog_is_connected(hog))
+		return;
+
 	if (status != 0) {
 		error("Discover report descriptors failed: %s",
 							att_ecode2str(status));
@@ -311,6 +338,9 @@ static void report_read_cb(guint8 status, const guint8 *pdu, guint16 len,
 {
 	struct report *report = user_data;
 
+	if (!hog_is_connected(report->hog))
+		return;
+
 	if (status != 0) {
 		error("Error reading Report value: %s", att_ecode2str(status));
 		return;
@@ -345,6 +375,9 @@ static void external_service_char_cb(uint8_t status, GSList *chars,
 	struct report *report;
 	GSList *l;
 
+	if (!hog_is_connected(hog))
+		return;
+
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
 		DBG("Discover external service characteristic failed: %s", str);
@@ -375,6 +408,9 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 	uint16_t uuid16;
 	bt_uuid_t uuid;
 
+	if (!hog_is_connected(hog))
+		return;
+
 	if (status != 0) {
 		error("Read External Report Reference descriptor failed: %s",
 							att_ecode2str(status));
@@ -590,6 +626,9 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	int i, err;
 	GError *gerr = NULL;
 
+	if (!hog_is_connected(hog))
+		return;
+
 	if (status != 0) {
 		error("Report Map read failed: %s", att_ecode2str(status));
 		return;
@@ -664,6 +703,9 @@ static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	uint8_t value[HID_INFO_SIZE];
 	ssize_t vlen;
 
+	if (!hog_is_connected(hog))
+		return;
+
 	if (status != 0) {
 		error("HID Information read failed: %s",
 						att_ecode2str(status));
@@ -691,6 +733,9 @@ static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	uint8_t value;
 	ssize_t vlen;
 
+	if (!hog_is_connected(hog))
+		return;
+
 	if (status != 0) {
 		error("Protocol Mode characteristic read failed: %s",
 							att_ecode2str(status));
@@ -725,6 +770,9 @@ static void char_discovered_cb(uint8_t status, GSList *chars,
 	GSList *l;
 	uint16_t info_handle = 0, proto_mode_handle = 0;
 
+
+	if (!hog_is_connected(hog))
+		return;
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
 		DBG("Discover all characteristics failed: %s", str);
@@ -878,6 +926,9 @@ static void find_included_cb(uint8_t status, GSList *services,
 
 	DBG("");
 
+	if (!hog_is_connected(hog))
+		return;
+
 	if (hog->primary)
 		return;
 
@@ -996,6 +1047,9 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 
 	DBG("");
 
+	if (!hog_is_connected(hog))
+		return;
+
 	if (status) {
 		const char *str = att_ecode2str(status);
 		DBG("Discover primary failed: %s", str);
-- 
1.8.4

