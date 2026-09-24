Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448543F8DE
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289075; cv=none; b=HXj7o1typL0laMZDhU0lK+rxc60LqVRkZkT/1FsAhQZexL34JDMBvMJPBmh3xGiCvNERD8cH3wTETMXMro0RP1wPdbTXkCDNAsnho4YMxkTtDakjA7IdcW21HM+xzNEerV+X33tQ1Xd29XhD4X0mjaY6PYghZvv9v+4+pL4QQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289075; c=relaxed/simple;
	bh=OV7SBkHxJfxKgpFXkAUD4AGlq/v0vhm5vZTET7FmHNI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hp2fCykGaSu4h0kuKrah81iWuQazFjs9H3h0NAvoWGHo3Kv6bFVduoTyc77z+2zcNDb51DV6V25oDdQpjV7TPbd/fnew619A0Bc9vljsCBelhYtulUframBqiIAgTcerZXnpaT8qdX6eSRubDfNHNKk9shQk49QEtcL/l0iPt44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGrdB/yw; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGrdB/yw"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c83397eeeeso171384e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289072; x=1790893872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0lk+hN/aPEWUN7r7WfMajmPREUjndpPZleLryBsYC3s=;
        b=XGrdB/ywSOKaatJ2xQgLHgGn+zXWeIxEFwTKSHy/VMJVwkEUb56rICUmuyg/bKtmvO
         ML/3WZ7fyuOYL7hmW+moeSq+GvotyrhCKF/FW3pLzJr7cfaZaXVqUgck/QIcN6sn4YeR
         JorWBp4xWoLLsbdnBgoUZdVcC2SyHmzndZdrFv8/NWAC97BMsdwwa3/zssbrLLLf3kB+
         Ysmk5sD1goPGgQc96UF1yAgWvbvxq3a2cvGbyT4Mw9qdJnxi3oRNi2plYzv8MJtx6XSS
         i6x2ajpXM4z+v6f+3jlorcoUTSzp3LDYS36URWJ0bzW46XYyqTo88tlgbmvEl05FqyEr
         liNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289072; x=1790893872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0lk+hN/aPEWUN7r7WfMajmPREUjndpPZleLryBsYC3s=;
        b=MnkrYhE2VuFkXNTa7hd3MHlfcfTcUvnRfDFC8FZu46gOnCgbq+f1ZIqpGV2gksPvQT
         1LHEigXpqibo0LGakhS9rSZ8IsbEzOHA1DPE6NVK23cAZagVfLEHuWXYpb5zDEQ1CJvv
         9htoGAryw0zIOap1IHWBS+0vCTP/8qirBlCEQXuNkPTjgmeAoKdISNR/Pbpsf3a2xWaj
         JdmgDFQVwNvQeJGV0U5HGsetmsy/uTkM/f0HKUGNF29Bh8eFFhV20e6OeGu+1iJiabWs
         XRTtlEI3M4g5g/fjFbEnmnWoNWlC2z05oJLaqV9tgPBss64YIASP6fWWBlDFbut1zban
         gTKQ==
X-Gm-Message-State: AFuF++nt6N2nZQVlNpwM5rLNTEcn7qNc635hY1FgLXN1GIhjyu5vEvlK
	dCWYeUHq+Jb+vWaik3v66082uC2Z0m6T0DQDUJoNanqN8i79aru4d/7yMfB12030UZ4+PA==
X-Gm-Gg: AYBFou0MoVHYHofZoyIR5Z8nO252bE2zlaniLdtc2hD1+eUtlkNsrCC1Ru9I9cgpVLY
	v5jMw01LXzOSoySHp9XhgHNWLKGTmpUaYZ4I2SNZvC4Z3cpFM1Y0+rd433BF2BVK9PkB68lzKj+
	RTMpjRQs/OvSWDaJfWnIySoWIZnqVx85wtcTsA56moqB2+3Fle+t+KmcuS3kzb9EVVhLktsYrVT
	dXCB82H4zQI4z6TqFarg87xZJCQpTFV8FCCJEyMDTQvUWan5D7NJDAH+sbETop99tU0aFlt0PKs
	n7jObiwboD+s1/ns79fyPErQ/jZEPnQyLlQPyoT/u5ME+CFLUHkfDtLjguT3wv9NDm1qfgCi+8Z
	o8w4tKlyMsx3gyOe7LPmzO9M1cn6OzxE8KzGPrPmIPUXUFx4lsCS3F+nutFY2s3MnPPb2/wsCwa
	CQ6r/Tc5WBDlGwRDKVHMnj3yHHH6sveoKLANQ3beK4WhPPOyKd1ubRjrJjWey/x5H97VoJ2vZ0k
	BUTXfZuZOzZG2GePknEMQxOQTa3flA8VjKHixI+VGbumV7v0grDWF+WDbGEFkziqTo9K/r4ezM=
X-Received: by 2002:a05:6122:3b89:b0:5c9:c60e:3a47 with SMTP id 71dfb90a1353d-5cb0adb0e2dmr2527409e0c.19.1790289072438;
        Thu, 24 Sep 2026 15:31:12 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc64f9c59csm890924e0c.11.2026.09.24.15.31.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:31:12 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 18/20] unit/test-uhid: Add Get Report tests
Date: Thu, 24 Sep 2026 18:30:43 -0400
Message-ID: <20260924223046.605543-19-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924223046.605543-1-luiz.dentz@gmail.com>
References: <20260924223046.605543-1-luiz.dentz@gmail.com>
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

