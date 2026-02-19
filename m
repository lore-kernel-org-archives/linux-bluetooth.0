Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005E9345CD9
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518163; cv=none; b=Se8RTHviU6Lv0xVjb1YzwbGOvpKbV4nmPibWg4urTrStJCjFnDOqCJ6ozR2Gsu6+USnobP1M0w+ZhGukD8KqbBnywOB5756fmg81/gLIHd+g5Zi22fmSM5NfODp6xTX1BF4JzGM8gEm+RCjYZiZQ58+rZG9jwTKYZ0Uerd1MTzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518163; c=relaxed/simple;
	bh=1IJc+iXbLOAclTgdmVYoo2gsguRPJplrQe70+EOH8Fg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcHy3lKkZET3O3yJlF17/3R5L50LQCjIeSK0Bqua0X94+PtSLWvkxoDeNrdvJQVC3wBv0DBCN4Ky+h0+ax6CtUXBDrfsX/KVeXWL4OYlGJfK4vxy/RKwLv83qWTxvanSdhN1qnTv1HmOczuMKoUODdYdrwzA/yD5b0wMyBXSG/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XN/mJjWF; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XN/mJjWF"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56636dc53a6so403978e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 08:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771518161; x=1772122961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q32v8WNXKb6NO9IFdmH4yaS1YUnL7pgZ8UnB4X5hSHE=;
        b=XN/mJjWFYrfxSDRYH7+4SmZZOuvpbv95AtRG9B+t2S0Ie/vEMsmCJzWgla7qAyP5ZE
         zhp2e51OcPgqmYav5X7UC2B4AHU8Z6cx+UcpQYMbLcECtId6SJ1WZu7cp2W5a9DLxW78
         Ypv6ALwK+4KUz8VGaUrJH2Gid/BAC6Sg5X48tei7B1ARKWUI1VWTqPHTcGn+awO5a89k
         NZb2Cr8b0C4DsV13Qo6colISNX1sV8BcIWyGmZ1lsUoLIJaRS3tdJBkmUMPy3NjdIIT+
         nKSOcDjZILnkapeVfYqRuljrB//JdVIdkDEBZ2kvWLp+MVj9im37JZK2v3sTiDNluYxs
         9pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518161; x=1772122961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q32v8WNXKb6NO9IFdmH4yaS1YUnL7pgZ8UnB4X5hSHE=;
        b=A+qHfJ8SJyIjESf9cK0w+h4Fuo19JpO7trMWtQhzvkcnTYYgHch9bZigwXjjmNrihA
         Z9/a5uZRlVgx2VvMqNA7c4kr6GPDEs4gBs1GymrnOKBnthKexeE9gxM4xCmSxFIPunxw
         terWMIiDKIM5984ul6IFE5Qu9zJIU0/zD8LK8CUMzZRpJSYrcQOvDoUENm7AC+EPg6I+
         d0dlG0e8UOikTBNn21SJe6AGRIIA5BqrScpqifSHl4pyRft2nGkLZqBoReSZWSba8xdO
         WjndTq/wUyECvJOTCzgoI4HaFgO3uvwcX5NZcBTrZ3gigauVD9dBdwfBFuZc+08Qi0Fu
         16fA==
X-Gm-Message-State: AOJu0YxK3dMY+/TU08YSorSmuozkBG5e4asCn1agNWJXn6UAUQ2hfXXG
	Ej58d580mIDGCccHrESiVD1XU2Gu5sGCTr8EO+5FWX9lqN/c+emNCY3pZ8pyhw==
X-Gm-Gg: AZuq6aKJgUb/CB2C41ocQo9KXLnp+J/DvE6XBubEy8yYzlLCdNeXbfeVXf/2ClKZP+O
	oBsLPvie22IW8qeeuyKwFb4TLKo4GaqOCP5Z3RLTu2nIBGewaorGUH84/X8PTB8Hfiia+6Pksvq
	Fl5WLaa36wRsJQXzTPIpw+ydHo5/99sbiL2mFHd5NzwpJlMRiuNwe8F4uOlLp1h0DDw6235hH1e
	r447phnC2nCTJVS0v6JkjZaNSwju8YWsSyX/hb99XZYC7/D6HMyLBnaBbcfkl13KINb80lN61mH
	IYLWAHJcGXsJ5wC8u+iEgtd7Y3Zci0ulLhOKpT3Wb0y43iVMT3dFA4x1er4VIuM7aAvERa4mVQR
	zFbrBn65FVkBePGsw0SxIqidsx8jdzCXeEl6QEo+ka2+s4rzrBDqsJuCbbnxm/IgsLr6VAQ3J4L
	Ye+FHaQfAgeMu41H8kZia7oEw8CNt/AF5ahj/kBTmNSUxfo39GIMhCpiA084svwOrSksvkt1wx9
	M5GyGv6t8TmETf7/A==
X-Received: by 2002:a05:6122:134c:b0:563:c868:a32d with SMTP id 71dfb90a1353d-568ca05a2admr1415852e0c.2.1771518160675;
        Thu, 19 Feb 2026 08:22:40 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674c20a659sm14435235e0c.11.2026.02.19.08.22.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:22:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/8] doc/btmon: Add dedicate sections for timestamp and frame number
Date: Thu, 19 Feb 2026 11:22:24 -0500
Message-ID: <20260219162230.3074355-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219162230.3074355-1-luiz.dentz@gmail.com>
References: <20260219162230.3074355-1-luiz.dentz@gmail.com>
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

