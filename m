Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414350;
	b=SBBTBffH4Ok/YPDF+aV768FrV9guJlMJJLVhoTBld/0RnIOyaSPUHEtBpjBmsJ7+Xr5o
	 57lPBy8VnUQNYz3RAn1htvU6RNSKwBxcYYIcsIW9naSUATFlbI+oljOhq8Np4Ayr5f95k
	 RUL7upLoLl8GxwkVYmJDe9+YQcoRvpRTbKLwOvOphPLRmRaVYnweHi7nqWW8o3ZaV4M8d
	 JmSmy9mDnYd4agh6yyHkI2sL9WU3vUfI+bNJrztDqyqj4CMiRnnZTcwow9fDquo4U7AJ7
	 uhensbLpgM/PIEtJOf3cVoWmmKI+mNTrF2HnKMbaJJJv3OeprqJma6AO+aJgWX5u5sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
	b=MB2965dS7Scov/b/+fAUbd04vUA8rx9UDU1pqEdOR9JVbMPlLQRoBPAk4UIPoDSK6HYw
	 GVHC1ZWXofWBS4FZd5Ni5m/ovUcJsqduVhd5wxKSH8WFzG+hVBCZ7L35cQG8kGlLpTD6h
	 SrEFui5ygPUFHyxV5Ka2ePDF8TBUCA9DXV1Bxs/oyoqxIaN4++cku5QqCDpwqlS8zo8Bb
	 oUFNrSbgIhJCLut+zEJYaslzQWnRQXMNztm0icluxBiXWjYecVZU7liJ3vK+IpP5PbXwu
	 LaotkCTw4OJmfzIsTXqbMXwtFQ+b10DgviN1op2C33DdzgnEN9xy3leRnhYpTafu98Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TKTE5ZVf;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA08F606A88D
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA08F606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TKTE5ZVf
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9851592ada1so889141241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414349; x=1795019149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
        b=TKTE5ZVfd2/bJvetbELrmmc6vyhAg1WcmtgHjfwtZ/kGvpmvciFoihHcAK0C1U4QSj
         XwwPZvgrcDKpPeZrw4UbvNR1p6afRer/V8hHxILAutGyqYfhhO0omDY+PI1ICTzEvuh4
         D8AWNtX3z8ALzZlKbcwpaEaIF1AArUlDtmyasTbNdkd1C7XCWL5wKGC65SKwApUQ/mgd
         LJLpvvXfPP9ZR1AaqrSybanWJYVuNCufudxVEmJBnq0ggUpbBYyWKe9I8LnH4wg5e32S
         vOBkg3dcSpV2SmVjdflURPIOnqxZZHBnswJPVYqR/3K7g3EQ9jV3XgOaLo+sXWuP+UGb
         +duA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414349; x=1795019149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
        b=BAo7xqY34yNmWj2rcMxpmxcyueY5zvMHFcoctz2GHmZSF9dfagygwl5cDiAkCl0NDq
         lqMcoV0yKw3ESRfQd0ZJ1kYfiG4fVSvd2Dr71ZyZadJ3rN6/iha4ZnQH6r6SMYLAiTYL
         rW1dJSfn0ZEw+Rt7QOohCt8Fzanskv6pIllIE7V4ObX8RObtBOBUH0X9muj88uidXW5p
         qxNvMK52+KoX0h+yLapq5i6M9cKQLoT8uc3INd0bilEhMHW/g9yJewcNsOnpDSBrL2M7
         g9cVIEeelL9yO4YpxlvHxfm1VUxFCPvhqtZM3xXgwTtAdjf2jE7BzfHxSr8ihpqVqWWM
         R4mw==
X-Gm-Message-State: APuU4Z+TTp9qwJt38wFnjjKLMpQB1hGzTVv15rVayksyc04PD6MuntaS
	7fOEHoQBa8Vf90KR3OX1VmM3bcd4AZAEFU4jLU7Qph5ovBmBWl+6q2Iz/IEEEg==
