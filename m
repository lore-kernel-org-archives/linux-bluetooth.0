Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446228C011
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635369; cv=none; b=c2s16GH+BEiNuRf2MYLnckmjX2yEbbbt+5mzENgYayhs9N+IhSUZHrEsX1fkXuqObSiaIbqMH0Xh9mVDZx7csSIZXl6EkrReQSh+yjiTG1jd8QL1VhXsADfl+FiZHkWROQbcTLDYoDA3Sy0xcSZstFmSFwClIatAIc5TBgO/LVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635369; c=relaxed/simple;
	bh=o3VDJSfHXuBJivf/NWUlSXxh7zYjB3W/1gz3aOuie3M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=J6WaghrzScRIcIKuJRA3G4V0d6ZcsP9EKAdYo7w2tAeEaP9L2vbply+BDkkjFuXfTnbeT/n/NqfSvQWGwaT/cpRm02weOyHs+D1J2DVZ2T64CwZ7mMGKa4Uq+05glrFGEIuldllsA/IbPepkO/RQKlcNKPfY+mUz7Qmi+4TCVI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIFENdTj; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIFENdTj"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-525b44ec88aso5409e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 May 2025 09:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746635366; x=1747240166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4rJFZxSWaDBclLg/BTKHyVpPBbxViKSIIXEZKDN7k04=;
        b=LIFENdTjrS2IRpDM7lNo4IslFs7dDU9Jy8w18BOqKAOpUPIZoo4rrTygIPSEnxXSd9
         57ERiEInKbD+/ck4a1Xrs7td9Q80VAw6FVI6Bgob3MpXWmLQgLz+RxFy5UvWDzGaSlE8
         1Ze1oJnR6wosWqDCO5XyKjFD00rbPYoRtKEn5m5s15DQCykZl/NtEoCbaUckDytq4SVP
         G/BAl04zrNkuSqwTxWV1+gmRtj7O5EvQeMUlIViBxHpch9W0udrra4/9Jxylxv/C0OHc
         R2jSFsurPHrvjECO90ROMbVuQYE6/iaKz7eJBST/X47I8bmzVmaTo3qQ8KoZBMAzM+UX
         iwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746635366; x=1747240166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rJFZxSWaDBclLg/BTKHyVpPBbxViKSIIXEZKDN7k04=;
        b=nwJP7LghhQD24qJGkrQmBRyHXf4WSUYfDi0wvwYdqW8YMY0UshbVQh6/OOqXtWQa4z
         gmtanFZU7Veog0gmDst7J9FXWGrk3g98fkrc6XAmpMLS8WJWQrGkyxMQda2brMY503mS
         JhT0ufaFUQTNfjDTuriX2TaLmU39UIc/BwwCik7NwV43jsXuocMl5Ul1Ca9+HGhXlvZV
         hDymsRRdY1GXdQ13/Q3lBvdFJAb+aUKfnd3aAn3CpXKGoBb4S2Zh0XUrTQlWLiU2mw5K
         fS2FIw2PosNy2SOH3kFoULYEE+tUujZNDqXeQxNjubVCOB0VmcBcjQeuCh47V3K0gefa
         lT6g==
X-Gm-Message-State: AOJu0Yw5swNjD4IkndV8OBW3dRQmw83Ixd+9mVmfk4Z2ZhUmYAz/FykR
	fGxB503dm9zG4WnZowVUNi6Jr+lKXPV2YkN4rG5kwlkT337Qn2GcfExuUUcM
X-Gm-Gg: ASbGncvd5gmprqWGfPCoYM9Li7f6Cg5N+q0nRZHgYsfNAqZRSp6K7QLEjs9d6gS3EJJ
	Im2nH5Xwi58GaTTKQ5zZ+OwLd7HGDr8gqNxGft7xN6peBozvZH3faPFPLJOVykv6N4Kcog7YUTJ
	E8OnYidiWE5SiKy7mNcPmjwDG6emXJReI3fyN/RewnbVZNQaSIIC6Mji9T8cUNnVLG9KRHw7vN5
	HOkXSzxpEXO7j2g8Yb7O3mV1ty0irzA8ZF5SXKLtQigYjen/+2LfSObIlH5VeGwZdR2tiuzJEUv
	nXgtcPqG9HTaOYmMaYl5RNXSZZZEYE7sbaxVulUoHq8FKXMil5bxdYOzhiRPKsMt5F5JlGYGfJx
	DEMsU6KGhZQ==
X-Google-Smtp-Source: AGHT+IFZPPiivekVxrhoV8YJKCPcMxvcLykvHnNCQMWJaNyzTfyeJZ2X0v4wAAdtGq8hDhAv4xhlww==
X-Received: by 2002:a05:6122:1da8:b0:520:64ea:c479 with SMTP id 71dfb90a1353d-52c4421cda9mr151255e0c.10.1746635365961;
        Wed, 07 May 2025 09:29:25 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52ae401de9esm2405274e0c.15.2025.05.07.09.29.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 09:29:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] btio: Fix not being able to set security level 4
Date: Wed,  7 May 2025 12:29:23 -0400
Message-ID: <20250507162923.226716-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for BT_IO_SEC_FIPS which shall represent the security
level 4.
---
 btio/btio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btio/btio.c b/btio/btio.c
index 14f2b700e383..b8afe0580aa7 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -455,7 +455,7 @@ static gboolean set_sec_level(int sock, BtIOType type, int level, GError **err)
 	struct bt_security sec;
 	int ret;
 
-	if (level < BT_SECURITY_LOW || level > BT_SECURITY_HIGH) {
+	if (level < BT_SECURITY_LOW || level > BT_SECURITY_FIPS) {
 		g_set_error(err, BT_IO_ERROR, EINVAL,
 				"Valid security level range is %d-%d",
 				BT_SECURITY_LOW, BT_SECURITY_HIGH);
-- 
2.49.0

