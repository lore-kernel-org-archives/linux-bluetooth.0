Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414356;
	b=q1e2uxGyUT1+DcaQnt9+w4AXSCzxrciXFerIrVnmIkp5hQSWJV5FCfWTkvVPMpLKRZX4
	 AYAQcsoctSjL2FInBWOi7VPgxeF638VdeW2NTJ0dqkETsXL0wfS0ot+O8KpuKT+vV31ud
	 R9ULiHxHWFdduSdb3zSADqCB5vYcSP3u4g0fG24XlOuIWMStMgWrXBIIP2FhDYbLfjpKW
	 K9STX/+HX7MC8DbypRNHA4wUdTcLlwTUaJuXURp/tS7VqM1euXaEwYH06dTZK9wp4n3JG
	 9Ljsx+Q66EGQCvgnsZkZBv8tFoc+IW6Hufs1uTxJUHOdctm3k6qaIgR6ZZSMEUICM1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y7tpnFce4GX5SpYT8cVXdDC5JhckczvpoB16GQlqxEs=;
	b=cnveTUCP1GOQqXi2XXh3WrnCbIsIHQ55yvkNeSL2+xxfl+kwW3OvWzfVX51o2i18X5U6
	 XHgT/yEEpEIN6bTBb8dxPSRUOmbCmK6IqOFI8WQyJA3FU2AUqsRrO981d//GxL0KM3Zb9
	 rjatF/Ga6ccLzvN4RJE0Rsl24+7uIl5OI9SuEfAZ92Lp7lxTuwUIMSRSlKQF1MVBIBHJK
	 jOiwqaDEBIVJP4lcTHjoY6kvZ5/ydvJnfM5nReQgNnDOSpbKDvmkvIDAqJaYxGRdgl+xb
	 iv6wPiJb/SIdLERywCUg4YSbrCAHZDncYyYaPh+Q2lsy4W2w1xP3ZB7Nv8G56W4vuDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BKQ7heoz;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4622E606A330
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4622E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BKQ7heoz
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so1619172241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414355; x=1795019155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y7tpnFce4GX5SpYT8cVXdDC5JhckczvpoB16GQlqxEs=;
        b=BKQ7heozQ2Qq8Jh65aV9ONZRk5/QiDwo2ChoSymB8YEiimY7uuOGIqiA0bHJxFwQGT
         GGOYKikkla5IieU7pRVtWDIss7nfpm3Tqr0Fdy9c8sQKT6mG4ufyaXyaT4fbm93YaHUK
         dNtr5aZD24+FxlxDk2OZ9OATEGnaYcOKqDGhAUs9xMgiL8tUcYBgFxtviKMJ9veigyan
         oaugi2n4ahBcTrRIZw9U2+ZK2S3j/fb231k7EVI/DG9+G/69+jR/jtcrcBsZfp0ZJKNr
         rCs5fIls2fZSvfvclEsMCYg0lwgNfUz+V8PULdmwRn0QARM0aMTFcNNEDlpZ2eTIweyJ
         cyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414355; x=1795019155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y7tpnFce4GX5SpYT8cVXdDC5JhckczvpoB16GQlqxEs=;
        b=AJqpi8ZqXZsandCZVAtepWEjHcfUWyYdxM68Em6vTLYZoR0mUV/EbwAsb2LiTaGvJt
         c6zrOzuDwF8dw3FjU0OLY/dpOqxKSMJaSn0OWzdtKW22aFpE45YHgffLWQrXzqXCJ2VV
         jMrZsDMovJ57cicAqVC+IkjGVyH6H9N2/IuajhluuwCRUhLDlowxD2LLZPr4hNwGJ9l/
         3fqlJe+cRq0r019gjxEQ/dOitLw/vR3uhn/MVF0Dk5vBwP55j06tg6tYRMcI0/mq7DRQ
         fqnkfNSkNH3kz3lDW2SBvOnhPayi/BnBW7VkSNnAoolaOzddPiefGObJEfksEVVDyVF8
         sy8w==
X-Gm-Message-State: APuU4Z+vLT+ejfAWwSWXaDUFp52ypx1CjoQZr/89wCtY4eXMU5NvHTY9
	CZe7GVURG0NPtAA2/kaIz6KEQDNujFEzje9QfXm4H1ZYqoARbnO47brHOukOXw==
X-Gm-Gg: AYBFou1JHZKEsqBHz7owhjfBIUwjukAAJnm4X/0YhpHv5a1/uZrfbpPgaj1HPb5iDVM
	S/ItTefnqOx3TPSEiEmWHDFXuXh34K/eQqPSCmbnvRd2WL+hYewuF23G0Q1OOv10CpGqdNX1euN
	MydNNttrSlVm2hiIHwwcJdynGjuJ7jwqzlgZddq2O4Ep382QKNQBq90TC5qR7SQsz5ozClfINzp
	dOmlkB3r6Ki0MR3BhwQKT29aoHJXzEPiKSlaaGA/h6DYoHid3pn2cyy4MTN143OTwtgiczOj5j8
	kDSSZSHWO8bBZ4bC7E6eEAS4bplWEokmeI8dhhs7YHL747X9sHkVRNri3QNh7+0cjDTYxS5JBA/
	3m/BxC8j/aSyQ/q4ndtxvBQWj4rj4e0z/Qjqos+VbMNaQBD2gyQ3F5lMSXJmrUUDQl6oZybzXHq
	SWhBktiKBlF2LFy/GFD11Sj4HBVLb27Hvb7+ZsUjYt4GfiBE9qzTH+/yAC9JQKqXzmGccAtXk87
	GzpzG2en770epp4NpT+ZwAReMW/yZoeJrh0sOUhCPK8Xr1n9pmwT4vKOjJsH4PA79JQca6lwIkR
	LkD0oOn45Yxi/HPQvyGHGIjsdKV8ugo37sFpFH+la/zf1ZOxtfRic7rVTvAZPYOU+JTGvdpL2RT
	AkhfnxmHr6kVHWFIDX2QFhCdUfbQj1P3idnMtEwGPultPnmBStf5FtHzaRHVKU6OcpeqMe2+2V3
	sUYj62
X-Received: by 2002:a05:6122:2491:b0:5ec:d5e1:ee47 with SMTP id 71dfb90a1353d-5ee1c3f5eefmr1228115e0c.5.1794414355313;
        Wed, 11 Nov 2026 08:25:55 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:54 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/8] doc/functional-bap: Document disabling one ASE of a shared owner
Date: Wed, 11 Nov 2026 11:25:28 -0500
Message-ID: <6a4a1db90def89839c55db8832e4c4e897ee164f.1794414122.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794414122.git.luiz.von.dentz@intel.com>
References: <cover.1794414122.git.luiz.von.dentz@intel.com>
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

