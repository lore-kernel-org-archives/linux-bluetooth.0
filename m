Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F7736C5BF
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 01:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039739; cv=pass; b=OLQgG6cnXDxLluWdDSzx74rAOLFI+nmxbf6eVLsfZC8wPs8zz9uy3yU4iqSDQX10uc/LnnAkbsGyyb+qW1IhMr0maTXD3ut5SsdlcWS42ogE1Y8wZi6C+KOHeyXFdvCC07DVPcjgcgxGYoYb08CNpqVtdlrJm2436Wv0xlJDdOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039739; c=relaxed/simple;
	bh=UWclIBpmxPgYztZsO45chnI+sq+qtnZqn1jQ7VJhKy4=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Content-Type; b=scGofhWYBonEO1zfxvJHbHP2ZqPfu1E4OhhmjO3EPUngw19c5awJF0X4pf3FIMXkHgH/rmF80FjiP2VSGXBBpWAs2+OiAZ+hJIDU8ITXOlCE68miHimvOoSzmaFJjIauMkDXuUeZYmyJUTd/zI0JZovxwgZO1TT7Qemq7e3WnCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxpS6Xx8; arc=pass smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxpS6Xx8"
Received: by mail-vs2-f40.google.com with SMTP id 71dfb90a1353d-5c9d8b323d9so979212e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 18:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790039735; cv=none;
        d=google.com; s=arc-20260327;
        b=WcNCtmIIPx1eHh9je7nGoD+/4rdU32xIRvuGGm63lLknWQLrpY6UUbh90UU2xSExwB
         9M3K0+g39vdAXzrdOO0yJYCXQoQklYUzz/AzU6PtAKTcDjHDU8cdTUssZmBPZ9VP2lF0
         U3iYhzeW2X8nu+8xIOgedGnEQvcatNHXPtK42V1UFlaRns9pSzF1yyKhnJSmA7ru1qHi
         i2ojq4+QOyX8XE/QxRl4QiC8F3ggYuZMHVLICeMvzBQCoZIgLbcZh3ho4ouSkuKYckZW
         RIepn3RXyrizBGZdj48nvrnpUM3P1ANO+1wPeZD0TNb9dNf34n5LTIIBSknHB0gl1BJS
         LVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature;
        bh=9PVuIbPluKxAloU9gtVnRyJstTGdPKzl5rAInSTlRdA=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=LBViErC3kUec+Iyf2I60csTwJktupd5KCfwPQzqoofsOPFP+LGbFBJAAq2mpzf1YCv
         f++rvFHRxAQfyyrVuTG9/YTm/3Eqb+EdnOCzqKtusG3FzUpsD08H7idd7jmxIB0eVNwh
         7+vBVdv41r+DZ7RhllreL4xwMrx8Zb7U7jh+RxPg0eLpKIZmmxIkitPRhiXqa3fD2RDj
         w+suWdOPOZIIUu8DHbARuYwMTFJEYeEx2ka7GlOBGoezwYKzv5niS45wFYVwe468aqu9
         MY1GyI6Dj14aS5udSNkgEyXunOcGcTac09WExzuUPZbwTbudjf6vwX0f0bjIdwOEaY6E
         gchA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039735; x=1790644535; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9PVuIbPluKxAloU9gtVnRyJstTGdPKzl5rAInSTlRdA=;
        b=MxpS6Xx8EZKyyYE3VwyTrgnJCh2wqP7VhlDIw6LITAtBkdG7Xkykg+VmPZPNCbYrdx
         WLh4Ak01k10zniLukH27JCJHfS688d5cWF59W2r+AJVIdKGF5t04A7wSgI4T/FgDDPGu
         2nDtUbt0v+SCBUhKtNOnm392vqaedBhVsMGUakI/jbdKkLRRWG/qYPNlnZPKdLQgRKct
         CIcHtSmDkdvuap2lyGnUU1pngMDL3o5epXqIcRBNI4kuHz4JTKp2biMVv0tT3TjcjWRW
         nSz0jj6PNklPREdR0hetDl0c1ganaM8nIbiSY9nMPq1yUYFmzmuDUrr9ptQ5uDD9HsOp
         iKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039735; x=1790644535;
        h=content-type:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9PVuIbPluKxAloU9gtVnRyJstTGdPKzl5rAInSTlRdA=;
        b=Asi9adeLfdk55yRursxmmvRuoHNwLpNtzuTMwwZ1mATNhs4xGUKEde3xIvPM4Aa1g8
         5E2iY/ZP6MN8mX4uwhkGQlTPXIEtrVqYYlKdDI6R/fFy/9x+i8DKJqvmrKdMnnu/SK+O
         zPRL/3n1kDfD70ZtKYpQsLe1yL5LoXtShUrut6gIxeOpePJeMDPs3Bm6Rfaol6rqvvP2
         /vWeIxQuq+/aY9/rwJs2wGml2ieEyKuMbMkgrra+uJbp9DE0Fyy7wTqfJxvYHXboQMv3
         Zy9D4RRRWg5A/1c5yZowj1gAo4UW81SQKAGNhVE/7NcCFL5V/Yqz/0EeCckxZq0NIFvg
         gj5A==
