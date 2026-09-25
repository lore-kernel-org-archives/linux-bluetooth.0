Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3479844C4F0
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373825; cv=pass; b=OaKrtWJfoJSjkHZxjMy8ZlrtLIp23MrxZL30PNkk+soKNzWSwXDqT+verqeWf0TDf5ww3vTDgsp3sVs57YkYOOf46u208LAPrBs/cXhH0Agjr2ZQqpORdY5zPGcFKSPVGzsbOHySaEopSlIw68EyGUFAlYQKYd7Wm+GuQsWrslI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373825; c=relaxed/simple;
	bh=sg36o/4bWtlBNm1Efj0YhxZyjP2yJ4xImlRqAxJ2oJ4=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Content-Type; b=GU7C+V30lrlZ5UGe2EqwNRJA3p4QNfO89PcBO98djR2T1FWy12YhgS1nvDaeDfIofmlZnlDbqUkTdI8F66YKn3cAnNcDwfN6e+CJ7+5dJ9KPFDTI++xmQ9fH9lw2vFNbkXa6b0JE2mIvDJ6TsvKLMJIgo5/PfQP6rX/q3kDHRmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEqhNAuO; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEqhNAuO"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e25187so582313b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790373823; cv=none;
        d=google.com; s=arc-20260327;
        b=gJabA5sKE+8iVDlHG1HUuo7Q3YEP/RfUW65ZoIQgglUA0qavUrPR1cIp7vbDRfpuoP
         /8HY1olVY9sDh8irGO6Sy0Wpj/Ou6xauSrA/Dz8uQjv+iUGZFZ0/OFazMXif0xkMcB2w
         tN+22Ej1GxOl2OiI8DJS65cyF8PerKoj3LD8a22ScuhjG55uZZLGsdYwO4XGeYF95xsX
         QT5gC65AcKeZhd1cFZhB7tHrZuygwFhNxvX7MzXMWDrdPXJIXwMxqxGdebHu+mx2gqm+
         S3NxHfSKK5gLx6hCEz4v0ygUgPJeT8UE8LD1GvqUViK43OrybvZsWRpYRhgBYxsbbsn9
         /krA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:references:in-reply-to:from:mime-version
         :dkim-signature;
        bh=uo2t4xPK8JBk7AfbYWO2Mli1eqGuJsezufpI564OIVw=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=lCo27y3OhmrlIipF2W0/Mf75OEvrRF4v6UWId/yGk+jZnC1su0ON3cdOm4JOEJBkhF
         mW8Txdb9IRYChgYMKd35lZFNnkGVZbmEgXxHoNhdnuVZ0c5GWTcH5SBQnpEhBudNDlsL
         op/vxhtrklotVFVioKm1Gh1/5Dc9uFgKKL5SBaB9S/iT+a3OOakzWVrE73aaYkPdRy+D
         B3L5pY2H8UkndTKWqyMDV5bvsFCOBWg0RnQT4BX6v0Lp+VbyChAxvBLe5x0IIX9b6Txs
         wN0DoXqDk2OWfGcNtBSh86Ai6yQWX8mXrB1CnbQAgk1BYq2Sb83HLCf21ngxVbJWnfXC
         k+wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790373823; x=1790978623; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uo2t4xPK8JBk7AfbYWO2Mli1eqGuJsezufpI564OIVw=;
        b=WEqhNAuO/cyfi1035ncLSsaGgLMNLab3Sw08plYxjL6hwwheShhvKNt6K3DBiqX9AI
         Px91V8cbcAqkl9ugeb10pQ4OPyR6ylm/vH4DWAepS6RRkv9OiXvmbrie7gVrKTW74nlL
         xLz35cjDrq/YZdlLL3m1KcOIYK7e+0ETb8ct9CRN8UqGDv1q4JG0XvKmFUDMx8Ju+uaY
         1+2X6chH5W0+RGk2KcvWMX7iBgvn5DHNbJgqAo5xCD7Kxv6xGLY+pm21IvZGbDzTr8Kx
         CUmMBFu7bkperqsVXDBS5/r6t1S2Zr3rnyZtxqfc2HaAmgtf5646jj0vP9itrubkcYZD
         /HHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790373823; x=1790978623;
        h=content-type:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uo2t4xPK8JBk7AfbYWO2Mli1eqGuJsezufpI564OIVw=;
        b=x/iI32pZLKCUEFXr29/+rijlAtbcEkR0apL6XH41GCNoECXQGA7KNgra1YjcOkdXc+
         GKJQgzAEdB3De44hj/LhiA7W4jeBXm52plX0AnUC0cWFf4rLCu9M9LGMeO0rjsbP1nhf
         L8pI3L/oCZrvv2BSJLmHZcDyvXazaF0exq5brmyrev79LwfgN7N7Pz27XqFpJj33zSGT
         B7fKMVFl5EcnaFwZos4fUFaxbpUdlnFzQ67h5VYU6juuvNFcwU5htHqyQu+3aTxtFCiR
         0h8uuUA+BbInEN6TjoQc7ZPpHPsRLwC7hU/EOLOGhFLyOPrxj6OprG5uS2Bamp1hsD2l
         baiA==
