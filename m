Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414360;
	b=yWoVlAEn8T7AToRRNIV3PFvX6Ip6cgeCxfjsuGoRm5Ipbrwcq256EQ7m9xP7AbjrHfZ6
	 mEh1/2WV5a613TXWiifPD47zHquhB2GTeEeKJp2omcYNnz1LojMX4J542K0pXvpSdqZWs
	 ++KXlE47s2Bulwpb13rXAkYMOxo/f4XI5NiswtQLAtrASNf8M1gkK2uzVpIIOVK1knBGp
	 1YF6ZrdJSOzyiJikhr5sObM9C+Rt2GHUNfNmkzA3mUBAMSekD1RDoHnsDIjlU9I8PEPQO
	 GvOz4UgoDMXdXDQ7DRb2AH/HWFX+wzTqbWYQaF4Nd4y8PhLYxUByJ9UCktZ8l40xD7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GrNUL9HFZkLleOC9oF8yCYsOhg7Mi/i76jQlCkpLLN0=;
	b=Knse+86nCCBTYM5V/CYKoMKz4IJdDkhxcnLRR2aHf3ZqOib8yIDrIkw8OD97eQpcO05f
	 mN+umBHz0QcaughrUgEESW4mO249omMK+y+vpenjGOX38G0rgvZaSyIRd++Pnqe7ZKwA3
	 49vYZzRMUeAaTwmdYZpD6eNR101HMBMkCOAg3PKgdPVK9LI832TVJGqFQ2sRkGEfU2Gkw
	 Gs0DV7oQ2/l+ZlWuo6gcBMO0cpB8D+A+XhMWxGarKjA/WB9JwAme9DhtqZyl+7K1BnRu8
	 MKAZL+kxdIqv/uqHlsze6X788emMhJSQSRDElKEs11UDFtu4/J6Nhxg6Gb+63+JC1tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IbxHUl0B;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E87606A333
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2E87606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IbxHUl0B
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-990703f817fso1562267241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414359; x=1795019159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GrNUL9HFZkLleOC9oF8yCYsOhg7Mi/i76jQlCkpLLN0=;
        b=IbxHUl0Bppftvg6Rh+QXDYvc+EtsKeaCFSxEzJgaGewI0QQle+Ub68e5LrcXD/fTcI
         TEPfEb1uSOTMTVG9GdUQorEylnr7sWnZAeICHale1QVLV90VbrQ8WBQc8//BQtrCKwRW
         +GHOymR1XqLQ0FKeb6YqN0TCxsZg/y8q1nRBxbXV2pLCdG5smlRWUdAEDHtT2OWNs4pZ
         gUhIDB8x9cahz6UAiqwaqw3n6EzA4h2EkUC2u/8hKGMajjqyuMiT496bA1LZbu6JBkPG
         JRJSn4AY4B2PKL0Lt2deYu2pcb2+ZTUp9wHyR+tQgj4JSWhKIyeOvAmWDtZ1Gg9XIaF7
         r8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414359; x=1795019159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GrNUL9HFZkLleOC9oF8yCYsOhg7Mi/i76jQlCkpLLN0=;
        b=2yk6ixsQZh3AHgkIzsPL5dYhYl0ABeBurSxFnIk8m83ZsXjtpqz/f6CHHskc2xhSfI
         k3rPNUueY64KOMDqv46xK5o7uouez5pmqdQsq6ENI+m6rHjar4Fnj/6uA3+J+8BMjiSz
         sM1BLkNJH9FImzYF9weaVfgfR7XxN71nZ8K0dWZyHatlq4DvS4SfDaFDlhOU4vj2GExl
         tHEw4AWzba2HC8a+0YOXBctfaA61tiV3klvla/fvIM+lf2A5nQkSlxMrjLz5RC9SJL1u
         mb2BD/D/ri84hu+6yjEfvvRvQ9xrIjGsx8m9MhW44VkqUAq5DLr1sKRNO1hIhb+sOhKr
         g4IQ==
X-Gm-Message-State: APuU4Z8VZ+JEKSdIOtJ+LEtQ3jY8iR5xyVk/8oRTeTl62lH7ikkQbqJ+
	QNZ/eLOyZtXxEU2Tnbhva1o4Pi7JLv3vkIjuI2zfaDJXzJPhUxKwLxeTINaJdA==
