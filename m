Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570D74F3EA7
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625684; cv=none; b=khCHYl1eJAgdequjhCbXwJYPgr8iUrsduiDHsDW9NJl1we/kcGP3ZMPECiJSDP6mBYrFjYVVOvigQnol2C858nBQYJLzZHNIja5bArdNXEjQeqFUHxi7tQAY6opPdifhn+oYLcAJEPweTJIbLy+9XBtCHmDIaXD8VGXdAG5NPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625684; c=relaxed/simple;
	bh=OV7SBkHxJfxKgpFXkAUD4AGlq/v0vhm5vZTET7FmHNI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMDYiVrQcSmPqC1+JDV6iCS/WsdO9pkYm0EHwVs8LJy82efYdnrQft3dADXTBm8ONVSPJF8qMipnO7AH9zsbaEijr3oi10EXCeo2VUYLfanrzLA8uQl7TNbOutBtcZg4Lfksn8uuLYcRJdjgl4IMSrMDiFUA3goqs7v2sGoEK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idBiEKlQ; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idBiEKlQ"
Received: by mail-vs2-f40.google.com with SMTP id 71dfb90a1353d-5c9b0bdf5b5so1279762e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625681; x=1791230481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0lk+hN/aPEWUN7r7WfMajmPREUjndpPZleLryBsYC3s=;
        b=idBiEKlQhuc09CE536oK9+aWsVNLquQpYuu6AD8xZbYyAj+Lq/5ngNI2Ap1yCbNmCs
         NClfu9IttyodEChBr9L+mAwlYPn88RagLXnEt0Pj5TGKTqyev6JJtBr6/3b8eyawcbjK
         /ftsYTFjb9TLqOmFmLxVaWKiGcoIm3+ADXdFU2D8/IOqr8iMPaW6jQ41hrSOgiI1zgTs
         vi+VgMiEQBnK/lLZoygiCVvnoM8ZJLOaC+LH9Wjghsnnpydv1rijWvjOgA4Z9EHohq0n
         ApbvKMRhRgrFiGXMuyPg+DA6tmobnOTulp7lCWVZoAccyt/dHETgx/pyUPw3QSq1y2Un
         r60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625681; x=1791230481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0lk+hN/aPEWUN7r7WfMajmPREUjndpPZleLryBsYC3s=;
        b=qnon3ULbhfgbfUCu/NNK97e421dexEN1sLQYYtzNfzj0lSHsU+Y8s6RrGtmNUvf8y3
         wr2DHy3W07Vt3GBEaCzjl6eKpJTXdiztNMFSxfPBF9jedhHQdOOjcdjK5IcUXsKG8lxI
         2UsOYRnIbYjKar0ysIbqITG60MJ2NQQBX3z1+Esj9ACXQIsJj+lEeNRpgJKjVchLXSl2
         lAKJKm4EcXHprfjXCP7mltTugrPHTdw9vExTuIVApPonJl7rbIbGJ1Fgru79hcvNXYnE
         moDtwoZt00gpR7o4jQjM3a8W4Lh735jk5B10ceTCsvCmFDCFnQLsRYPYOrW9iRT1p1j7
         yKSw==
X-Gm-Message-State: AFq9FYL8aRrQcIr1US9jizCGo5wIS+5MzPQOd1AUY5YB8BAWTLK/LbRE
	iqFQDKgVPpvzucAUkb+1KWcaaG95c85ODRrZ/X+U5VAhxPsbM23E70KKzsQI4KzfVUA=
