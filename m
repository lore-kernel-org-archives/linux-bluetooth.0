Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4462638BA
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439484; cv=none; b=X1wkMbBN/ABCrkvwmusLaHO0hh6BVGkOGdUnoIWQyjtwOWpVGG8IoJAR2Y++ewcORRW7GsKKqdFCDEz2Sh+tpn3gRhoLp9/YF8oNQDJEju4fCSQNTxR/fU+6+JVMFywUGZcnvQdmIgbBNP/cMH7LKoiEfpTlICl7a4HUsm+Jj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439484; c=relaxed/simple;
	bh=1IJc+iXbLOAclTgdmVYoo2gsguRPJplrQe70+EOH8Fg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwQXhkfVmwMbVu/hqJzZO3hfq3nBmNJdNteEOtu1Jbdl+fZ92AylvvDqvGJL+xHP6uMn2p3k0ZmYaha4zfJS67ImPyThEK10R0DSDSrw4X/cmGUTK0L9cT7Qon8piUSClfleM1JoYr348W4mSPFFI+7M1PfsWPn0nggZh5WStns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEz+MK7Z; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEz+MK7Z"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-567404384b7so100961e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 10:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771439482; x=1772044282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q32v8WNXKb6NO9IFdmH4yaS1YUnL7pgZ8UnB4X5hSHE=;
        b=iEz+MK7ZljUSIbRFtQZxYqbruWRkFY0HL8FprYkqvkhX54j/liZA9ocHY7i7hCn/YX
         fVUEn5wS/KueKTr/GGc6lOexEBMZJRDTKIaD9h7FIH5iNa6PU5DDh7cMZBhRuiodTnvW
         TvnkIGHxQrw+3xRuHeOqTgiub1H3F+3zfqDyqZy6GTgcYkSABzPxxVCetAvuRoKPp2IL
         gusakZ0O3wKEh0/urdPrbKczRHGWUGcM5n4/vccutMl0H6tKOD+A0JCdoPLtjBrn+TRf
         F+JOHNmEfw24YiYmaP/aomAR6DV+sBnVNupfMl1h2z7lFdroSbTQtyttsIdoihmou6L1
         xOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771439482; x=1772044282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q32v8WNXKb6NO9IFdmH4yaS1YUnL7pgZ8UnB4X5hSHE=;
        b=qdrdSEynGrHoBcQlBu2Iqf1tiqim5wz3FmcoddJTUtkrXWgzrGznvZ25YvjuK0Vo/U
         Apxt/xUc8Y6tkpJkIxfjsP44xeFFrVVleV9KqBzsD3Ou1KXswB0/atxv7jvRI38ejWw6
         DT1FHckUC87HCGWHpXiClP/ZxwW/XHC3daEQrDRvNFaj2UWbqWtDY5xMidj/LJ6dHVtW
         x5wmQ7MJ/lHKDCQahIpCpy3Vab43pY5AHFDNFPqGhASRzOEJ3fyPPqKS3ubvVnYwZJ0z
         fbGi/2WY6sJmMNNytdS9d9hRyGjnnzsUQaDL73M0L9Klt9CehaXXaeXZH75wvpdGOlFP
         KV1g==
X-Gm-Message-State: AOJu0Yz/wvt+dGQ1MHnvMupH99FRnRiggFU6ZFmJRK6rJxz/7IdWX6BG
	/pZcouK5Tw4L4ceIo84ROV2EWfnyrzkzVv6mM7MX6gadNELfNwPcPmi7iCOcVPOO
X-Gm-Gg: AZuq6aKiiLhonzbwVWbbkTxv0D62O8OfOWNAQLlUm85GAXf8X0imkxLyWa09HQT+b6i
	u6L0ARBONDMHc11oan65fNalxm+K4wbs4PSPDvJ+ScSL7xxUFYyUeOuk6QvRaDwYIkp4/ytyGYd
	/6iiudsQiqTTe2MBhjtwgjxvmTGY8JSB8gOzKXtE5HxUEmj6QVi1wb6wYZOUN3FxWSoQbEZbvdr
	IXxX3tgYNtzIBNB4u046DTQD0IqZvy7/H8aWlceFKEJ6F7stJVRUMq1zbZI+tzHrl3ex1t0Rlm6
	MdJoQLGagtpo/baqx6m4TH4vZkK1gS63mnyiJQ78zUAv2kwzZpk7KkPEGiD4OAsba7P2c8Y7l0r
	RdMA4+Qn11IsD62JaiH/rmyQbUTBNh1OMIO7H4TYPjwn14ZhsBx0XwmSKjm+uG+J6XhY6ddruKe
	InCnLv07IMBtIL1KW4dOetIO0n+Nl1/0oFXtXvyMYzePur3CxXC259NsPrjsBfizFQHBe3mWaBi
	jFDoJ1ywONM5X85vUriT4dADUJh
X-Received: by 2002:a05:6122:4f98:b0:566:226b:e30 with SMTP id 71dfb90a1353d-56889b79736mr5711737e0c.7.1771439481617;
        Wed, 18 Feb 2026 10:31:21 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afd1f1f82sm10959316241.8.2026.02.18.10.31.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:31:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/5] doc/btmon: Add dedicate sections for timestamp and frame number
Date: Wed, 18 Feb 2026 13:31:07 -0500
Message-ID: <20260218183110.2840582-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260218183110.2840582-1-luiz.dentz@gmail.com>
References: <20260218183110.2840582-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds sections for how timestamp and frame numbers are generated
and explaim the difference between a frame number and a line number.
---
 doc/btmon.rst | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index e51001921ab1..de05a5fcd6df 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -442,6 +442,41 @@ Example of protocol layering in ACL data::
             Authentication requirement: Bonding, MITM, SC (0x2d)
             Max encryption key size: 16
 
+Timestamp Notes
+---------------
+
+When reading btsnoop files with ``-t`` or ``-T``, timestamps reflect the
+wall-clock time recorded in the btsnoop file. The precision depends on
+the source:
+
+- **Live capture** (``btmon`` monitor channel): Microsecond precision
+  from the kernel.
+- **btsnoop files**: The btsnoop format stores timestamps as
+  microseconds since epoch, so full microsecond precision is
+  preserved. Trailing zeros in the display (e.g., ``14:38:46.589000``)
+  indicate the original capture source had millisecond granularity.
+
+The default timestamp mode shows seconds elapsed since the first
+packet in the trace, which is useful for measuring intervals between
+events without needing to know the absolute time.
+
+Frame Numbers vs Line Numbers
+-----------------------------
+
+btmon assigns sequential **frame numbers** (``#N``) to HCI packets.
+These are stable identifiers for specific packets regardless of output
+formatting. However, when processing btmon text output with tools like
+``grep`` or ``sed``, the relevant unit is **line numbers** in the output
+file. The two are unrelated:
+
+- A single frame may produce many output lines (header + decoded
+  fields).
+- Frame numbers only apply to HCI traffic (``<`` and ``>``). MGMT
+  (``@``) and system notes (``=``) do not have frame numbers.
+- When referencing specific packets, prefer frame numbers (``#487``)
+  over line numbers, as frame numbers are stable across different
+  terminal widths and formatting options.
+
 Practical Reading Guide
 -----------------------
 
-- 
2.52.0

