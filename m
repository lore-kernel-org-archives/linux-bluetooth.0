Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687382C11EA
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474067; cv=none; b=CApfRMGAWAJVM9gcJtAZ4FxoDU/mx7htZGMfC2D+J42H09wld8zKowecgI/J8iRUt0EG9vamloRsUp062KIlY4HP4p79I3sMydcxlpSehcNepxOuJf0mGbhamZ+mFUvCLXaC/XJ2GLS1jMYcfIxlVJ+4VlOmAL+JgtsD3x9rmhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474067; c=relaxed/simple;
	bh=dxKRR5Oct9OvsapPKQ8CB/sGKQzOTBjWbqT44dtrars=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j63U3i2HZZpn3wzkh18+wWG8F8MgQKaQQYifzCE9+MxBXbc63HkX9UIS+MpcK6CyW4EhkOTpG2quhG3Rpo0rXivZatRfCTfKnLyjHEbN+eIzv4b7byW5yhfxDYsKgdrsa8r7pj0aH6vPlr5/r0X8iNHX5CQW+LutnoelJ3b3OaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj7M3AE2; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj7M3AE2"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-54aa30f4093so1949008e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 13:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760474064; x=1761078864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doJ7U7lzUHIr7jQNVm67JsaWry9+16XGOO/Jng0d4n4=;
        b=Wj7M3AE2x5w90amsqJ3VgEuj3oXAtFdRliMD6zcjDoc/4zKNmlxIZZZw4kWM5cxkLa
         ygCHHytN0cetxd5CRMG9TF/uZgpiBPOKhx+TmG9gWO3o/f4KjoScDVIkJaa8GYMDgFl+
         8liAotQ0ZfT99WYX0LCoeE47x1lvBzqbYYO3f9ijKXiOEFJwhAeyiY7hIcdE4h1xVnDo
         muSs9dtRxV7Y6rxZkrtgdSJ56uwQAi2GFyqzA0yDVctEsu857t7EwQ/ldUwWZGFv5G2z
         nZsxX7ptsTaNTSnqaYz2Ee/4ifZ26X/iYY0vr4gNU2NM8O3Rez1teuHpgmEBiywC4Ue7
         4A0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760474064; x=1761078864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doJ7U7lzUHIr7jQNVm67JsaWry9+16XGOO/Jng0d4n4=;
        b=RKnmShMgM770WaBwmj0gqP0BX3rX73nnbh86rtMS/VqBV/ACzRKslBMPw6H1Jp0nA6
         ejAsvqkUrxpVYCoBCHwAGwYynWjqcsbarwaMLjdWedZThTsq2iULHZ4j2xEXww5kOrzB
         R4j9chj9T2rVcgWiSINU6qj21c4vctZ77czR9aR6JmJb6MnqrJKlrWiPiBgD1ddm7ee5
         n29Z3S2KEDCEuEUx1k+DR6mJo7z+4yxkkXnml+p6mtkKFtlAWJNtmX7xEmB3GewLd7Uo
         JpKkwlASVt22+EA/9VXVNbVuAH4aoG6HKXn61oXg3PE024GR71rG4HfqhKR1VRLzEpZP
         qRtA==
X-Gm-Message-State: AOJu0YxGa1wvRYTrzO75JfoQOtjH2MGsWoAUlslEsWsB4GPDeoHON77u
	iW8VP1syYnQpbQilcTLjTgOYO+5lSf/cetoG4PGdFBq+9l86JZmSs6z3VUHrf1zD
X-Gm-Gg: ASbGncuX+Tl9iYj6rDmTNwItHmY1lJP6YuWcJLMCPcfTOtGLF5eFFD6NEgmwwVc6rga
	FQ2OwExcZqpdA3VJQ+amQO5GbtZfdGzIi+I8hU5DISdyQF+WB4YcmngBz+Lwjw+WN4XGRHH+Hsg
	LwG2s3wU+q8Frl/39Nx/r3IProYIz9ymHshv2Fc5AL+lqucVhZVmJKvmu9Nili587GPd+nhcMns
	1UxbMGiOLGsTryqoc6IfSvTxdaPKdZ2bFXOGYjV9oZAqKWkfUKWf1WnXgHS6wkBOJ+T5HzyJDqK
	Iok2SZ/ipujEZoHJueZKoTNW94MucUwEVZtsu9GaJ5yyc6aPrJQXDv0hL90lA4w1Lyh2LtL1zMW
	KkXLMLkS1aVIZuW4Nn9GtdcgWoL/nrZduzYc8RjLAvgY2
X-Google-Smtp-Source: AGHT+IF9IyyTDbiHLS3L4HJ74gbKf5lDR8G1xDcD5MyRQvSwZj4yv3naOeokGrJIXxOunMsPS1DeuQ==
X-Received: by 2002:a05:6122:c95:b0:54a:a569:9564 with SMTP id 71dfb90a1353d-554b8ab6630mr8661200e0c.6.1760474064550;
        Tue, 14 Oct 2025 13:34:24 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80a456csm4434116e0c.14.2025.10.14.13.34.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:34:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 6/6] iso.rst: Add documentation for PAST/rebind
Date: Tue, 14 Oct 2025 16:34:00 -0400
Message-ID: <20251014203400.453454-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014203400.453454-1-luiz.dentz@gmail.com>
References: <20251014203400.453454-1-luiz.dentz@gmail.com>
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

