Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0317B1AD9D4
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648301; cv=none; b=HF6GvHk85nV8UOzDv9Dh8LM6gLxP131rmY9axVyOxExFIVoWqcxge2lt2L3nx0ziYb1eXmWFeW+xdJqzoe3Pk+Hy7h2cifFUdoEkWDT+9VKPy5kMOtsK/C8YpypgzpTC5h1eIRBWnFTpj+b+ZRQn5IosyNWi1EKaHM60gWKbdLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648301; c=relaxed/simple;
	bh=yJqc70wp4Eoxg8mFcmIkQR4F7E8WQ7lJVfO2+9kTV+Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CC+oJEULkgu1fFxDYe+X5E7JAFdQxSQQh/gvZCCwHdt2T9nlt2rxNo7fhGwwPJeLGCejNSkV2G2atbeokY1fq46Z+J5JbIHd3KYNsi2uOx1MY6eznWikR2Jj7mHi3ivM3CwIiHVEcJDcA8TJOspNExxPosepFslNKb7EZinj6AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXtyTMH1; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXtyTMH1"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-65f9708c50dso158867b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723648298; x=1724253098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WgPL/SsVewAK5Kcj7Nki/VIMiF2GVMi3oLQ3SucY0S4=;
        b=UXtyTMH1uux3Ki3M4lkFpUpNZFleQgZaJNcCt4OY57Q0QMuZOlR6ugYUblYWWDbZpe
         EmVxU4JRlRdamI3gjtXA+y9UnjvI9+RbqmOz3FL9o52O8JKRmfyby6hu37vc7mrt5WUQ
         OHyhD80DhiDb3tG8AyY+kYio0T20quroZL9uKEZ1O6rodryJpg3Hr+by5DsM4IA8fKgf
         pWI/V/mTcifTS0nsuPWeG9MMk6QvazIgiw0uOJRUcfxiPaYM0xlh84bgWUjn22sKtXPV
         atZZgtqqAHTAHLPz3WT96QcaJt9X2gl9BtMICVMhxXIlh1yr6r43SGVe5SBo/XrnFuac
         j2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723648298; x=1724253098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgPL/SsVewAK5Kcj7Nki/VIMiF2GVMi3oLQ3SucY0S4=;
        b=D4a/icNSthPU5ESjfvDTbnZczBo29oCy2uykaXwYzCllXMNhBkBpX5eJkhJ+5N06z+
         +9cshLWZ281xowEPvXqnjoEjOpWwprrPYC+id6e+d/EYmGtTgCldttUeiCzPOFBDTgnq
         AORBv6THoWmCsLcIr5Y3wMTHjhoQJNqiljdb3h5AhEGBbIaTWajYEcktHAbYGyh+q2rL
         Lpyg+DIH4NTTiKGwL+CFCPkwCZTNrF+DXBUh4zxlM2D1CaTaMJU+th4xl4rr2Ltm3++N
         wD1SsEK8y9pVE5AJr+aOF9a59+NtPrVJRk5j+D1SQ/kc6xVIU5sKlxULRrWRuSDzEkOU
         GXAA==
X-Gm-Message-State: AOJu0YxBA2DxUgB1lB+8lP6eZeG9Xt92lbADlWuzSKrql2KW5or8fbxr
	cjxceSPWZ5+vhZNsTlMbfwQ61+HVwwcGRgmZUMIgZ/gs3EuAaKwk612FLElA
X-Google-Smtp-Source: AGHT+IGpjYCpDRrLzaTyJbPbbL8tdqe6K5kD6H3mEX1X6FywoWR2GaOqfd9uetuMGpfQMerlfR82OQ==
X-Received: by 2002:a05:690c:26c5:b0:631:3c7c:f766 with SMTP id 00721157ae682-6ac99dbb5aamr31824637b3.34.1723648298042;
        Wed, 14 Aug 2024 08:11:38 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a50a2786sm16051527b3.141.2024.08.14.08.11.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:11:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] test-uhid: Add support for device specific testing
Date: Wed, 14 Aug 2024 11:11:35 -0400
Message-ID: <20240814151135.725001-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables device specific testing and switch to run
bt_uhid_new_default when running as root so the actual kernel driver is
used:

input: MX Anywhere 3 as /devices/virtual/misc/uhid/0005:046D:B025.0031/input/input86
logitech-hidpp-device 0005:046D:B025.0031: input,hidraw10: BLUETOOTH HID v0.14 Mouse [MX Anywhere 3] on 00:00:00:00:00:00
---
 unit/test-uhid.c | 70 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index 573da318d480..2765feb72b06 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -33,8 +33,19 @@ struct test_pdu {
 	size_t size;
 };
 
