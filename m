Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798262063C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993073; cv=none; b=KArkzjb7+4xXT5AUJRh4asCSCn6JBYRplFJISccTrcB8ch19rdRQb8Tb7LonCB5wRm9wS79/nENGNPHjYA8apylncBTMQmBmkRm/c0nUa5VurXfkZgMnkasYfyhNrZP1waGZ45sizwkCgsKx2vaLAI57rMGdryXDzGndvG2/b8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993073; c=relaxed/simple;
	bh=pu9hTPtCMtObxpP0cwNSw8LchlWDYWdY37q88nHLCHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bF94lkhIpfOpNzLSDRlg/PsMAvbFwZprh0b68pxSK6W9pnOgyIF0w0Q9ngd67CMY3QwnMD7SpII9wXnma8mI61XLTfl6hfiAYzOTOb2t7eaLWLCTbwmx2PjOXhl8acykifSz8G6rkij59gVsgwmAc+YIkAznVChVa+kzVaVgBNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvOwaPua; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvOwaPua"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so569690a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 00:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733993069; x=1734597869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZd0Gbu6XQwYCQcGohlZ2WR8NsphWYmvDVrFlMqvsUY=;
        b=OvOwaPuatLkgELAB5OSLupBGKIu0iuwKt57sqJD8pCJYRgutMt33CA3HCRzySyJ89t
         SV2/ELBEWl4sfvIqWdvBdmY/yoPpluUzHvW4w4TPW3e37foMkpVljGqgzzvi4MgiXEtO
         oP4R0jani1TGEx2LPENsnAeqz0mGeu9mI5EnLM+4yutY/npvucCXbeFrwk/ZwWpIfwzt
         9qzvRnDW6vPv5fgsZXAZMR1Klh/0EclSioZ6ZUfM8JARjRLVLIGt5XNAvnChkw2E+byf
         Z8Zsh2Br36MFpiG0j5j4ha0ifL01elL7FRV4eB6n83QOX5sbYhUZGaF7SKiivTDoNcmH
         yHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733993069; x=1734597869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZd0Gbu6XQwYCQcGohlZ2WR8NsphWYmvDVrFlMqvsUY=;
        b=iQ0X8fROtzAkeJ89RNd8D0+w2tQY+Gw0smA8v0xjpTXkmNQ0xB7TWiACxOud60jRr3
         Lm7ONZE4T396tsm2ibvlEgfBailkcnJwitJWdDdUX0RO2q3hdLEiD1ewugQTewlCqclQ
         5gGveoMYvJddd25OHhfzoKBp90Cx+6tzrewDG1gaMHf0ncSBXWyRv0Rj6PRbbddF71b4
         NhbnBwkjXCi1lfiMylh3d2oJVUywNgUkeLiGS+EXUA62AqYsX4xSIoeNgDAVIfOtO978
         ynGBJh2InWq0ETReh+vHV3GAvU5fRIloB1PHvf65hJoFdmxy6kAiwCxY+nEm6pfGyZt6
         DOHQ==
X-Gm-Message-State: AOJu0YwBpTQH1IkSow4TLuYdnjnaENOUtQWpj0hPgECSMOPYaylZDMus
	afOpj5DDWH2tJMrbPM4CY5ZFRqZwg9fqCtphCPIvRujf2/qBvH7knljbXQ==
X-Gm-Gg: ASbGncsgeUUdim0V9fYzLtI1mfPpdl7/CoGRpKRugyCBxasXMVOTCeqnkSVHs6vgXOW
	GY8+5PiirelZ2SxfuKLgsiiWPbyVmJmmYpFafr2lGVfJGOvwLXa23MG7lfo1FvVpPC2GUWF/zWL
	9KqoenFAXLTL04RaU1qlG9kT8nUC0dl3aabmnpMo2y8sPqmyMhFYlSUOgRBKpgxSMVIcC2yt2fL
	b7Yu1JCY2vH5dSCUQPn3U5Re/u58LKZJbAQCUy47+4l8LzYf0iQtT2bcObIPh16Rlm4PMBqdLYG
	eruky3727AqFkTAW0F8f9J2G5jCamM7vLydq98MudN0=
