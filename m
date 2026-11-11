Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414359;
	b=PDHB/WzCugfbf716OWhceQ3cczhmbvW4XawcMJwS9UzhVHhHOHrg6kQqi49oiDkcDd2W
	 Qfwk/v3l7m9hezoVz3/bGRIyhFNPYE9c4bybOFSsAdJHU5KER8GaQMd8dHkHHwLNVuJAk
	 LIeAdtLH43Gmi+upB7E4fVj1TnyoE/WZTH7dWZUCCtCGtmQ8lKLT5hs4vebM0X2S2f6tB
	 bGInmgMFgCnvj+TrFG5pQE1VSraPXbyi/PMdyrf+UqEFglGq2da37t45eiUMblhPEslth
	 Q2uLDwk+E2hPZvWOXMmp9cF4ObDooxbLakfr3HjkjdlbBdl6+UZEhU2iKnKivbPqL5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DyHJgA4QUlv27BrIaycarYSRXQktkTDJ0oSpKfy2Acw=;
	b=1h3Px+lFZnE3cIERVmixeVnPAer268dgJVYaUvYkeWx+0Y73rGLAdlB3N/STKSiy/WAa
	 twSIhDAdum8hbR2yv3DDHWkHAlxzCM1YTrTrut3PvhSBgYsRinCfcEaZjk+j7x9MtMY5e
	 LgiccsCDSYE6UkTNmNsFCWWl63mAjK+lTIuwPPUaktgsynnm1PwxQrP/IiDRrt94PwfgW
	 BeoyN0eV+uy6b/OCmeFZg+yzKud/GdHgFSTpZmQrsKVDePVC7EgM01DShrJk6bBwPMEq4
	 4eLPt0FUDbBAdMM07eV57+P3OmxAycTRuaXmAIqEEoL1YhseCbLQzO+zYNGze3o7aZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S6VuPdm9;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95B0606A333
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A95B0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S6VuPdm9
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cc603a168fso1297265137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414358; x=1795019158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DyHJgA4QUlv27BrIaycarYSRXQktkTDJ0oSpKfy2Acw=;
        b=S6VuPdm9v+kVOeG7RvfKFzTcfTGQbXbwAkfruLW2jnuDnaebYOpZtfORP3i+UNZNUD
         7WQjroqUi24VtvHGzbG4EVb7wfN89hiTNijQneYcrdHPsE/AHC0WKOQM5yXm6qkU2x7r
         hxT5ia0pL5tcaP7sw5OUi9eShXh1u6S3SnymMGzg/Pq5/pbTvbrR0ClLLPSguVID0xTj
         jIYZZXHq8KM0YU841ZJQ1G2ilfMjVvrWR7GAVM08999SXb9FGQWGtFJV3raZQ0CXsnfN
         L+umOjBpBlg+qvMgw0mjmHuXuozArZ2SxVfK8JCqlTyPBHbQySim2AN6dzf2rsPtYvmG
         0+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414358; x=1795019158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DyHJgA4QUlv27BrIaycarYSRXQktkTDJ0oSpKfy2Acw=;
        b=XjxL3M9nYP5wAkmroHJIcIMkY5zAMwoC9dagcl4raKQX9uqwMKpYQPKgHDyYpkjI+c
         GG0wVK/ChQ4hOFqXkAGcOJAdqmtWNNFAS7RApbzS9dkCZGyBGqylj/OJ1bhg6Cr8RTW0
         peClmFNpQYF42PtLgfW8FgWPBDfTUN6HXRZC42ZY1cxXriJMNYgGviF91c26Yq889Cgm
         XDpl2XTYygVNLcMgXto8oKJ8LRbylE3TP9+h6padvwk6nxxdpZz1/eqMozWo0LpiZuHP
         jF8wPjmWcZP7T9hM31Fymk6btb0UclYsYApNlNbxYtws6ofcNrruXxEYo+E4FUQrvS6g
         nFcg==
X-Gm-Message-State: APuU4Z/gQup4mtK+tQ67Cx/5gjgmnVuknrkzqK5mRqDjUa0pJheYtWHW
	lYvQBSAhXthuWAToDbC7pzF+2GkHn07THephAfB/OrtzsUAZfAYpPFw5xja0dw==
