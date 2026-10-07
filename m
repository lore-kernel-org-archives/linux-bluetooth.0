Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73232C11E6
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791402519; cv=none; b=Efcq7WVLRMWJInK1Xdwxnrz9Rr2mNNc3WyJacJrTbe784m5tIviBk/x3O/uuoqouetKBojoEU2sO5bVgzdTVVv3YNEJBDniRggBASMfsfFFp7xcYtG4tBduB/RksdguTjIT1fQODhj6cpBb1F+dofOFeQnPGXcrebl0ON9Si49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791402519; c=relaxed/simple;
	bh=O5vrvk62RFNzvWg39pokce9j52N15tZ95rRkY8miVfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRhurEbekpbAbVcnvK+o47yGqTTKQZGTt8i3Wi1wxR2I3hSY3ZZD2vrc7GaTm00RDLs4riJmf0OFdm/WYIbbLIqssW++yPZiMgnnpWcQkHYdbRtrgvUkm4y0zUNsck66maGPp4TTLVslSXgD8UuVhtmJuhYPdQN1QbrOp/ZdO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFG49HVi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFG49HVi"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2db710396ffso13172455ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 12:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791402518; x=1792007318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pbKYcyGwwt5OH5lSkH465y98UeyGwofmWr2r/6Q02/Q=;
        b=cFG49HViZAjq5+czgH+i8zMO6OeYFtlvLPr1TC60B6Rz3s36lxsVlsk2cKMCKfhkcG
         as84+bWtG8rUT7ef8X5+ZCEKJclhBp7dqXGY5aOPTqO3hBJSuxDohUzA2wZ9TW+9fBJn
         jMDVT4d8UvFpdaI8fmN64yw5Jf2VIaQIRZkzNJsk1XmCD0Vvsh16WSdFZQNqikHwFfA+
         X5yPk/+giA2hpw6uGIGLmAzcWVuHxlkePSQkn6PFfF37Ds9rXltXwcosQZa9Wqg2z8ep
         /1EUrR+ijVp2VNEJAduew8W3cS9vhqud18zT0TNChbzFOk/myv7l++uZhxxbEW7pOUmE
         UT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791402518; x=1792007318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pbKYcyGwwt5OH5lSkH465y98UeyGwofmWr2r/6Q02/Q=;
        b=2FUwoKnYdn4kQjL6as61yOvAO8PPx9UgxcntYNA76ViZyyTe+DYwAFHnQ3ognTrYUb
         90KHAZkfaxH2JukJ7qRpGjifR8uPrnjngAQywC4VNFGGVVgHFMhDabl2uLb+/U+mRLG6
         AbCloknP/MP2zumxoJoDzSkc6qeF6JFNSRmFGuBrDeDPANvueO7HqrIRVLkPA3degobs
         kM6QaRlhoqyLVHRtzSU4WPxs/A/hT3Lu/ZfeJwPGE+F/oGWVsTOhO7R9m/V/6xX5Uwk9
         C9y0a0K37Pu9H1z5eLTVP0B2vrmiicTLoPEpWioWlNcVCq4j8lc5dVjfCm6sOZ2I29VO
         gB1w==
X-Gm-Message-State: AFq9FYJK9zrg/fCYWo0DQ1V8TzlZoSysK6wKABJd/446VmpzOg8NF//1
	hppeh7fRTAAJ0z1VrS3UmyLxJyVe1M4Q8gJtg0UHTrSBBCRJ8fYxUxCwzdUrRB++
X-Gm-Gg: AYBFou1nd/NhXLm4KaNpwf13zMAEaMp7247oFGv6IfOfvuExEvbx5IdY5/SvzAg7xss
	zbcj4mCZR0GKjpBcW/7Hb2j17AYp+J+DYrD3ioW0nGB/ITDcgLEpe1hB/WxRtPxiOBKMVrxnj6/
	YZk+kky0pAC1wKs0ajJQU3BqYD7jBFiN/iVatShWROP7Bm99GnuQixAcK8bxw9AO+uFECYHwraT
	fdRny1ipu86h9kDa/alfq9ns/rwMm3u3BUr03hRFCyqWZZm5v65QwljsFmzPMYjOXUfgKpNXR8Y
	fBGVw7KIJcu1apJstNTbWUM2QZwWDgWPUKIzZMUB3CvBb8U7F2AoVZw6mHqzeDlqSoIiZqXy7UJ
	1ZLSGdr19OxPrEs8/jVKFTHC58aRUnECgaUGUuSSwxP68KQAIrLmmvxGoOPl/o29pn+DXSJxs9u
	qNAVufqdBGuvrBPPClQJxx5hvBiLPDO69XrQ3wFpIr51U2acqiEf99L8VZmXT1tLTPC3hZ9ucCh
	qAl9VGrcPHDWysmOo0/4r+GKzxulukfytnxpVI3vGEN2mKsKmwHzK7MsxIalHcE8Dhgv0Y9dOxX
	Jh7GEHY/og==
