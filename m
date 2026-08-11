Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31201391E55
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461030; cv=none; b=AOdNt9cJTx2CKxZ64UI8cD9B0F7gYHjmsBH9tj8OumMW3Cp9GThAMkPh/ShZHPwKMi7ayNQOX9Ttdy+nY5mTczfPBTh/zibUa4XClgK6DrVtA8d4ksuluN21xIddipzCnXll2jHHM8PmRHS8ihEXV0X8x/9qIFw+Zf1yIkTAkBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461030; c=relaxed/simple;
	bh=pFuIwu8cwx0SuQog+mqu7D15++4zRLacajRgcAtssuE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIR94RZW2NDn/TqRm6qyGlnSq2GBUh5ALRi5aLvUBYEQ17mz4OXsc0rx4bz7W5ab63nem1U+Tm53/ak7+lOj+/8QpdZqdijjHA1VcCpLNlZpcKs9z9e2SI4BE3QHL0vj8sCFHkUTC0j8KqnVBLmQGelbbyOkOiVQA98UJNOcpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 75DEC582331
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:21 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 53F7D3E96D
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:14 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v3 4/9] sdp-xml: Fix memory leak when adding duplicate attributes
Date: Tue, 11 Aug 2026 16:54:07 +0200
Message-ID: <20260811145704.1766949-5-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811145704.1766949-1-hadess@hadess.net>
References: <20260811145704.1766949-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTE7//a8gsi3w1GPpapT5Ukt+fEcfN0ZqTSeGCFTUi06HsKf4CTnNBAfQbQDkgHMQet12ca5SSLbtGFwNNEDfR56GEWiE694LLeds/YbTFK8oKE84ZZdRJN/9FvvJbitjEXe5X2Ux89sLo+6GZDvGV8fazWxgXEouHAPP8iOQOz18/3hSyqTpUBzum+i6Ub0Nt2fhaOHGrZ6NgN+LKLEtlkbSxHz7YtbNs3pVeVioymzgo9MfUufhQwyCrV3uFtqkiDCROWsNOJPwtkJ1K6Q+FDhjCe4szlYUmtKvmhPVzImpKtNCEY8GR2ieMfP074xV8f74uk7YI29NimMTemkaUPeKDzjICpogEQ7m7VCSyBbyEXIcYNAHEI9n+HKZ1SjEB7ySDq/INfLMlDIW1/pJgdKb4WotlLQS+CQbBeiViXK6OhOeqodkaaKBLCU7A2aATOuDf5wGB71TcebTMlvHy/L+pTkYP5uVxdYolAfoMWapGznBt6GYnk0stc8Wjb/qmrY0x4RmFAAXbgwaI61D8z9DM0OB6ufaZ3NspHsGQctysQU7dUPr+8sFjj838O0IWhLnY/we+RVA9KfaZaNZbVgAK4I/1Gidr9+3s65+DYNNNXcakGmUNRTTbaZUaRZn/FPPIt1pJQFbInRoUlqqnLHXHrdhovpwdXHr1y2gHc9hQ
X-GND-State: clean

When sdp_attr_add() fails because an attribute is duplicated, don't
unset its pointer in the parsing context data. As the attribute wasn't
added to the record, the ownership of the attribute didn't get passed
to the record either.

Don't set the pointer to NULL so it gets freed when cleaning up the
context.

Fixes those 2 ASan warnings:
Direct leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7f896a8ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)
    #1 0x562042b747f2 in sdp_data_alloc_with_length lib/bluetooth/sdp.c:350

Indirect leak of 2 byte(s) in 1 object(s) allocated from:
    #0 0x7f896a8ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)
    #1 0x562042b74bd7 in sdp_data_alloc_with_length lib/bluetooth/sdp.c:425

See https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc

Reported-by: Aisle Research
Co-authored-by: Aisle Research
---
 src/sdp-xml.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index c8f9ed013b29..816d19611f8b 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -537,8 +537,11 @@ static void element_end(GMarkupParseContext *context,
 			if (ret == -1)
 				DBG("Could not add attribute 0x%04x",
 							ctx_data->attr_id);
+			else {
+				/* ownership transferred to record */
+				ctx_data->stack_head->data = NULL;
+			}
 
-			ctx_data->stack_head->data = NULL;
 			sdp_xml_data_free(ctx_data->stack_head);
 			ctx_data->stack_head = NULL;
 		} else if (ctx_data->stack_head && ctx_data->stack_head->next) {
-- 
2.55.0

