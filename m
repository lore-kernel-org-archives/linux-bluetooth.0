Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429483;
	b=H7ePwY6BjQKTmlsIEFybOvwGW9LnPtv5sVqxLAV9VZmp3wqZTFw11RngmzPHQRArIVlj
	 XW5ftxZmvcvi2gDLZfb4HbwiKg2MNi1mlAfbrtIfOcRrnApNtQC1ZM8Oz4ADvPEt2RO+p
	 FhrP0eIImeo1Zf6j2/XGnuC7EsbBtIviCu6i286wjys/I2pMQjRmuekxiekzDCkYjbNt1
	 G6HpqhcldUhm9IC+pAGZNMwu1jahIk37jWHIafoKC+NyEDxZyFqUGSCdoCZNMBprlBpek
	 4zw6nlcCL6GoPD2P4siIz/JDeJwC9Wy+0QcYoOt5RpMkrhs0cBKvuOq7V5sFA+Eapqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+FrtUNhjFOkRGO1jsR0OM2G6zkJ5LXPkExN1RsSj9sM=;
	b=n7sEuKS1ThgKPlEVsSVaENwd6zRdKWlXdCsmC579yAC0+oCaf/Gb76lSXQJNuYE98XKK
	 mTpSKPNNuTgv66hUiZYsUHOQar9R7JPhIPHdwGfcbOrXbVCrq8npy8pBZF4bahPJd0xOT
	 Cq7744Un4VzFvwXvgvYisf7+f82PbHW3hmH4gkyuCcKJQ92/2htmcUYYZGKBGH32WMVtX
	 yo+tlsMb/ZI1JLSOXDh5tkUwYyvhOMygYpTsrH4XwSWqW/DoRn3nsMd2QThkf9ol2Fnc+
	 KjH/rxSQxssoo0i4W7xmMuxWyuVt69DW31rWif8KvSs4NhXBGrunq68XNRK0U9lUodA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YMEUl4tW;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1A260A2639
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE1A260A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YMEUl4tW
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7cc1cf48a39so1389315137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429481; x=1795034281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+FrtUNhjFOkRGO1jsR0OM2G6zkJ5LXPkExN1RsSj9sM=;
        b=YMEUl4tWqLOQzMh5XnTt6B5xDuXGxCrcVFeKL4kx63eEa/vVMouu6dAyRkXi7pszTP
         IXA009locL7lp5UFdcrB2utbz9E1Pd8ycjAnMvx5HML/H4jjLGKMi84wkCLaqsQT3STv
         6ChXICj5LU/aorVv5nH++4aOAS268ytQZ3XYsjZ9dFZzxuxggzuBNY3vgw9zIj7QUGWo
         vtPCD1hkdiPGN6NTy3+BqeRAhZKn0fKaGsE3YBGddJ7FK6it8GjDFcsxsVS0gGrDD9mI
         zw0wSm9eEWgSibKA9ci2bv7gRV1dQI6S4KG9bA36yE56wRyB2f6e5Z3Tnx0KiAw+bpmq
         Nfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429481; x=1795034281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+FrtUNhjFOkRGO1jsR0OM2G6zkJ5LXPkExN1RsSj9sM=;
        b=emP46Db+M647bj6QPjDCK6/4QTQRzmpJZsfrkMiIbEUSzPZ8eUCeliLhCagR8zbRC3
         HHD1wtw6heb1Kk46iNJrPLeD5bkNYre3Dqaahb3jBsm9Yw1DhJd+C0bPuCML3eD1Y0wT
         YaApt0RBrlhpnNGzI2QkinTsD6UarDoZcRpNsFB9VOMjPB2+iP7/QN5xzqT16u2p6U3o
         5yvSEmU38TNKEi7/GC1P4uqhPcmDgIXQXSuDJ8Ni5ATPxvKSDaK4xloe+ZxPrNUSGi7F
         QhtufmBwoKfYkf2SkZjD+EeaE6z3u+4mXGFVMu2tjepLiau/AnTQQHzq1p4iMS+T2yNq
         npVg==
X-Gm-Message-State: APuU4Z+yCHZUMYhnWmgCNKNsNXQZd/Xjbre1tZJAWgBrlvuyVc3wBf43
	72BV2CuhLfbhR2kxm3ZhbLXObSLXxDLeFjof42VSpTohQnLd5d/vWBL5lUF57g==
