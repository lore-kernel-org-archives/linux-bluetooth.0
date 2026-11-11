Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429484;
	b=g6AGul4zbYrdDy1+TDvouwLg+sqJoO6EjDaqZIs4iGYRQsEBy3SiymcFG41C6U0N8MBO
	 W4nehjXw4UjC70jPm1T550V10f/ZJQu0WYoSJQjBBPsgz7JDvcv4mQbwmTYl8G5hNPdc5
	 BS37FYDWXagPh1YbUJ8R5SJdC2/H93q9hOJxkvBEb1t8/c8DD2fDmaabi5/TsivlSo2DB
	 NkLU5JYMDOH7Cj2UYnBx53PVucXZb8g56ogcDpjKRqqQ012hK0Fz+f2L7WZcxRzI43zzH
	 SYhXKoDD8ff5mzzD9TCrLITcICpjZGVubTKr7oUa/Yj5kxIhPTfZZjkx4MleCx83low==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x4KsuKVHiuWjPoTc/slC6vGiZh06sSBcuIIm1+y7UDM=;
	b=T2LGeTJ1Cnj3ePyhaedenH42GqyWUCIhq6VyDID6UUAfcpaWK9hVlysjlm7Y9VZLrPhQ
	 7E8bKZYBzszHN0AxwfcFu0YgdMXBHvnYN9jo9IcA5co/5S+EXPM5+MqBI59zoGKvaeQrw
	 Fj6QP2AW4iYnDR729ESYgexCL6BLLQ7MJKUZyoOIfDDNET+ZDg+vbcNsBOKWH/C8HCpSt
	 dyI4lS6UaPF0h1U2W+cbTLIcGSbgvoin9gZcdWR8Oq1cj5Bjzc0spzw2WmbUWuwlsWEX6
	 GGadKF+tzIbvRw4HEsuR2KzVAWhpO2/+eh9qg097yit8eaiEYaMEf5fgMHVi/doMG+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bLFw6u0/";
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F760A2625
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB6F760A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bLFw6u0/
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7d2ee9e7093so1130291137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429483; x=1795034283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x4KsuKVHiuWjPoTc/slC6vGiZh06sSBcuIIm1+y7UDM=;
        b=bLFw6u0/GHTcv3gb+fi23oklFTBduKb2fdbQekR+mQdfZOGhPlQjMVWTeJS9vk+Ye/
         IkB7sas1aHVKWwGogBRT+tsVd3hqbZkznZdvheFhCnzAIl9lxa6uvpifsMvedUkNb/lZ
         hIbrvmM2XOFzW7plISlouBxuAYTWL7d9+y8+0GZIOmZ1g4Dw2RHh+4SajETNyNV5GW04
         SrFrE4Cd/5MxPVh7jQEOcfPm7rhirxBqXAqFbID10aIxYH8tW8Gb36bYR8Vkelj+PHgv
         Q+8JUUyB1rgpXGlkBairz3ESvGBZULnvNxLoV8Oo1W/mYvD4zFCZT2y3AFDb91l6a54L
         d9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429483; x=1795034283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=x4KsuKVHiuWjPoTc/slC6vGiZh06sSBcuIIm1+y7UDM=;
        b=Xy56xJXzBfPmsyuogRCNR21K7/0QLss6A2fDGRzAixAGNvIC9lpWjTafUVLpwhmM87
         B5/uPKXgrAwald7XLsAM/yy93yKNv5xwXCwj4XEUN35gxyrFs6V0fZkiAcy8xQIhasdl
         2Bms8HhlXM23RpEFc38yPjou8Hjxd9pYJqPlXMTSvE6DqMCHrdJeRH3lziM9UOcJ7XYs
         ytfMFUDnhyGm4SJk+nJhUZDdeI4IShLCUEdppzDLjC+jyER9uKIPwSAFOJjdBoKG7jyc
         NV6a10Uye3U727pO89R0aawUlbGvzBTguFA8ujpFBpDpXtIddf356Pq+r6le2vO/wI7z
         9dEQ==
X-Gm-Message-State: APuU4Z/soh6iuvS+h+vTyjV+RqwnbqiYHsfSYRr/f8r9TGb31F8tGJ9c
	E81JXEIaJYvooV1HAnFtgfp+JIsRIsl/RVKVxAKLsTYd7IhL+lwrcvu1QiitlQ==