X-Gm-Gg: AYBFou00z2CDGsIBaZmz9ztirxU+R6+ANtMoS+1ZW+aL5wY3W7VmhNUohHj4FIqSaTf
	zAYVPIdGSD4u9XdcXh8+at+iZfMZP57SrYzEHKQwhKJPD7OelsEKbqj5LylRmVVUtbiH/F60GfC
	wTx3DO8KZn2CUskWsUcdjkb4BRuqKsSDsX6Hr96yoYzqzb6FLLjS3SenYcMmQmd3Iy+wCvAcEaA
	mbb3G84Q+5++llPZrwV7IgFsDVFFaB0GNbwNV5IAhwwrXswzGSkh04UpO0prRE3rtatqaq0msQT
	yVyBzl7qclYEPjQC+gZ8mCSOm1gDZsojZQMwhGibAgZ34/ym63GPciQYid/jDsIGQnDXdsZeK0S
	zm+KEvVWvJsAbP0rsXgZExKEYMLQWjZJuPhX68YJoWpU6z7y5yIWUZ0+HaCYFziGf64bEhLc/se
	rOBdHjiyJnJQ7W03VoABKWeg8sgWcLdHInZAOMjRp7txOHYfjbS/hrkkwmq5YczHPXsIGnu2Z8N
	Vu5Rd8c3AbSg1rb8ECNN3sZtiClGqkpGwSXyaWil1xKXyBdp1R6tVjehQ0viSHP7xJsmi4Xk1rf
	kJB+Jmygrdy9wld5Vf4uXfLNa9AH2F9FCv9YoNGGYeLSn5c5FyXkQAHnzre4Gh+2SFygGw2Owdh
	yt1vQWutmQ0CMmR1WnikoqoPbFjUf7FXTCk+sz4unKDVP8DpCvSoK9hfzgzJ8xc+hPiMgQpObUv
	QQFhI=
X-Received: by 2002:a05:6102:3f44:b0:7d0:3ed0:c61d with SMTP id ada2fe7eead31-7d4edd08a5dmr934483137.2.1794414348551;
        Wed, 11 Nov 2026 08:25:48 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:47 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/6] test: functional: Cover clearing a cached configuration
Date: Wed, 11 Nov 2026 11:25:22 -0500
Message-ID: <885e7c0aac5e5743d4da7a183793e7ea7fa1bb8b.1794413813.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794413813.git.luiz.von.dentz@intel.com>
References: <cover.1794413813.git.luiz.von.dentz@intel.com>
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

Have the initiator clear its remote PAC Source endpoint twice, and
check that the acceptor removes the transport of the Source ASE once
released again from Codec Configured, leaving the Sink ASE alone.

Assisted-by: Claude:claude-opus-5-5
---
 test/functional/test_bap.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index 324304204caf..02f203b68667 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -698,6 +698,29 @@ def test_bap_unicast_desync(duplex_hosts):
     expect_all(initiator, [ACQUIRED, f"Transport {to_sink} State: active"])
 
 
+@duplex_host_config
+def test_bap_unicast_clear_cached(duplex_hosts):
+    initiator, acceptor, to_sink, from_source, sink, source = duplex_hosts
+
+    # Releasing the Source ASE removes the transport of the initiator,
+    # while the acceptor may cache the codec configuration of the ASE
+    remote = from_source.rsplit("/", 1)[0]
+    initiator.send(f"endpoint.clear {remote}\n")
+    expect_all(
+        initiator, [rf"DEL[^\]]*\] Transport {from_source}", "Configuration cleared"]
+    )
+
+    # Clearing it again releases the ASE from Codec Configured, so the
+    # acceptor does not keep it configured
+    initiator.send(f"endpoint.clear {remote}\n")
+    expect_all(initiator, ["Configuration cleared"])
+    expect_all(acceptor, [rf"DEL[^\]]*\] Transport {source}"])
+
+    # The other direction is left alone
+    assert show_state(acceptor, sink) == "idle"
+    assert show_state(initiator, to_sink) == "idle"
+
+
 @duplex_host_config
 def test_bap_unicast_duplex_enable_one(duplex_hosts):
     initiator, acceptor, to_sink, from_source, sink, source = duplex_hosts
-- 
2.56.0