X-Gm-Message-State: AFuF++mym+XkbaVoT3GJpk2tfxR9tFwNvRXrcHY0WhdeUBpKZd9AyGyt
	xRP5APjtviW6BVG54e/QlmMMqve0DdFb/xOzIGG7wQ4XOnqGr/TkKiM12rWpOwePMcE/5YsaTA/
	JkA/XefcGQoMJ/PXK53u2rJZ+1mRWxPxgSw==
X-Gm-Gg: AYBFou3tYiwbJc3xaVwhZm7KLxbu0+tnPyFSCTPIY5ICy67BX8TSBHK0Mda3cWnuTR5
	KJUXsbb3hjYTMutl0gt8XQLLdqYNC0AAjchqrdYI5oREMZxm4YlZ86vAt26fUDKVgGgfER51iSu
	Stqla61v3nVv1UvScQhXmLzNZASgZ+PEyk0N/p4mkYxKTjJU7AqvCyM4I63aU/+xyD0IBM2AzlJ
	OFiZcZy49I8+v5OfDzCMCwHg12db1oXZJrd1OWyBf4ZElZ0iCWfngF7wjisbPYwi3+nfnLf8VdA
	7kXfMKPLwugcpsVl0W6+PWuPOqeyCvpS9MiVZqo9ctacR+Kz7ZVvw68AHAhZZM7tZ7OTpiEoQqA
	6Y/zXBhg13w==
X-Received: by 2002:a05:6122:d89:b0:5c9:a60b:e5b3 with SMTP id
 71dfb90a1353d-5c9b5933a2cmr8428553e0c.12.1790039734999; Mon, 21 Sep 2026
 18:15:34 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 21 Sep 2026 18:15:32 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 21 Sep 2026 18:15:32 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAB2hQnQ+aahjM-Q=1CJx-Ek+icwzNa1LauWDAgtPj6O1G5GSqQ@mail.gmail.com>
References: <CAB2hQnQ+aahjM-Q=1CJx-Ek+icwzNa1LauWDAgtPj6O1G5GSqQ@mail.gmail.com>
From: Nicholas Hammond <nicholas.hammond0@gmail.com>
Date: Mon, 21 Sep 2026 18:15:32 -0700
X-Gm-Features: AcwNN1XhnciLgJjSBz2OTVI9X50Lg84I3P_nNsj45gaC3twflP_CrxAEZ4I1Ym8
Message-ID: <CAB2hQnRNL1ivYNupM6fKfP=Z-r-4yQ58NpAUU4WLRFu3qfUPYQ@mail.gmail.com>
Subject: [PATCH BlueZ 2/3] unit: Test pending HoG reports across detach
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Nick Hammond <blender7@gmail.com>

Exercise the real HoG, GAttrib and ATT implementations with socketpairs
for ATT and UHID, without requiring a controller or /dev/uhid.

Cover pending reads, READ_BLOB continuations and writes whose responses
arrive after detach and object destruction. Also check normal completion
and reuse of a surviving object after detach. Keep another GAttrib
reference alive to model the connection shared with other profiles.

Include hog-lib.c to construct a single report and invoke its request
handlers without unrelated service discovery or new production APIs.
The follow-up build change registers this test with make check.

Without the preceding fix, the three teardown cases fail under
AddressSanitizer and the reuse case receives a stale reply. All five
cases pass with the fix and leak detection enabled.

Assisted-by: Codex:gpt-6 AddressSanitizer
---
 unit/test-hog-lifetime.c | 152 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)
 create mode 100644 unit/test-hog-lifetime.c

