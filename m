Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FA139C00F
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978541; cv=none; b=K89q7Hrbs+8twtj/DsrRutKkASzAFLxXyDkPARO63cJ/hEfOCyd+00xSp2Ag4wSKpp9rkrJ07LGBaZJxPiuByOKTN0EFwmgn+4onNshFzJoVs3k4TNJ5SSbXkQbs0O8yOrU7ujFXgtsSc9ugnQP1O+KbsVeYjaFlvLPC9Iqn18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978541; c=relaxed/simple;
	bh=bcwgMUL7pfChRxREM2cgIF9Yjwmw/gFcbCi3Dep/OBw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEVFKzUfVbFmy8s/CjIKZ7prp4jeOoAjwxbGi7yFpqPm8Yhgwdj0Kr3IHiO4wS+PBLbomboXdEqpdnAt5Y1wf7+0VOv0XLjUuzMPW4AyTj9/UGCx+YdS0D2eYSyriaxbVBcUzmwXYRPxR8z0ZzSjvTYfrvHmH3CcI+pwRnt5F44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pS3/jHHj; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pS3/jHHj"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5c7afda4515so3557442e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788978537; x=1789583337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yhszrW/jjj52L1UE9c6jM3cVJ1ffQzrtOTPCvB94jEg=;
        b=pS3/jHHjFgcMzzYBtlqbx79/t5zMCzkTGUHIX5o2l0+0G/tdaFLzGNHKK21Ahce2Es
         88jAzQh7A2IQio4jeqGRCFl29znFYVupOm2tZL+3bYHM8mkDLYQr62FC+FMKCWZLjyuS
         q64BHSlDDziGhnoH9oPArjqbEPzUiYrFxIcc5EmPazFRRSD3meZ8CPySNvCtlfv3yhYO
         wNjNXWw3F6LXbXbzJ79sKGms8W7Fd9+KN+xZTL8BUZeqe/1xngF7Y/W2etxyCAi7jP5z
         vaoPINlrdoVdod1rll2cPtWLbFS7I+phzLp/ylkQ6uWRYZQ3rYi6OTPfRB8x0qa5q6nB
         O9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978537; x=1789583337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yhszrW/jjj52L1UE9c6jM3cVJ1ffQzrtOTPCvB94jEg=;
        b=c1lMGveyqZIB+xSpy1+y6dXF3umo9AB/GRFqWlyMvhSTA4dTNn/4qkX6mGbWF7A0Lg
         MuIYGEiwA0WDMiVzMHN1oHazs1dDnOzBJw7oKy4S8qRA3/fvXm8BbbWfUb+oCiw+1Zb9
         eoTr5LTM8tmfEhyFJ7nv4UTyy28giDqByqI68iTQuoJvug51/ewAHGrdwvA9Wm714y0a
         St4ChD5nbhBDaRY9Qv0EfAOVIGoaPWlmEp9/HaUhdRdDZ9/1+XugXgkRzLkkAn1xwSlp
         G/ZbQMm6+6b4hpLXYYmqYOIwp3ti751pSIlUI3hroTc3iPOmpom4P86MAzoVyYogDc/1
         d99w==
X-Gm-Message-State: AFuF++mRrzChk4C6a1FrtxORo93n/Zkz9n/Fu2t4v85CsYqtfwRMIPNm
	FwKVQZdvyBLCC9Bc1pBNM1719oz1ae995DpLCM7AvYsseU6QHtF8t2EFbn0/gZwf
X-Gm-Gg: AYBFou1mdR4pGGO8z+wk0VUg+dvd7j708CS2X3aMb2N9DxFqXG8nmW9bYGhoAsqTZcf
	0KSXj7v1SpTuKlfpbC3f5iZ+t5XMHeGZ2j+0OtislqqFbuKvLcrPWbooerWAKM7tS55abzocwYv
	J693KsgFVics1ppfW5iL89IDkKk0xk4z1DjuydeRksXC3Clm7yGZ6hdX63GjGD/+Q+1CiNAD+ze
	XRDd8PkG5TjvjCYBTaoDXNySm9zPeVsY5A0E5UrVBZzip6q19tTM+yzY0ikXs4wL1McD3K5XUxB
	4li4O1vY6H8AzBrkGFQ05g3ER3TdycamH/eemfRfI97KvBe8XDdcMtY3ptDObn3kbjCQJKHdwR1
	iss0cmDxTytfHqhWxBgxA4IBPR4GznPAH67a47cBYeWVT4g7kTC8prcD7wsuEVaujR/BK6JQ/Q1
	n/miE+Q7smeeL+G0hZQh1LSSsl/5FBOHpPoNY52YJZPWNl9tmQxLRBZGLxQbQC2ZKH/dkGhvcsR
	gqg6oyECC66BhqFiRCAsTVyqPJ5hlhtaTKq0lm/2LScoxbfaLG0ujvK/d4QbIR7awYtk7F4l57R
	4Q==
