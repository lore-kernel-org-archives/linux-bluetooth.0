Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684036;
	b=G2GnlrTTfuEQSQFqPvHGFh8aj1aUU98vnLKygxPce6qVAswUIWU/DNIHIrRc6z7rIlc9
	 eqZyMVSaCaaBShnS4VkZhe+mEUci6iDcUzbKJ4VnGgBDZvUjjCU/oY4QdclyXtqsHxV8J
	 ZPWOVa38YIeYnN2ESogMNEDLeuxo7tygqBLHUN+l2MPDPKHRkK9o0SDplMtTbcOIjpNOP
	 0b4qjxCZCcJZpHw4/GQdy/ES4VixC8FX/r7iINInleUPmc7mrJ7fXeHrG4s1DG0o6VXWL
	 Rpm+Rihumu89s12P3aRQa+Pd1UKabZ4zf6Q5lUx3r/lWv15FdCBHyn/96KupSJQlNZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GBv5VGyRve+e0B8Ho9t72b/lViNJhwCh82bLXWKnQsY=;
	b=UC74XaSotp0Hz6+aywgsJI0Gr6D4+N+wu6uFWV2BauIaHPn2qZVA2a8BD78VWeVjzvfk
	 diR7iQDQf42Zw2/b74l4vodLga1s6j/rTiYcq+gK1QmngTBA0kn5CIW4jwLoVqAxHQ0OT
	 ETqvgl/Y/iVu9iLbA9tJZ9xwCtGVG0DVzPetk0xlIKgfasaPrG/PnCzjLHS3aC5dO+wqy
	 +wTAA3ysxFkWmwtScw0BOao8w8esH6CRlFohL6zlG8Mjrpjl0SGm9T78b0eFhw0BAvFoQ
	 4K2Pph9o5Wp44qxV9V7HCvZWEKBVEzOAroSpsh6QbiCA5SZ9Iv4bVrsXHYFp0i7SC/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="o1/A87bP";
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB29606A322
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEB29606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o1/A87bP
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5e9528732b4so20459e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684035; x=1793288835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GBv5VGyRve+e0B8Ho9t72b/lViNJhwCh82bLXWKnQsY=;
        b=o1/A87bPgfMCLoygr6t6YNr0ZMQ9ph0snu2KJ+e9RTbWCsLc+3tPz+KuZ1TEyylqmw
         Oevdbp+yTfC+9yz1VjwGTc+FaMp1hidUDJbLQKdwgvJEvNAoHOuhoMjoGlbYpUNQs7yV
         djbAqP0R7OPHMWyvsOisOFG7pe7SeqM53pijrY1MVJfiuYS4Xm1Rk6e0XK07g34dlffl
         9c8js8mzu19e30iJYElJyh1DCvY3vSfPueMDuj9zYET+XVvyzVvvEVs1tAMLsDn4L5q3
         LOjNqWCNfaKhFviVknh3fYdJKnIjsnmNwBiLCEKO/EABx2CI0vghi3lXi4eRf1xTqXJH
         C1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684035; x=1793288835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GBv5VGyRve+e0B8Ho9t72b/lViNJhwCh82bLXWKnQsY=;
        b=qawk00lSaLrr1nAZwfFHGfNdnao+PG0ICXVytGl7isRS/ddQ4FUboWrYuop31+6gDE
         lI9lhGgIuPHcJspRyTugKbOqTVCLIE9mxJ2jdxCABusqBmFlwOsVRIt6RTSa3P0IJV6c
         Ny1mpHSzTkgOrZ7s/FOVmybLMOH7FUyp1duBD8MLQA16BTzyXMZ4IgAiVJMhuZb0wXEL
         wBVp2ovF5KzKyx6/xLyZy2J/r7GRBfNz3RcVhy4jEJEvjS8dERIzhfg8C5sogMipeLgP
         eM+YIroy9122wJS+ij68MVeb5WoMQr4m0NQJKjVc8IAAP2rrF+EyY1Zz+w+DIx1C7CEj
         Efgg==
