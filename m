Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349165;
	b=3L0Gm03GqllCFQMlpgLkTomLVGKv5+0zDgrpO1bG3OsZzArEZO+TJ+np5MACSLxhyk9U
	 3rORYoqXlWNO7hKNyW6rAeAdcp5raBTq+1CFd3FWd/ufgZVWi6IFS1pXA5TZ/UXYhK9t4
	 X4EZSoOUjaPlfAcKHXQRxEhj2sjASxoIqYOHtgY5KRSGCgmu8nP/KuukUI1Rsdp14OzGv
	 s4rETWplyRKgZiQfqml0Wg7Ozu6WmRDTcsEXwxO1f4ZOSrYbndRlUbjDQAQlzy88ETAUW
	 VniAGedypswHNud93eBPtuRzIQD/qVnDJCJHj+utWUIEMD3HV46QgkrDNVmKdFHpuZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VQ9XIKkCNk3fozE5f1r68DOd14g401yrqdbfdhrwG8o=;
	b=YBLjoG0ohk3eSZDs6K9AZpTvqjL0frafRYAsXg6Ga9dEgxH2bRfZLO70TLLAAnQqAceV
	 eMigm31mPfTjtR0psrR97wTtPyQUGHYpKKnbaY3ipfvKRdeh044z5gq3R6SBtFXUFiAGv
	 4xkpDlM59Ycn48GBOSN1Y2bIP4NAnGtAj8Eo4mGcyfaGRITsNTfRqsSRhYeZVOjrfCOOM
	 sj+z2iZ5FulWftdIGknULP7WDXddcTo3fKyOgof3PiEgRH0AiwIlH/n4re9J9zx4Bcosi
	 f0lYu3q5lfPsFa50alYqt+EYATlKJjHLpzGO4f1ptgC5UiNpTbGTxDjla+HTUehHB+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WZubiiZS;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC89606A32A
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DC89606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WZubiiZS
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5ead5ff47caso860679e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349164; x=1794953964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VQ9XIKkCNk3fozE5f1r68DOd14g401yrqdbfdhrwG8o=;
        b=WZubiiZS6CKk1KnAW53gU7sHfR+yoHX64TgQT+pEmSCJWlBohE8udPgJBaHZiKDKOM
         5EwNRUIz7QQcRiKK3MdzIXkmRP96UXuHrvgXkfIIi8zh+28Di6KAYeM19cobOQCFB8YQ
         LVigAQjXE/mN+vWFvFlbWgJh6HHai09pAzgWEuFSfmC6k4ayDAS1pNBKRAkgZRn6Gits
         Uu0htJMg6wCiGgALWf1sk9/xj1Wcmsnoqk1OLGBU8GUYOyHqoZ0BgZYHFePUds82gQkT
         xI5bZYHu+pV8qkx7CVw4cjIRJjWy0lL27tVoGBBRBA07srAYCP84K0Z3NguKLEM41FuQ
         wz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349164; x=1794953964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VQ9XIKkCNk3fozE5f1r68DOd14g401yrqdbfdhrwG8o=;
        b=W1LHaIhewXxB0dnHnuSyIV4WudaT+pUgJDv0iju5WYLVX6M9dcigex4JK3ReBVZ82w
         MBjHdbBAvShfI57Eo1XwtdIEi4Qntb7kkCHro+rgzrIovsAYPghijSORv/iHwderH4gD
         ZjqAUabb08Sa/LbwSsJkcr7vbf8BKc5YIHknZTL8gGXGuQKpetk5TG/koz60H9X459Mh
         lgMakLAtiF47Y4tFV65beVqWlbcXE+h7tyhI8lksM4yxmil/Bqgb4Me30Xx8P2J5CZz9
         ctWQpJ5B9YrRzJdC/1cvFmMODsHSkCUUE6c4NfCpD/RY0x302hdmRxmLKCw5s56EHU4z
         a0Fg==
X-Gm-Message-State: APuU4Z8sKuyL8N0juo6UpvZQoC1O89o1q3kfYv1YX3eDKgeqSpeZwnYJ
	T/Ro36KtJO6tpjboza7PYOdmDWwKt/i+3lBXqZr6ANqgw2K4GG7BbPAr3dIbkg==
X-Gm-Gg: AYBFou1Vi35/klb7HSSvl6hTWc9+EGSGmj5XCp5nzuktxeM6Yz+CVxGP2Y8XOlideRx
	SjJ/WP7bhMIdZF2Ja41jr+G8XFn7bTcOCvAWdmXvki/8o51sxiEtbfVvVVWFf1Wq6dPNAGX4OYD
	iXpw/SkevPQiKkk8ZL03IgYpsVb7GuOrdJ1bLzrqpIdQJgZ30FCs78KiDzodek5UnL30WMXqlFx
	8ZqJzfD/uokoahDyptZ/pwEkIXM1+qZoxPPdPkjZwzoJQdxqQ8MGKcPGPOhGW6iKFPQbLYO7hMi
	sZkBci8xbBBkhah6OHn6KjpZOBi5XpzRvtESTpiTjptleG0pSHlhugzUNO6uj8TmOKXyDy8LmjY
	frM0bsAF4JaEtpcWLsA9W12RBA25wrD3oaqFbiykt8QXpXW1Eb5cCqMVyY9S/7+bj6XAgTnDtQv
	s59kkbYPhClJa9fB8uSzhr+odG4boloyXydBYh8w/GZ7DFBomh+b+tu2sV3JRpCI3q57hSs4Iwu
	6/M420zRL0/nayesXFrro0BdAHg6iC5wxvys91GUZAWjniU4hWn+hAGTlK/6/xwgoWrnRKkmC9g
	n8csuIYMn6lOzE+srcat9LTyyg+CQOShix9sawC4t/1m8r9CmzIiLmkN+erRFgQ1vxws2V6fcFD
	zT1vfJiO5OjIiQ/1/mb+pWEIibOeGYorVX6jJpDE8qN95bCdNlfBaC81brRcrknOItUj+1Hsuag
	RtPQU=
