Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E829974E38
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959444; cv=none; b=XfuQooVCoZ2lNWehGcy0RpgOqcHDCALTDl8Caxr8hZq/fI+gYyyLHzNP/2WfHwYsrTg5vWoofGT+2CdQDokjqEfZjC8h3jqnxPH4N85+FwqX7jqIdaSiEGjLpNvYlqmPSP82QA8aiWVwMjL11vC+MZ5IVcA4/BHugi3Z0gpy7cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959444; c=relaxed/simple;
	bh=55b4rrW5mmTIfz1WueoXRp1JDRgxNMSEDrMH7f9JmoA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CCGc9OKoARURUP69iPiUmDRPfM7cGD+DAqbdYTqQRNfDr3d+iNVu4reF52rd6vNw3hwXR1cTzCSTjKfJD54N4L+I7oh3Kf4X71hpnJBPa/Ca4PpvlUzYNTK/Ol8eq7Zuuxi+MsbcNrsXAf2Puu0zMgqRFC7WBbCk3Mc1zWnhOes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAeGxE0O; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAeGxE0O"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4146af3ebc8so966025e9.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 11:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710959440; x=1711564240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kwlrMkhjYHMWNIC6iIWezqATnpstXoiCQq3Z8kKPQEc=;
        b=jAeGxE0Olo5D43QmBHNQuuXEz+zDRuU9FoBRr0QX/44lNHxYiwA72qn/dNB1LIFL3x
         BV63v9ai2J2YqYXpGPbThWgjPvNfadN1sGI14FGxCcOEef2lSQgSy1z+i69QENrVv2Fj
         Lt93KXVUXuhNX0GHTibMKG5UQgKcuXkKdaGLVXZHt9ZogGM6lxp+dR9rlp5Be+UXgTia
         aecSVQrH7ZP0DuqfVE8pPME0ivo3ftkbrePUu9HhEFakPDLZrCyCXn1e/xM6KnlJ++Io
         k1+rMszdH3XXtSuaAhNIHid9etmgH9yzajoV1VajRHQ2Zz/B/YuL5a345LsHOuqRGUPE
         TK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710959440; x=1711564240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwlrMkhjYHMWNIC6iIWezqATnpstXoiCQq3Z8kKPQEc=;
        b=NHjll88FgYkN/AcK3YRm6tHzb62Ql3kpZ6BOBWXJbC0E68oET6erAM7cEUUCFvggVF
         +zCscjml2W+Cy8GWXJWuwIKrFSEmnJZr40tlzXb1W3F+qPaIA7xTvq46KBKh3Fr3+xkO
         in2v0Hc5H+wlJFodrqGjhJ+edAI8htbrzMWsRSaVS1Ut1+BZY3KeRYG1sM51x58iIuHP
         vd0ADOCWYEbUbqtXEW7852OCPGpem8RR9TQtHBVqULiY69cfV+K1pLIwebSgcEiPKE7P
         SlUw2QW/VZLDNk46hKkfhCAuQzMAD0TbUz1obQJY5+wlClhydsYrTuTdx1Q16uf0DS8F
         rihg==
X-Gm-Message-State: AOJu0YyBr0SH7lUqg/g92HIv2fAOzG9nrNOErjVBssqwtIzAD9uCmfGc
	ebH2V+GzXsPCIvUVa8niETGBplzHVtc9DGlElY/0ofRCOdsIaDxq3/WswcuQOiMZjhH/
X-Google-Smtp-Source: AGHT+IEtOa/d4jr/Df5AnGQPWYeq/K/pfCIrTat1/flz1j+/vx6npwPai9/igRhTNdXIxffUNNAsuQ==
X-Received: by 2002:a05:600c:a02:b0:414:8d7:8292 with SMTP id z2-20020a05600c0a0200b0041408d78292mr10067972wmp.0.1710959440169;
        Wed, 20 Mar 2024 11:30:40 -0700 (PDT)
Received: from lvondent-mobl3.. (ftip004290803.acc4.faraday.21cn-nte.bt.net. [109.144.76.63])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b004146bcdde06sm2927313wmq.6.2024.03.20.11.30.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:30:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/btsnoop: Add proper identifiers for ISO packets
Date: Wed, 20 Mar 2024 18:30:37 +0000
Message-ID: <20240320183038.411332-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds ISO packets identifiers so they are properly stored on files.
---
 src/shared/btsnoop.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
index 8b93203b3..bc5f7fcbe 100644
--- a/src/shared/btsnoop.c
+++ b/src/shared/btsnoop.c
@@ -305,6 +305,9 @@ static uint32_t get_flags_from_opcode(uint16_t opcode)
 	case BTSNOOP_OPCODE_SCO_TX_PKT:
 	case BTSNOOP_OPCODE_SCO_RX_PKT:
 		break;
+	case BTSNOOP_OPCODE_ISO_TX_PKT:
+	case BTSNOOP_OPCODE_ISO_RX_PKT:
+		break;
 	case BTSNOOP_OPCODE_OPEN_INDEX:
 	case BTSNOOP_OPCODE_CLOSE_INDEX:
 		break;
@@ -428,6 +431,14 @@ static bool pklg_read_hci(struct btsnoop *btsnoop, struct timeval *tv,
 		*index = 0x0000;
 		*opcode = BTSNOOP_OPCODE_SCO_RX_PKT;
 		break;
+	case 0x12:
+		*index = 0x0000;
+		*opcode = BTSNOOP_OPCODE_ISO_TX_PKT;
+		break;
+	case 0x13:
+		*index = 0x0000;
+		*opcode = BTSNOOP_OPCODE_ISO_RX_PKT;
+		break;
 	case 0x0b:
 		*index = 0x0000;
 		*opcode = BTSNOOP_OPCODE_VENDOR_DIAG;
@@ -470,6 +481,11 @@ static uint16_t get_opcode_from_flags(uint8_t type, uint32_t flags)
 			return BTSNOOP_OPCODE_SCO_TX_PKT;
 	case 0x04:
 		return BTSNOOP_OPCODE_EVENT_PKT;
+	case 0x05:
+		if (flags & 0x01)
+			return BTSNOOP_OPCODE_ISO_RX_PKT;
+		else
+			return BTSNOOP_OPCODE_ISO_TX_PKT;
 	case 0xff:
 		if (flags & 0x02) {
 			if (flags & 0x01)
-- 
2.44.0

