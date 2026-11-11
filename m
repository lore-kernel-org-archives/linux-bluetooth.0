Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429477;
	b=T1uuq5YckR7TYAUUs1Eq8gt/KJcrNteyAtyJ66pYD/BXWtorHp0wtbth2LRq4+/6brXk
	 +cpAY75E7U6htDryKdCAPk89mDN95SRRiEmBkcjaaTpyO4qWl1KUI4PNZuVGCfeZO85G5
	 yrSleB4lPIIkeDfXNdihuogZ7xMPlULdF6yf4920XvTTsQHz/XHnylPPdOeubV+6cBeyP
	 EyI3/+TtTqP+E6210qkC0Ul7G1IMi04kYhmldJWt8qyrYKvl6hI5zA4H9j9GjuHQuR70H
	 EhpKfRSb+tgDoJv+B81bNKmDED8tkMYvdJk3DxrUz40UY8R6FztXNdtserWwKRLi3iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
	b=FchezTeNAySed9LKO0LMfPrbNdqNtKZzaFARQFyAuUaRXaPzgAZe+SG0zxjxcenYiAzA
	 FLXzIgio98UQNG1jgsyKHK77OVu3sXd57UgyuyQ3/xz6HAGozw0k+OvkeJrUkC+E7WjJu
	 RAvWOtHf2GHOa4Q8RIez40v1qGqLne5Z5uewgHv3s6KpPQ1siiJi93t/Q0iFAIKZpsjyf
	 VuVvu3S4LqbPBFmDKnfszZI4HS0yKc12QedPzpyrL5dnkS4kYy5xHqfkYmL7Z4CLc5GS6
	 4W5ynJSsCT2A5RaVUza6ENqRgORRWf7Ek2S8ZiyNnPtPvqrLceJY3shGMBJ9dzhyhpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AqehAnBM;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877D360A2620
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 877D360A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AqehAnBM
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-99a5710ec0dso565215241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429476; x=1795034276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
        b=AqehAnBMij8GjQYM5oCxFDICYUqrYUc8dAxcffsUggx3DpPJ3WJD+iLqdX7Ic0g8/D
         szouy8EDqdsxlBiX2OcTR/nA57wXXzVnf8hjYqijAR9L/p4Ve9D7wqcWrVTWL0/FYF9N
         Zg3NbvRAvDAs45o0qaiqz4RiSOpqkrEP9Qb14HCgBZc3+njvdUMOd0d88hiMpCyNrVQz
         eQMM/0UgRGZBvZWga21HRcttkWpLfpmv75SkNpTqDICklfX11rupna+zHE8o2SIRxWMn
         ED64TSKmjTM3hO39KbZpVMqz6phML0YuB++xsDb/S7l7C3rD4LQvWY2Ik1r4Kzj14oCj
         i0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429476; x=1795034276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
        b=ZzwWnanVKxSNMsVW6CfiJWVqH8YrDes/0Lyrlw4FmA1A0KsPj378PjylDfrJKPrsZh
         FV83UaWhupBf8aw4+8zjeJfN3ZjMn1WpDW85WG21/5xaoHAovWBdc5AYBG/TnB6jL0OP
         z6aUPIihyKKDzxrGpMTkRZxRRjdJjsfJCHCP2ZyW4bWe3GiTQ6BnVaUzyNSTyVurlqO+
         c4P3oO0skJnpPyMjRrw28/nS34UbIyry43vwCBdq1uOOTOvnI06oxoBxubz6AJOCiqJ6
         beqVVilpteHUAx1TbWWiWWhZNjVr2SDJ2KmZFCfwq0/M4Bljgt6d1epBRQBrJIknXIta
         1Jqw==
X-Gm-Message-State: APuU4Z9A5LMZXfgaNPfveqYhuPaN3e7f9Sb1imcp82J+NW5XbgI11R3O
	4DGhkWunxj6R8xrERwc5+8v4MDk/J1lDroiFVb9ioLJdNXvUWclgm9CorpGcWQ==
X-Gm-Gg: AYBFou3NIXiHE9FFq47OJcd/Z7TbWya6JjpGrFxmYofRyzHPhJTemEVQOd+vmefzUR0
	5GGVQ8KxF35LfOzSHnX3LebDOZ2h7ow/F/xQVo6qBS4V/YCBpGCFmVBsJE8p2aBN2U8OMAvaE51
	1ekVJ4IfIPCw18qcvKLmvwjbWWHNvtDqfwXHMzPZrOrl8fggw1AUQED1jVSOEqxHMtLvRfdvRmZ
	L1YKXJichjMMyuduJgkxr9YNjFZWFmaX70FD2k62ANVn2CTOGq/17Id8J5+xUK9ZArWnvx2BBt3
	kluNyr7LJD8o1LSgdVPMJuRGFumOx2U/XvuB0AIZ453QaA+cXbTaB15DrJqE6+SkuKOF18w546/
	7yZ10EWDM5KjWHOKh3CP/U7t03X7C4+1u1c8cqPFCeXpoWmpiR0ftYsxrJ/uHeMuTForfwvVbr8
	9j8EShvhkU2dtUNJE0IwyfVJC08/n5cZWJ3KIXjdVKsnUzc1dZxDycsiNT/j7FQ41DQhyHZnQuO
	KDjdp4zYa/OLpoa4JPJOX1e9udHWqO+tvL0nRBgSKefBI8YB/48QkDOOP584DTjOcbnZJ4eeSft
	Eh95icmrpwWTR8DUNvgXh0kswEdtqCXLo/fbiYDwMFgiAkKquSRRkiRPHEehLH1NbFYISA7uT9Y
	7vO299mj+CTO1qZVmiqlqUB8BOYmR6RPzvRVKtA8+Of1sDHxmokOS2pOCvj9aMuUjVtO94bU513
	TD3Ys=
X-Received: by 2002:a05:6102:3ec3:b0:7d2:7be1:272b with SMTP id ada2fe7eead31-7d50615b505mr1454975137.28.1794429476524;
        Wed, 11 Nov 2026 12:37:56 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 6/6] test: functional: Cover clearing a cached configuration
Date: Wed, 11 Nov 2026 15:37:33 -0500
Message-ID: <13748578ddb6cfd5de0f49a06af0205a0601db0d.1794428234.git.luiz.von.dentz@intel.com>
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

