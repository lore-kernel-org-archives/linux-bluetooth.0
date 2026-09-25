Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1C48380C
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358190; cv=pass; b=pgCihkb/ioF5DHlWqAf0J41OpdrxoSU/g1txLze8jax5NaUA5c9Nxjeo1rlj/l/55KRPuOworyOHvQUZDXpD2oQntXsV116Xia6qVoWh0I6ZPZ9jYEcDymfMxkgAY/MoSuuwzk7WsT/tUQIGIe1jbAC/6W1O05h988qQfgyfHMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358190; c=relaxed/simple;
	bh=lbS1uRJZzg9GdrzNCmOtNeHNxaFuC7qz0eo3sSNcPLE=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Content-Type; b=j8jpYcLwz+iulQkueK6gWyoocLd2DF1g0Z7d12MDZq7QAR12p0T3uFap53PIY2KLNYtlDKFxNOmy9YUry3s63vvET++XNzhr9v+NHP8xoMCrqPcN1eKGHo74FihunYPADJptSGHZ6o5cNnMS4gVsP1LiTtoNIWswHsQE4Sc48Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvW/TEDR; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvW/TEDR"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so825865a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 10:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790358188; cv=none;
        d=google.com; s=arc-20260327;
        b=X5burTCl9onkLGxnDwD3AVi7b8K8D2njld25jba6KkxOnTVHE2+BG3fuCBpIiNQ53F
         u+GcWfzMEW9GtYVrSau+Cv35eJnRy3wYrrCqMHw/rrmdDMl6GbhOf7Yx/bB1Cr6b2a6X
         mg7XmXUaRXiUs36kQhu1makkfMUF9yphrJXC9tzMVlongOpuBK3TLvCOl1bRWS6bysJi
         2VE/QO5j0FhwFXjfgDKoOVCJ9H89JQXq5eY/tuYPTjhk79OTOyPBTYHXKgwMjfZSo/82
         WLG8zoiXgXOnSh3PR/lWv4a4F7SzJQwHN6GVtC68OV3vkTj/k5ToI91OXCbEvYsdyQDF
         8p+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:references:in-reply-to:from:mime-version
         :dkim-signature;
        bh=qIl1kaCqa88h/F0spFUsJPsJ6PJblHik94utcR8dVjI=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=sh11tMLCeLcOdYHfWiWGIuDbPzavaY0d4F3x97T8iJROaavoCGKPK9JcBpZ/UcWdx6
         QmBfgsfdzW/Mg5Ham7N8Ia99gtWhKXLtrathWRcbjigkh+9jiaigGqA7YjYkvSa9ZbWO
         v/RsVRHdbovQoz3hc6bVMz6DRFTN9jZtDb903SS20Zm3hSnJByGWD5f7XwUfm1Tj9vpC
         hcfCNlXwIp1fAfsA0T8juqtWN3PPSOlVbwhOVCp2a5k1+LR2Ka+tl0V10qQ8+xCGP/aI
         8V2tA9Anzcz/l3I/BjnY5qbGwRzBJo5VnjKaeizWUsYY5VyXiM7ZZGLyBrJgWqTJcCRT
         L8DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790358188; x=1790962988; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qIl1kaCqa88h/F0spFUsJPsJ6PJblHik94utcR8dVjI=;
        b=dvW/TEDRRp7L7KEcVHCjTHTiVlXkmBIl2MG6rmmg2NO7OYN86m7Y5+KYN7I6nYPOBC
         Ptx05ePp2/oQbHaHU1H2AzRzyN3z2vJ9W0+dy7HQa8A7vSUr07IPoRhDe9Wm5sHRP8RN
         YGPybzyVJ3T+qd8DFESYVX2rBzfwzr0XsCAeFeE1Y3wrj1e2bkxUr3RMtIcfeC1KNCHl
         AvuhEWNBfFT8Kz6BdsQmPq/b7ajV5TIr+RqS2n6GGRLmuAjiQn9Vxfh+ygo7qWdZGo+5
         vtbR85KU/0iluLBM3ytvYPg/pmb0obFvrR8KxB9u9K93p2CIr1BLHHZfXlV0xpPa+fv+
         SxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790358188; x=1790962988;
        h=content-type:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qIl1kaCqa88h/F0spFUsJPsJ6PJblHik94utcR8dVjI=;
        b=Q3G5iMnVxvH9Z+OyakKhhpXNDlN6/rnNmrWQdOxEJQil1pLaJV3QVDwIVeMkoLEiwH
         OgRhA7hVDT2NqjC2A069pf5HilOO13/bOD3x5Bj6YVkmJxZO46jAZ9rmYuVWIYIIUog0
         lX6pE6a5MVoIKuIusIESub7YDW93YzyslMOWfX6xlBC45Ta8EcewykndQZzrGaFiOlxr
         ZCFL2rFycAx58GjkGJ4MMCnv8dawS+XoX58RwFRYAArXMIkqfofQvFoNfZmft+cCVoNP
         RGK2Qn5sU4sCiJhd1K8JyuGGG0KQd+k4bdfh5qlZRn1H/R2pVOOhwsgJCIlQM645qu8Q
         bH5g==
