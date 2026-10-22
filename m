Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684035;
	b=10CmpTJxEVUF4mvhPpz6GPRvzs5slyquGy2TZRC+RHF5UsaVSk1xefis1vke/BipbWQ0
	 Bz+4Q8uDowj8nXooFfyjxPHyiZ2V/wx99VesIyir/m9VwDCjHnX1+gCfCk4nHptOMQ0GX
	 JFHqPc/629OWvgidcvS9JGBjM0ucSJ4chILv3P7MpI9wpsiVKTWnHm99Eq8Qt5G9ArHhT
	 OfD2hAfwL9+GWTt0ecaiRDFZk5mqoY2JkEX7EjjZpKr9lu1UTe58j36hX8BzVweU4ZDpj
	 dCTwwC2ExTQnCzex7jvkm9wsKDAiVaEio4UzFqUQlHi7heg+HnPE2sjybRM93JVPV8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cE6YBn1Bn8trnMKjBCUDYyHVMIXGru7330e0PtIkuuQ=;
	b=vr16sKGVm83ttBoxjehpgjD5hKqVoRKznLkuWrsd2he3IzYS6JXMcUG+tvLrJZU3bPrR
	 2eh5EhEklSJ05b71DGqU/gZrhwv8+vEaxZ0Wg4bn0Haa5+ypUrLoaIOx5xssemJw+du7I
	 iJJ4zAYysQBzxiTZVzIozABVuP+ZcYATS+gCofylmNFAFa5SdicCX3h4vJIcsHiduThH1
	 hTrsl2UVTNyEcKD8tJ5Z6cWEJCY1qniylbZ+NmNdCZzsPnbcuLujOxQeLjwfqbjMtb1el
	 YVARyjSTGJxTr45mUnQhHSLqIfg0UuWZjw4Zyn+g8gPYP3/NxA8cwZIAeM0iTUQh+pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XMKsMtfJ;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E3606A338
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C1E3606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XMKsMtfJ
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eafb65e204so4246e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684034; x=1793288834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cE6YBn1Bn8trnMKjBCUDYyHVMIXGru7330e0PtIkuuQ=;
        b=XMKsMtfJrOzfIZLF3LkT2MxitgV9D1n/oT+MHepsmvosMJUda12h5v4J2YVqCeSi7p
         ABuxNE7oWzqns82p3D3syto5r0+hHHKxW//ZUo5aVZn8+9dkDKLL2Onu3QW7J4nxcw6y
         gdOBid0Kb5No9WZAXB+HVTnVk4BR2hod++8Jit6gtT54zSn5op701/PQqW1cq9okGUpo
         oRDMeyHwv8H+n/Vs2yvwHLHX6CmE8kUifnhdWSRfG3VmkgSBe5U7DyIgo8TO4vjnRH3L
         HkNxJ7kA1AGSxF8NgqUdXhgQ0MTd6MwASzRlVyjkoKxPuwQqtvD3JM4OWpV7+D8hRRPs
         ENxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684034; x=1793288834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cE6YBn1Bn8trnMKjBCUDYyHVMIXGru7330e0PtIkuuQ=;
        b=oxZyz+bFx9cNzL+dzcCqqm76XrKjczYKIegf9cY1UhKw0sDXxYiZUHcAw/qwq0qvS1
         Vwc9jmeDKwSz+Sx3I5/rsRwKQ2Ahuo5DhitCuXWGDGbA+NQgoEcQ6yHnNBQ8IAundu6f
         NEIpSbcMTs57DlNTJXZOqBqZYnhX/0SgDKPgeSB0cTfcGReoGkWOujgpzvCDpJXSUftT
         3npuRloQ+dSYg0w3dFVjidQABB3JJHV7xWJMPLZFfopuWfa7cACdDGI2ooRa6nOKQ+xy
         SpM53t0161Ne8E+L1SjwLvgGuALRdW45lzG8DTeRCrQ+3yj5cLhQcFJhoggCvhohDIaj
         6hGA==
X-Gm-Message-State: AFq9FYIkixH1eJX8Tk4mE+Pw71UbZo0Lsqu0xJbJ/bnkRPERcylzWu8a
	TV8MEqnjC1kH4YyjlmMUMAuqCjyqycrhKRXR6fZTZIghxqESBlYblA5l7Yxf2xYQgZ8=
