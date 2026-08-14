Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE0357D18
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729665; cv=none; b=XNNdd/GnucAJLhppRnO9XOQ9frT0W6JEuk20gprPx+dGssoNnViVnFdVoNgCgZS5QXiyS8npD+8ernGrCdR0OvuBUFlXFuYmRVLaixQWi76EB0hUSwVh301t42E8fPg8C6XwOTruIotunfUEsxEiuZXYRN6Zs/uRHSCGFYc7J6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729665; c=relaxed/simple;
	bh=aLqbf5p+G1MscI4f4Xx8UVcoKNGfDX3V+XUh+zaIChQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAr8Zi2YZqb6BJ2RHWHT7+F+viVrmYbynuRd2vOa7JbnLk8CylOzIYG73OEGvENBEDje+H1bwZ2igKhWH3mPS+iKyMA8EZ8jyLu1CeANVb1fDQ2Zr9H1QnZ+MvHCZEeEKUPrOhE4LpYeofB71S5LW/L65uliIuA0ubwu3DWxQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaoQdkf7; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaoQdkf7"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c3163a88a1so429503e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786729663; x=1787334463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RnlcJQJb2q1sMaZAhq99yMjRbXT6WXbOf6852KXQimA=;
        b=OaoQdkf7n1vPvROglLOCSeaCT0WGkKP9rO7z0zK5W5QXpsHKv5SNpuSuXUYfRI8quH
         dq9Jd6YSy4xgA4diyGZjZJfw2zf99ItNyjIuZ7gg92avJMOVGzcBAuP2tU98IHuGeHfA
         /z/KMfatkGdLrr4GS7BL902D6ZYcnIAi0VXFpKHR1/d7J2dab7OugFJ0fXZiE1eDTB3r
         daRcQfbamkMpKUnCbaEPjy+2IwBeo2d3SUfcSeWiMJ60x7GmPLMxwNXvcQE7TDdlFcCt
         WDM1NxmCkj0NWW3TSVjG+ywLnaKknAkaLntJpDsLhpK6n6pxTJa2TTFzRlWcYlZc3H3V
         4ZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786729663; x=1787334463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RnlcJQJb2q1sMaZAhq99yMjRbXT6WXbOf6852KXQimA=;
        b=oSRCubabVWdW30M1g0jbqIuf4m/kglQYeP+SeQeruNnL9bkimrp7iP5ODfDX9ay9dD
         gi85vgRXo7UpJ23p8oMATpPR6TPacP8OCM4uGVYJXZVFlqJJSvmm520DrXLzuzzg7XFk
         XrevkPDH66sHaBF40sxOnMNYD1vFO3P7k7H1Pth9O0lN9l8mr/QDuJ5dHfAybWLxrT8Z
         CLlK17Ze/M9btrJNnxxw5WOaM66EeecA5HyPQ/XoPCJulAb/waXKAhEq0p6Dx+WJaZle
         Jm6uV15/162wl7FOXx1ancF8ZqvPDHt1F1XE7gupTSbJ3G+RPIveugArrYoUJy9fOM9N
         AxYw==
X-Gm-Message-State: AOJu0YyiNSYJ9bgGb/U5idQsyiFYQmHATCjN1Tzq7/KZv4gQFvq2Dbnv
	arOnPN8tEewFdUS0jRDQ9odYWZEOfUsuzCOmLBxbnrpMa4LlIpI8TGqE5LDV8TRa
X-Gm-Gg: AR+sD11PkE59MmXqb2F/qwm7QT5+rcKnBU5FdQEK34fEAA2kFYssO0dstfjwZqS2LxP
	78kg5tjSdHLxLaloqjqQ/HPa2E5q9O0TuyB54CLvl231PJGA4wBGbNkmbFccJlD4CTuQ+v36L8s
	4GhE5IvF2Ia4kZ/KyVEw8uvSISyuryhdirb9/0EcS27Pk+cOOhPwZJfHO+aRab/f4U2w54qIg1v
	mbihbrLFr2EdmT9psz6FDu5kE5G4mjXrRL60+UAsNPR+vcDkDh7MU4LoCsVUqX4X9m5S9PQMGtc
	9vz1DQkABbaSehcR5Pc9hmTYLUjK6MK227pm0AEfOqmup/OQbzQuREZfKsbnQyNYgVMqIUns3g3
	wFDtKt0d+RNlKGezqDo5YY4eC5uxQltgBDENdONmIWHQxusxLI8muAXVm4gu5mNy97JMLr2ppiT
	zW28LmKOCS02g8JrkjC9KZTn6/TEYqHLxnI+dssPfo60uggeKBSqC+WImpiJHTV7Cuhc7fxXHXS
	jaGDlqCcvgH26lVHoM5K/ykfVuvqjPoGsNFsL1ngNSxpwqCeJiuiZc=