X-Gm-Gg: AYBFou2cslz6uiig9/zwd3yC1PZC1xcEe3VQQoMSYDtmRc5OoIzUmEV0LaAMChNKz14
	HS/xvWN5h2GDtG1/p+ZwdVaQ3tgDJ6YHBrgFd1GmnL9Am3qbWJVqBghhkjPKnZc+/dewwyFJHNx
	3pGkus1AOuMVgFkMsKhNimFadcZU1ryHNaLYlyfTGDR4L4nRbta40lqUI6UlXRfANGTtdpOwwwX
	U80JegD3UKe8Sg4CEcT84auMr75PZuLUnKKSldVMaM8kl3WJn1vr/LGf3DZ0SkGRv+cUF2wlRaa
	LmwwEFE26y1qQILMbiGmbH6WGBbKal+LYq8iKmT9Ha/RFTWp7F6XpZiL+IOE8EzCGDlCLVrE0st
	X4cAwGCyG2VqWyo0z56uKh0Q7vM8n2MZJD2Rq/upPJQOrPufe6ndeGQkPAqZDilVWjY78yOlR4D
	3pvRPxxN6Ek6QM6Bvs7P98DnPftMJYbVGqDvw5G+cRzRnXy68WJS9vCSQ5XWHhryFZaXHxfponi
	8/mdoRlO6mdSZRuQhbWdilvmXZQT/65Ji2KZ0ziKbkmusny9sYjBYT4OZl3qD/PDZs5LGR13oif
	iAB1sfZ3W3wsfRViiVWV6dLryM8Q9DXWVuEfhA5lt7m5hkfhL/KJxoSE6DYA7vVc57GnGScyY+f
	FLoHvjKGvjAEn5t9LE3gKD52TFxid6ZFR7hkoepkpL7znkh1nCZBUPnbNDmeZARiitNnv53lDEO
	aHicE=
X-Received: by 2002:a05:6102:4410:b0:7d2:75bf:2fd6 with SMTP id ada2fe7eead31-7d4fb292f75mr1298885137.18.1794429481456;
        Wed, 11 Nov 2026 12:38:01 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.38.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:38:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/8] doc/functional-bap: Document disabling one ASE of a shared owner
Date: Wed, 11 Nov 2026 15:37:39 -0500
Message-ID: <9b4196abbefc8e5284c6b48ed457a695f1d457c2.1794428234.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794428234.git.luiz.von.dentz@intel.com>
References: <cover.1794428234.git.luiz.von.dentz@intel.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Describe the test where the audio server of the acceptor acquires one
transport of a bidirectional CIS, its link sharing the owner, and the
initiator then disables only the Source ASE.

Assisted-by: Claude:claude-opus-5-5
---
 doc/functional-bap.rst | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 5bbae3817062..ca8e1ed14e2c 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -313,6 +313,39 @@ test_bap_unicast_duplex_switch
 	seen by the controller of the acceptor, recorded with `btmon`,
 	rather than by the states of the transports.
 
+test_bap_unicast_duplex_disable_one
+-----------------------------------
+
+:Setup: As above, with both transports created and linked.
+
+:Steps:
+	1. Initiator: ``transport.acquire <source transport>``, without
+	   desynchronizing, so both ASEs are enabled together.
+	2. Initiator: ``transport.desync <source transport> on``, then
+	   ``transport.release <source transport>``.
+	3. Acceptor: ``transport.show <sink transport>``.
+
+:Expected:
+	1. ``Acquire successful: fd <fd> MTU <read>:<write>`` on both hosts,
+	   and both transports of the acceptor move to ``State: active``:
+	   `bluetoothctl` acquires one of them as an audio server would,
+	   and its link shares the owner.
+	2. ``Release successful``, and the transport of the Source ASE moves
+	   to ``State: idle`` on both hosts.
+	3. The transport of the Sink ASE is still ``State: active``.
+
+:Notes: Reproduces a remote initiator, e.g. a phone ending a call,
+	disabling the Source ASE of a headset while the Sink ASE keeps
+	receiving media. The transport of the Source ASE leaving streaming
+	used to take the owner, and so the state, of its link with it: the
+	audio server stopped the stream of the Sink ASE, which kept
+	receiving data, and acquired it again on its next update.
+
+	The initiator has to acquire the transport without having set
+	``Desynchronized``, as that is what makes the acceptor share the
+	owner between the two transports, and set it only to disable the
+	ASEs one at a time.
+
 BROADCAST
 =========
 
-- 
2.56.0