X-Gm-Gg: AYBFou1kOj6doatJmkniGcOMFMqiPFBiW35QhHQqqrYAHgzR17MWD3E3cRTgewSxTxc
	SbDbmvSUu91dYGU/VcRRzVm3kUR4o9aSZbpLjdx/euRO/ns4ulIlV/xVgDL/oeVtAcsfmutKTDE
	Y3LEJy8zOzGjFmkxPvWuHJg9L5cVkrYMBkFOnCvabBFrj+PQ9sqOZ81cE+1lk2yUCjAo3s+gcg5
	2odC7K3fu9v3Y4oBkx2x+CTrOdA8uJFk51Vkhn1S07gcqAGOzB1ZA7oV+/ohCT4Iu4CynmHLEwH
	K647umiiH79MAKrERlBB1DvaznL2YQ3zuHJHE36fyJoVrLGzrvVMmawh8DSNBWAgPy65aMPfa+t
	KP7uT6qnEL+Rl8Zexunixmqa4d7bqVFqvqjunUxp0bReBoOwW2ghcarx+d7eeuzdLXh9IRU0YSL
	DJAkXZi3Q+ff6ikfJTho8TvWZrRwGxZJ7KPcSSKQhpHbyafiB5qlSaN3IugLUTIS7h0p4BNINmj
	iLV9vZG9W5P+2qh9RpgfGlq2DYw0kryzMfzgdfxXpO+cOFB7oJeN6n5ZUJ96SzBNunZYKGgb3sf
	jJGtmu/3enalk8nL7KOxAAVxpPpFqpzp2JCNBy2zZEMikP9cSHWyyVDU9c403W2RYSVDic4MTjf
	8lBWQd3t+uCJWDIJPf0RQLxX+JM8MNjaePaH6woHsGbgubD/ByPs6Lr3lQ0CAhvkcpOkL9WRrNE
	lr07s=
X-Received: by 2002:a05:6102:441c:b0:7bc:dd88:add with SMTP id ada2fe7eead31-7d4fb3dc935mr1136144137.14.1794414358751;
        Wed, 11 Nov 2026 08:25:58 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 8/8] test: functional: Cover releasing a shared owner
Date: Wed, 11 Nov 2026 11:25:31 -0500
Message-ID: <bf8168c62fac6738dc7ca44dffbbcc31d8e474c3.1794414122.git.luiz.von.dentz@intel.com>
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

Have the initiator acquire the transport of the Sink ASE without
desynchronizing, so both ASEs are enabled together and bluetoothctl on
the acceptor acquires its transport, as an audio server would, its link
sharing the owner, then release it and check that both transports move
to idle.

Assisted-by: Claude:claude-opus-5-5
---
 test/functional/test_bap.py | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index b76417824f97..c382d1a9ad46 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -835,6 +835,38 @@ def test_bap_unicast_duplex_disable_one(duplex_hosts):
     assert state == "active", f"{sink} {state} while its ASE keeps streaming"
 
 
+@duplex_host_config
+def test_bap_unicast_duplex_release_shared(duplex_hosts):
+    initiator, acceptor, to_sink, from_source, sink, source = duplex_hosts
+
+    # Acquire the transport of the Sink ASE without desynchronizing, so both
+    # ASEs are enabled together and bluetoothctl on the acceptor, as an
+    # audio server would, acquires the Sink ASE transport, its link sharing
+    # the owner
+    initiator.send(f"transport.acquire {to_sink}\n")
+    expect_all(initiator, [ACQUIRED, f"Transport {to_sink} State: active"])
+    expect_all(
+        acceptor,
+        [
+            ACQUIRED,
+            f"Transport {source} State: active",
+            f"Transport {sink} State: active",
+        ],
+    )
+
+    # Release the transport it acquired: its link shares the owner, so it
+    # has to be released along with it
+    acceptor.send(f"transport.release {sink}\n")
+    expect_all(
+        acceptor,
+        [
+            "Release successful",
+            f"Transport {sink} State: idle",
+            f"Transport {source} State: idle",
+        ],
+    )
+
+
 # Broadcast code used by the broadcast scripts, see BCAST_CODE in
 # client/player.c
 BCAST_CODE = (
-- 
2.56.0

