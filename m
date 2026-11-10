Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349178;
	b=q6askzC9lAILjm6qg+NBrHDpwL48fVH0pF6H6af6auN5SBu0jjHfWRumd54zhHol6U8m
	 QXF7m8fMT1OW8/RDNyWbQ/yQhtHOgzXzHve04FutNS1G2PAroLlcwKaIOPLhsP0T3sC6o
	 b1wjqtWXyEkgzpTm6X4wJ3K8oN06KtJ8h3MLS/Bqv1rGWX5d5/o5KePkMYHALTnXZjIL3
	 eOaCGqkFQO7nYPzJ6VAUfU5kVBcUWU1orAsLYqCdf9wscyaBK7B05qPalfaYpF8yJp1h5
	 XsNLM8Wjm5GIV3MVBJYh/QAZxTq9cq4ZphhQv5E3C3CTBoFgT5K1U9XxqPwmEjZktyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y7tpnFce4GX5SpYT8cVXdDC5JhckczvpoB16GQlqxEs=;
	b=aH4zUN5e7dSriWejrM9SW7Xx1E63OCa7O4DAdTPRk5QiUAWsi0ydYxj42K96mwTCyt3c
	 sFieofKH941W1AI5LAUt9FXcCh5VklGxOx7ZdTjBuGULIUn/UpeLFngIKJXKec/u/zgxQ
	 7+OOaNtveQlhaGIlmuuQD2LcNx+IHwdNqs3RoQ7P18dEn120siM5RlSITiwxb/SzlFPnZ
	 w+0jIrkRO6R5lEBNyGBMFa8gwK3+ujh1zGtg+p+Vf4+P0cJUiDVfcTZjGZBrd3CnoYp/8
	 JIkeuTcr2/zbRHTBK58pGwUrlDPEIG4plxgaip9VMhZTs66ADdc2wWKHieWqmx23cTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FgxdRAwy;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4423C606A320
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4423C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FgxdRAwy
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eaefe5b523so1681518e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349177; x=1794953977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y7tpnFce4GX5SpYT8cVXdDC5JhckczvpoB16GQlqxEs=;
        b=FgxdRAwy5psRSn6EuWbODuuLTAhTsUnu3YEZpMjlVs8njVZ3infPh+n8DmyS7Zz6Js
         T6+3n+VqJN6WfpP25UuxKmqTEyfZAev8iJN7/ndkGU8xf8SBeEn+liEG2f7BPY2sAxmL
         09W0FtBUlhWrUcSE+4JlC1VTvuG72WpO4b+G3NA3Nu5AenBa9BdtFJVEKObYIhZ0zvrU
         aGV4FNB6//wYgC2zVFB71EHos6a+4ozOuw9AN2l+3z/oBY8G9Y/zl+0/k8YX14qd0ZF6
         TzxhIccvx+3AT2F+3RE12hgAkNdsTS9L1VcV7+D6RH2l+hoZIEASVNbXZpt34HD+5OLj
         7aQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349177; x=1794953977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y7tpnFce4GX5SpYT8cVXdDC5JhckczvpoB16GQlqxEs=;
        b=PsSVO6EPW9cLniJ2aB2C5ApGm11KCQqL9CrUXWwDDUNAL6Bxe33NYFBoPP8AZwm3mc
         HusRAaAe7Q9hEhfgmLYV5FdkVcPMFYq725B8CoBFP7PdV05yLISiR5zckb86qmLItHEn
         iQ5937X0+5/hYxI4J7TFIbKmb5UwGTi8LWWDpnFsjmXw2LDCf4MihE7EktrO/H340E+Q
         707W2qchS+wg/yWpqdOIoEwT1LXVxvILVlu2zV53tHiuF81uP1FFIt9moLMO+lrwRR9+
         9ntq/r+uLCm7lqWHbw2rTA3zXyROCweuSdUQ1wDTsGfXNe0Hr59cn7Egp2FFRndrGlgV
         D0aA==
X-Gm-Message-State: APuU4Z8UluVZ0ft+efLw+C//07V4rr03bOiSw5SCitKs+77DLLTBwR+O
	ZFSCJBw4jWF+Lt5y+FTgPZDSg8nyfEM4WU7WLXRjanjE2We+Fg2OUzx9oDg87g==
X-Gm-Gg: AYBFou2eyp0AI9GQX48J0HJScItPF1ZD1YxaxV2rOVxi2hTQ4fbza5DNXOnw1v1E5F7
	/jTEwxgqZ7TThX5tXlFPrZFHXho/ziBHXjJyjA5DmaT64lFrmJp5zi0dfzgf05XvHDhiWQDGdZg
	fLQpaodmwdi1ka+kbsyCWN5XBAnWtR4tjYnRHVsTZr1bm3GSt9OzM0A+ljvaMsjTqPYZ//AP6B2
	8Leyp+TNOUaBesBrJgpA/oaY2hwAYtDSrjrZXVO1xDDx5qORbd4MUa+Ky/i3iohcvv3MPza+2hJ
	UkvcUyWMl5VpCnDugUjU26H1q1hWY7XhY8u8kClz47d7lgYSzZpFp7wSugUfnl0pydJS7eWtAsV
	ZRVk0yEHw2fESAgSnhkcknss5QBhDM6UPNZxNa6EqfmXP86mxrukkI7oP7V0TYutyncdXiCO/7u
	wjfGrF6lWDTHmkc2wy/M/fSjOZh5Cjd7FeDT79waOzPOsiqjRz1TrceUdpfd+glTu8BZSFkz3o0
	1bIn3hmvqTSERaMH1nlNPntWXSqNgLeI9fgQ87nNA9dEzkwgE4mAYBPIlIzkSV3oM6R1wHaK6bR
	M5Z2/409lQ/bltw8v/cqFn/dfzYxRJaGyw2PkU3xXqAwEnFTzGbrdgUhDpn/4fPTK+gOwnhzIKE
	j23xG0SNIjcEaFnaOJq1Ga3lEjaHtmKdw0dMaBJqo2tFEvSJ0ugn99p5Qd+F4VYI+6GAMiAjxYE
	1e7ZU=
X-Received: by 2002:a05:6123:110:b0:5ee:19bb:f8ad with SMTP id 71dfb90a1353d-5ee1c427773mr133449e0c.17.1794349177137;
        Tue, 10 Nov 2026 14:19:37 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/8] doc/functional-bap: Document disabling one ASE of a shared owner
Date: Tue, 10 Nov 2026 17:19:14 -0500
Message-ID: <1e077d5b0c04600ac6ec91ff45a3b3b97f0c7187.1794349049.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794349049.git.luiz.von.dentz@intel.com>
References: <cover.1794349049.git.luiz.von.dentz@intel.com>
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
index 8f3f8e62cd4a..453458feff4d 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -306,6 +306,39 @@ test_bap_unicast_duplex_switch
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

