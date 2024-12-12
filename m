Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A520E02D
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993078; cv=none; b=IHVIpvoluz8cqY7PogGhYnsCGH5szn5GYWWUFXGYIrhGf5dWfmsqw6W7hhuoLlmrvvgtRwxocov4/faTNsfBoLSnH9v72D3m1kme4t3Id3TvnZF4Q6llD2MlVtQbdWVCXTa17OZ5E8APs+7Y2e9iMTSEhuHLfNXx2GM75E2gO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993078; c=relaxed/simple;
	bh=wll8mfUJPfBxpFYpKgOcB0K3t6bxxcxWKiVYQEF6/9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vCu3Ir1L1OVwDb7KOtAeVPaZNQxrSoxYGMTbB7QniiSMX584X67LkPnPUGtvviKoSP3nqP2f/Sv223td3Ht2GvxHjjKjvp2N9VIpk6LOFCMuPKC0U8OIzsFx1uXgejaXwM3XLHl9tr49INHxZktaWjUfwaZYaXqzy1UStKioxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoIWG+F5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoIWG+F5"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9e8522445dso60414866b.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 00:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733993075; x=1734597875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSc2uHjP/LSBPWbFukm535fyWEeje0qmDbvk4k0NIHQ=;
        b=AoIWG+F5qLd9o4ysCkXPKyRbRX9EHGEWNWf9h4/HrnIIZbpFMtsa8Lfbxdc1yJqIll
         Yxd3pXwNVzKkjGaQhRU8Lb4iRKQLXysTWk4Sg8ktk0Rmju2QTWXpIdFAFaB7S2IipK4X
         iNxyEb2i0t5/7irUNcLJbpDLCAUGTCODGW2yz9eMrQr2Px3fFkvmLTG3dEzHQCttpWAz
         kjKSSb6P+SZY8zMMGRf7DYwzuUt/Q23dyU7xdudfuAmDo/YwITd9OWfXZmrqv8GAd7C7
         5d5CjaR+YT4IECJSnNsaFWv9dVwUIn8QfAevU21cMmZ6XXf1qELAObCWoI3Mwv4qqeMf
         H2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733993075; x=1734597875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSc2uHjP/LSBPWbFukm535fyWEeje0qmDbvk4k0NIHQ=;
        b=BbSQAEyyY47f5LkbrMcJiFNoQVZ0pF7OJydqdn9bVm67lQ8u5maRzHmRNMXa7p8DAb
         zDx4NVtmHyIYgtzHh+dGBWyJpIG0w0K00fxhiR/iMafa45fSVcApSpZsZ6BUL8ixQQSh
         zgj/iX1yOSUGnC7DN00yxsWWf+llH7pGYsBAQ4hYVar0uJsY+BkxxQZiEaVtHnTGoCgh
         jpgXJjVkwDr244wF6dw8E9dU7I8cwDJBwJGUbsdmYdOGGKEaGMjkW/a7TK7gaORRGMd+
         ptnZ9/Pk9GmlQ9EiRCdsQTiY4N13nhbF2liNos0u0Kx8P16HjDc0ULzT9ymrVfWNzJ4Y
         mLQw==
X-Gm-Message-State: AOJu0YzKcN+hBHpuVrb6U8t4HzysJGIU0+tz40zqLCj/LQeREddip32q
	Z1ldmQcNgOq4tzCRQTFYEfyT6kPj0L/I79M0XM1gXRerACbGrEnac6WoVQ==
X-Gm-Gg: ASbGncv8E5mW0fy3lA+reBsO363L4PzbxxZix9E9BW4T0SISdnpPsPgYc8SGlNZJRID
	E9qicXrJRprmJ4A0DVHE0yYR71cffmdSFdKrU7bAOytnT3+6DS1dXHS6ZZcvjTWSEMJpWG4CyB4
	POqRpda/VxCLtqiIACaadSDkhDyq28oQr+Xh6UgEMcYBu9UqDN71LwQiWurF4Sdqwd3tQ/mGKKL
	nu8T8VmTrZ7LX7eZA489hvQR57FAHR1MM3qzh2tmhy8s0vGKBD4Jo2hd4eURJUf1WD7g1hLu8FT
	+1oSELyo13UiZc4GFwVj302XRNACGQAu+kittsD9Z8s=
X-Google-Smtp-Source: AGHT+IHKIcj5/ArT/nhYljrt8qzcAgpHu85TivtEu1Tj/TzvelCPMJDn7mYpiqEoypTnzUlqevOmag==
X-Received: by 2002:a17:906:31cc:b0:aa6:6ca2:b772 with SMTP id a640c23a62f3a-aa6b10d6602mr660144166b.10.1733993074993;
        Thu, 12 Dec 2024 00:44:34 -0800 (PST)
Received: from raspberrypi.home (46.205.203.47.nat.ftth.dynamic.t-mobile.pl. [46.205.203.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d42a754cb0sm2948476a12.88.2024.12.12.00.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 00:44:34 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH 2/2] sbc: Add sbc_get_delay API to retrieve codec delay
Date: Thu, 12 Dec 2024 09:44:19 +0100
Message-Id: <20241212084419.1326427-2-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212084419.1326427-1-arkadiusz.bokowy@gmail.com>
References: <20241212084419.1326427-1-arkadiusz.bokowy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most audio codecs introduce intrinsic codec delay. SBC codec introduces
encode/decode delay which is not constant but depends on the number of
subbunds used. Providing API for that will simplify library usage in
case when precise delay calculation is required.
---
 sbc/sbc.c | 20 ++++++++++++++++++++
 sbc/sbc.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 428c8ee..869f367 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -1470,6 +1470,26 @@ SBC_EXPORT size_t sbc_get_codesize(const sbc_t *sbc)
 	return subbands * blocks * channels * 2;
 }
 
+SBC_EXPORT unsigned sbc_get_delay(const sbc_t *sbc)
+{
+	uint16_t subbands;
+	struct sbc_priv *priv;
+
+	priv = sbc->priv;
+	if (!priv->init) {
+		subbands = sbc->subbands ? 8 : 4;
+	} else {
+		subbands = priv->frame.subbands;
+	}
+
+	/*
+	 * The delay is caused by the processing function which analyzes
+	 * old samples to encode the current frame. The amount of that
+	 * samples depends on the number of subbands.
+	 */
+	return subbands * 9 + 1;
+}
+
 SBC_EXPORT const char *sbc_get_implementation_info(const sbc_t *sbc)
 {
 	struct sbc_priv *priv;
diff --git a/sbc/sbc.h b/sbc/sbc.h
index b7323e8..829b161 100644
--- a/sbc/sbc.h
+++ b/sbc/sbc.h
@@ -94,6 +94,9 @@ unsigned sbc_get_frame_duration(const sbc_t *sbc);
 /* Returns the uncompressed block size in bytes */
 size_t sbc_get_codesize(const sbc_t *sbc);
 
+/* Returns the delay introduced by the codec in frames */
+unsigned sbc_get_delay(const sbc_t *sbc);
+
 const char *sbc_get_implementation_info(const sbc_t *sbc);
 void sbc_finish(sbc_t *sbc);
 
-- 
2.39.5