X-Gm-Message-State: AFuF++ks2fJG5TU5gx6UuOLtURBgA4fXJVwbQDVNuK33IIOZI7LEPLN2
	UnJfxC/t4uFwpda6GeOxqjyMFT4D3U1xVCUZJoGlD566CQk/utILMK+yBM7YIdRc1qRRYjCuTRc
	hVeR4oXJbyFv/1rCUPKMElB75KUgqIRXQpg==
X-Gm-Gg: AYBFou22aeg8PzvqCjLgS6E3krVCMmsJx3MpoS7Hsz8UEern+d5xkys1745kFF4giUP
	KrqudGmTmF8wLpMdLdqs3W/BCP7tPj3bDZyaD5i+vEmVxPWdYtJfqSH0RYsRPjqHEkR1doPdhBB
	i/7zRIQM6QeVWJERcTqw565gHDZvuehxBW1VgsiF4BtEtyD5hjhcUgRQZaps8TA8CSdmaaIlOLq
	qDSNWgS8pAjCWkDjV9DbLuX/mPXA1vz55jLKNJol1AdE0KXRJiSgfguS05AIhlQ2APPGK9emwUn
	W3UUskpAP3JV8YznS6G/oQuuk5Ldx1Ow43zzDbp3VRl5o3G2v39viw==
X-Received: by 2002:a05:6a00:418d:b0:878:34d7:69b2 with SMTP id
 d2e1a72fcca58-87e9cd0c246mr5734594b3a.57.1790373823184; Fri, 25 Sep 2026
 15:03:43 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 17:03:41 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 16:58:27 -0500
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Fri, 25 Sep 2026 16:58:15 -0500
From: Giuseppe Piscitelli <ooonea@gmail.com>
In-Reply-To: <CACmoRBYhQg2kAp04fFeNyArgQRoMHpBwpNX3b0-1knp6RiLpWw@mail.gmail.com>
References: <CACmoRBYhQg2kAp04fFeNyArgQRoMHpBwpNX3b0-1knp6RiLpWw@mail.gmail.com>
Date: Fri, 25 Sep 2026 17:03:41 -0500
X-Gm-Features: AclHuK8F0kMiIlNVQ3_mZ01QvbrHPYWtE_RKQd3FoUUCm3KzhWHTLi8drHMcHOs
Message-ID: <CACmoRBYCiLYXr05CLjvAA4wPpbjje2BhFHe1v9fEfSFAWFR89w@mail.gmail.com>
Subject: [PATCH BlueZ v2 2/2] unit: Test HoG report map reads after reconnect
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Giuseppe Piscitelli <35407790+ooonea@users.noreply.github.com>

Exercise reconnect after an ATT error and after cancelling a pending
Report Map read. Require a fresh read and validate the resulting
UHID_CREATE2 descriptor on a simulated transport.

Stub Bluetooth address lookup for the Unix socketpair fixture. Both
cases fail without resetting report_map_id on detach.

Assisted-by: OpenAI Codex:gpt-6
---
v2: Resend without quoted email history; code unchanged.

 Makefile.am     |   2 +-
 unit/test-hog.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 1d46b9b..1621794 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -767,7 +767,7 @@ unit_test_gatt_LDADD = src/libshared-glib.la \
 unit_tests += unit/test-hog

 unit_test_hog_SOURCES = unit/test-hog.c \
-			$(btio_sources) \
+			btio/btio.h \
 			profiles/input/hog-lib.h profiles/input/hog-lib.c \
 			profiles/scanparam/scpp.h profiles/scanparam/scpp.c \
 			profiles/battery/bas.h profiles/battery/bas.c \
diff --git a/unit/test-hog.c b/unit/test-hog.c
index 45ffe71..405af8a 100644
--- a/unit/test-hog.c
+++ b/unit/test-hog.c
@@ -17,6 +17,8 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <fcntl.h>
+#include <stdarg.h>
+#include <linux/uhid.h>

 #include <glib.h>

@@ -30,9 +32,28 @@
 #include "src/shared/gatt-db.h"

 #include "attrib/gattrib.h"
+#include "btio/btio.h"

 #include "profiles/input/hog-lib.h"

+gboolean bt_io_get(GIOChannel *io, GError **error, BtIOOption opt, ...)
+{
+	va_list args;
+
+	va_start(args, opt);
+
+	while (opt != BT_IO_OPT_INVALID) {
+		g_assert(opt == BT_IO_OPT_SOURCE_BDADDR ||
+					opt == BT_IO_OPT_DEST_BDADDR);
+		memset(va_arg(args, bdaddr_t *), 0, sizeof(bdaddr_t));
+		opt = va_arg(args, int);
+	}
+
+	va_end(args);
+
+	return TRUE;
+}
+
 struct test_pdu {
 	bool valid;
 	const uint8_t *data;
@@ -211,10 +232,128 @@ static void test_hog(gconstpointer data)
 	g_assert(bt_hog_attach(context->hog, context->attrib));
 }

