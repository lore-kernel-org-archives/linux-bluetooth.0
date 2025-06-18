Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAC63085D5
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750273897; cv=none; b=afh1MiEUu9r8fkZ6AnI5RLUuLciSVUImt8fP4eh0xQ/6mxQTuGvgbOym4z9JgDKY7NFyywlLJMcIp9H6/m569Gd66bMo79UEG3ePVLbdF7mb19wdHtkFBCtNJuJLEKxUnYQ5/Q1qwyg/62/n1BLICPr2a3tgHhGyKYjw/riB/Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750273897; c=relaxed/simple;
	bh=MFfuo+NeJCGbH3n2ZGS+FRLC8WnhSNJ4D6bE1wN2wMg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omhGSd2f+B29H9w3i1eaI/eR2y/ymtI1eXv1LWOJloedj9z3AtqwblgwjL1emzXKJTxFIplkXt8355sLcSdqATEa589RtfPuW8gOz+gehwAyjsaphe1dieMlac7UyJ6rb7lCYP2ijEbyhdMO51uQJhRIv3FXh4DLOuRaBVyaYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrdFWq2q; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrdFWq2q"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4e7ade16082so17261137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 12:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750273894; x=1750878694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oK0xQe12UPOKd/MhT2Z0itqiBG9rGHKnKi68QtjQry8=;
        b=jrdFWq2qUHmFZKkeRbTplRti7gtrL/n1BpsDdFLI+cYoW0tkin3rvVhYSFnnVCsu0c
         dJIxD0fFTwz01axJV8apAxR8DWQPh1rZ/+BVmRqpRSz67bUqu1ohFiPCZPjHAkIb2Nnf
         cLxfd3PKnL6NIFG2MBL6xGfISi4jX76fgfd0j/IKkStzOY154cAGPMZJ1oE05KdTRLVU
         PMrIX7waQtMvUbi8qtyEFh9NePQ8qWqSl0H2sZUCaZ71HRvQp0ePypXTzDRNDokIWXc8
         731hmxqCjhZsenUOv/V3C14OfMiD2W7yv5iYn+6QA0gzqwtajGLBvUpMT0DM1ghewfbH
         Qk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750273894; x=1750878694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oK0xQe12UPOKd/MhT2Z0itqiBG9rGHKnKi68QtjQry8=;
        b=JhxUuqH/wzgyWAFakwY3Yo4R1vtbdq8ZBKAybA2yX4XS/Fo+ePc6faXepHLxSkIzwO
         5u3AtQyEnq/2K5gaISjPCJG2MTxBUgKlbdFQ7g3PrQUzhTTWp+rNaWSGmQ6Og8x1TXGT
         CnDZIdeNvcq1w/kQpeZiAakgxVqjl0orIJ4nr8U1SH8rSmP5zqeeEM5fw7ehu56tQjGY
         DnAtW4jL3mnbi5FWKmmKzutOw7xAlM6+S8o7UYzMoMEKp1Dy7WRmvKCMKv07Ns1y1QAY
         8BVdd81y7L6voAaEEdCU88tBnL8PH/u5xduk/i3o8mR2AnISEcNn0puflrsJ+CB3rOrN
         Qi4g==
X-Gm-Message-State: AOJu0Ywm4bHLhW3wDcthN1EH1Z0/pOIcBMozpf2lTc2Ach00qNMaH8o0
	yhfJ0d09DOjKI95XQ0mqHhxMZWZvKvPI4NzByVJqzmdTKdJve1VoiSjYduGqlg==
X-Gm-Gg: ASbGncvcxs1kxGVw1r7nVZ8bYTCtZYgeoeNlib2ZFl47iJzEH0j7OQxHK6HU9COJQ+w
	hBCc99HKcqWK8sMWwQ6zBl74vfnyNe2NW3k1xHpp+QNolrRn/dwTyzH/pAbzXRen8RaadyeedCP
	3s7y9j5oNnJueHSegzVaRziK67egO/sGuUyRTxY0zGOZx6kMIBl/aQJiaDeI/friytxFfIDoz9p
	xrlLXJL+rOLRwvCCV7cym7j4ZIzMXeODoLwpFKYwmXnJ6xRfdfsYSgGqj6fwyBNxnvaeC1UD8bf
	HuAM4p3hZIHIo0GPloRX8933sgnmAW4MbISmibuBI7SegdGyZI4lc7SSa97xGEJlnM8UXPm4GTU
	B4UXMJoKjZg00XaCpuUu68f+cHCpPIOE=
X-Google-Smtp-Source: AGHT+IHl7QK1CVKEswhCrEplFgoXspVXM3F1X0EERf5fBoJf9eIkfnfTzsWvlFzqYxmWyKB7ejrS7A==
X-Received: by 2002:a05:6102:6f03:b0:4e9:9281:85aa with SMTP id ada2fe7eead31-4e9928189ccmr3772619137.1.1750273894365;
        Wed, 18 Jun 2025 12:11:34 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e979b63419sm695910137.25.2025.06.18.12.11.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 12:11:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] tester.config: Add config options for USB-passthrough and drivers
Date: Wed, 18 Jun 2025 15:11:25 -0400
Message-ID: <20250618191125.3123951-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618191125.3123951-1-luiz.dentz@gmail.com>
References: <20250618191125.3123951-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the necessary options in order to enable USB-passthrough
configuration and also enable most of the drivers so they get
build-tested.
---
 doc/tester.config | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/doc/tester.config b/doc/tester.config
index 099eddc79bcb..b5fee30b817e 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -34,10 +34,6 @@ CONFIG_BT_MSFTEXT=y
 CONFIG_BT_AOSPEXT=y
 CONFIG_BT_FEATURE_DEBUG=y
 
-CONFIG_BT_HCIUART=y
-CONFIG_BT_HCIUART_H4=y
-CONFIG_BT_HCIVHCI=y
-
 CONFIG_CRYPTO_CMAC=y
 CONFIG_CRYPTO_USER_API=y
 CONFIG_CRYPTO_USER_API_HASH=y
@@ -57,3 +53,37 @@ CONFIG_PROVE_RCU=y
 CONFIG_LOCKDEP=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_KASAN=y
+
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_PLATFORM=y
+
+#
+# Bluetooth device drivers
+#
+CONFIG_BT_INTEL=y
+CONFIG_BT_BCM=y
+CONFIG_BT_RTL=y
+CONFIG_BT_QCA=y
+CONFIG_BT_MTK=y
+CONFIG_BT_HCIBTUSB=y
+CONFIG_BT_HCIBTUSB_POLL_SYNC=y
+CONFIG_BT_HCIBTUSB_BCM=y
+CONFIG_BT_HCIBTUSB_MTK=y
+CONFIG_BT_HCIBTUSB_RTL=y
+CONFIG_BT_HCIUART=y
+CONFIG_BT_HCIUART_SERDEV=y
+CONFIG_BT_HCIUART_H4=y
+CONFIG_BT_HCIUART_LL=y
+CONFIG_BT_HCIUART_3WIRE=y
+CONFIG_BT_HCIUART_QCA=y
+CONFIG_BT_HCIUART_AML=y
+CONFIG_BT_HCIBCM203X=y
+CONFIG_BT_HCIBCM4377=y
+CONFIG_BT_HCIVHCI=y
+CONFIG_BT_MTKSDIO=y
+CONFIG_BT_MTKUART=y
+CONFIG_BT_VIRTIO=y
+CONFIG_BT_NXPUART=y
+CONFIG_BT_INTEL_PCIE=y
+# end of Bluetooth device drivers
-- 
2.49.0

