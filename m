Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737820;
	b=SyBWG/fsOo6/Mn+v9u9EhWNopOapooHomiXE1CKSZ2lJd7Y+nQHDLYvOzywTgIFxEuld
	 XdHYT4oMujdbW+xeJKzEZog86vxNbhNoa4xSo//Y/N5lJ9TX214CfMNPn1eetJNziy2S/
	 vj/9YmzPX/aQV9limG6nlvRI0Y0KxleMGPgNMYJiIVdeCq0wVVVCY0nwPjfpeOcCFmP19
	 uhdwwoircXFxOqp/jKUk8s6+EfvOY2lH+qiFRblrf0nvfRdaCPgqe1cB4+IAooa8dP8vr
	 E1rqhE6si78YtqNOCPMM+mKpMnP+NrPyiuABpCgykxlo/k2Fo7jiGEjXbaolC8H7YEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0fEbVpzAYZ1geT4KPz+slnD3AQTSaGYACgL7oQWmOCA=;
	b=q7SxtFQrplecFCQK6fveCCIYLoxI5wgdpFLp6KXaSiwj3Le3UQspuSL9JXYA58Qj624h
	 YJN8tmbPS84/KdznVWF90EOJNOX2QAanXdUPOsjbdL9dpSe4zZDsmpSOIJpuFBJH8u2xt
	 dVo3VvU40ZrTONqZAHeZXZ7SHiifol8WCj80CkGGXtJj9bKICLqqHwKcLyqf4h0VNy/aE
	 K2AsM33FJuc0tBS896zbMJeDtpdGaeNWsrOV7bs+LHAeXUZzgzWfgt1Ox6pi9tsICjkeM
	 ZpRU2X80D4mZeQ+ajXuDoii/XWDL0CcWCC2uKCac4167Tiy2ksSUS4kOllOZPpKwb7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CeHD4VBx;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7527606A331
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7527606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CeHD4VBx
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eadf48fb2dso1650062e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 12:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737819; x=1794342619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0fEbVpzAYZ1geT4KPz+slnD3AQTSaGYACgL7oQWmOCA=;
        b=CeHD4VBxiCyp6sEoxuLl1fotBRlmbVloa+AXi8q6Zk6SWkTJjCii4sJnsrufhoSpDg
         xZ6otGNHaSGBAqlkUulJZnc9xi9dU3evboCYp6UbUNch/zzqpjpntCkHq49/5xeE0Pdn
         FOa+yWOoXds2T5uUj0QRuuqsUQA4cWiCE7N0PwcTJ4Do2strp9KPtobfCB+D/br3aMqG
         1MNLzMvzy+HhwhIqS2J6/sxkVKgxK6UqcIXdU+NkZVYvlrlG3aFDPX513f5guk3giVJo
         yW12HAvEaHObdONJB8TgISe+fTIRsq57OZLWDSL6wvWNHwGg/ZL/AAHtAs0EaY5UGiEG
         Qcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737819; x=1794342619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0fEbVpzAYZ1geT4KPz+slnD3AQTSaGYACgL7oQWmOCA=;
        b=w9QXd0iUiabai1GXgoZntjix5203eh7rGVeAMTyyJUAkYLIfHWn8FwBAbNwzCkz1Bl
         HCO3XFs8zqwpH/2qasgm9jCiQZSD0TPR4HQaUYVN9OKh91q9d8hsgizyVs1oA58HMWVf
         k9gpyCWLEGt5B5k9MbaF6cOcseZCrmffGRTg5hiV7g6cILC4ofa1I/xQZrXna7FnTdoQ
         dJj+XaNFS9AGhbIlVomwa8tvJgYxp2Kx7nvNwFtRx1TDoic8YcrGzGchusKnBPrJxHyl
         ucguwUohlZgFESHMiHw5WQqJz3oMGL6xP36aHvpuz3B/42cMjTNNAy1NH1580ncxX8xu
         iW9w==
