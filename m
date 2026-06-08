Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C464369207
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918186; cv=none; b=k/6YZq9b8d/UU935us3gnFrgZ8zsOSsYuCy250M/VoxjjGgLuK4PfO9pXaH3s4QYjTEDFeY4mQ1wJcmsHD+7NoJlYojfz8NGdp/m00qYgq1pegOc74bPcNMUGrQHXLqdQBUbHqRHxKbY65Z3JjbEVc6OgcU9gkxoBQo2JJJIkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918186; c=relaxed/simple;
	bh=8uJriw1Phj49o2dqMj2JkApSy/9opkDF282lt+d2M+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EecE3rApQe9Wxfj3EeiuXI/SlT9DaHqu7HAbl2xjFHSLo/9xD8bDiHeHVB3GO3IPCRGu7kI+e4+ORRGw1w3f/loet8Al+7pd9GugKLxzDh+PbuANQf2iriyDJTAtt0+N80Q3Phi7y00fAJTKrnvB3YbEBETJWQHIY8TWah/TG+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=BJdvDnb5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="BJdvDnb5"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso34077715e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 04:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780918181; x=1781522981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKlBbcj0g5GX1g0C0ipbDhOzvhLO4ER+CT2amUY96Pw=;
        b=BJdvDnb5xQdVKSGO4nd+5eXffW0XQPrHiZpQRECGp8kOEVVCO1bxAhcVKvKHk6QjRN
         TY8oQUer1KvNAGg1Y21C3zVAujADZT+sNrvoYv4vImOpt8iN9kfvaKp/Patf01Op1rH6
         M6MYv7DvRc8yktmVWG7nfODDFQfdZkn7ta8pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780918181; x=1781522981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKlBbcj0g5GX1g0C0ipbDhOzvhLO4ER+CT2amUY96Pw=;
        b=lSIu4MCYB7cHNsX5/Ipx0YBdX/OPSlIlJIcpQK1jRzbH69k8WzYk+/dqEqFvsjlywt
         lBmJ1pq8akyaW8JLTAPlaa7PEUyzd2tpOhmXeeCUWd+gduCTaKMW+DxrI7SGguuq2V0q
         SAwy7c//eYemgC1xx+bUUg4Rg0H3giPA13tvzygNqwW19rciyEbM3CqL1/CbWh2N77gW
         GSSSgDLDzc0ymbOt8eEQpccV0iC9fUIvQUvofiqOOJVaykWJ9fUSW5yZGMAbwrdFSU5N
         jxS1RkJto3PZTSe23oGo6HN6uy9oCPWNydK1BPSBiH7z64BdY1owWTKhfLeEUi8HQUUn
         XGBw==
X-Gm-Message-State: AOJu0Yzzy6PjcRl2bLh4nU7jlZHivtwKbvQhpx3Gr1dFv79N+iARrrJz
	+UHzL0dzm2YeIzpfb8Vv/wyHmi16EGMuc2fR845fMGpFI902VUVxDPy7EPY3jgq+0Qb22sD6rJq
	SBpXw
X-Gm-Gg: Acq92OGf3SYm+3em+B6y15l46iXlbEiCKLXNPp1MLTyiCvPWHBHGuxF3vhCL56I7b78
	38baK187TzA0jvbxSakHhIUBgXJJEJOzUU6ApW9bGvkSjS8zBJ7EHcND87lCLj+A+4vuTMWc6a9
	E6PwFgbj39bMBjj1fta43dSgvxW0KMEI0y5jcL5Us23qdziKTlv+AbDm4DFulvYB2//a3hWi+fq
	7r2OKNnDjOd/veU6mxLKHaZuIS/dniBWEcWdfwQW+ydfdpelnpKPSUFJb6xuQHy4GIci8Q0SPdi
	RXr5fL9oR0rd2F5LlYV8l6RRm0kreaRK11z/ewvrs1KAoYQOPz3NWNYB2S8yuNdIWkykGGCkDWf
	GEcsNVAXRFPejDF6xPZIf7y8zjR0WmMm3CwWls2zNlZzmymKr3aIVYAgrs2WvZlslHW9ViZf8to
	ZT0kn9EjZov4SQBCcH8srPcXyxBCjVArqusj2xMvnMg9JW17v6Q/eBYQ==
X-Received: by 2002:a05:600c:3e0a:b0:490:5000:917 with SMTP id 5b1f17b1804b1-490c2cb94b8mr200818255e9.1.1780918180741;
        Mon, 08 Jun 2026 04:29:40 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d30eeasm248446035e9.1.2026.06.08.04.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:29:40 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/2] avdtp: Fix error handling for AVDTP_OPEN cmd
Date: Mon,  8 Jun 2026 13:29:23 +0200
Message-ID: <20260608112923.3722754-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608112923.3722754-1-simon.mikuda@streamunlimited.com>
References: <20260608112923.3722754-1-simon.mikuda@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have to return BAD_STATE when local SEP is available instead of
BAD_ACP_SEID.

This fixes: AVDTP/SNK/ACP/SIG/SMG/BI-26-C
---
 profiles/audio/avdtp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 7cfc9a80d..6be6e99b4 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1771,13 +1771,14 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	stream = find_stream_by_lseid(session, req->acp_seid);
-	if (!stream) {
+	sep = find_local_sep_by_seid(session, req->acp_seid);
+	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
 	}
 
-	if (stream->state != AVDTP_STATE_CONFIGURED) {
+	stream = find_stream_by_lsep(session, sep);
+	if (!stream || stream->state != AVDTP_STATE_CONFIGURED) {
 		err = AVDTP_BAD_STATE;
 		goto failed;
 	}
@@ -1790,7 +1791,6 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 							AVDTP_OPEN, NULL, 0);
 	}
 
-	sep = stream->lsep;
 	if (sep->ind && sep->ind->open && !session->pending_open) {
 		if (!sep->ind->open(session, sep, stream, &err,
 					sep->user_data))
-- 
2.43.0