+struct test_device {
+	const char *name;
+	uint32_t vendor;
+	uint32_t product;
+	uint32_t version;
+	uint32_t country;
+	uint8_t type;
+	struct iovec map;
+};
+
 struct test_data {
 	char *test_name;
+	struct test_device *test_device;
 	struct test_pdu *pdu_list;
 };
 
@@ -54,17 +65,21 @@ struct context {
 		.size = sizeof(*args),				\
 	}
 
-#define define_test(name, function, args...)				\
+#define define_test_device(name, function, device, args...)		\
 	do {								\
 		const struct test_pdu pdus[] = {			\
 			args, { }					\
 		};							\
 		static struct test_data data;				\
 		data.test_name = g_strdup(name);			\
+		data.test_device = device;				\
 		data.pdu_list = util_memdup(pdus, sizeof(pdus));	\
 		tester_add(name, &data, NULL, function, NULL);		\
 	} while (0)
 
+#define define_test(name, function, args...)			\
+	define_test_device(name, function, NULL, args)
+
 static void test_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
@@ -174,8 +189,20 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 static struct context *create_context(gconstpointer data)
 {
 	struct context *context = g_new0(struct context, 1);
+	const struct test_data *test_data = data;
 	GIOChannel *channel;
 	int err, sv[2];
+	uid_t uid = getuid();
+
+	context->data = data;
+
+	/* Device testings requires extra permissions in order to be able to
+	 * create devices.
+	 */
+	if (test_data->test_device && !uid) {
+		context->uhid = bt_uhid_new_default();
+		return context;
+	}
 
 	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
 	g_assert(err == 0);
@@ -197,7 +224,6 @@ static struct context *create_context(gconstpointer data)
 	g_io_channel_unref(channel);
 
 	context->fd = sv[1];
-	context->data = data;
 
 	return context;
 }
@@ -229,10 +255,20 @@ static const struct uhid_event ev_feature = {
 static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(data);
+	struct test_device *device = context->data->test_device;
 	int err;
 
-	err = bt_uhid_create(context->uhid, "", NULL, NULL, 0, 0, 0, 0,
-				BT_UHID_NONE, NULL, 0);
+	if (device)
+		err = bt_uhid_create(context->uhid, device->name,
+					BDADDR_ANY, BDADDR_ANY,
+					device->vendor, device->product,
+					device->version, device->country,
+					device->type, device->map.iov_base,
+					device->map.iov_len);
+	else
+		err = bt_uhid_create(context->uhid, "", NULL, NULL, 0, 0, 0, 0,
+					BT_UHID_NONE, NULL, 0);
+
 	if (err < 0) {
 		tester_debug("create failed: %s\n", strerror(-err));
 		tester_test_failed();
@@ -284,6 +320,29 @@ static void test_server(gconstpointer data)
 	g_idle_add(send_pdu, context);
 }
 
+
+static struct test_device mx_anywhere_3 = {
+	.name = "MX Anywhere 3",
+	.vendor = 0x46D,
+	.product = 0xB025,
+	.version = 0x14,
+	.country = 0x00,
+	.type = BT_UHID_MOUSE,
+	.map = UTIL_IOV_INIT(0x05, 0x01, 0x09, 0x02, 0xA1, 0x01, 0x85, 0x02,
+				0x09, 0x01, 0xA1, 0x00, 0x95, 0x10, 0x75, 0x01,
+				0x15, 0x00, 0x25, 0x01, 0x05, 0x09, 0x19, 0x01,
+				0x29, 0x10, 0x81, 0x02, 0x05, 0x01, 0x16, 0x01,
+				0xF8, 0x26, 0xFF, 0x07, 0x75, 0x0C, 0x95, 0x02,
+				0x09, 0x30, 0x09, 0x31, 0x81, 0x06, 0x15, 0x81,
+				0x25, 0x7F, 0x75, 0x08, 0x95, 0x01, 0x09, 0x38,
+				0x81, 0x06, 0x95, 0x01, 0x05, 0x0C, 0x0A, 0x38,
+				0x02, 0x81, 0x06, 0xC0, 0xC0, 0x06, 0x43, 0xFF,
+				0x0A, 0x02, 0x02, 0xA1, 0x01, 0x85, 0x11, 0x75,
+				0x08, 0x95, 0x13, 0x15, 0x00, 0x26, 0xFF, 0x00,
+				0x09, 0x02, 0x81, 0x00, 0x09, 0x02, 0x91, 0x00,
+				0xC0),
+};
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -297,5 +356,8 @@ int main(int argc, char *argv[])
 	define_test("/uhid/event/output", test_server, event(&ev_output));
 	define_test("/uhid/event/feature", test_server, event(&ev_feature));
 
+	define_test_device("/uhid/device/mx_anywhere_3", test_client,
+					&mx_anywhere_3, event(&ev_create));
+
 	return tester_run();
 }
-- 
2.46.0