X-Gm-Message-State: APuU4Z8ZCTVzXxsJRddkrYp/sd64hS1ohTvyNOO4IrIRLQWEbWFCRZ1p
	j0V3/QsTt3lldq1FXEJ7jyLLHR+o4H84zmYgsM9BykcykyVIyYjIuvrjsBWpUQ==
X-Gm-Gg: AYBFou17TL4nz79msbAIbAqpqh/lvhV073cLt2dIwld/84MZ3RqN1N27aQpAhY827ws
	2BoYWhDRfpwqWk0mvJS8FU+sCnlsHtsY0F0AsaXbdlWeRuivyLLvAc6JQLKkcBHIwMbLj3CCJtx
	YFOtTBs9cgIpN+m50t9UNEeXNgjgxsEKiVWe9Fa3Ul2qfcI9AJr7YZ697/URYF0u6LnR8zTr+/H
	F5efj7BNXA6dumfIKGyh20GsFNodQEyHp2rp9D7VHOLaLuyoF5zxj3af6Xz1NKjJdetDYAzAHop
	o0rFFCR+iCEsvEZyXMdZjCcWXKolTkv2jQ7rnJKQKqX7HFjjHoh+Fc9bq/tWY8ht4A/gfFsiag0
	BF9fyjfpUA9XE/gZCt3mdyxY8rFuT8rOe/WCPwcsH9niJVxSstEaHamlAYW91b4utoaXXwclAL3
	UyHM+j2NP5+r7oERrtIiSjbPZcYra4yoeBxtmYL4LuAHTBLAsQterUM77DiagyFzHv+XWN3cccN
	X52pD+RbxITYSNuK60pU2u1vFZZQIQ/KR1QVHOQCo3awKaVomaUU87aGvIJUWjfTpty+C/PzBzc
	COQQiGwmmib9GiWfps0VWnKUCOx1H42zcpPLXJFFafePzr3m1fB1/EYD4s8aOeZK6iS/X8fzNkE
	tzoKHO4lxp4Iylv8jtqtH7NUd7qSj4vVlfn7zuv+P/ptyp5EIYRzZjuVIoQ+5Afeeswz9mRC0+y
	B3nGT5AzGZxMBYvE1tXIkoIOiI
X-Received: by 2002:a05:6102:148c:b0:7c3:9464:efaa with SMTP id ada2fe7eead31-7d07223f482mr6132529137.2.1793737818936;
        Tue, 03 Nov 2026 12:30:18 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d91d2a3asm139916241.8.2026.11.03.12.30.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:30:18 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/7] shared/tester: Add support for alternative PDUs
Date: Tue,  3 Nov 2026 15:30:07 -0500
Message-ID: <20261103203011.3904290-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103203011.3904290-1-luiz.dentz@gmail.com>
References: <20261103203011.3904290-1-luiz.dentz@gmail.com>
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

