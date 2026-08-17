Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DF53C65E0
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000452; cv=none; b=clQ6C2VA89K1JxKNH15hjBkBSeNaAYmV4fpqkWgSJFn9BsSCr3o9aOgeDkqiP38aTeOcCBcJWm3h0XLwxE6UgnJwt4yrexvYe9z/flzeHbw//tDXDjvdBuPF4JCwGepayJKElh7MjCLKLqGr8JyA2nTCccMnzmBIKyf7Fq0jlso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000452; c=relaxed/simple;
	bh=jF77E+Wzp/nx3cBMfwOuD/Iz2bMC5jvXavEMJQy63AQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f211qMH9zwbvjQN/Hm3KwD+zygVeSQWk2BqiY4GgkzhzA2PJo9plbOfXa2vL8jqbCG+80nSzEFJ94rBEn/+Jdc/yhQAo4VoDz29D2sDKmgVXjx7+/qRbAU3SGMr0Fyig5t23BohnKT29mEHDgDUiv5J+rVqjXA8SAUKaM5gFQyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mdf3KxRI; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mdf3KxRI"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-97bf91b2e6eso555498241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 14:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787000450; x=1787605250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NOdn8uH6vUr+RTDhO6/Gm+rtGQKbjeKrJV8Jbf1rsrY=;
        b=Mdf3KxRIFalMt65BMsFB5GmfHrQ8gV1AyI9AmqczqaH+UakGYV5mnep7+vJ0x2U2qQ
         2/XQuZfdSWyFepluida9EBSaM5iIE6lHsCgABAfPqRaUg08yqu2j1ANxqJMM4useuZYL
         GznigH5hNgmzgKQVwfieNnvBC8KzsuPc/1Wlvg8wjaWg0t7nmFK+2JgyWu3bsmlPfVtu
         eFsryyKByp/Qd7oGvGVTtx5RkrbFq1tfiduTdQklPViC8uZs9/sj6wIuBWpydM/kpd9d
         YPWuzhrdzlJT+TluLsNMxfrsyaxKynjykuimWf4rffqeQR3GuPmokSree82CXOXsVE20
         qfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787000450; x=1787605250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NOdn8uH6vUr+RTDhO6/Gm+rtGQKbjeKrJV8Jbf1rsrY=;
        b=J28tYxyktD0V5IoMLncgGjwTs0sIZ+/tjNerUa+wP80IcZC3HHgd0rEPYmOVAvCR+s
         gPOdENomlFg4F1lEquuhklWeFWKrMU4iNyVVdtEIW6CWj/ON194yVectMUNaxC22aCrn
         BqwbF9xZ8g6uSBMsAISdIpSdWQeu33gk7N8OZaeTe70IEEHBObHil7EZ/mpXC6aiNjuU
         Q1Vahhu77Xnuyng+ow7Uoa3UmorO6uWnE2eCFZYV/Y2C4o46DTEiD46FAppLc6U/ubnK
         LWZQhSCo+/qu4dQNSfvu9Q7z/173FnA3cntY+2UkA7Pxp/dHtAZwQsMSd3Kwr0Cxr6AK
         xmeQ==
X-Gm-Message-State: AOJu0Yw8Lyfv/ErIogghehf+HLHUMsz0ek7DwOOYxI8rqdellakAkbE3
	YT+bEfrYET9MLMWo84VEg0jXllkC7Iprkdw+bMYuR6ZqppMGtNXRyZNOcBsvb/bW8j/ajQ==
X-Gm-Gg: AR+sD11mmDEQSmmwVnwNRWHTDxSH9t3FPUq+HMumWUN6uipGe7B7Vttik0CPrY4clCz
	u1Ib5PawBNjVD1AQGcRFrjYNVzFPvaCvz43IOoq48ADw42EoGU5YC/3KCtyU/eQmidHYRsvVaaS
	zcpMrYv5hnD64xnrXltI9CSuyjOIGyPJMFnOqTrQboDGzV1cFWhMEHpCu1KW5dzOtjLiDlxZXpE
	c3xCeZ6Tg3Ovyx9fXmmYLrbzKF6cP6J97FDjLhA60nyr9BZo+foMqsHCWOwjDY/vRu6XNqw1caI
	11MqSJjb7xhDXChBOQMVkqd9XCPtGbooiVuJwqdjybfpItVBzHdbsgwv1Kw4iSZ4g7WQUuC9XGA
	tmhGN7wo8kFtuxI4BSk1ptv//JETwu1Op/K64QcJJm/K3SFJJtcCf8IepJIp1ajKEkUbetdt5Mo
	t6b+5f71B1thm7pP9IIwBvcI5gxjdm/oumqHhIrvm3BT0lg81w+2/0xZJcbnhdN7LjZTKzyNrvX
	qnVNYAIx2HDSNU79bH48nGnvv7Yq4Co0TlaK4V284OmZvkDmsAmMpA=
X-Received: by 2002:a05:6102:512c:b0:76f:eaa2:6fa7 with SMTP id ada2fe7eead31-7747adb4896mr796401137.2.1787000449741;
        Mon, 17 Aug 2026 14:00:49 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97c2c29e934sm2121511241.3.2026.08.17.14.00.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:00:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/4] sdp-xml: Fix leaking the parse stack on malformed input
Date: Mon, 17 Aug 2026 17:00:36 -0400
Message-ID: <20260817210038.1839617-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817210038.1839617-1-luiz.dentz@gmail.com>
References: <20260817210038.1839617-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

sdp_xml_parse_record() frees its context but never the elements left on
ctx_data->stack_head.

element_end() returns early without popping the stack when it rejects a
document, for instance on a mismatched </sequence> close, so a malformed
record leaves its elements behind and they are never freed.

Free the remaining stack elements before returning. Found with the
compute-seq-size-type-confusion.xml test:

56 (direct) + 1,072 (indirect) bytes in 1 blocks are definitely lost
   at calloc (vg_replace_malloc.c:1678)
   by sdp_xml_data_alloc (sdp-xml.c:73)
   by element_start (sdp-xml.c:473)
   by g_markup_parse_context_parse (gmarkup.c:1369)
   by sdp_xml_parse_record (sdp-xml.c:696)

Assisted-by: Claude:claude-opus-5
---
 src/sdp-xml.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index bad9e289344f..bcd5785f87ca 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -551,6 +551,17 @@ static void sdp_xml_data_free(struct sdp_xml_data *elem)
 	free(elem);
 }
 
+/* Free the elements left on the stack, e.g. by a document that is malformed */
+static void sdp_xml_data_free_stack(struct sdp_xml_data *elem)
+{
+	while (elem) {
+		struct sdp_xml_data *next = elem->next;
+
+		sdp_xml_data_free(elem);
+		elem = next;
+	}
+}
+
 static void element_end(GMarkupParseContext *context,
 		const char *element_name, gpointer user_data, GError **err)
 {
@@ -696,6 +707,7 @@ sdp_record_t *sdp_xml_parse_record(const char *data, int size)
 	if (g_markup_parse_context_parse(ctx, data, size, NULL) == FALSE) {
 		error("XML parsing error");
 		g_markup_parse_context_free(ctx);
+		sdp_xml_data_free_stack(ctx_data->stack_head);
 		sdp_record_free(record);
 		free(ctx_data);
 		return NULL;
@@ -703,6 +715,8 @@ sdp_record_t *sdp_xml_parse_record(const char *data, int size)
 
 	g_markup_parse_context_free(ctx);
 
+	sdp_xml_data_free_stack(ctx_data->stack_head);
+
 	free(ctx_data);
 
 	return record;
-- 
2.54.0