X-Google-Smtp-Source: AGHT+IHtRMSM3zo+riWXa8ceQO8ws0eqTJpz2gA4PkdG99SzjPXht7cOhTYRpNBkK2n60ECDVsjv1w==
X-Received: by 2002:a05:6402:1ecf:b0:5d0:e3fa:17e2 with SMTP id 4fb4d7f45d1cf-5d54763c067mr4423a12.11.1733993069164;
        Thu, 12 Dec 2024 00:44:29 -0800 (PST)
Received: from raspberrypi.home (46.205.203.47.nat.ftth.dynamic.t-mobile.pl. [46.205.203.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d42a754cb0sm2948476a12.88.2024.12.12.00.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 00:44:28 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH 1/2] sbc: Pass const pointer if structure is not modified
Date: Thu, 12 Dec 2024 09:44:18 +0100
Message-Id: <20241212084419.1326427-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 sbc/sbc.c |  8 ++++----
 sbc/sbc.h | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 886806d..428c8ee 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -1378,7 +1378,7 @@ SBC_EXPORT void sbc_finish(sbc_t *sbc)
 	memset(sbc, 0, sizeof(sbc_t));
 }
 
-SBC_EXPORT size_t sbc_get_frame_length(sbc_t *sbc)
+SBC_EXPORT size_t sbc_get_frame_length(const sbc_t *sbc)
 {
 	int ret;
 	uint8_t subbands, channels, blocks, joint, bitpool;
@@ -1407,7 +1407,7 @@ SBC_EXPORT size_t sbc_get_frame_length(sbc_t *sbc)
 	return ret;
 }
 
-SBC_EXPORT unsigned sbc_get_frame_duration(sbc_t *sbc)
+SBC_EXPORT unsigned sbc_get_frame_duration(const sbc_t *sbc)
 {
 	uint8_t subbands, blocks;
 	uint16_t frequency;
@@ -1448,7 +1448,7 @@ SBC_EXPORT unsigned sbc_get_frame_duration(sbc_t *sbc)
 	return (1000000 * blocks * subbands) / frequency;
 }
 
-SBC_EXPORT size_t sbc_get_codesize(sbc_t *sbc)
+SBC_EXPORT size_t sbc_get_codesize(const sbc_t *sbc)
 {
 	uint16_t subbands, channels, blocks;
 	struct sbc_priv *priv;
@@ -1470,7 +1470,7 @@ SBC_EXPORT size_t sbc_get_codesize(sbc_t *sbc)
 	return subbands * blocks * channels * 2;
 }
 
-SBC_EXPORT const char *sbc_get_implementation_info(sbc_t *sbc)
+SBC_EXPORT const char *sbc_get_implementation_info(const sbc_t *sbc)
 {
 	struct sbc_priv *priv;
 
diff --git a/sbc/sbc.h b/sbc/sbc.h
index 9b8c6f2..b7323e8 100644
--- a/sbc/sbc.h
+++ b/sbc/sbc.h
@@ -86,15 +86,15 @@ ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
 			void *output, size_t output_len, ssize_t *written);
 
 /* Returns the compressed block size in bytes */
-size_t sbc_get_frame_length(sbc_t *sbc);
+size_t sbc_get_frame_length(const sbc_t *sbc);
 
-/* Returns the time one input/output block takes to play in msec*/
-unsigned sbc_get_frame_duration(sbc_t *sbc);
+/* Returns the time one input/output block takes to play in msec */
+unsigned sbc_get_frame_duration(const sbc_t *sbc);
 
 /* Returns the uncompressed block size in bytes */
-size_t sbc_get_codesize(sbc_t *sbc);
+size_t sbc_get_codesize(const sbc_t *sbc);
 
-const char *sbc_get_implementation_info(sbc_t *sbc);
+const char *sbc_get_implementation_info(const sbc_t *sbc);
 void sbc_finish(sbc_t *sbc);
 
 #ifdef __cplusplus
-- 
2.39.5