X-Gm-Gg: AYBFou0g9Fx1Lfc89/RwjO+0IROlDrUxvg+fjqCimFIlWcbU7mEweNE+z8+1pQ28RCd
	ne6ye4Q3pWPtLHEd3YTsw3GvrsDOhgoLQMpy2U1EeJyrXdXvkjiWdDNevKT0405ma1OEWRAPdYJ
	hURUjlL6uFjPqN1N/Kwuq/Lm3eykxrhG5hPHp6TmjML30ns9SoYMzGohX5ef5XWVcBkFQ8V6ZXL
	MRWmHWVSEvTtOn/v1pBlQEVb6UtUM4TVdEWb00OKFqA7IqTTO0/5WpSCgqH8QtcExOvHtV6OWw4
	fHjRsSuTsd6mpTKLwRBQlqXZbdPEylXzJbl2wz44EWz7jGpqDjiwFtOWSJRoW2hnqzInRR5yk9Z
	8g8i3jcxGAZfOqJ+kKoRY8NrGcczdNYvMI+a3R/rhGeMQqGUQsQ7+k7RWiQNvHNUCsqRnxN1pAe
	w64iRML+CqXj8r/loNBgKYDlNpZVVFVguNC2QoKaJCnFsTE9YKnfmZDT/abcH27L/sjD6gsFtO5
	bP6qtpjheWravviain/whF4M7MlqS2HhgtdjfleAZIJvDdNPQiuGVYYdrtfXD6q6Q==
X-Received: by 2002:a05:6122:e44d:b0:5ce:d56f:efac with SMTP id 71dfb90a1353d-5ced56ff807mr1831401e0c.21.1790625680877;
        Mon, 28 Sep 2026 13:01:20 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.01.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:01:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 20/23] unit/test-uhid: Add Get Report tests
Date: Mon, 28 Sep 2026 16:00:26 -0400
Message-ID: <20260928200031.1209311-21-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add tests replying to UHID_GET_REPORT for a numbered Feature Report:

- /uhid/command/get_report_reply checks the reply contains the Report
  ID followed by the report data, with its size accounting for both
- /uhid/device/get_report creates a uHID device, requests the report
  through hidraw with HIDIOCGFEATURE and checks it returns the Report ID
  followed by the report data, as documented in
  Documentation/hid/hidraw.rst, since uhid copies the reply to the buffer
  of hid_hw_raw_request. It requires root and CONFIG_HIDRAW, otherwise
  it is not run.

Assisted-by: OpenCode:claude-opus-5.5
---
 unit/test-uhid.c | 272 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 272 insertions(+)

diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index c5848bef97f9..7ccfe8f375ff 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -18,7 +18,12 @@
 #include <inttypes.h>
 #include <string.h>
 #include <fcntl.h>
+#include <limits.h>
+#include <dirent.h>
+#include <errno.h>
+#include <sys/ioctl.h>
 #include <sys/socket.h>
+#include <linux/hidraw.h>
 
 #include <glib.h>
 
@@ -56,6 +61,14 @@ struct context {
 	int fd;
 	unsigned int pdu_offset;
 	const struct test_data *data;
+	/* Get Report through hidraw, see test_get_report */
+	guint poll;
+	unsigned int poll_count;
+	GThread *thread;
+	guint done;
+	uint8_t report[64];
+	int report_len;
+	int report_err;
 };
 
 #define event(args...)						\
@@ -100,6 +113,20 @@ static void destroy_context(struct context *context)
 	if (context->source > 0)
 		g_source_remove(context->source);
 
+	if (context->poll > 0)
+		g_source_remove(context->poll);
+
+	if (context->thread) {
+		/* Destroying the device fails the pending request, if any, so
+		 * the thread returns.
+		 */
+		bt_uhid_destroy(context->uhid, true);
+		g_thread_join(context->thread);
+	}
+
+	if (context->done > 0)
+		g_source_remove(context->done);
+
 	bt_uhid_unregister_all(context->uhid);
 	bt_uhid_unref(context->uhid);
 
@@ -331,6 +358,245 @@ static void test_server(gconstpointer data)
 }
 
 
