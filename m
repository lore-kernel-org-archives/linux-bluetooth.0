Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402122848A3
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045402; cv=none; b=csCspP93qlItGPd6TKvFwN7ZZJ6DE69U58hV80UD/l3WAz/HSs82vPnXYhk/XIJdY88y2QbbnxDO1JdSnijPXvd5WvaJPJ7nmkPtAC26BgxSlKFLMvDZp+om5CPOwCTHkwXuhRxxPAc9fiiiY4Dgj+gHv5yemS3XRe1WDU/gU1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045402; c=relaxed/simple;
	bh=dxKRR5Oct9OvsapPKQ8CB/sGKQzOTBjWbqT44dtrars=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFqRXaYgQu+7UDPXKj203gKt+rKL6mkpGUm2JrIOAAqz2MO4T0XjB3wDu0kC8t7HMGnCJTLz1rrJei/DfANQc3FIeOba6qSPQmepMotNXuB8aPwRbWnxPrAiiEkPAIGHtXPsMsUejWwOOvLNBp7d1VIi9ALQxKgCnaXf+TslRqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwyV7OZ7; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwyV7OZ7"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54bbaca0ee5so319540e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 14:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760045399; x=1760650199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doJ7U7lzUHIr7jQNVm67JsaWry9+16XGOO/Jng0d4n4=;
        b=VwyV7OZ7tM7zRkDjC9eRaGmqvEmJtoYzdEAxzpyp9Gwl/ltwL7utXl3hO8r/g4y7Rv
         xr04bmzFOnG2qLVACnbWvkK9CiIAYENMiRKoolVz+qKy5tTn2vR41xsx4OkFoQ6hXW23
         SBWVjtyv2umVXOMdwlsnPCSNk/NYt2relqm1DmMNlVrNagZca679Evlr2bs8C3ZA/0F7
         HMtPCO36oLINO//5PThXAXB5BQJOARF7i8uBn6jXgaqiUYbCCpeLzBRd6p9vPkWlHkKM
         mz213wIv102NeS0iR0haSx7TLXGY9n3mUXZcU7TtOcIOPZbVLmfHa5hzo8DCJoyOPXc1
         yKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760045399; x=1760650199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doJ7U7lzUHIr7jQNVm67JsaWry9+16XGOO/Jng0d4n4=;
        b=ZdUmJXGXfF2hpq53Qgp7vnftDQ5UBzbx+fk8p64U/8/EyW5YWBs7VdklfYEoCDupcA
         O+hThncnnYE8vLt3jzq7V47uF/5LZoItC94c1w7rBz75KlD7OhP1D4/NwSshF+3m0ql+
         8M9bUFiVVLbUizuA/zwmYQa30nxwgyXSY+v5QLxdVKsfgL8UrB7Yx7qZhhnygp39p8aX
         kLPPijDGtlckA47eAFPI4nN3kgW354X3Nnx6sMd8PYemB7mFTzGD+eElHP1ZMO4zG88C
         02d+11o94cgI9Js7BFXraw6FHo3iMa4ekhx4mXlbjyzcZ8RUPnu0fyIqPmyHjCtRZrLE
         OFbg==
X-Gm-Message-State: AOJu0YyKwD7Yn1A/6eMzeulqJlxRJkKv9c5nidjJoGRv2qaeCPJKofGR
	YIupgPL41SNYUraes/KX5nRiEuvowOppKlnghf9jd6oDYjB/HLq/CRhCQ68fROIW
X-Gm-Gg: ASbGncs15a2Ss5dv1IWrcUd34vyU41fK2QfGRhzITbKwyYNoWu168d/w1P3lwIIjySy
	7RbFhfgB8egaRNU2k2bpUqccj4VVzSiWlQC5Ef8GJF9piXlrBvltYbCbBSdiWTEmGFmJyQjrCQh
	PrD52WYYwoX0dhwhqoRGGmCUwGd69Su2X8J8jXT77wQp4A2Ym4C0KVBkiGz2ZMGVB5UFjBi6bCh
	C8/htZJZsAs3f5lp0BRqWbzvpo1fZ6gNseZcGfldtOtReeZOWDa+bg4Gzx7wbFZGhiiQAO6nG9z
	Eb/RVm3EMaRMyy3puw0dkxJ/yV0/PnH+x5FWAsFChs59Jx+cR0zzHxi7zHEiZHEUT7fJRxTTY/B
	4KZAwEr5OEb85XHSazTxgpE1vR/GCWzlzhIW2uTHRgGqfCZ9Dwt79g0sdu7CPVv4oZrIsSQiLCZ
	+ed1ArNXCnEMxuoJ53LA/JDufK
X-Google-Smtp-Source: AGHT+IGAAaIfYcNk/0b+CqB/okfr3Kt5I1umurANJhCZd0GSsJXOQY/FZMSG1zdoibZ0Rj0jvdzhfQ==
X-Received: by 2002:a05:6122:45aa:b0:54c:da0:f711 with SMTP id 71dfb90a1353d-554b8bec72cmr3594124e0c.7.1760045399448;
        Thu, 09 Oct 2025 14:29:59 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7f01e3fsm211224e0c.7.2025.10.09.14.29.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:29:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 08/13] iso.rst: Add documentation for PAST/rebind
Date: Thu,  9 Oct 2025 17:29:26 -0400
Message-ID: <20251009212931.445719-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009212931.445719-1-luiz.dentz@gmail.com>
References: <20251009212931.445719-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This documents how to use PAST procedures by doing bind on already
connected socket.
---
 doc/iso.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/iso.rst b/doc/iso.rst
index 2ad9c73e4eb8..4d315132f911 100644
--- a/doc/iso.rst
+++ b/doc/iso.rst
@@ -125,6 +125,26 @@ Broadcast Sink (Receiver) example:
     /* Bind to Broadcaster address */
     bind(iso_socket, (struct sockaddr *)addr, addr_len);
 
+Broadcast Source (Broadcaster) or Broadcast Sink (Receiver) Periodic
+Advertising Sync Transfer (PAST):
+
+.. code-block::
+
+    struct sockaddr_iso *addr;
+    size_t addr_len;
+
+    addr_len = sizeof(*addr) + sizeof(*addr->iso_bc);
+
+    memset(addr, 0, addr_len);
+    addr->iso_family = AF_BLUETOOTH;
+
+    /* Set destination address to PAST destination address */
+    bacpy(&addr->iso_bc->bc_bdaddr, (void *) bdaddr);
+    addr->iso_bc->bc_bdaddr_type = bdaddr_type;
+
+    /* Rebind already connected socket to PAST address */
+    bind(iso_socket, (struct sockaddr *)addr, addr_len);
+
 SOCKET OPTIONS (SOL_BLUETOOTH)
 ==============================
 
-- 
2.51.0

