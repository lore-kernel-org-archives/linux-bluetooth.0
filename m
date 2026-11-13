Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587889;
	b=iL7GF6sATwMv1D0CGPMNAqa1tSuJb4uIDNUEcJvy+JIZloEjhojvEiS504ffWHuqzMd1
	 9P2csqMkaCB9WbyIfc7xxzXXCL+pggnCiCT1tHzyq08lfz3XykZVGPpReLb6xKq5rjhta
	 JC9WF7QIAehIZwE4V2BeRFB2kjOgzuBIyEUi2kBcT6PxsFSmIPVp54htJHqLAA3QQ8V+q
	 dbazb8GGJFLLkWnnkGNZ7YheijOVo+b8M79ZCHb9YnrwtAwsmAScnkFbG2Jd/ke0ZfEe0
	 s5vTFYjj8j2KHSAYPiygjhnhBNFQJlE1Cv3RKoyHDxxoqLZ9OORWQ/jyyYxtQU1+txQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
	b=ntQeWHBUJmzhIE0uHCbDC4jB/gx208B5g+VF2UAKV4wqlO718lj6ce2Js8+ONQbNKn0R
	 U1EQrAQMLP1GEvUsNEdux3HSBwzpm7W/ifwFaC4RcH/3T9bFeCBL+nToYcf4i+tyfhk4X
	 Rv2an1/G3RK051xhsD/lWdjp/PaEj7YF4cqk2K+KchcKQXxhtPxjfsut3MdoA8foTuhLl
	 gLYzz3VfYZgikcm7cgIywPt4rDZUgVmao7L1IQs7XJnJI0B0nXCvr4zDZLeMnXYe9KDVn
	 hMCfx9oB+Gh1Cd6nmDx0sbsjyArWYsbzEBc6U+WzB2UifPq1ZTBlE4XbitTfA23usvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GL8n5JCy;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B175F606A323
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B175F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GL8n5JCy
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-99be509f943so320485241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 08:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794587887; x=1795192687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
        b=GL8n5JCyOzD9BBnJuxRkt8+pbqFq1HRVD11r+JqWrzJ4hVgipAxDZ9HtarTM13iJl3
         KY/rfBjfhV3C5Cptcq7mKUyhz7weuIHe167yO8s/pmCoDA5DyQhNw4cJ8d49wDZE3abp
         iRIh7htLaq2UQTni76xUzsfMpP9zCLIkv/0dXFsMJaYwzO0TWiqIdj4D/pw3TvPuBWK0
         jB01IJ/EwS2ibkTVVv0WAImR7hmw1oadh8oGACkk80j7l+Lw2REtQeF1l5xX0930qadk
         7djfqnk/UCT2NRwNnCDid7yCcztLulRlCxNOWT1VcekMRcZogzqKLsoc9zUNa9eRt13v
         53hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587887; x=1795192687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
        b=cIr5itZ1/XwWI6HzOhx6ejR73fzCghzn7mahYAlixcREwzsY/loubpBay96kGIOiKe
         mYIiAOlNdXaj5GURr5Wvr3pynUeFOYAovjinHkvbQyPgQyMZamqY27IzogyYwcRaPrhN
         QVPBzFA/9LpfVz1GKQlDmhZc92g8OpyXI62Zf1gUiHLM/f9ydgy5yDIFAyTeqxL+HpQv
         UPUdubh8ZLB7kuyyBQDzYtjwBagN8wTY1ojTLy+8t/MFhSNZgKm4TTYCKtza+xOOcE1p
         nfveVOGPFZa/nHcAK6hPIwTZuW8SiUYbu8FQKnRreVZSkGdIgwYV4B7Sbm9jRnpx7gYv
         P04Q==
X-Gm-Message-State: APuU4Z9dgyEruTGNhmnQ/fRS/gQMmjPbUxwoM+4stmdmCe55BWAepuh1
	jNrTkXd6/aITLHLnRgfeqRlYNNH/QSw0rVsiQSQKEfF5wtjjBYfmxSmMzeAW7Qia2Pw=
X-Gm-Gg: AYBFou2whlmTNTNQo3Wgmtu0EbNqqCZLOhgG+iZynjyII2KJjxrhKqODNpZF4qhomR4
	FPPcH98jP/+8auSgbGrF23ob37n2PSatXOqbb8pc4lHfEPHXBdXklI/Xh8dZkuqT+mrkFcvDeUw
	Zq52XLfW75LiFnOYIJzaCnrhSeBJx7mFylIYfGF9ftbWultTDyI2zuh31GW8BMvo4EdZeraiLZG
	PJ1SbHRIW6QYRpwsXa7sjFoO1AQx5Vi0tlK3Ha0jYXuimYgKo3vL5kF6mxqunY8deBx/L6zNRMm
	s5pri/sjkCpUw+61yLkzAKBfVmSgZReTSWP/46P/W4Y/mtqhd7a0hQHrEXSqF/Y3sbOC2nsKvr7
	CCBn37sSCQnhPZe5fIqmNu0cKb9h+3pjCtPi+qrr5AZzJvtz88cyC5mK7+QOM55HsoVaEduKNHF
	kHO1vRFeAAOPluliY5ixXjX/NceJGJZTEgUfId9ZQsj5zMc+KtP2SiaSFlAg2eMp5FYqdi5w/Nq
	C2MQA0PCFO0uie6DBgFATU9MmfPSBQzkzS/1Wfl54NPSU5//zWb8Bg+LlGooqZhLzREO/LlW6/u
	4wzCyBvUnIApX2UMPAflOW2UYDcxY9nWnutChcLwHeyXzNiq2pH8a6ShymrP8ixscke9cEeYwJP
	W7NaAHOtqjaXSpRRHtem4VPoB+Aknf6hf76EVUaOslruY8N+m6Wrp42LYW5ChYt8+lcNc8bZmdi
	T8nU9kIKhLA2wDBm5tlYX9m69p
X-Received: by 2002:a05:6102:83d9:b0:7d0:6cf3:d8f2 with SMTP id ada2fe7eead31-7d64d77b815mr776770137.20.1794587887380;
        Fri, 13 Nov 2026 08:38:07 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c842ac652sm1746701241.10.2026.11.13.08.38.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:38:06 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 6/6] test: functional: Cover clearing a cached configuration
Date: Fri, 13 Nov 2026 11:37:58 -0500
Message-ID: <9e7ffacaf02c96b673965682f0433380dbad86e4.1794586887.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794586887.git.luiz.von.dentz@intel.com>
References: <cover.1794586887.git.luiz.von.dentz@intel.com>
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