+/* Feature Report 1: 8 bytes, which is numbered since the Report Map uses a
+ * Report ID.
+ */
+#define FEATURE_REPORT_ID	0x01
+#define FEATURE_REPORT		0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08
+
+static const uint8_t feature_report[] = { FEATURE_REPORT };
+
+static const struct uhid_event ev_get_report = {
+	.type = UHID_GET_REPORT,
+	.u.get_report = {
+		.id = 0x42,
+		.rnum = FEATURE_REPORT_ID,
+		.rtype = UHID_FEATURE_REPORT,
+	},
+};
+
+/* The reply contains the Report ID, followed by the report data, as the
+ * buffer returned by hid_hw_raw_request which uhid copies the reply to.
+ */
+static const struct uhid_event ev_get_report_reply = {
+	.type = UHID_GET_REPORT_REPLY,
+	.u.get_report_reply = {
+		.id = 0x42,
+		.err = 0,
+		.size = 1 + sizeof(feature_report),
+		.data = { FEATURE_REPORT_ID, FEATURE_REPORT },
+	},
+};
+
+static void handle_get_report(struct uhid_event *ev, void *user_data)
+{
+	struct context *context = user_data;
+	int err;
+
+	g_assert_cmpint(ev->type, ==, UHID_GET_REPORT);
+	g_assert_cmpint(ev->u.get_report.rnum, ==, FEATURE_REPORT_ID);
+	g_assert_cmpint(ev->u.get_report.rtype, ==, UHID_FEATURE_REPORT);
+
+	err = bt_uhid_get_report_reply(context->uhid, ev->u.get_report.id,
+					FEATURE_REPORT_ID, 0, feature_report,
+					sizeof(feature_report));
+	g_assert_cmpint(err, ==, 0);
+}
+
+static void test_get_report_reply(gconstpointer data)
+{
+	struct context *context = create_context(data);
+
+	bt_uhid_register(context->uhid, UHID_GET_REPORT, handle_get_report,
+								context);
+
+	g_idle_add(send_pdu, context);
+}
+
+static struct test_device get_report_device = {
+	.name = "BlueZ uHID Get Report",
+	.type = BT_UHID_NONE,
+	/* Vendor defined collection with Feature Report 1 of 8 bytes */
+	.map = UTIL_IOV_INIT(0x06, 0x00, 0xff, 0x09, 0x01, 0xa1, 0x01, 0x85,
+				FEATURE_REPORT_ID, 0x09, 0x01, 0x15, 0x00,
+				0x26, 0xff, 0x00, 0x75, 0x08, 0x95, 0x08,
+				0xb1, 0x02, 0xc0),
+};
+
+static gboolean get_report_done(gpointer user_data)
+{
+	struct context *context = user_data;
+	uint8_t expected[] = { FEATURE_REPORT_ID, FEATURE_REPORT };
+
+	g_thread_join(context->thread);
+	context->thread = NULL;
+	context->done = 0;
+
+	if (context->report_len < 0) {
+		tester_warn("HIDIOCGFEATURE: %s",
+					strerror(context->report_err));
+		tester_test_failed();
+		return FALSE;
+	}
+
+	if (tester_use_debug())
+		util_hexdump('>', context->report, context->report_len,
+						test_debug, "hidraw: ");
+
+	/* hidraw returns the Report ID in the first byte for numbered
+	 * reports, see Documentation/hid/hidraw.rst, followed by the data
+	 * of the reply.
+	 */
+	g_assert_cmpint(context->report_len, ==, sizeof(expected));
+	g_assert(!memcmp(context->report, expected, sizeof(expected)));
+
+	bt_uhid_destroy(context->uhid, true);
+	context_quit(context);
+
+	return FALSE;
+}
+
+static bool find_hidraw(const char *name, char *path, size_t len)
+{
+	DIR *dir;
+	struct dirent *d;
+	bool found = false;
+
+	dir = opendir("/sys/class/hidraw");
+	if (!dir)
+		return false;
+
+	while (!found && (d = readdir(dir))) {
+		char uevent[PATH_MAX], buf[1024];
+		ssize_t n;
+		int fd;
+
+		if (d->d_name[0] == '.')
+			continue;
+
+		snprintf(uevent, sizeof(uevent),
+				"/sys/class/hidraw/%s/device/uevent",
+				d->d_name);
+
+		fd = open(uevent, O_RDONLY);
+		if (fd < 0)
+			continue;
+
+		/* Start with a new line so every line can be matched in full */
+		buf[0] = '\n';
+
+		n = read(fd, buf + 1, sizeof(buf) - 2);
+		close(fd);
+		if (n <= 0)
+			continue;
+
+		buf[n + 1] = '\0';
+
+		if (strstr(buf, name)) {
+			snprintf(path, len, "/dev/%s", d->d_name);
+			found = true;
+		}
+	}
+
+	closedir(dir);
+
+	return found;
+}
+
+static char hidraw_path[PATH_MAX];
+
+static gpointer hidraw_get_feature(gpointer user_data)
+{
+	struct context *context = user_data;
+	int fd;
+
+	fd = open(hidraw_path, O_RDWR);
+	if (fd < 0) {
+		context->report_len = -1;
+		context->report_err = errno;
+		goto done;
+	}
+
+	/* The first byte is the Report ID of the requested report */
+	context->report[0] = FEATURE_REPORT_ID;
+
+	/* Blocks until the reply to UHID_GET_REPORT, which is handled by the
+	 * main loop.
+	 */
+	context->report_len = ioctl(fd, HIDIOCGFEATURE(sizeof(context->report)),
+							context->report);
+	context->report_err = errno;
+
+	close(fd);
+
+done:
+	/* Read by the main thread once joined */
+	context->done = g_idle_add(get_report_done, context);
+
+	return NULL;
+}
+
+static gboolean poll_hidraw(gpointer user_data)
+{
+	struct context *context = user_data;
+	char name[128];
+
+	/* Match the whole line, not another device named with a prefix */
+	snprintf(name, sizeof(name), "\nHID_NAME=%s\n",
+						get_report_device.name);
+
+	/* The hidraw device is created once the HID device is started */
+	if (!find_hidraw(name, hidraw_path, sizeof(hidraw_path))) {
+		if (++context->poll_count < 40)
+			return TRUE;
+
+		tester_warn("hidraw device not found, is CONFIG_HIDRAW set?");
+		context->poll = 0;
+		tester_test_failed();
+		return FALSE;
+	}
+
+	context->poll = 0;
+	context->thread = g_thread_new("hidraw", hidraw_get_feature, context);
+
+	return FALSE;
+}
+
+static void test_get_report(gconstpointer data)
+{
+	struct context *context;
+	struct test_device *device = ((struct test_data *) data)->test_device;
+	int err;
+
+	/* Requires the permissions to create uHID devices, and the kernel
+	 * to support hidraw.
+	 */
+	if (getuid() || access("/sys/class/hidraw", F_OK)) {
+		tester_test_abort();
+		return;
+	}
+
+	context = create_context(data);
+	if (!context)
+		return;
+
+	bt_uhid_register(context->uhid, UHID_GET_REPORT, handle_get_report,
+								context);
+
+	err = bt_uhid_create(context->uhid, device->name, BDADDR_ANY,
+				BDADDR_ANY, device->vendor, device->product,
+				device->version, device->country, device->type,
+				device->map.iov_base, device->map.iov_len);
+	if (err < 0) {
+		tester_warn("create failed: %s", strerror(-err));
+		destroy_context(context);
+		tester_test_failed();
+		return;
+	}
+
+	context->poll = g_timeout_add(50, poll_hidraw, context);
+}
+
 static struct test_device mx_anywhere_3 = {
 	.name = "MX Anywhere 3",
 	.vendor = 0x46D,
@@ -366,8 +632,14 @@ int main(int argc, char *argv[])
 	define_test("/uhid/event/output", test_server, event(&ev_output));
 	define_test("/uhid/event/feature", test_server, event(&ev_feature));
 
+	define_test("/uhid/command/get_report_reply", test_get_report_reply,
+					event(&ev_get_report),
+					event(&ev_get_report_reply));
+
 	define_test_device("/uhid/device/mx_anywhere_3", test_client,
 					&mx_anywhere_3, event(&ev_create));
+	define_test_device("/uhid/device/get_report", test_get_report,
+					&get_report_device, event(&ev_create));
 
 	return tester_run();
 }
-- 
2.55.0

