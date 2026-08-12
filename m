Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3993F3C4167
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521869; cv=none; b=SbA27DSbDCzVHsUYmgHzfI+jMOS8z/yOUFX0oVwSxcqQOF0SWc/Sb6YbQc4Mtz62sXz1JsZEt2JEDF5saX2nfsbo6D1bl7zNBdap1fKvWJwKv3zF8ERxAEfrjgeX4voYw+X2VgqwcF8eMKBmlfSVGsZ6CHKXEnxXe2yAXbGU+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521869; c=relaxed/simple;
	bh=pFuIwu8cwx0SuQog+mqu7D15++4zRLacajRgcAtssuE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IH7s8vsXYt4pZ9KKwzgHdS0h3R5K5Xdzux7c0xhmrspntTsLzp9olD+U6HkZctJTKQWFkBh3/s6zQ5KYhWhMqPgJxtqFZgQ8P+gD4SHMRTTylMYjilPLZM6BLegNP4XS+euAPTC7Q4AdzXdvYhlZLJa+Z/rJZ4Y9ROEBqw3KLF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83BFA3EE64
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:19 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v4 4/9] sdp-xml: Fix memory leak when adding duplicate attributes
Date: Wed, 12 Aug 2026 10:01:35 +0200
Message-ID: <20260812080410.2116906-5-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812080410.2116906-1-hadess@hadess.net>
References: <20260812080410.2116906-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTEATMgZESnXpnF9odixN+j9pjFJQtDJ1lOhKFVo5Z/nUe0V4kv8/975cH/jEC+64/687m2yeqptp72V8V+Fn9K7g/HOIo1s/A9vRcgAydT3FnC79LRZiaW2AsRMtWp8LHcLMk8RcFDZX+r73gvBiN0XAE69n/K+cGPfKTwfhuW4u+6P6l14AuHgA/JCsdUHL9YAy7vZyMQgTf4Y9kDKFjf6ZpkPzEK1NNr+QOxeLPriprXbk5OoT4J/7DzuhFaA2uT7ogxycD/0WB/G3uqVtCR3ahE9Xg872i09EVeEPn7oX7BCDVBYVDLUT70+1UfOo+2x9MExJKd0WKIq1ANYXqkcXBT2Zb5Fzk5MNCN/fJWaPrg3KuLcWdkg1mDj2RNHuHEyZO3Wme/W3aNdqUNEXExnsWVr0OsZtm56tPQtp1Yr8KHi3HU+90bpSSPnExEzHus8/nfAYNjQqk83VdR0M+rzd20yyu7eRAAJQsUb5Eos0H7fpVen5m9b7nOyPx4SUsb30i6Jz06zAMFcLN5g4a6ksee3daV/AQIRndiTBeh2yLaL6eqBk2EoYICw8kZDzh+1zYIHCiOX25YP2odZYI1+Ov1KOdMFsgUEkwvp2C8IPM5Ucr9/Sc3s6NNnUPnlPPb69Qp/ue1g4PO61ddDZe6CV0QaDNX1peeiaYCxLyXHjg
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

