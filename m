Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AA525771
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754616867; cv=none; b=ZKDijcxVhhRyJF8Es1DWzckMSlbUok37bDhIcXhWi9yUyJy/KqHDZkyysz7rB1iWxutkpnRtsKtKV09pccrW+bPhvTAPs6fwMqg5uGNQzhhJuP7GlvnAZwf1sHcRqQE43PESvvjCsp+Tm7jk7aMnT0E95iEfgxYSXjO3cdPfFcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754616867; c=relaxed/simple;
	bh=QekBkK7MEMxk7GAzguv442Qe6PBvLjyHJZRjY10HoPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XlL009Sw9cW+4RWy4Kt4IcTPDgXPaFNwTMGA3O6/x4TvNzbUmLWiqO+t9+t1vhdRxR/ScRGxIS8J729SCu9jnQ+VoAzbwFoE3AKthr4E22S/oi0P8wYIfeoICTGswcIpXD7bjPWPcPW7P9EJ7GEJ6DlP26Q6jPTtNJieyxdeZ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ochang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IsVRy2AO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ochang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IsVRy2AO"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3214765a5b9so3266849a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Aug 2025 18:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754616865; x=1755221665; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNV3YDOvw4ZWIydwk7skw09gICf9leoJScB5uYFRKFg=;
        b=IsVRy2AO2nXLG7zluunkY2WBdsRSSinUlr53N+58hkJS6rVv9JORh/TswIT9f1b4I6
         UFXMSQUG6NK1JdvxNlEwXxkHVVg6sekEH9IUAmoiENDZWdH9hUM7RuOp4rNE86+BuK4z
         k6TaxTiRl3XBuUlsL2lH55iI5rNHu0hQHZ7e+dwkp1fTGZaCCws/cDiUjfJOqubFuKOD
         6hLsD8DnGl811u1DnMylbPi6jR9jp5pnZApnu3NcgSNNlpQ+Ix6oxou/LlBfbWzPmIde
         r8KbELI3xjGNQkWNVvHfVMVv4UdwItcn3rqdpg+opZKipAn/udX7dkGQn5I9IQjssaAp
         V9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754616865; x=1755221665;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNV3YDOvw4ZWIydwk7skw09gICf9leoJScB5uYFRKFg=;
        b=m2iPgUo+NjFAuXcDkRQmtzBTrQA3tqfpJnduKv4QG8eJicK78fSHVAOZbHN4xCVEUv
         syooYXPoSF++pn8bgvXORqhyqOe/VnKhKSlo0uBhS4SP+cgGanXm2VmwsS7d74yOVDVT
         0BmVFz8rldLxKhMP5hHk8fyxXTfDaHsiMih/z4cZI8+ltHcjChk+jjZl4ED7K8TUk/5R
         cxlxgGJx7p1sG+YZEvwmU00sudTsNcFcfUEuS8XP6RDguz1VB2I7PSQUpcAr12ypY3wU
         mAfeQsfuoPdqkZ/jJUzswP6+wdDwRu300tUxONMhIyf/6N32aPfGgzsPyHz2xOfUYVLh
         V3Bg==
X-Gm-Message-State: AOJu0Ywzz+sy2SZcxClUFFbu9G32fBeIm7TS4Pos9k4ZLFZK1JgGlryr
	Wy+spOBWsYGrTEDfNaWnQzgMooto5ID4uf5YGOa2McP7AvM3TMbVDVPHv8u9KQ75fAvY2L+SmX5
	BZnsebtraspjce5wGWZIIHqYzvO5I4mWMnOvH+OjptNrIrxe8QSx5PRdRj9snbn777hIrJpkULH
	aJBzEucg1TdEZGPC17s5ghFsCUqy+ywP0AGLg7POpoRqCXJTv9
X-Google-Smtp-Source: AGHT+IE0tanmg36lZrGjsR+uHSelGCiovQvNQAEHdAex/6lgbNqbdLYArM22GMP9mhN8zPG6g/bqxkHjmBI=
X-Received: from pjre15.prod.google.com ([2002:a17:90a:b38f:b0:31e:c87a:ce95])
 (user=ochang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1811:b0:321:39f1:f421
 with SMTP id 98e67ed59e1d1-32183b4576bmr1907566a91.17.1754616865273; Thu, 07
 Aug 2025 18:34:25 -0700 (PDT)
Date: Fri,  8 Aug 2025 01:34:02 +0000
In-Reply-To: <20250808013402.548986-1-ochang@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250808013402.548986-1-ochang@google.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250808013402.548986-2-ochang@google.com>
Subject: [PATCH BlueZ 1/1] Fixed heap-buffer-overflow in `compute_seq_size`.
From: Oliver Chang <ochang@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: oss-fuzz-bugs@google.com, Oliver Chang <ochang@google.com>
Content-Type: text/plain; charset="UTF-8"

By adding checks for sequence/alternate types in element_end and
ensuring proper cleanup in sdp_xml_parse_record error path.

https://issues.oss-fuzz.com/issues/42516062
https://oss-fuzz.com/testcase-detail/5896441415729152
---
 src/sdp-xml.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 5efa62ab8..b10882db2 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -545,6 +545,13 @@ static void element_end(GMarkupParseContext *context,
 	}
 
 	if (!strcmp(element_name, "sequence")) {
+		if (!SDP_IS_SEQ(ctx_data->stack_head->data->dtd)) {
+			g_set_error(err, G_MARKUP_ERROR, G_MARKUP_ERROR_INVALID_CONTENT,
+					"Unexpected data type %d for sequence",
+					ctx_data->stack_head->data->dtd);
+			return;
+		}
+
 		ctx_data->stack_head->data->unitSize = compute_seq_size(ctx_data->stack_head->data);
 
 		if (ctx_data->stack_head->data->unitSize > USHRT_MAX) {
@@ -557,6 +564,13 @@ static void element_end(GMarkupParseContext *context,
 			ctx_data->stack_head->data->unitSize += sizeof(uint8_t);
 		}
 	} else if (!strcmp(element_name, "alternate")) {
+		if (!SDP_IS_ALT(ctx_data->stack_head->data->dtd)) {
+			g_set_error(err, G_MARKUP_ERROR, G_MARKUP_ERROR_INVALID_CONTENT,
+					"Unexpected data type %d for alternate",
+					ctx_data->stack_head->data->dtd);
+			return;
+		}
+
 		ctx_data->stack_head->data->unitSize = compute_seq_size(ctx_data->stack_head->data);
 
 		if (ctx_data->stack_head->data->unitSize > USHRT_MAX) {
@@ -621,6 +635,11 @@ sdp_record_t *sdp_xml_parse_record(const char *data, int size)
 	if (g_markup_parse_context_parse(ctx, data, size, NULL) == FALSE) {
 		error("XML parsing error");
 		g_markup_parse_context_free(ctx);
+		while (ctx_data->stack_head) {
+			struct sdp_xml_data *elem = ctx_data->stack_head;
+			ctx_data->stack_head = elem->next;
+			sdp_xml_data_free(elem);
+		}
 		sdp_record_free(record);
 		free(ctx_data);
 		return NULL;
-- 
2.50.1.703.g449372360f-goog

