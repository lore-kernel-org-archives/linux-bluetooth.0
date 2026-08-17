Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E23E0222
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958893; cv=none; b=SB1j3BfT2i83lHH8JzhsiO9ij/o/InJe61VEeq7w+K5Bbcl/MSJxGeBUD/aYrOlVnTWDJJFeZ0zuU0QUTqM8k+0B700fsYIHxIx5etD3TRxqBulC8s1NuC5rr/1Uz6o2h27mrtRtW9tiLKpWenR4x1U1OWUft95DdH6tfohVdCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958893; c=relaxed/simple;
	bh=I77vCqt69BN/M4jLKGyd0p8wE+Nm/qGxZFR5eG8yqSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pg86IJ5DO6dI8BtzlCmdJpuJYCSDhpqYqa1BRPcf1Zh+lTUl5CIoaAFCCE7Do9kvXYE/S4YO7jfxJtISUSp+kJ/zXHGlx+Hti7Bv4u6gS8uX3hzjScTeZfCjgA7sX1eJRnlEjrcOg3P6fGSrAQApbBUesXrzcYMRbxmoKCFnuKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=bkQHMA3D; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="bkQHMA3D"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ced3386430so32463655ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 02:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1786958879; x=1787563679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=beWULb3CcEPzF1OvJZ87lJuQr51Mznb8fDkBwd4EFYY=;
        b=bkQHMA3DAzsl4nIJk2aVl16w5wXn7AH/OVcHiPJ/l0xm88vJIrBQbVlWrT12f/UniJ
         +eMcAb+zcwBCZ8rw59EJrbAZkEHvt9ov+wqbVXpJRiV+GadqR/D39HqssaiPaVkbGAUB
         QCXsT0LkYvMCtuk5QnL5i2bju4oSTpatECENFUWHcl8Rv7PTJ83eOkXEKiwW/mopj8zb
         qbIJfkcUxKM5HfHlU7wqCTxpqDNJN9/YwyYmHXP83CITOCBPyJ+Px7k4c2HwECyhJutW
         xSkTpFJ2kixpATuYIC+E1srIS4jaB5wxyBJEq3kCk7VdkmKIy36XKQPY8HfqMeQIRw4d
         7mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786958879; x=1787563679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=beWULb3CcEPzF1OvJZ87lJuQr51Mznb8fDkBwd4EFYY=;
        b=gt7rjH6SMB+4QLTS5m5fWq1u7tUesD0AmQwMXAomCXn8HTfQsw9iozKkJtGYRslw+X
         QJafk9RiVyOQxiYSwDeO8ExCpQ6esdep9VgW5NhvISHmHLFVY7qWj47rxu6poifXnALs
         RJILi9V1iJAYQczkuX3jFVl6L6fqVvsaZeSu5WDICSYvk+WRc7y/fSMJAhIKwY1WCgVt
         kayf62AzTw1CzUEfX5GwbdCp93kKN94STo/ISGtE+onT8Mgf10L6CKYeGzMDmLiyX18j
         sJp/dFuOPOWR7PGyMpR1xuPxQvgGlKnxsvCjZraZ8dOBP/CI8H9+eoDj2LdIQcNXXvVN
         TjUw==
X-Gm-Message-State: AOJu0Yy2JzZeEMC6n7+v6Uiy6ISUtnKqfwxSfTY3M679TJ9+EhMgKCHv
	PwvpGTM0aQwDuyc3O1Wm8xJFtqpNQd4ChuH5lR4oCKg4jsmJc7ywWYcY0Fgw9PWada/cmC/R9sT
	yxqI=
X-Gm-Gg: AR+sD13SItnn47SE7Isfz5PWJcMYjNemKhge/UMaaZRQFyQ1EPRdg6389he7wG2/wrR
	DA/qhftQwsGKqb06yuKWzpPvm0BkfJxhlSZqXHG5KcejgyzA3z4Rvt2/JyR9IFYqKsQ4OHgmd67
	7qVlQFV5RNbslqr139QVb2InjlLNrs0591tqPwIUpPEGwP0Cbk8TX3wchLoYwansOZUys/NAX4x
	k1aBVPIGMPhnjDGKa3M0NZmvxl2vt2gH2A6GLkMvMZGvNXEaHLR6mcu39twBTnrVPhvDw9W/bKG
	cTJyY5pjqtRQ0Fcl/U4s79T9U1L3/7Zl7/0FyCIwiAdyDdiwfPTTRu1o9I1mdNGKxZDGZJhqkHy
	GsaXWYjVqkzPmNK6Spn//P/LkvJk8CSh3iGbVksQL38yV0wkSQVc9477PYhS0hvR38tPlOGc1wl
	aLSagXeZilBxFRP2UDDm8xUA0eGh9Hb2XpVL+Il5v4I4bRj1d6LDwL1Pp578TH5f8cBmHAaNbYi
	cklxxNo7BhIf35dZSll+FJTNrltyepVaB6IFZzym13VLY6rApDFPkQqjHkqFRg/Eg==
X-Received: by 2002:a17:902:e543:b0:2c8:1c05:16aa with SMTP id d9443c01a7336-2d3b0cbe5b0mr245366715ad.19.1786958878937;
        Mon, 17 Aug 2026 02:27:58 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb499e12sm2962455ad.8.2026.08.17.02.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:27:58 -0700 (PDT)
From: kaihsin <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: kaihsin <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kaihsin <kaihsin.chung@synaptics.com>
Subject: [PATCH 1/2] dt-bindings: net: bluetooth: add BCM4384
Date: Mon, 17 Aug 2026 17:27:22 +0800
Message-ID: <20260817092723.637956-2-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817092723.637956-1-kaihsin.chung@synaptics.com>
References: <20260817092723.637956-1-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the brcm,bcm4384-bt compatible string to support the
Synaptics BCM4384 Bluetooth controller.

Signed-off-by: kaihsin <kaihsin.chung@synaptics.com>
---
 .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
index 95501e858e6f..612d21123aaa 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
@@ -31,6 +31,7 @@ properties:
           - brcm,bcm43540-bt
           - brcm,bcm4335a0
           - brcm,bcm4349-bt
+          - brcm,bcm4384-bt
           - cypress,cyw4373a0-bt
           - infineon,cyw55572-bt
 
-- 
2.43.0