diff --git a/unit/test-hog-lifetime.c b/unit/test-hog-lifetime.c
new file mode 100644
index 000000000..53a563c40
--- /dev/null
+++ b/unit/test-hog-lifetime.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Regression for outstanding HID report requests surviving detach.
+ * Uses socketpairs and the real HoG/GAttrib/ATT implementation; no hardware.
+ */
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <unistd.h>
+#include <sys/socket.h>
+
+#include <glib.h>
+
+#include "profiles/input/hog-lib.c"
+
+static void pump(void)
+{
+	while (g_main_context_iteration(NULL, FALSE))
+		;
+}
+
+static void test_report(gconstpointer data)
+{
+	const char *name = data;
+	bool blob = !strcmp(name, "blob");
+	bool write_test = !strcmp(name, "write");
+	bool normal = !strcmp(name, "normal");
+	bool reconnect = !strcmp(name, "reconnect");
+	int attfd[2], uhidfd[2];
+	GIOChannel *io;
+	GAttrib *attrib;
+	struct bt_hog *hog;
+	struct report *report;
+	struct uhid_event ev = { 0 }, reply;
+	uint8_t pdu[64];
+	uint8_t response[2] = {
+		write_test ? 0x13 : blob ? 0x0d : 0x0b, 0x55
+	};
+	size_t size = write_test ? 1 : 2;
+	ssize_t n;
+
+	g_assert_cmpint(socketpair(AF_UNIX,
+			SOCK_SEQPACKET | SOCK_NONBLOCK, 0, attfd), ==, 0);
+	g_assert_cmpint(socketpair(AF_UNIX,
+			SOCK_SEQPACKET | SOCK_NONBLOCK, 0, uhidfd), ==, 0);
+	io = g_io_channel_unix_new(attfd[0]);
+	g_io_channel_set_close_on_unref(io, TRUE);
+	attrib = g_attrib_new(io, 23, false);
+	g_io_channel_unref(io);
+	hog = bt_hog_new(uhidfd[0], "lifetime-test", 2, 1, 1, 0, NULL);
+	g_assert(hog && attrib);
+	hog->attrib = g_attrib_ref(attrib);
+	report = g_new0(struct report, 1);
+	report->hog = hog;
+	report->type = HOG_REPORT_TYPE_FEATURE;
+	report->value_handle = 0x31;
+	hog->reports = g_slist_append(hog->reports, report);
+
+	if (write_test) {
+		ev.type = UHID_SET_REPORT;
+		ev.u.set_report.id = 123;
+		ev.u.set_report.rtype = UHID_FEATURE_REPORT;
+		ev.u.set_report.size = 1;
+		ev.u.set_report.data[0] = 0x55;
+		set_report(&ev, hog);
+		g_assert(hog->setrep_att != 0);
+	} else {
+		ev.type = UHID_GET_REPORT;
+		ev.u.get_report.id = 123;
+		ev.u.get_report.rtype = UHID_FEATURE_REPORT;
+		get_report(&ev, hog);
+		g_assert(hog->getrep_att != 0);
+	}
+
+	pump();
+	n = read(attfd[1], pdu, sizeof(pdu));
+	g_assert(n >= 3 && pdu[0] == (write_test ? 0x12 : 0x0a));
+
+	if (blob) {
+		uint8_t first[23] = { 0x0b };
+
+		g_assert_cmpint(write(attfd[1], first, sizeof(first)),
+						==, sizeof(first));
+		pump();
+		n = read(attfd[1], pdu, sizeof(pdu));
+		g_assert(n == 5 && pdu[0] == 0x0c);
+	}
+
+	if (!normal) {
+		bt_hog_detach(hog, true);
+
+		if (!reconnect) {
+			bt_hog_unref(hog);
+			hog = NULL;
+		}
+	}
+
+	g_assert(write(attfd[1], response, size) == size);
+	pump();
+	n = read(uhidfd[1], &reply, sizeof(reply));
+
+	if (normal) {
+		g_assert(n == sizeof(reply));
+		g_assert(reply.type == UHID_GET_REPORT_REPLY);
+		g_assert(reply.u.get_report_reply.id == 123);
+		g_assert(reply.u.get_report_reply.err == 0);
+		g_assert(reply.u.get_report_reply.data[0] == 0x55);
+	} else {
+		g_assert(n == -1 && errno == EAGAIN);
+	}
+
+	if (reconnect) {
+		/* Reuse the detached object for another report request. */
+		g_assert(hog->getrep_att == 0 && hog->setrep_att == 0);
+		hog->attrib = g_attrib_ref(attrib);
+		ev.u.get_report.id = 124;
+		get_report(&ev, hog);
+		pump();
+		n = read(attfd[1], pdu, sizeof(pdu));
+		g_assert(n == 3 && pdu[0] == 0x0a);
+		g_assert(write(attfd[1], response, 2) == 2);
+		pump();
+		g_assert_cmpint(read(uhidfd[1], &reply, sizeof(reply)),
+						==, sizeof(reply));
+		g_assert(reply.u.get_report_reply.id == 124);
+		g_assert(reply.u.get_report_reply.err == 0);
+	}
+
+	if (hog)
+		bt_hog_unref(hog);
+
+	g_attrib_unref(attrib);
+	close(attfd[1]);
+	close(uhidfd[0]);
+	close(uhidfd[1]);
+	pump();
+}
+
+int main(int argc, char *argv[])
+{
+	g_test_init(&argc, &argv, NULL);
+
+	g_test_add_data_func("/hog/detach/read", "read", test_report);
+	g_test_add_data_func("/hog/detach/blob", "blob", test_report);
+	g_test_add_data_func("/hog/detach/write", "write", test_report);
+	g_test_add_data_func("/hog/normal", "normal", test_report);
+	g_test_add_data_func("/hog/reconnect", "reconnect", test_report);
+
+	return g_test_run();
+}
-- 
2.43.0



