Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5217964E
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757734; cv=none; b=oO26qzbExwwNX8qvPVmsKdA0TBCLfG/voODMQwIKLUmRP2Cr9oZnD52pHKBtFArbuA99aVwW6PlQXWcprotyQ2PupGEDSfL8BTHXUUAN5y4VgeQfC3rYzi5AS6mvrxRez4FTJNLUYBDpBl45S1PdSzMG+IdjejIwUxCYhefmImw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757734; c=relaxed/simple;
	bh=9aJoy5YWJ+2dlXqHyIFDhuX6VFc2cSpxJgETMwfMlRQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guldXeQtMpc4b+ns70BqJE/FRgpM2ORKoBKu/Re05dIwexAoOLs2GZ9ak3GqFMUT+2J7jy+NGDUZp0tJlxo27yfNb63k20xTi5ucEpLwy4ZFLP7j1ntfkFlQcyVkATHr1BLYc6ovEcTw8lwrXzmNdrh2h4eZYcVCU4Uac/cea2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQHbNmpH; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQHbNmpH"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c397193878so3581234b6e.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712757731; x=1713362531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wl+SppwAKGBp8KZCd6/T4Y1i/PcNDdL3WeE9JQ5bmM0=;
        b=ZQHbNmpHLnqJvOc9DNlmcCwedfaU969NfwdjdefhR4rJgc8qyFzc1y9Ve2izyTna5u
         ytPRT+8sGE+Iykiu4uGG8sKpOmL2L1L67b7+n0ge5+6mn1H+mowx3h7vUOto8qnXCg/G
         QgVXiOFsAcKpBME6mL6eW7B49WlyReJsPhyZuVnY+AIPCmHvzE8twJFtPFbrb552Ii97
         krMB8qmEM5B90e1GlkqIDIro0QXjjfU/6FJw3FIk6pEqK2irYP1eK/olviienQyZpfVL
         nCr9Vu+FIEKOk1UoMrFenQU4hyyFWyVRuLTfRDYDiQ7S+FP1OKjzRLnzAIgE7WRT9FEp
         wL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757731; x=1713362531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wl+SppwAKGBp8KZCd6/T4Y1i/PcNDdL3WeE9JQ5bmM0=;
        b=at1UPIjgG/kYxe5T/xSKIFQAjwX778NjZHbY67/nn3aQ0t80VJtKhWGh522H0zLUbo
         p6jwOdBn3zgeTBrYba/p8Jh+dj1VtxYzRnee86lamiUsUP106wdQzUQfpf7ZsZxu82d8
         7ZCic+3xr/vMk54jH4AILfI1ZcSmP4gHWTN8UKqLvBWuUcUt23zoqIShECYV55JvgTfM
         t3lVpfr8SsGVw8xHlTNW95hakK78VZaTmbXjGqy6v3DWGtCXeI0EwRqBTgIOSLRMBr4T
         pWAf/4eXBbZjuPZM/nz6TIxf7bIb5PND2zB4Ei+exHPXdcBcZBN7YxYAe2FmLTHOd+eU
         VC4g==
X-Gm-Message-State: AOJu0Yx/TgH44PGIJU73z9HMlhpgUXAkGlqz0fXkLnmj0PNBikXPiMqR
	9miYYNQcowf3Mwbsl9eS2CZ597T8djABKs3lqb4zXo0g9JNMpauzY6ufYdRY
X-Google-Smtp-Source: AGHT+IHk+D4ytnxOpEO+ZpjXIjS15JmSg5psQ0v70BI+Fq0Ec2j6Bhf0T1AwF/W72mlw9BTFH9lBcQ==
X-Received: by 2002:a54:451a:0:b0:3c5:fee2:76b9 with SMTP id l26-20020a54451a000000b003c5fee276b9mr2612941oil.57.1712757729504;
        Wed, 10 Apr 2024 07:02:09 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id k21-20020ab07555000000b007e3199adc5dsm1382051uaq.0.2024.04.10.07.02.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:02:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/4] hog-lib: Make use of bt_uhid_replay
Date: Wed, 10 Apr 2024 10:02:03 -0400
Message-ID: <20240410140205.4056047-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410140205.4056047-1-luiz.dentz@gmail.com>
References: <20240410140205.4056047-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_uhid_replay to replay the GET/SET_REPORT messages
recorded during the first time the device is created.
---
 profiles/input/hog-lib.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 8071e1364b10..0291adb6eb23 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -856,12 +856,14 @@ static void set_report(struct uhid_event *ev, void *user_data)
 		--size;
 	}
 
+	if (hog->attrib == NULL) {
+		err = -ENOTCONN;
+		goto fail;
+	}
+
 	DBG("Sending report type %d ID %d to handle 0x%X", report->type,
 				report->id, report->value_handle);
 
-	if (hog->attrib == NULL)
-		return;
-
 	hog->setrep_att = gatt_write_char(hog->attrib,
 						report->value_handle,
 						data, size, set_report_cb,
@@ -1726,6 +1728,11 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 				"handle 0x%04x", r->value_handle);
 	}
 
+	/* Attempt to replay get/set report messages since the driver might not
+	 * be aware the device has been disconnected in the meantime.
+	 */
+	bt_uhid_replay(hog->uhid);
+
 	return true;
 }
 
-- 
2.44.0

