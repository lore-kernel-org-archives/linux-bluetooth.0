Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF1313267
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789220716; cv=none; b=V0HoldDSanVHWYY21s3UWumDzCbo1nWagYMtNQ7bv7LxFbomE8IbeE3VNDG0HqNKIYmoFg0WhE4jotP5pcEZW92A0XPPPdJZMWnHWCk6dMqI5YteZQy505O+8jN3C0zbhkR/OBpBJ7LKpq14elNOn/PNEOdttUY5TmghHqjUTrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789220716; c=relaxed/simple;
	bh=3JZt4wcl0Rgzqix3YfyA6VcuE+00WH9Famwe+6uXqzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKN/w/T1NpoDklqiNN4rUejdRVB4BsafZ4Q9cj9w7lqGSlFqUDQBlP9m7COA2ropldXnnjQLqvRuRC3XIVLx98E9S9JPMWifAXGJAZniqb7D3wOX7TFey+GRELmUJSIqD55ZXSGpnCMpOHpxMe2XAlVPhkqy1j9yACdJGgYoooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=NfcyAEEk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="NfcyAEEk"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d91ded8174so17142455ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 06:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789220715; x=1789825515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t15J8IgrZiKImEsXvOmlz/xd0OdZcADtL26laP5+Yqk=;
        b=NfcyAEEkQDM5+iftIRY6xap54eaqupkVqkSdM7L1Biej7wZPQQ0hA8bF2iZOPrtHY+
         XX0ST6HjYInrI/jfYm+wFYNMYo+aa8pY0iGIJCKBqkLhblExhGCc0X7o2cDIVAUxaZDZ
         WB8HkDHJIuyXLnLOT6tSuuro431IPGB/nqYQ04/MWnfUeOWNBjoL9dvb3toHxcdb4l4B
         Oj1VIoUDi04rgZ9xh4JelZh4Cs7HRW/itEghctAeTSF/wngNtflRJDnaK1KY9+nZqQIC
         UT0HtH5NRNthhP9ZLf9CnqcKP3522mlr/bJMbqtqvy/pN4qcqPIa0+NubnEKnVwyiI8m
         Pgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789220715; x=1789825515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t15J8IgrZiKImEsXvOmlz/xd0OdZcADtL26laP5+Yqk=;
        b=Ymaj/l3r+fkuNR9fsFWgr6PvnyxdLDpEcu2UZufpQixSv9TEyOPcG8lmamfdyzZJuD
         bXVldiuLl1hIFsV6rpwsl/JQssLohyCXz60rR23Cyf2QBFi3/aiHdNYTJkkK9Xka1D5u
         UAs91ZSa2X8EYeT39iCip5WKM56vUBxmMfnx75LDXMEsHMdOhFiBfS5qM1O3Jqd9WMYI
         KPbpke31EQpM9mLqBL1oUTdz0eHo4PRF10PH5fGixmT9Hwpxc5XX0IyPNZ8QVT+qdp3B
         k2yCwMUek82Y0bFfNkVIdOwTY5ApHoHg2s/kSnN75V8PTTQaSUjZzjhoJ9zkY/DKqE5C
         wCHQ==
X-Gm-Message-State: AFuF++lsHVChkDiJwkKE26S3JHeia1SNzLJSfK/XCGUwf7AqmIhhGRWK
	U6FT2AkrFceJW/Fc8eneaThpZUg7HtukGv/xw/86bnFBnhkNKl9M8gL6VxGU18GO7chQw4VyEZF
	bmCDECAlkZis=
X-Gm-Gg: AYBFou2/b9qE5ew61hqhY7JKXmBnRUru212G15ltaIPFttN0qdkPmwNNl1NRDnmz81g
	oKvDURmqZRsI0lEr2df/13sKUWZU5AXWOnfNp6X8pTTTUI8MyvOFHaHJBlHekizLZZpS3mQ9jQ+
	2DqFdywx+NM5hLRZHQBWCG8jiaejYGjpmi3a30Z1TGpdg7PPQ4KgcPj+JXvqnMVW4h15320rXo6
	CMhUbFyjy3Umd9Oi1OpfrKpbHJBCZ+1WJJknbu2YmBju+vYCocVS/MAKz9qpwSZ+yTpbD4V+iNp
	CRpCZMo2bJn01zdkyv8jiBj9B0eo4xOvfPWpP3B2T5van23h/DYBam0P37GpB2rwT6Ju9dsCuQD
	2hEcwD6dEm4eFdj3ARjR0JYvWkqo6V12Vh6gP/L3F/8iTk6hpO4qm7eH8cxYyLfSFVeRY77T/ur
	EiR32qaxlCQiSUq7/C63GGVs/XNr7uX/QY6gSg12wwOOgiUiUCXsSulAYGDyjQqS1M6FqpO2ZO6
	woejq8=
X-Received: by 2002:a17:902:dac2:b0:2d8:f965:7e48 with SMTP id d9443c01a7336-2dd2a1bfaadmr144818395ad.1.1789220714512;
        Sat, 12 Sep 2026 06:45:14 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f7390csm14006314eec.26.2026.09.12.06.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:45:13 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	chethan.tumkur.narayan@intel.com,
	ravishankar.srivatsa@intel.com,
	kiran.k@intel.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] Bluetooth: prevent wrapped eSCO connection attempts
Date: Sat, 12 Sep 2026 21:45:00 +0800
Message-ID: <a45e40e8a5360391b24f8d1a3a0cc7d03e8607de.1789220439.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789220439.git.zhilinz@nebusec.ai>
References: <cover.1789220439.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The eSCO retry counter is an 8-bit value.  Repeated synchronous
connection failures can wrap it to zero, after which the eSCO parameter
lookup uses an index before the start of its static table.

Reject a wrapped attempt before the lookup and before building another
enhanced synchronous-connection command.

Fixes: b2af264ad3af ("Bluetooth: Add support for HCI_Enhanced_Setup_Synchronous_Connection command")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/bluetooth/hci_conn.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8de98af2fb581..582b85f063874 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -217,6 +217,8 @@ static bool find_next_esco_param(struct hci_conn *conn,
 {
 	if (!conn->parent)
 		return false;
+	if (!conn->attempt)
+		return false;
 
 	for (; conn->attempt <= size; conn->attempt++) {
 		if (lmp_esco_2m_capable(conn->parent) ||
@@ -294,6 +296,8 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	conn->out = true;
 
 	conn->attempt++;
+	if (!conn->attempt)
+		return -EINVAL;
 
 	memset(&cp, 0x00, sizeof(cp));
 
-- 
2.43.0