X-Received: by 2002:a05:6122:179b:b0:5c7:b165:7057 with SMTP id 71dfb90a1353d-5c7ed3cf5eamr19838558e0c.5.1788978537490;
        Wed, 09 Sep 2026 11:28:57 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c81c506f31sm5399388e0c.11.2026.09.09.11.28.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:28:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 08/10] monitor/att: Reference the request frame on responses
Date: Wed,  9 Sep 2026 14:28:38 -0400
Message-ID: <20260909182840.1289776-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909182840.1289776-1-luiz.dentz@gmail.com>
References: <20260909182840.1289776-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ATT responses use the request opcode plus one, and only one request may be
outstanding on a bearer, so the opcode itself identifies the transaction:

  ATT: Read By Group Type Request (0x10) len 6
  ATT: Error Response (0x01) len 4 #6 (45.500 msec)

An Error Response names the request it rejects rather than following the
plus one rule, so it is matched on the opcode it carries. A Handle Value
Indication is paired with the confirmation that answers it.

The model wrote the matching, which the author reviewed and verified
against a trace covering ordinary responses, an Error Response, an
indication and a response with no request.

Assisted-by: opencode:claude-opus-5
---
 monitor/att.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/monitor/att.c b/monitor/att.c
index 44965a2aaf3b..a35198949e3d 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -5873,6 +5873,64 @@ static const char *att_opcode_to_str(uint8_t opcode)
 	return "Unknown";
 }
 
+/*
+ * ATT responses use the request opcode plus one, except for an Error
+ * Response which names the request it rejects. Only one request may be
+ * outstanding on a bearer, so the opcode itself identifies the transaction.
+ */
+static void att_req_str(uint16_t handle, uint16_t key, uint8_t opcode,
+			const void *data, uint16_t size, struct timeval *tv,
+			size_t num, char *str, size_t len)
+{
+	str[0] = '\0';
+
+	switch (opcode) {
+	/* Requests, and the indication which is answered by a confirmation */
+	case 0x02:
+	case 0x04:
+	case 0x06:
+	case 0x08:
+	case 0x0a:
+	case 0x0c:
+	case 0x0e:
+	case 0x10:
+	case 0x12:
+	case 0x16:
+	case 0x18:
+	case 0x1d:
+	case 0x20:
+		packet_req_add(handle, key, PACKET_PROTO_ATT, opcode, tv,
+								num);
+		return;
+	case 0x01:
+		/* The rejected request is named in the response */
+		if (size < 1)
+			return;
+		packet_req_str(handle, key, PACKET_PROTO_ATT,
+				*((const uint8_t *) data), tv, str, len);
+		return;
+	case 0x1e:
+		packet_req_str(handle, key, PACKET_PROTO_ATT, 0x1d, tv, str,
+									len);
+		return;
+	case 0x03:
+	case 0x05:
+	case 0x07:
+	case 0x09:
+	case 0x0b:
+	case 0x0d:
+	case 0x0f:
+	case 0x11:
+	case 0x13:
+	case 0x17:
+	case 0x19:
+	case 0x21:
+		packet_req_str(handle, key, PACKET_PROTO_ATT, opcode - 1, tv,
+								str, len);
+		return;
+	}
+}
+
 void att_packet(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 					const void *data, uint16_t size)
 {
@@ -5880,6 +5938,9 @@ void att_packet(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 	uint8_t opcode = *((const uint8_t *) data);
 	const struct att_opcode_data *opcode_data = NULL;
 	const char *opcode_color, *opcode_str;
+	char req_str[32];
+	struct timeval tv;
+	size_t num;
 	int i;
 
 	if (size < 1) {
@@ -5909,8 +5970,14 @@ void att_packet(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 		opcode_str = "Unknown";
 	}
 
+	packet_get_context(&tv, &num);
+	att_req_str(handle, l2cap_chan_key(index, in, handle, cid), opcode,
+			data + 1, size - 1, &tv, num, req_str,
+			sizeof(req_str));
+
 	print_indent(6, opcode_color, "ATT: ", opcode_str, COLOR_OFF,
-				" (0x%2.2x) len %d", opcode, size - 1);
+				" (0x%2.2x) len %d%s%s", opcode, size - 1,
+				req_str[0] ? " " : "", req_str);
 
 	if (!opcode_data || !opcode_data->func) {
 		packet_hexdump(data + 1, size - 1);
-- 
2.55.0