X-Gm-Message-State: AFq9FYI1w6QRxgD1zqMj82OoAsP92x3nXkll0FnnL9Mk6vHKnlz6/jTq
	1rCXtPBX5ouq8RH4YhOS8eiI8AymEsgKArJ/KSE5mOqKMQkmJ/l+3Z6nrWHaZeC6Y28=
X-Gm-Gg: AYBFou1++f+eaHgI60i+y8hiMNnKiwnacgRfyt8AHxkY7MnerTIlQ3gOPqfLmd5pret
	Am8RprsPkv/2i+CVNfosRQTp1iMo92ToEUNDAUyab2Q5nzfFrwoLaw4dzHY9j1375S90cFnODeQ
	DwoxcO1aPu+bAwx1GiCDDnhqu6vOFKcrZjhekyhFuAJzFaHv/5V//OkTL/5pSW3767xfZuLhYFV
	FTMTtVJMmsIf2qROmHFRvOZcMiFO9rNekS5tZX30ECs9qKNRf6mlr0u0gPlNwEcJtgq5/52rLX9
	dc/O0H1AE5U+S9tzfW0pUj9eWoNPl3m9UZ0yylPmPAYcA3E+TsnGk99kkofKgcZH0W5TWShSjo6
	p9FE4Sw21LWBDOYzeTuYw58Nw0a7Qgrg/uUAphIfUbmT9PbMX81AbtXNP59p1toi+S/2xFx66O0
	zUbSFiNqevCw7eGGo18gZaJHiRi59nFPNkB6ln8Kfz2cuhUGWsikcgnDCMmLFN3OiNYzsBKbVkc
	E8O7OvhBsCtHlTik8hJ4guWcscja2IRAlicFlJ7sYuY7VZb7dRckHnd4eaDIkAsYkOjCMQhbjqm
	EfoCA95rlmwMvgB49FURCf/q5SZVCdRodnhT/tkIQlt6pQ==
X-Received: by 2002:a05:6122:3310:b0:5e7:8bd1:731f with SMTP id 71dfb90a1353d-5eaebe0abcemr2486996e0c.10.1792684034817;
        Thu, 22 Oct 2026 08:47:14 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 05/27] l2cap-tester: Fix race in LE Client - Close socket 2
Date: Thu, 22 Oct 2026 11:46:38 -0400
Message-ID: <20261022154701.3959500-6-luiz.dentz@gmail.com>
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

The test closes the socket once the scan is disabled, expecting the
kernel to cancel the connection attempt with LE Create Connection
Cancel, but the kernel only sends LE Create Connection after disabling
the scan, so whether there is an attempt to cancel depends on which runs
first. Close the socket once LE Create Connection was sent instead.

This shows under User Mode Linux time travel, where the test always
closed the socket too early.

Assisted-by: Claude:claude-opus-5-5
---
 tools/l2cap-tester.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index f2d3e56b8761..c2643b4182b0 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -2769,7 +2769,17 @@ static void test_close_socket_scan_disabled(void)
 
 	if (l2data == &le_client_close_socket_test_1)
 		g_idle_add(test_close_socket_1_part_3, NULL);
-	else if (l2data == &le_client_close_socket_test_2)
+}
+
+/* The kernel creates the connection once the scan is disabled, close the
+ * socket only then, so it has a connection attempt to cancel.
+ */
+static void test_close_socket_create_conn(void)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+
+	if (l2data == &le_client_close_socket_test_2)
 		g_idle_add(test_close_socket_2_part_3, NULL);
 }
 
@@ -2793,6 +2803,8 @@ static void test_close_socket_router(uint16_t opcode, const void *param,
 			test_close_socket_scan_enabled();
 		else
 			test_close_socket_scan_disabled();
+	} else if (opcode == BT_HCI_CMD_LE_CREATE_CONN) {
+		test_close_socket_create_conn();
 	} else if (opcode == BT_HCI_CMD_LE_CREATE_CONN_CANCEL) {
 		test_close_socket_conn_cancel();
 	}
-- 
2.56.0