+static ssize_t receive(int fd, void *buf, size_t size)
+{
+	gint64 deadline = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+	ssize_t len;
+
+	do {
+		while (g_main_context_iteration(NULL, FALSE))
+			;
+
+		len = recv(fd, buf, size, MSG_DONTWAIT);
+		if (len >= 0)
+			return len;
+
+		g_usleep(1000);
+	} while (g_get_monotonic_time() < deadline);
+
+	return -1;
+}
+
+static void expect_read(int fd, uint8_t handle)
+{
+	uint8_t buf[32];
+	ssize_t len = receive(fd, buf, sizeof(buf));
+
+	g_assert_cmpint(len, ==, 3);
+	g_assert_cmpuint(buf[0], ==, BT_ATT_OP_READ_REQ);
+	g_assert_cmpuint(buf[1], ==, handle);
+	g_assert_cmpuint(buf[2], ==, 0);
+}
+
+static void respond(int fd, const void *buf, size_t size)
+{
+	g_assert_cmpint(send(fd, buf, size, 0), ==, size);
+}
+
+static void test_reconnect(gconstpointer data)
+{
+	const uint8_t info[] = { 0x0b, 0x11, 0x01, 0x00, 0x00 };
+	const uint8_t error[] = { 0x01, 0x0a, 0x05, 0x00, 0x0e };
+	const uint8_t map[] = { 0x0b, 0x05, 0x01, 0x09, 0x02, 0xa1, 0x01,
+				0x09, 0x30, 0x15, 0x81, 0x25, 0x7f, 0x75,
+				0x08, 0x95, 0x01, 0x81, 0x06, 0xc0 };
+	struct gatt_db *db = gatt_db_new();
+	struct gatt_db_attribute *service;
+	struct bt_hog *hog;
+	struct uhid_event ev;
+	GIOChannel *channel;
+	GAttrib *attrib;
+	bt_uuid_t uuid;
+	int att[2], uhid[2];
+	bool cancel = GPOINTER_TO_INT(data);
+
+	g_assert_cmpint(socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK,
+							0, att), ==, 0);
+	g_assert_cmpint(socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK,
+							0, uhid), ==, 0);
+	bt_uuid16_create(&uuid, 0x1812);
+	service = gatt_db_add_service(db, &uuid, true, 5);
+	g_assert(service);
+	bt_uuid16_create(&uuid, 0x2a4a);
+	g_assert(gatt_db_service_add_characteristic(service, &uuid,
+				BT_ATT_PERM_READ, 0x02, NULL, NULL, NULL));
+	bt_uuid16_create(&uuid, 0x2a4b);
+	g_assert(gatt_db_service_add_characteristic(service, &uuid,
+				BT_ATT_PERM_READ, 0x02, NULL, NULL, NULL));
+	gatt_db_service_set_active(service, true);
+	channel = g_io_channel_unix_new(att[0]);
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	attrib = g_attrib_new(channel, 23, false);
+	g_io_channel_unref(channel);
+	hog = bt_hog_new(uhid[0], "report-map-test", 1, 1, 1, 0, db);
+	g_assert(hog);
+	g_assert(bt_hog_attach(hog, attrib));
+	expect_read(att[1], 3);
+	respond(att[1], info, sizeof(info));
+	expect_read(att[1], 5);
+
+	if (!cancel) {
+		respond(att[1], error, sizeof(error));
+
+		while (g_main_context_iteration(NULL, FALSE))
+			;
+	}
+
+	bt_hog_detach(hog, false);
+	g_attrib_unref(attrib);
+	close(att[1]);
+	g_assert_cmpint(socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_NONBLOCK,
+							0, att), ==, 0);
+	channel = g_io_channel_unix_new(att[0]);
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	attrib = g_attrib_new(channel, 23, false);
+	g_io_channel_unref(channel);
+	g_assert(bt_hog_attach(hog, attrib));
+	expect_read(att[1], 3);
+	respond(att[1], info, sizeof(info));
+	expect_read(att[1], 5);
+	respond(att[1], map, sizeof(map));
+	g_assert_cmpint(receive(uhid[1], &ev, sizeof(ev)), ==, sizeof(ev));
+	g_assert_cmpuint(ev.type, ==, UHID_CREATE2);
+	g_assert_cmpuint(ev.u.create2.rd_size, ==, sizeof(map) - 1);
+	g_assert_cmpmem(ev.u.create2.rd_data, ev.u.create2.rd_size,
+						map + 1, sizeof(map) - 1);
+	bt_hog_detach(hog, true);
+	bt_hog_unref(hog);
+	g_attrib_unref(attrib);
+	gatt_db_unref(db);
+	close(att[1]);
+	close(uhid[0]);
+	close(uhid[1]);
+	tester_test_passed();
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);

+	tester_add("/hog/report-map/error-reconnect", GINT_TO_POINTER(false),
+					NULL, test_reconnect, NULL);
+	tester_add("/hog/report-map/cancel-reconnect", GINT_TO_POINTER(true),
+					NULL, test_reconnect, NULL);
+
 	define_test("/TP/HGRF/RH/BV-01-I", test_hog,
 		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 		raw_pdu(0x11, 0x06, 0x01, 0x00, 0x04, 0x00, 0x12,
