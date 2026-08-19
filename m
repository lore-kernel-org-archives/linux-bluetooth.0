Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E5736B913
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172025; cv=none; b=snkDbI4DtReLHVE+zygHHNlCn67azfxENvDy9zPvcs0a++qHyLpKIYTJk8SGwPn0wxfFJoH8pNNcFNdP+K6Np4VgRg4RbaDTIC2wRhdLR/kWytmn8hozdYE05Qv/MRMLGAztrnZiyp+qr+G2EoYWrr5zFTnWS5yIXyBhnfie1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172025; c=relaxed/simple;
	bh=AVT6NyI5VIAxuiHqdbPzfRisakYnAJuRJPoEguAY4mM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpKskCvPDaRkI3WoEPBZSv28GRMrx9zApgpwhH4Fxx0EVaaR8wbU40NXbe21uMq3F+l08uN7+MvusVJdCXizTfwBX2mFzONAz9oPu+A3qJWQ+7S9Li+AvPqBbk3O3Qj1ZTdHbeAhjGCuXGX8emsTkQY4VeLfmTMuAlXKzRLaHFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7R0XirQ; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7R0XirQ"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bfaa014978so726921e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 13:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787172021; x=1787776821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6uVof+dVhvhA19F+4r5hCVs4cEId7W/uxl5pVKZ2Eb0=;
        b=r7R0XirQRH4PXSBoalaVdIeo0nzrPzuMpGqYQbP6l6Dpe/P+kk17g9ve5KnKqm4vSj
         37vrin9JsB5pjCdWdjHRDlF6/gw8pOoaNbssVFt89/PL5sK7jWtVLbCBdGsFvBPZLbwG
         XpGJbILPP4a1WSDhCq5hWTBv2ez75KrrUhWKHD//DPoHxOQkVDnifZfg94dMOZq2tJUT
         Bq1v+bn9U2OC2fwT8EF0VsI+FcC8dsc+ioQ17DxiO5CgJg2f7SooWezASiaU5QrEqKm4
         CZiXscL5qMwfbNv63IrES84rd4pjvFYH+FTQtJdI6R/ukJphTwBACG+XcfrOgmgRMMe7
         fEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787172021; x=1787776821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6uVof+dVhvhA19F+4r5hCVs4cEId7W/uxl5pVKZ2Eb0=;
        b=N9abjHMzHfyT1NsPD2S3Sf8+2bTvuV+3TeqSW2OsDvsHSWod/EDyYuCVbRT3t3yiqA
         piBqO51f22csLlN5RGazvuNui4LeQhySvh1h07juRv4AbrNmAIl8vuRL2H/wv5FnOYnN
         iHjL98+6l3lsbcYGxu8hGMr8PVK7xKEYdN3Wa84TqQcVV9a/KpCVnsD/Toq5TpMv4tUa
         fUJNzaFfXBykrJbqCa62J+wx6e1vrwEYswyDp2OhJJ6K2Jc79wsQfVhz6DK0pQCR228i
         ALm0v/XCCJL6CFIosWKbinispaM1ueFbHpEzb2U0KYwmWYzl609569TsMrtLLxB2T4EU
         oNhw==
X-Gm-Message-State: AOJu0YyyC0txgAJgMgpoFk2PMLHxr5Bv9MYaYVWKwiZ4xe+RJEDOfae5
	uncyiVowaTUbnqGiCY+liqmtU+P6PW9/CN+97P6png8XeBpoGKigWvp3BAwRzEOFkjV+tw==
X-Gm-Gg: AR+sD12IoDj8+NqtE4xCoVOvU4H/r2MDJy/l97GeEzW0z1GyJkevaysxFzsFgGEG10t
	5BxuyCVdMnpM/CAmZDr9N44MqALXVD/jNuOXQGLZfOJO8S7LHqdbtMVS+7azOzcilcjJoY3GiA9
	dtmLHFJv2npsguFaHBZal40qBU/5uGNSfV1UyrQ+9J3qzBIPTAFEaAWG0GmLN2kZuOmgNBsCUU3
	F82S6NQ1B17x0ceQziekgTcFl+uqGk2J/D29PHsOq4Q+B2KR0hfhhOKedQgi6OvQ3fNzN+RAiuD
	p9J5Usi2grVd32Uec3r8IYxFNmXF/b7Hk6/4fm0T++whxpRsT7ZoQAQ4zR56MVKZnUcRRDZWh9a
	vvLOO3DNI8kq7lC0OUqV4gmPKPYKD4IZlrshNOBNbaILYoAiM+BWhwAP9JRCVuyncC4dbxD9Vka
	lmvJYUu4mxuMoWqbGle4QmU8REPQVSez/jNSUUdze4ZQyltU8fDqA9J+EpgUgujd9gbMbDppbuG
	OT1JjL/S+rQBp5s9qsY2NN5dx66SHX1FSoCPT36/mzaF2Si15hOv7I=
X-Received: by 2002:a05:6122:4694:b0:5c0:fb8d:9993 with SMTP id 71dfb90a1353d-5c5e2ea3024mr2364539e0c.0.1787172021298;
        Wed, 19 Aug 2026 13:40:21 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e2486864sm3496404e0c.0.2026.08.19.13.40.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:40:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/8] eir: Fix stack buffer overflow when parsing the remote name
Date: Wed, 19 Aug 2026 16:40:01 -0400
Message-ID: <20260819204008.2292225-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819204008.2292225-1-luiz.dentz@gmail.com>
References: <20260819204008.2292225-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

name2utf8() copies len bytes into a HCI_MAX_NAME_LENGTH + 2, so 250,
byte stack buffer without clamping len first.

eir_parse() only rejects a field once it runs past the end of the EIR
data, and that data is up to 255 bytes, so field_len can be 254 and the
data_len passed to name2utf8() can reach 253. strncpy() then writes 253
bytes into the 250 byte buffer and leaves it unterminated, so the
following g_strstrip() and g_strdup() also read past the end.

The EIR data comes from a remote device, either in an extended inquiry
response or in an advertising report, so the length is attacker
controlled.

Clamp len like the other name2utf8() copies already do. Parsing a 253
byte EIR_NAME_COMPLETE field returned a 253 byte name before this
change, and returns a 249 byte one after it.

Assisted-by: Claude:claude-opus-5
---
 src/eir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/eir.c b/src/eir.c
index 89c15995a546..95351d015323 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -137,6 +137,8 @@ static char *name2utf8(const uint8_t *name, uint8_t len)
 {
 	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
 
+	len = MIN(len, sizeof(utf8_name) - 1);
+
 	memset(utf8_name, 0, sizeof(utf8_name));
 	strncpy(utf8_name, (char *) name, len);
 	strtoutf8(utf8_name, len);
-- 
2.54.0

