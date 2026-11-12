Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515621;
	b=fNUw9ljz5pFEApgcRLqWPNE2oBK0oj9Xd+YFlX8unme2L7a0qoLfliJV5Cxxvaw5a7zt
	 o8tca2+emUh5McrBC7KHlLkdnjYHiL4/pWT4W9B/1TYCHA4RZJn1oxqvrviDI/MgWHBkL
	 GYRK1eejLveXLHKBcpIHri5IrxzGf1biu9mOGr2Q2ZLaiDuPe5GB7epwW6JokP/ZuvS7m
	 so550AYj4uW3KgEPI6xPsF0v/jFXeQWirUSL111PoaSWavxqaR258on2ylqVzWyLptY4d
	 8GpSTODHOqBvxk4a7hXv28QmdVsKv4dxo+zG/S42DtJrUY4Abg8OqXufj1eMFCzyZ2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
	b=d81soEv8LTW/czzxv1s/0kZS/6yxWq57oW9kPLr7yh0M7VSvgCo0s7G3VV1Rqf3ZDAvl
	 CdoFS9F4AnYnxVqnSTjzzQ65Z/HMlmkWyCB6f9AVH0cm/qbASIBXN7ih/gqYBscsQfMeo
	 Gi36iF/W8if/Npbz57gIYEier/hEIK7g5wsOOHGR1pSN//7TKUdm+3CnI0ndyZXpBm4zI
	 rzAIJvdTKNk3KYxwydwrP8LbQ/McfJMTrJ4lBZwCXTvzPN6dbo47ed5KDvuXEUtUiQdsa
	 ygwSaLjvCt77MtL4C4F6SuXJOQWgxKxnkDZ2bh9nfgW3WQaC/BD+3ECNPlT68uRZG9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wtBJqKOz;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB156606A882
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB156606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wtBJqKOz
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7d2d18f1bf5so155195137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 12:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515620; x=1795120420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
        b=wtBJqKOzx/0b+aM7ABfBwgXq9Y7mgvPU8P798PnNSDmDkx6b/OshX47jEdpp0XfdSF
         OvoKU+rrWVOBiDum2RQxzRV2Ypva5MhyKEDSIR1c+adEt3TAMs88GO5ZYnGEc8bblteI
         2PeOzVas2KiNjdzRhmAh/IP9MnpPvdqKoG3/nYmSGoZA5K+VNwIyQgX0y70GxNtNllDx
         HQ3NzbwxcE6Tn32ZB6qZ/s5jy4+cKS1Alh4SXnorIs7QC3a68hvJtBl2qRKyCKKbat/M
         ZYWDB3pSmpRQdw2i3x8us7BGEhDJjBGx9RAoTn/alMwINnc9t8GRWAY+EJh9ku7qRX80
         xvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515620; x=1795120420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
        b=Wd8tyNg9m4VfLW3US0p6iPrEb5+/RxBczQv4rkohDW+KTySgNAaa+aQ4rvpHvwEtVU
         zzqBSOsymEjOx+ilqm24/3MMPl8WOBj5qQhTgQAmbaIkO7cRj8tlxX+BJRVLai71Pi8r
         zVidrK5Zbl7XKBdACuApVcZWaFJRQWjYOdJQ2+fVok6uag/HPdWjjCH8iK0oBXmqBIyH
         CUqH+sqUoz+ST0+X+nX7AVaSofCKRqb6+3tg1jh6+H+x1Vg6naR3xt36vgV77gR6gV/x
         M4UiXoW9fcUvqZfbzHafVhSYT55ckDyTGkx8+rBj03+aE3fVHQ13hfj4qC1kXGRNyxYo
         CEwg==
X-Gm-Message-State: APuU4Z9Kr3b00mJ9w6NsxGN2RP2n+6WvzIAVAtnbNMsikEBAPQ11FfOP
	RTwPGZf6H7Az3kx5NBapya5/s3KxSVUB9r44RFxDfq/ZU3hMMbFfDbfU7+8ViQ==
X-Gm-Gg: AYBFou3LSt/bpirDcS7OpfnJaWB/Gf6RDT95zDjjYCNtpv9lh6FPsWB4IpbJHIgZ6s/
	GGzZEJjmFd+dtdW9P4my6XGmKDLWcxlxiSHFJ5tO7gexVIdL4wSGmvLAU0FFBvugoryw9C5BPx1
	F9y6kxzijKBpGHhtxgtkris9FpJpwOcXBcwqtluIA0TRK3ptB+qZyrAyvE/h1a+OwtUVEUpxZ+5
	onlYBcF4ZWCcg5JDIRssEbDsotU7JlISz7tnJA3NVOOsLh3BumiWnqBXHqtiC8jYGIAPz9GeyOI
	ixQLJQnr9A847EEJR6CVrvNjXXWi7J5spUgLqO3eqv8rkU1rPrDwpzlD3NqAp7Nnf2J3la7zZE6
	6BISyPbR4ndTMWRqn4zVnOgq+ykAZm4eF8vzQZajZj/7vmmRoUasp1cc5m/19403z75h6AKCNSE
	MhRMgTRyh5sMFMXVnwKsWBxWQ/UcmSUNAVs4aSMKi3UXjuO964eQRpPhysAEKIYK87AMMdww4Xe
	3o7MqlY9poQVCe34B47rOmjDudY0cAoEOll2+jHejWmpPn+Hr0CKtOuQcx9wLEpMYA5aWw1WPPY
	gfJHvVvGbuxCjzOlxyLkanT3M3q0MxFP15ERsbsHZDm0aiobYI610VnTFgopmKuuvCeyT0Kixp+
	ArGYuDpLcAx9fNnIx+ip9nb4cmRLhMst/7JD6cwIkw9OsiHP+otTNaZzmpvZx6rTIrvaTR6YfoM
	FQ+fEpI7zVEPfs8B9WyuSuDGXL
X-Received: by 2002:a05:6102:94d:b0:7cc:2cef:b330 with SMTP id ada2fe7eead31-7d64d6ea31fmr148277137.12.1794515619792;
        Thu, 12 Nov 2026 12:33:39 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c842ac652sm346627241.10.2026.11.12.12.33.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:33:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 6/6] test: functional: Cover clearing a cached configuration
Date: Thu, 12 Nov 2026 15:33:32 -0500
Message-ID: <f0682dffbf9c7705726f28babb16a03fefaa922a.1794515475.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794515475.git.luiz.von.dentz@intel.com>
References: <cover.1794515475.git.luiz.von.dentz@intel.com>
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