X-Received: by 2002:a05:6122:4696:b0:5d4:1193:73d3 with SMTP id 71dfb90a1353d-5ee1c418cbdmr120073e0c.14.1794349164073;
        Tue, 10 Nov 2026 14:19:24 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/4] test: functional: Cover switching the direction of a CIS
Date: Tue, 10 Nov 2026 17:19:02 -0500
Message-ID: <a1bf517e7ddbca2362458423a705fc38302088fc.1794349049.git.luiz.von.dentz@intel.com>
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

Have the initiator enable the Source ASE of the acceptor alone, then
disable it and enable its Sink ASE right after, over the same CIS, and
check that the Sink ASE transport becomes active on both sides. Then
disable it as well and enable the Source ASE again, which needs a new
CIS.

bluetoothd as initiator establishes a new CIS when needed, so the
switch also succeeds when the acceptor disconnects the CIS. Count the
CIS requests seen by the controller of the acceptor, recorded with
btmon, and check that the acceptor is asked to accept a single one for
the switch.

Assisted-by: Claude:claude-opus-5-5
---
 test/functional/test_bap.py | 68 +++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index 324304204caf..56205a61e61d 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -733,6 +733,74 @@ def test_bap_unicast_duplex_enable_one(duplex_hosts):
         assert state == "active", f"{path} {state} once the Sink ASE released"
 
 
+@pytest.fixture
+def acceptor_cis_count(hosts):
+    """
+    Function telling how many CIS the acceptor (host1) was asked to accept so
+    far, which bluetoothd does not report to the test: btmon records what the
+    controller of the acceptor sees.
+    """
+    btmon = find_exe("monitor", "btmon")
+    trace = "/tmp/acceptor-cis.btsnoop"
+
+    host = hosts[1]
+    host.pexpect.spawn([btmon, "-w", trace])
+
+    # btmon has started recording once the trace has its header
+    ready = f"until [ -s {trace} ]; do sleep 0.1; done; echo ready"
+    with host.pexpect.spawn(["sh", "-c", ready]) as ctl:
+        ctl.expect("ready")
+
+    def count():
+        events = (
+            f"{btmon} -r {trace} -P | grep -c 'LE Connected Isochronous Stream Request'"
+        )
+        with host.pexpect.spawn(["sh", "-c", events]) as ctl:
+            _, m = ctl.expect(r"(\d+)\r?\n")
+            return int(m[0])
+
+    yield count
+
+
+@duplex_host_config
+def test_bap_unicast_duplex_switch(duplex_hosts, acceptor_cis_count):
+    initiator, acceptor, to_sink, from_source, sink, source = duplex_hosts
+
+    desync(initiator, to_sink, from_source)
+
+    # Enable the remote Source ASE alone, as for the microphone of a
+    # voice call
+    initiator.send(f"transport.acquire {from_source}\n")
+    expect_all(initiator, [ACQUIRED, f"Transport {from_source} State: active"])
+    expect_all(acceptor, [ACQUIRED, f"Transport {source} State: active"])
+    assert acceptor_cis_count() == 1
+
+    # Disable it and enable the Sink ASE right after, over the same CIS
+    initiator.send(f"transport.release {from_source}\n")
+    expect_all(
+        initiator, ["Release successful", f"Transport {from_source} State: idle"]
+    )
+    expect_all(acceptor, [f"Transport {source} State: idle"])
+
+    initiator.send(f"transport.acquire {to_sink}\n")
+    expect_all(initiator, [ACQUIRED, f"Transport {to_sink} State: active"])
+    expect_all(acceptor, [ACQUIRED, f"Transport {sink} State: active"])
+
+    # The Sink ASE streams over the CIS of the Source ASE: the acceptor must
+    # not disconnect it, as the initiator does not have to request it again
+    assert acceptor_cis_count() == 1, "CIS requested again for the Sink ASE"
+
+    # Once neither is enabled the CIS is disconnected, so enabling one
+    # again needs a new CIS on both sides
+    initiator.send(f"transport.release {to_sink}\n")
+    expect_all(initiator, ["Release successful", f"Transport {to_sink} State: idle"])
+    expect_all(acceptor, [f"Transport {sink} State: idle"])
+
+    initiator.send(f"transport.acquire {from_source}\n")
+    expect_all(initiator, [ACQUIRED, f"Transport {from_source} State: active"])
+    expect_all(acceptor, [ACQUIRED, f"Transport {source} State: active"])
+
+
 # Broadcast code used by the broadcast scripts, see BCAST_CODE in
 # client/player.c
 BCAST_CODE = (
-- 
2.56.0

