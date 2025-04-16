Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0B12080F6
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819483; cv=none; b=PnUjDvCok610fL70z9orn1Zpt5qMKDd7QF533tvU+Lc73RHe7wpXNDT54fkt2mqHPW2y0CfjyQgzISzQbe/s7TZVZx7ngQ/xBV1PJ1Erc4sutL7owvIIswi5+xU0hgCVdSj8QzvB53E07bJJYBJFtDAV1nqXLb7aVehW8KJQYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819483; c=relaxed/simple;
	bh=tn3LLMUkmIgzSHBzNCOPge8xddrWH9LcOTg27zwPgds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iyjvso5w4dATgqinalkX3TwSRv29TEczlq5hEdoCP2qxnP8dDHUT3zB9cteg/Q43YrzKmlR1CPnjnIBOg6EqCwtzpwy9+/gloR5p4fDLQHe3VdkrQQQnexvi2r98EscdOTUj5d1ueWrb6QWThFaho1Y8DAq2Tgj0uBqzXzbc56A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V35zuHJ9; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V35zuHJ9"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86d42f08135so2489776241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744819479; x=1745424279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qAWmu4uWB6mmSNQRF8c6wKOSO8fTTfpFkXVXjHgTSk=;
        b=V35zuHJ9HjhlB0pzJQQnTTLpsoPKCtaROFKLudBxyOY873avrtCsDGpdaVI6sPV8pA
         ToaQicLB/KqiuQUi1C4I3hMyLnd6YJBUcsRnjczIeF8N3NnaqDjiuJXc0xoBJi1qBtsu
         /6k6YiFgfh1uTJoXDvNVRsKXmASXecN4dG9G54tHqc3d9Aj+yl+2I0DXNJLb2T+9M3Sy
         FDMqx+5DTqWvQ7Vn9BtbXp0PrIlqVTd2U6gTRmeNmzYNeELUntPpK3RO0SI62GSe+9f1
         r2x1lkmtYfIcgQ1gL1YNbiCJmnlQT12vX8RFqIOE/kEVIJ63rtfET0RDy2rpaR61eH7v
         D69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744819479; x=1745424279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qAWmu4uWB6mmSNQRF8c6wKOSO8fTTfpFkXVXjHgTSk=;
        b=h5U8ofNMr+x6VwjcjNJFBp8kic1WnqIQm85piny+/dSmKy+JVWuuyGgetoffiOb9e2
         SRT7ES5KW0vWb8+6NKDQ/wK3exXUsXraKGyvKhPjhzAM71E7wIo+BtPLmFGv+wIXrgM1
         gwK0P8C4x0B9STYaxFN/PEQGAUNGEaRh2Eglx4VsuSX+TWsdqnx1men+ntvDwTD/VCuL
         k4dDWXal4FGQtewvZXYHlZXzT7v3lrU5oWAc70Ke5UWZTvCFAlK2NOPU+m2wFvi/rP+G
         pEZ3jB7nDG81BY81WHWNWy6wfgUIbNDYR1otS6eBxrQWoOgVzbfLw6lPE2FHlVlJ60IN
         JxNQ==
X-Gm-Message-State: AOJu0YwHZIgk0NdC/j3s9MJ4CnTjrhyPvJWCxHxTJAvI7XRq/ALUh1Jt
	AOLQM7kChFGbA8cHwgQqB0/jb+OyeP5RTr3m/obQQZmbnaFDDAQCfWX1zUA0
X-Gm-Gg: ASbGnctZsIKznwjOOTVmp31iC+B5hDYcZUNALXDOsWOnzYIjWbKBptnvqCEqU+6ZfcJ
	7ZhFDWUCXmG7xi42kNS+lNVT4ZYx2zN3jwdNB1XKW37c66xlVF+N5S9qSIYSTa7oVx+xKs6P/nS
	RGnBH3x50O0fc9UmMWOVOuvaQwfJ1XqShEhQGJIAixnsCxxjBNlQGgXWQgbdMmsmMWXbCba4GsF
	WLduuVOAzu6Ka/T62tmOGIHqLqEC2Y9iJTmSkwVmgBFV20OxXCMPtjIgU3cOjQdgV3JCHMhMWON
	qerDNNNnqy21I4/+/DNFI7x6myTUtr8mJFBJYALtC3FhrRenzq+aFJ6UcMi+SUDHBJMhu2THLgp
	GEVACw8WlDg==
X-Google-Smtp-Source: AGHT+IG/cNNf53t2pEYX4UXdbFqls1Qbp+BmVmknQwVve+7yLcOrCFslv6kJpQlI0rWeMGKYL+W5Gw==
X-Received: by 2002:a05:6102:6b08:b0:4cb:5d6c:9943 with SMTP id ada2fe7eead31-4cb5d6c9a39mr1254271137.12.1744819479080;
        Wed, 16 Apr 2025 09:04:39 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c98afd43sm3094029137.20.2025.04.16.09.04.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 09:04:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/7] btdev: Check for valid SID on BT_HCI_CMD_LE_PA_CREATE_SYNC
Date: Wed, 16 Apr 2025 12:04:28 -0400
Message-ID: <20250416160433.1822263-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416160433.1822263-1-luiz.dentz@gmail.com>
References: <20250416160433.1822263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 emulator/btdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 7e4cb9393593..a1c82ae306d7 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5728,6 +5728,12 @@ static int cmd_pa_create_sync(struct btdev *dev, const void *data, uint8_t len)
 	uint8_t status = BT_HCI_ERR_SUCCESS;
 	struct le_per_adv *per_adv;
 
+	if (cmd->sid > 0x0f) {
+		cmd_status(dev, BT_HCI_ERR_INVALID_PARAMETERS,
+			   BT_HCI_CMD_LE_PA_CREATE_SYNC);
+		return 0;
+	}
+
 	/* Create new train */
 	per_adv = le_per_adv_new(dev, cmd->addr_type, cmd->addr);
 	if (!per_adv)
-- 
2.49.0