X-Gm-Message-State: AFuF++mW5iE45q8FXK4vcdMvNXdqaazTjMNgaPM6ABkQQ7VcMHOPjofO
	qwP9qeDpD4J63Y190PyrDz3vpoW8zxSAFkJZ81FiH2mh7GH2pr+mQZcR5ceGhIA5sWNwVKOcAMH
	iE197V9RdQG4vMg/hFMcahEKLbE8raZmBRw==
X-Gm-Gg: AYBFou2KIms0l0RczqTSzAFcv/d33NMT1ZAt0D36fdgR8lyZooBDqoNgTcr5NQB/P2J
	VVcDRkyhSZoZ6WX7o3J4I7jOn6lMky5+PcLpmc1Cw+ZqradbiQmAAxoFYuQ1bWzpfhSLxXEZk9h
	jc1DDXuCqBaTVm+cBEnWK7HC3U25OmdI5HFgWcp3AMcU0b4DiCl+Rn+HPVKzl+w9QTTEoJE32U3
	/LYwskf2PCexUQAgP1Z60ZnFRvmF+xKLonCExrni3zh2gvDHWBwSR39lUZz4OCec8TObWrkDiJC
	WlfU2UqR9Ada6b1zSbj5nsT+822Vd9l30HaeQDFENukdxcxva4nhL/4=
X-Received: by 2002:a17:90b:4fc9:b0:3a0:c9aa:b68 with SMTP id
 98e67ed59e1d1-3a0c9aa2b17mr1267047a91.58.1790358188422; Fri, 25 Sep 2026
 10:43:08 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 12:43:06 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 12:43:06 -0500
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Giuseppe Piscitelli <ooonea@gmail.com>
In-Reply-To: <CACmoRBYhQg2kAp04fFeNyArgQRoMHpBwpNX3b0-1knp6RiLpWw@mail.gmail.com>
References: <CACmoRBYhQg2kAp04fFeNyArgQRoMHpBwpNX3b0-1knp6RiLpWw@mail.gmail.com>
Date: Fri, 25 Sep 2026 12:43:06 -0500
X-Gm-Features: AclHuK9zHppIu1zG_LEPUq4TEVN8hSfFoVHJ6NGRDXJvFT-4PUOvEwig4orUNZg
Message-ID: <CACmoRBbCJLVJ_9Yxzi24yoDwuJUGsVV=2O=CMoQKKtPM4Nh4Qg@mail.gmail.com>
Subject: [PATCH BlueZ 2/2] unit: Test HoG report map reads after reconnect
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


On Fri, 25 Sep 2026 12:42:44 -0500, Giuseppe Piscitelli
<ooonea@gmail.com> wrote:
> From: Giuseppe Piscitelli <35407790+ooonea@users.noreply.github.com>
>
> read_report_map() leaves report_map_id set after a failed read. Detach
> cancels queued GATT operations but retains that ID, so a later attach
> cannot request the report map again and never creates the UHID device.
>
> Clear the ID when cancelling GATT operations on detach. This also lets
> a reconnect retry a read that was still pending at disconnection.
>
> A socketpair reproducer fails to read the map after either an ATT error
> or cancellation before this change; both cases create UHID afterwards.
> The existing HoG and UHID unit tests also pass.
>
> Assisted-by: OpenAI Codex:gpt-6
> ---
>  profiles/input/hog-lib.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index 6c75c60..2b6dcae 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -1908,6 +1908,7 @@ void bt_hog_detach(struct bt_hog *hog, bool force)
>  	}
>
>  	queue_remove_all(hog->gatt_op, cancel_gatt_req, hog, destroy_gatt_req);
> +	hog->report_map_id = 0;
>  	g_attrib_unref(hog->attrib);
>  	hog->attrib = NULL;