X-Gm-Gg: AYBFou3KXdBNyZTKzcmNv+TMmHQHlc49gVKKsKTcV9jMR03SPCCxwXsMJaywVwe1l+F
	wPAJL9pXEAVHifuxN/ck5TIiXcteoZoS+iiZJSRm+LfrHkeO8iX2JO8hyQoVEUJqVz7P1MJnFOn
	fxKj1eFKIsTuDeSBPfX9OkxTgbbBCfNyNl2PG+9azxyoqPW4KKgWcFcb3+4DwQf2fqIgm0jZHB5
	rUH1yY0EbCnshfpmcDMMRX5jQZwg5o9Ix4prB04tSJgqbdCFubVPns7npNMH3fz58nqE3wqSwtn
	Z7JIrEIkKgTKK79GPdXjBbwEeJTYJrQyPuP0wE6al66dRAUnbaRhy4ea0pmwM9Vyr25DqGjGaJ4
	9TJoELS5WN+g/BEyVJgLs1VI8DmXeV0IlJaYIFtb9YnCXe9yYKwQBo0tp+uWpeaM95wax+sbZmW
	6hboZhkrVBkIPj0//1Bu/OOPr0+2w/acWzf/nRYgwWnTZYs4eABFgXecZbFXtQwDlvgoSlNbUx0
	ovYN3cX64ewSCBZjQkXptLW4bU8Zjk3JBgeXi05bLC0ELoTI6sDlkYnRLqYPKxDYoNJmAoHGUSX
	zR4M3OGaHAbZl/h20y+atZ5WNjo1HAio1vLzTFc0x+rEmA==
X-Received: by 2002:a05:6122:3b19:b0:5ea:e188:a5af with SMTP id 71dfb90a1353d-5eaebda5ca8mr2528713e0c.11.1792684034189;
        Thu, 22 Oct 2026 08:47:14 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 04/27] iso-tester: Fix leaking socket watches
Date: Thu, 22 Oct 2026 11:46:37 -0400
Message-ID: <20261022154701.3959500-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

iso_recv_data() clears io_id[0] on entry, but returns TRUE to keep its
watch while more data is expected, so the watch can no longer be
removed, and the watches with ids are only removed when the test data is
freed at exit. Either way the watched socket stays open past the test,
and once it hangs up, as the controller is removed, it wakes up the main
loop over and over for every following test, as G_IO_IN does not
include G_IO_HUP.

Keep the id while the watch is kept and remove the watches on post
teardown. This busy loop is costly under User Mode Linux time travel,
where computing takes no simulated time, e.g. the PAST Receiver tests
took about 7 seconds each, with -T:

  iso-tester  before  49.2 s
              after   16.3 s

Assisted-by: Claude:claude-opus-5-5
---
 tools/iso-tester.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index fe27eaaf34bf..d610b3c32c51 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -707,10 +707,22 @@ static void io_free(void *data)
 static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	unsigned int i;
 
 	if (data->io_queue)
 		queue_remove_all(data->io_queue, NULL, NULL, io_free);
 
+	/* Remove the watches with the test, as the sockets they keep open
+	 * hang up once the controller is removed, which would wake up the
+	 * main loop over and over for the following tests.
+	 */
+	for (i = 0; i < ARRAY_SIZE(data->io_id); ++i) {
+		if (data->io_id[i] > 0) {
+			g_source_remove(data->io_id[i]);
+			data->io_id[i] = 0;
+		}
+	}
+
 	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
 		  sizeof(reset_iso_socket_param), reset_iso_socket_param,
 		  NULL, NULL, NULL);
@@ -2542,9 +2554,11 @@ static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 
 	if (memcmp(buf, isodata->recv->iov_base, ret))
 		tester_test_failed();
-	else if (data->step)
+	else if (data->step) {
+		/* Keep the watch, and its id so teardown can remove it */
+		data->io_id[0] = g_source_get_id(g_main_current_source());
 		return TRUE;
-	else if (isodata->disconnect)
+	} else if (isodata->disconnect)
 		iso_shutdown(data, io);
 	else if (isodata->terminate)
 		iso_terminate(data, io);
-- 
2.56.0

