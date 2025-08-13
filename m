Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801F22F531D
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081555; cv=none; b=LBpZV9m1OnFcPa3woL4Z20NAITKNPTESabECbPrfzwr9pfP9ZIm9+zWCY8Ecapk8eGcKpNvwszEwrr2C6+iqinq/d0mTtf7LkfGWoH/a0YavJI6atHJucaKcgMN9orpbGnza+6HtYDBpAyW+ARbaODr4N09QSM2QIRp+4eBoxHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081555; c=relaxed/simple;
	bh=lUYIHsbUEAP1Q9DvDO4Sq9GKvQvxKlx6sImNAGq3r+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RFuta01FdZsX9dFY8MmMZSBGsxpRMLkptQQpBFxIhRL/b4w3puXigMwb1TMJl9HVphDxQOeRvbRIUtXPIUb/NhuAAiRxsfBqpSXaN3/Kh/9oSMDbep/BJQup4UAHvB5PokjYHKCw+OWE+P7dmdY/9qOddmuPZT1e8208DsKOcaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ochang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gv3h2ygL; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ochang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gv3h2ygL"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b42218e4a59so4799235a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 03:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755081553; x=1755686353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vq9vo2Ko6yv8GAgYx3zY/kpewYc2fsVyO2G/VwUUO9k=;
        b=gv3h2ygLQA8NHLHuJNmsznjmgpahIcL8z2CJTZiGRIsVXH8ZPNF1wqwxMYkDAqercV
         bA6GHQQ62gtFTX9HOpg+rbcNJYgLgCyjKU/iGvSxxFXIK6Ev3pp3py09hq2Gb/E7HM0J
         c07JGMDSay0NhZGy11EPM2uAvq38AEhjf4YQKgF5lp9noTOKJBL8Z3EiayWYolgHBb6/
         Qz9z8TZczcve5lfYoIWhxXnvL0y4ITBv9AdS2d81MAE8nrSO7QscNWqUzv/g7mvyAx4N
         hjn8zNTRJ6kse/Ri8vGUxtMedoYEA630mOoSaQ1EfG9QPP9iLipiNIQhJm5kLTo9lzX3
         2hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755081553; x=1755686353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vq9vo2Ko6yv8GAgYx3zY/kpewYc2fsVyO2G/VwUUO9k=;
        b=I0fX2KYiH5yWb1o19CaCtIpCexQPT3wXPEposbk7mMQsDeg8xrd4YRmW81LSpxMsk/
         FeHmVszQz8fp3flybKZ+TL8d8gXjXRZzv6GGXvTMO5iC5vsgoXkBq/Sl7uyR9o7s1GMn
         GsAHHFPQ8Qlqby1nerG7QG6YC2md9i4/PP9BDUZO4tLqdJc3h7B6grLdQ+KAvrOSRjZm
         NHO6lTtdDN3MnyF/KkZrfXNXfU0Fd/O7HW4Hb+Humf86sHOnAgAHpizqS0nGLTu33yXL
         5YR+wS7piHnN5DYfXkEFrNiIOY3t0Pgaibzglo3ohI2OmhQVVwG/gaHFKEPBgqclD+3U
         B76w==
X-Gm-Message-State: AOJu0YxDiuvD0FaFdd+NrPBnPLfRqOJmGYutdykcPudSyuOb2OiJRs5x
	MmGm4ITTZf5sMvPxGFWsQtk2AwxW2ugJR4pJUG7DRxDoXO2CpGp/+iEw0zP8ECgDh5UQX625SCa
	yKVPTzQVcFklOTbtBFHppVHKCQkgM1/qapzowHZAIP+JcxRWP7d0SZwYqlVQ8KnyxEdwNvAaXBQ
	7jpbuS1s9GNZuwmEmxFca+Qk8PgF/ZeAG7NnVsVx0oxYG5oCNR
X-Google-Smtp-Source: AGHT+IEys+QJlzEnNcZpVjJ4yh5QRr7cqtpQqsQ1f8SBz49TNk05LNp+mRR1QbyLUmGY4hXgLfJU2BQ2+fI=
X-Received: from plbmz16.prod.google.com ([2002:a17:903:3510:b0:240:801d:1089])
 (user=ochang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:286:b0:240:44a6:5027
 with SMTP id d9443c01a7336-2430d12cba1mr35433945ad.15.1755081552717; Wed, 13
 Aug 2025 03:39:12 -0700 (PDT)
Date: Wed, 13 Aug 2025 10:34:59 +0000
In-Reply-To: <20250813103459.3690107-1-ochang@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813103459.3690107-1-ochang@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250813103459.3690107-2-ochang@google.com>
Subject: [PATCH BlueZ v2 1/1] Fix heap-buffer-overflow in sdp_xml.c:compute_seq_size
From: Oliver Chang <ochang@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: oss-fuzz-bugs@google.com, Oliver Chang <ochang@google.com>
Content-Type: text/plain; charset="UTF-8"

https://issues.oss-fuzz.com/issues/42516062
https://oss-fuzz.com/testcase-detail/5896441415729152

This can be triggered by using an input of
`<sequence><foo/><text/></sequence>` against the harness in
https://github.com/google/oss-fuzz/blob/master/projects/bluez/fuzz_xml.c

The root cause of the heap-buffer-overflow was incorrect stack
management in the SDP XML parser (element_end function) that led to type
confusion.

When an XML element failed to parse (e.g., an unrecognized tag like
<foo/>), its corresponding entry was left on the parser stack because
the we returned early if data was NULL.

With the input <sequence><foo/><text/></sequence>, <foo/> failed parsing
and remained on the stack with a NULL data. Then <text/> was parsed and
also remained on the stack because it's only popped if
ctx_data->stack_head->next->data != NULL.

When </sequence> was encountered, the parser then mistakenly used the
data from <text/> (which was now at the top of the stack) as the
sequence data.  This led to a type confusion: the TEXT data's string
pointer (val.str) was interpreted as a sequence pointer (val.dataseq).
This pointer pointed to a 1-byte allocation (for the empty string). The
code then tried to dereference this pointer as an sdp_data_t struct to
calculate the sequence size, leading to the out-of-bounds read.

To fix this, in element_end, ensure that the stack is popped even if the
element's data failed to parse. This prevents the stack
desynchronization.
---
 src/sdp-xml.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index a83dec157..e5b30e885 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -545,8 +545,15 @@ static void element_end(GMarkupParseContext *context,
 		return;
 	}
 
-	if (!ctx_data->stack_head || !ctx_data->stack_head->data) {
+	if (!ctx_data->stack_head)
+		return;
+
+	if (!ctx_data->stack_head->data) {
 		DBG("No data for %s", element_name);
+
+		elem = ctx_data->stack_head;
+		ctx_data->stack_head = ctx_data->stack_head->next;
+		sdp_xml_data_free(elem);
 		return;
 	}
 
-- 
2.51.0.rc0.205.g4a044479a3-goog