X-Gm-Gg: AYBFou07lwEN7/PQJZaIhD+ZmP8NaXsYk7goBAveIx+jH+Z6SkLnay2JYgfkQ/PR7mI
	iDjObt1z/m6/SCjO5EoOjSoavxAJ/Gr5Xh26Od4d1hf/FU+eRn8IGR0sVPizuinHVyxHSkGasm4
	rQOJOcEdfxz2ibiAPsqVrTO3K248aq+CopY0NRrTKsWU1la1yCGlP+DktOyR3sot/ohiIKs52if
	QfqlkxD/IlPTA5MM2dyzL7yZcCQqBo+KUlnufFVIPYPNLz8JvKEiLjv/Mm2rZ1k4fP/hWdJBwGe
	mMeTQfsY/ACNDZA3KmEW3bxSmYIOma+uspRqxkKL7Bide8FE1aXkZhJput/dBsuNxZkUjkbGTYT
	NNtSA/cb8+t6xQS92tfcr/gsmR2sgvuZgCsH8Cf2Coif+w4sKpfea5GXNfhIuwlC7F/gI0Nr3U/
	jf0SwdlbPkIUSH+qQNltEHL04msOXOpD5lAUqqv6zdx00b6BkvkG3LQaXwsKmDLYXGoUCDiq2ga
	5QuHXIqRZ5IOWI30DUEc/WbgThvgJJ0/PdYTjKfZSTkSeNKmsMl9406g6PvpIIw04TY2maZr0Aa
	ADyGLsuDCBcN2Z/rv9QL6FsP2K2HzA7+U8b55urg3BQmaFIQ2V8fsJzWIqO6uYM8Hz7fZOXuWXO
	E+YjFfSAXeaDkfj1tSs1BBf6sCFMlkdmvt9+58j3C2GJ/70qnDILR57QTciS56HnbIxAT38tcuU
	2t+wdeO6v6QBgVJiRM9njkATN7
X-Received: by 2002:a05:6102:418c:b0:7c1:5862:a97c with SMTP id ada2fe7eead31-7d506225c92mr844462137.37.1794414357538;
        Wed, 11 Nov 2026 08:25:57 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 7/8] doc/functional-bap: Document releasing a shared owner
Date: Wed, 11 Nov 2026 11:25:30 -0500
Message-ID: <d79360b296c5bfa9615360e529a25492de22efc4.1794414122.git.luiz.von.dentz@intel.com>
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

Describe the test where the audio server of the acceptor releases the
transport it acquired, whose link shares the owner.

Assisted-by: Claude:claude-opus-5-5
---
 doc/functional-bap.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 453458feff4d..7dbbb7eb39e2 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -339,6 +339,31 @@ test_bap_unicast_duplex_disable_one
 	owner between the two transports, and set it only to disable the
 	ASEs one at a time.
 
+test_bap_unicast_duplex_release_shared
+--------------------------------------
+
+:Setup: As above, with both transports created and linked.
+
+:Steps:
+	1. Initiator: ``transport.acquire <sink transport>``, without
+	   desynchronizing, so both ASEs are enabled together.
+	2. Acceptor: ``transport.release <sink transport>``.
+
+:Expected:
+	1. ``Acquire successful: fd <fd> MTU <read>:<write>`` on both hosts,
+	   and both transports of the acceptor move to ``State: active``:
+	   `bluetoothctl` acquires the Sink ASE one as an audio server
+	   would, and its link shares the owner.
+	2. ``Release successful``, and both transports of the acceptor move
+	   to ``State: idle``.
+
+:Notes: The audio server releasing the transport it acquired has to
+	release the linked one with it, even though a transport leaving
+	streaming hands its owner over to a link that is still streaming
+	(see the previous test): a transport that is being released has its
+	owner removed by ``Release`` itself, so the link, which shares it,
+	has to follow, or it stays owned and never goes idle.
+
 BROADCAST
 =========
 
-- 
2.56.0

