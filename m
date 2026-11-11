Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414357;
	b=EVTi5HXUSwe5YrCM1SaT2sCrspskdmdO1PpmSECvx2/D6iR1MNEyPbtXmsvedD1i8CEn
	 uQu9yddMqsi/CCVnfpa1HaZE+AVJXK2dwvmLaadbK/EKjl1F2fKXguT/K6qqavLTT2YOS
	 chcZUOu6u8bxPcGD/C1v80yLOD6+iznpZc+lzIuwddeC98lTGu2ipBL702+13ey8Li2km
	 3bCelvhK2YsrlCILnT0nRFDmb2ZEUKRsZ398uV5xVyEoXVrdu6XHQM8pHVMc/V1djg1cE
	 OAZUt5zFQQrWPmSFGjcPE2yTyoXQ9ZjQUrBaEiouIg2/F1IVgklDSXt6Ylotd7zeddA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vcPsqZTsKjA650KAhNuOyoT8omvFwcB+Bve7nXe/LBE=;
	b=D1uf6r2yOKkT8Vgx8Bpm5LbHN+MkKSwhigwkQefL1yBoh7Z7dzj5fBTFEuFGM/eox/RK
	 WM8N6wLq3KRx6x+NtmrFOm90GRcNBsjKc/SEDjE0Im7MrnxC775UQbOBZ/l/+i5ULtlgk
	 JAecZz+XJ1l4FP2PhAZjm9/0Q46/3KrxJ0X1um6rAV9byrcjnhwZXTIC2DokhEIpLYw//
	 hoH+8LYWAg2XZJdN16Z5kDLMtORdhFQCmHLYASS0kZg2Qz/Mnro7wPLrxm5jLBNCZGsfR
	 qCPCXwdXGfgvmQ+RwYOjiO0q0cPCSoT18t15GSf7CQ5e2foZ1tNKUrCZdGz9XYR9njQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wbDAKA96;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B48606A898
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55B48606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wbDAKA96
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so2441948e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414356; x=1795019156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vcPsqZTsKjA650KAhNuOyoT8omvFwcB+Bve7nXe/LBE=;
        b=wbDAKA969mB71m8PeOeNKWjp5cw3kMTncNcmPo3pjJMWBqGLkjppUykEQq8/oQ5HqO
         no3VuQlbUhEIcoyhFDQrr3MyWAGC3aBBPSHOINuBB2aqAfCx/zCa8oHFfQ3MV53y84PV
         /pQzZCYqi8JpKD3E1Zf3TpIsLPele5dbMyPirMPBC7347GOiuXKnWXwSWjShSo3Yr06N
         QTHkGrvLubBufLLofUhbvAxPDcgpEGI2/tPAZ6x5BfYaG4dRfS/tkqIRqtLtc+XGRWtq
         WLvi9LNa3OetJfRWvCLLCllS/b/RIKObz3/Pnl9BWMgHeeYFAfPEgdMaNkRtOFbuYLBc
         0niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414356; x=1795019156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vcPsqZTsKjA650KAhNuOyoT8omvFwcB+Bve7nXe/LBE=;
        b=MALX+fQeWo4gNco6ekYRzfuvHhhVuGc8J5WWE7Uh+UmSrwVBJV6z24GKWhGn4+3/di
         wjMMoV3+2LFAnhFYIIyKswRE1pufDUTvAxSjNizGfAjcyjsHqlNixYoF8Tn80hW9/Wtk
         JXLzzC6VyqkW/K/JCyr1QxAyMUuIkZUQooIyvy+x5qRGmBqE4U17oYFZKSIiH9df4Swt
         WXcrL9UHtYAss0eWVyqB9J1oIvBFujDp7IpsZqYmJXF7kTTYTJhDyyDV/uXJqjaONXki
         QCwlRMOThSBoqrV2ECLMhF9pdeUUq98pyYNLcCv8a1UFdVTIe+MnLMV4Z0QF4dG5Vr5o
         CBOQ==
X-Gm-Message-State: APuU4Z8hJrGKOG720r8gIxgcMvrKGDSUGyiPhTO4vgeKVSbhTW1K1y9e
	Zv0rTlPX4yQVSwarFtbuG+v13d4mXVpQo3Z0w7MBiXxWFOuVmRAEePRgEGV8+w==
X-Gm-Gg: AYBFou2KZ8EZk7NVxp3vQMqv4usGc0CyZU+RbIdFMzrh1Y/vOG2ZOn+KywNXc+Nwe55
	WDd7CH4A3ZK4WI7//BQGp0MAfORN4gUrx4tznWsrOF7ZmwLOjEQ/9A0Zh6DU++PI0+oyYQBYC5U
	PqyeytHpeHXiSZJj6oimci6KvKigA0Pnpw2GfxHliIgbx23+izN9v/0Ni4H8SqAFkVTW7mbtTtc
	zzBwg8RYJB1CKXSVc6P40Ghp/hBduC+fJUqulquENh9T2LL4meBViLr6Dkve/oXvQn1UJMpt9Ww
	sxn8iKzxgwXEaxX1SCSIqszAleGI0NYM30iBhniXiRN/xlguuauHHLwdi6cD18N4zaH/OxyNJ2+
	sbuVtKqWTSMreUmPW2cR8mWUtbnc1qq6KHoAJaVi7WTr2+PkY9XKWDmV/v0mP5kX9Nlyw8ASj85
	4jM8KA8GbWSIipTHjSu9WiBkSfda0Gtly/XOpRdvMOCdEAJCZQ3aYNIPBT1GkLEhyNKpSKfc2pJ
	sgS8bWbt/0teMFZpQ9IWl2BYI6TDf1x17yjgEXlyKcdJki4uA/fROXRAwcnfd2z/Pve8IDJpRP6
	8H0LOOKmPm+XoR/kTwG31zQKBBwkj/OTPyAcselIZ0fXbbA9kfyJzKqQ3hO+L4PzTTnqLTwoxhb
	pweyNCpeNmN3mtQw09yuOINhHNezbNB5eXGy1ytcCRXDO1Ss0MZoAWs5Zr4QT/ENyjyR2U3Idf5
	ZDV9c=
X-Received: by 2002:a05:6122:20a8:b0:5ea:be1b:1b24 with SMTP id 71dfb90a1353d-5ee1c42fdbemr1037811e0c.13.1794414356287;
        Wed, 11 Nov 2026 08:25:56 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:55 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/8] test: functional: Cover disabling one ASE of a shared owner
Date: Wed, 11 Nov 2026 11:25:29 -0500
Message-ID: <3a94b646ac88732881fee81691d270c9e0d1553a.1794414122.git.luiz.von.dentz@intel.com>
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
index 56205a61e61d..b76417824f97 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -801,6 +801,40 @@ def test_bap_unicast_duplex_switch(duplex_hosts, acceptor_cis_count):
     expect_all(acceptor, [ACQUIRED, f"Transport {source} State: active"])
 
 
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