This adds IOV_ALT, IOV_ALT_OR and IOV_ALT_END markers which can be used
to express PDUs that can be exchanged in alternative ways, e.g. when
an optional feature is used, along with tester_io_set_alt which selects
the alternative to be used by the test.
---
 src/shared/tester.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
 src/shared/tester.h | 13 ++++++++
 2 files changed, 87 insertions(+)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 72b280a1f3d5..5207b6aa7cf8 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -85,6 +85,7 @@ struct test_case {
 	const void *test_data;
 	const struct iovec *iov;
 	size_t iovcnt;
+	struct iovec *alt_iov;
 	tester_data_func_t pre_setup_func;
 	tester_data_func_t setup_func;
 	tester_data_func_t test_func;
@@ -145,6 +146,8 @@ static void test_destroy(void *data)
 {
 	struct test_case *test = data;
 
+	free(test->alt_iov);
+
 	if (test->timeout_id > 0)
 		timeout_remove(test->timeout_id);
 
@@ -528,6 +531,8 @@ static void next_test_case(void)
 {
 	struct test_case *test;
 
+	tester_io_set_alt(0);
+
 	if (test_current)
 		test_current = test_current->next;
 	else
@@ -1170,6 +1175,73 @@ static void setup_io(void)
 	io_set_read_handler(ios[1], test_io_recv, NULL, NULL);
 }
 
+const uint8_t tester_iov_markers[3];
+
+static unsigned int io_alt;
+
+static bool iov_is_marker(const struct iovec *iov, unsigned int idx)
+{
+	return iov->iov_base == &tester_iov_markers[idx];
+}
+
+/* Only keep the selected alternative of the PDUs in between IOV_ALT and
+ * IOV_ALT_END.
+ */
+static int test_setup_alt(struct test_case *test, const struct iovec **iov,
+								int iovcnt)
+{
+	unsigned int alt = 0;
+	bool in_alt = false;
+	int i, cnt = 0;
+
+	for (i = 0; i < iovcnt; i++) {
+		if (iov_is_marker(&(*iov)[i], 0))
+			break;
+	}
+
+	if (i == iovcnt)
+		return iovcnt;
+
+	free(test->alt_iov);
+	test->alt_iov = calloc(iovcnt, sizeof(*test->alt_iov));
+	if (!test->alt_iov)
+		abort();
+
+	for (i = 0; i < iovcnt; i++) {
+		const struct iovec *v = &(*iov)[i];
+
+		if (iov_is_marker(v, 0)) {
+			in_alt = true;
+			alt = 0;
+			continue;
+		}
+
+		if (iov_is_marker(v, 1)) {
+			alt++;
+			continue;
+		}
+
+		if (iov_is_marker(v, 2)) {
+			in_alt = false;
+			continue;
+		}
+
+		if (in_alt && alt != io_alt)
+			continue;
+
+		test->alt_iov[cnt++] = *v;
+	}
+
+	*iov = test->alt_iov;
+
+	return cnt;
+}
+
+void tester_io_set_alt(unsigned int alt)
+{
+	io_alt = alt;
+}
+
 struct io *tester_setup_io(const struct iovec *iov, int iovcnt)
 {
 	struct test_case *test = tester_get_test();
@@ -1182,6 +1254,8 @@ struct io *tester_setup_io(const struct iovec *iov, int iovcnt)
 		}
 	}
 
+	iovcnt = test_setup_alt(test, &iov, iovcnt);
+
 	test->iov = iov;
 	test->iovcnt = iovcnt;
 
diff --git a/src/shared/tester.h b/src/shared/tester.h
index dfc1ca3a8ebe..b22e8b38ea2a 100644
--- a/src/shared/tester.h
+++ b/src/shared/tester.h
@@ -23,6 +23,18 @@
 
 #define IOV_NULL {}
 
+/* Markers for PDUs that can be exchanged in alternative ways:
+ *
+ *   IOV_ALT, <alternative 0>, IOV_ALT_OR, <alternative 1>, ..., IOV_ALT_END
+ *
+ * Only the alternative selected with tester_io_set_alt() is used.
+ */
+extern const uint8_t tester_iov_markers[3];
+
+#define IOV_ALT		{ .iov_base = (void *) &tester_iov_markers[0] }
+#define IOV_ALT_OR	{ .iov_base = (void *) &tester_iov_markers[1] }
+#define IOV_ALT_END	{ .iov_base = (void *) &tester_iov_markers[2] }
+
 void tester_init(int *argc, char ***argv);
 int tester_run(void);
 
@@ -84,3 +96,4 @@ struct io *tester_setup_io(const struct iovec *iov, int iovcnt);
 void tester_shutdown_io(void);
 void tester_io_send(void);
 void tester_io_set_complete_func(tester_data_func_t func);
+void tester_io_set_alt(unsigned int alt);
-- 
2.56.0