X-Gm-Gg: AYBFou3LA5r4m3bpc9KSt5N5SgmLJh1BfXQwl+0whJC6FebBsuGemoqn8mipMTRHsGW
	y1zIensBSPucLkemdcrdJR8wXDTILV2eP1T13+e7qc3s9bSomr0B5cG1UGerZ35TTbQpGdUilUS
	NhsGM8RW6rAjSPTXtmicxU3ivOdPcJ4kYGEne8Q/NhtMDNfNKLQ2RFo5E2Y/p8KU2NqSUyRAn0J
	FcsBiuHaqPfVFCBTEYgc/ToqU4OsOwXS/NYi/rgpxjV1EjcSvd8wnu6h5DC267ccbobDyrm3tyF
	YRj4YwrSRz0Enwl5EpfHhBNx2mXCrqXxWiexQAQZUB6MeUvfAnT17/FexusaOpe6x+oeuUACCKx
	mgZDW0WbDRceG/kVRLGmdsQa7C3QPqd3n7bquvciMLMRL1rJk0j0yYstCWCGZIfhbdNJQV6jSse
	3vw1C8plu7qTrSkjWQaX3w8LHbA6CQmnW6idgLpNXO6dTWJJK1oghZF1T6yWTECcJ0qwbfbKPFN
	JvcqhoWHCN6RK08bYAJIb7aP+id15n9S/587WKIC/VEngCDUzoKncwhOIr+Lhr6owIMnCTaNdVj
	ElmsU3OkHiMlzbgaAx4R84nbn3bZL4dKUvUGoKurs7WIQrZvsxy4KvOyR88b9tocFeCI7n1QSlo
	NftieXx4AAMP5efqhxYg4Zaka50FHBv7hxQzL34aAtqUEhxg+tddh0XUqu1vqsG7egwV5eSCnmk
	nnXUKC4imGnBbHL8774iPzVbuz
X-Received: by 2002:a05:6102:3fa1:b0:7cc:56a:58da with SMTP id ada2fe7eead31-7d506157b1amr1418694137.23.1794429482835;
        Wed, 11 Nov 2026 12:38:02 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.38.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:38:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 6/8] test: functional: Cover disabling one ASE of a shared owner
Date: Wed, 11 Nov 2026 15:37:40 -0500
Message-ID: <40720115137c05aad4cdcb4c596c66516a97b963.1794428234.git.luiz.von.dentz@intel.com>
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

Have the initiator acquire the transport of the Source ASE without
desynchronizing, so both ASEs are enabled together and bluetoothctl on
the acceptor acquires one transport, as an audio server would, its link
sharing the owner. Then desynchronize and release the transport to
disable the Source ASE alone, as when a microphone is closed while media
keeps playing, and check that the transport of the Sink ASE stays
active, as its ASE keeps streaming.

Assisted-by: Claude:claude-opus-5-5
---
 test/functional/test_bap.py | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index 086fc8e44d23..13e969a4a845 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -819,6 +819,40 @@ def test_bap_unicast_duplex_switch(duplex_hosts, acceptor_cis_count):
     assert acceptor_cis_count() == 2, "CIS not requested again after teardown"
 
 
+@duplex_host_config
+def test_bap_unicast_duplex_disable_one(duplex_hosts):
+    initiator, acceptor, to_sink, from_source, sink, source = duplex_hosts
+
+    # Acquire the transport of the Source ASE without desynchronizing, so
+    # both ASEs are enabled together and bluetoothctl on the acceptor, as an
+    # audio server would, acquires one transport, whose link shares the
+    # owner
+    initiator.send(f"transport.acquire {from_source}\n")
+    expect_all(initiator, [ACQUIRED, f"Transport {from_source} State: active"])
+    expect_all(
+        acceptor,
+        [
+            ACQUIRED,
+            f"Transport {source} State: active",
+            f"Transport {sink} State: active",
+        ],
+    )
+
+    # Disable the Source ASE alone, as when a microphone is closed while
+    # media keeps playing
+    desync(initiator, to_sink, from_source)
+    initiator.send(f"transport.release {from_source}\n")
+    expect_all(
+        initiator, ["Release successful", f"Transport {from_source} State: idle"]
+    )
+    expect_all(acceptor, [f"Transport {source} State: idle"])
+
+    # The Sink ASE keeps streaming, so its transport has to stay active
+    time.sleep(2)
+    state = show_state(acceptor, sink)
+    assert state == "active", f"{sink} {state} while its ASE keeps streaming"
+
+
 # Broadcast code used by the broadcast scripts, see BCAST_CODE in
 # client/player.c
 BCAST_CODE = (
-- 
2.56.0