On Mon, 21 Sep 2026 18:15:15 -0700, Nicholas Hammond
<nicholas.hammond0@gmail.com> wrote:
> From: Nick Hammond <blender7@gmail.com>
>
> This series fixes outstanding HID report callbacks surviving HoG detach.
>
> The investigation started with a bluetoothd crash on Ubuntu BlueZ
> 5.72-0ubuntu5.5 while reconnecting an MX Keys S keyboard after switching
> hosts. The saved stack passes through report_reply/get_report_cb,
> read_blob_helper and attrib_callback_result. The original core and device
> identifiers are intentionally not included.
>
> On current master (17e624d1c), getrep_att and setrep_att still bypass the
> gatt_op queue cancelled by bt_hog_detach. If another owner retains the
> GAttrib connection, a late response can invoke a callback after its HoG
> object/report is freed. A surviving HoG object can also receive a stale
> reply after detach.
>
> A socketpair test on that revision reproduces the read, long-read and
> write use-after-free under AddressSanitizer. For example, the long-read
> case reports:
>
>   ERROR: AddressSanitizer: heap-use-after-free
>     get_report_cb       profiles/input/hog-lib.c:929
>     read_blob_helper    attrib/gatt.c:791
>     attrib_callback_result attrib/gattrib.c:235
>     handle_rsp          src/shared/att.c:913
>
> This is a lifetime regression test with a shared live GAttrib reference,
> not an over-the-air reproducer or a claim of unauthenticated reachability.
> It does not establish that every historical keyboard outage had this
> cause.
>
> Patch 1 cancels the separately tracked report requests before dropping
> attrib. Patches 2 and 3 add and register five hardware-independent tests.
> The test includes hog-lib.c to access private report state, avoiding new
> production APIs and unrelated discovery traffic.
>
> Validation on current master plus this series:
> - AddressSanitizer with detect_leaks=1: all five new tests pass.
> - Existing test-hog (6), test-gattrib (6), test-gatt (193): all pass.
> - checkpatch --no-tree --no-signoff: no errors or warnings.
> - A backport to Ubuntu 5.72 is installed on the affected host; keyboard
>   and mouse reconnected after restarting the daemon. Long-term stability
>   is not yet established.
>
> To reproduce the failures, apply only patches 2 and 3 to the base revision
> and build with --enable-asan. Run unit/test-hog-lifetime -p followed by
> /hog/detach/read, /hog/detach/blob or /hog/detach/write. Each detects a
> use-after-free without patch 1. /hog/reconnect catches the stale reply;
> /hog/normal passes before and after the fix.
>
> AI assistance disclosure: Codex:gpt-6 analyzed the saved crash, prepared
> the fix and tests, and ran the validation commands. This contribution
> includes Assisted-by tags. No claim of an independent human code review
> is made.
>
> Thanks,
> Nick Hammond
>
> Nick Hammond (3):
>   input/hog: Cancel pending report requests on detach
>   unit: Test pending HoG reports across detach
>   build: Register the HoG report lifetime tests
>
>  Makefile.am              |  14 ++++
>  profiles/input/hog-lib.c |  11 +++
>  unit/test-hog-lifetime.c | 152 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 177 insertions(+)
>  create mode 100644 unit/test-hog-lifetime.c
>
>
> base-commit: 17e624d1cd9a4d94f90e0ca008548456c3455492
> --
> 2.43.0