X-Received: by 2002:a05:6122:6611:b0:5ab:26f:49e3 with SMTP id 71dfb90a1353d-5c591c7e2e7mr1410838e0c.3.1786729662701;
        Fri, 14 Aug 2026 10:47:42 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c59472656csm1158387e0c.5.2026.08.14.10.47.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 10:47:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] unit/test-sdp-xml: Give each test its own test_data
Date: Fri, 14 Aug 2026 13:47:30 -0400
Message-ID: <20260814174731.1441738-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814174731.1441738-1-luiz.dentz@gmail.com>
References: <20260814174731.1441738-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

DEFINE_TEST assigned the filename and expected result to a single
test_data and passed its address to tester_add(), so every test shared
one struct and ran with whatever the last registered test left in it.

All the file based tests therefore parsed the same file, and a test
pointing at a file that does not exist still passed.

That in particular meant compute-seq-size-type-confusion.xml, the
regression test for GHSA-7mmr-gwqx-vc34, was never actually parsed, and
passed only because it inherited the expected result of the test
registered after it.

Use an array with one entry per test instead.

Assisted-by: Claude:claude-opus-5
---
 unit/test-sdp-xml.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/unit/test-sdp-xml.c b/unit/test-sdp-xml.c
index b338788aa295..72e01f5f5806 100644
--- a/unit/test-sdp-xml.c
+++ b/unit/test-sdp-xml.c
@@ -114,25 +114,35 @@ static void sequence_on_squared_teardown(gconstpointer data)
 	tester_teardown_complete();
 }
 
-#define DEFINE_TEST(fname, res) {					\
-	data.expected_result = res;					\
-	data.filename = fname;						\
-	tester_add("/" fname, &data, NULL,				\
-			parse_xml_for_filename, NULL);			\
-	}
+#define DEFINE_TEST(fname, res) { .filename = fname, .expected_result = res }
+
+/*
+ * Each test needs its own test_data, sharing a single one would make every
+ * test run with the values assigned by the last one registered.
+ */
+static struct test_data file_tests[] = {
+	DEFINE_TEST("Bluetooth_HID-sdp_record.xml", TRUE),
+	DEFINE_TEST("qt-SerialPortSDPRecord.xml", TRUE),
+	/* From https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34 */
+	DEFINE_TEST("compute-seq-size-type-confusion.xml", FALSE),
+	/* From https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc */
+	DEFINE_TEST("duplicate-attribute.xml", TRUE),
+};
 
 int main(int argc, char *argv[])
 {
 	struct test_data data;
+	unsigned int i;
 
 	tester_init(&argc, &argv);
 
-	DEFINE_TEST("Bluetooth_HID-sdp_record.xml", TRUE);
-	DEFINE_TEST("qt-SerialPortSDPRecord.xml", TRUE);
-	/* From https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34 */
-	DEFINE_TEST("compute-seq-size-type-confusion.xml", FALSE);
-	/* From https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc */
-	DEFINE_TEST("duplicate-attribute.xml", TRUE);
+	for (i = 0; i < G_N_ELEMENTS(file_tests); i++) {
+		char *name = g_strdup_printf("/%s", file_tests[i].filename);
+
+		tester_add(name, &file_tests[i], NULL,
+				parse_xml_for_filename, NULL);
+		g_free(name);
+	}
 
 	tester_add("/sequence_on_squared", &data,
 		   sequence_on_squared_setup,
-- 
2.54.0