X-Received: by 2002:a17:903:46cf:b0:2e2:dc3f:4131 with SMTP id d9443c01a7336-2e7ffdc5fcemr1118475ad.14.1791402517656;
        Wed, 07 Oct 2026 12:48:37 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e6049497fcsm16696675ad.64.2026.10.07.12.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:48:37 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hovold <johan@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH] sdp: Prevent integer underflow in string attribute length calculation
Date: Wed,  7 Oct 2026 19:48:31 +0000
Message-ID: <20261007194831.2275879-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In lib/bluetooth/sdp.c, attribute string length calculations subtract
sizeof(uint8_t) from d->unitSize (e.g. d->unitSize - sizeof(uint8_t)).
When d->unitSize is 0 or less than sizeof(uint8_t), this subtraction
underflows in 32-bit integer arithmetic to a negative/huge length value,
passing invalid sizes to memory allocation and length extraction
functions.

Add explicit lower-bound guards to ensure that when
d->unitSize <= sizeof(uint8_t), the calculated string length is safely
set to 0.

Assisted-by: Antigravity
---
 lib/bluetooth/sdp.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/bluetooth/sdp.c b/lib/bluetooth/sdp.c
index 1e027f9..a750274 100644
--- a/lib/bluetooth/sdp.c
+++ b/lib/bluetooth/sdp.c
@@ -730,7 +730,10 @@ static int sdp_get_data_size(sdp_buf_t *buf, sdp_data_t *d)
 	case SDP_URL_STR8:
 	case SDP_URL_STR16:
 	case SDP_URL_STR32:
-		data_size = d->unitSize - sizeof(uint8_t);
+		if (d->unitSize > sizeof(uint8_t))
+			data_size = d->unitSize - sizeof(uint8_t);
+		else
+			data_size = 0;
 		break;
 	case SDP_SEQ8:
 	case SDP_SEQ16:
@@ -1524,7 +1527,8 @@ static void *sdp_data_value(sdp_data_t *data, uint32_t *len)
 	case SDP_TEXT_STR32:
 		val = data->val.str;
 		if (len)
-			*len = data->unitSize - sizeof(uint8_t);
+			*len = (data->unitSize > sizeof(uint8_t)) ?
+				(data->unitSize - sizeof(uint8_t)) : 0;
 		break;
 	case SDP_ALT8:
 	case SDP_ALT16:
@@ -4852,7 +4856,8 @@ int sdp_set_supp_feat(sdp_record_t *rec, const sdp_list_t *sf)
 			case SDP_TEXT_STR8:
 			case SDP_TEXT_STR16:
 				vals[j] = data->val.str;
-				lengths[j] = data->unitSize - sizeof(uint8_t);
+				lengths[j] = (data->unitSize > sizeof(uint8_t)) ?
+					(data->unitSize - sizeof(uint8_t)) : 0;
 				break;
 			case SDP_ALT8:
 			case SDP_ALT16:
@@ -4929,7 +4934,8 @@ int sdp_get_supp_feat(const sdp_record_t *rec, sdp_list_t **seqp)
 			case SDP_TEXT_STR8:
 			case SDP_TEXT_STR16:
 				val = dd->val.str;
-				length = dd->unitSize - sizeof(uint8_t);
+				length = (dd->unitSize > sizeof(uint8_t)) ?
+					(dd->unitSize - sizeof(uint8_t)) : 0;
 				break;
 			case SDP_UINT8:
 			case SDP_UINT16:
-- 
2.47.3
