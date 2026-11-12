Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453780;
	b=GCLLAK/b9CHA6+uNH+Z8tX+HnFSedXvFVjmJpDcBlRCeXXbEvrO4anFV1kSqtD3EJW3m
	 FDm9tc8nwCbek9AZrayxo5OhmQxSAUQROWfbSoQ2HSQj2sztFALqyRvbgmprfLDpTVHpH
	 GFPGvkoZYhLlSZfNot0CLIV2THe6PVTWd+q13usWfIjU9oLTdX2sdbqNKzQ+12LbRAtaQ
	 l+iEW0Sh6nnej+ihw+WbuD/Wn/PtoRXH0bQIxAU6O4DYSj8Pw60yX5q5Rv1byE7Wsxi+Q
	 QJlgtZu7bJ1OAPvzykl43gKa2u4AvEu/mUUFYHanJjFeK50wthMzZckA51SgL7g9fiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NTrNiTU+sW63SK8STyPqhb259zjDMxSfbiBYzNCXb5g=;
	b=aq2xRt183qOuHxQAxmTLpZIlVc+83SmpEV0KNXa92Jk985docelJkcwS8XB+ZmfkJNs3
	 X5KNBLoxJiWORtMHO1y/6x+FdlhZeHUGND4Sg9d2WKOG+Z3dxclrltj0XSePjyfs+M5ah
	 STHlgtfXX+JiJt3YsHjdgQ6MIPOoeA0CaHE2yeVfM3rjpuSE4a94D5tRXTcgQBNuDE45w
	 W7luYrpZ5I+iCqRK92ZHFdIjJ5HVn8CkL+aCyfzcK/QQ8VHbZSydFhB5pjIneCSamVtoa
	 hZkQ7CvIbwMw2KNs7xJRxOU0dgIigQCF6fzsxmcSdfNrvaJ1NFH4Ksfiqj7Lw12PaJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=GMkRDD6E;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60588606A32D
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 03:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60588606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=GMkRDD6E
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so5779620eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 19:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794453779; x=1795058579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NTrNiTU+sW63SK8STyPqhb259zjDMxSfbiBYzNCXb5g=;
        b=GMkRDD6Eqf+PninbXbR5KoSqo+MDHcXO+DXsjavTMDvr4dDETE0klgk3AsURR236jF
         QRe+bVB1irDj3Hznekrb7KCqKr6NGFEP/4+Pn1/1HaS+IIcgTlMmrSkN8P8+oKJ7iL5x
         QBq6tWgQRtiOiTpZkMqd/0WYLkuNqkffTVz8ousCOYdTj8pL7V6fsifV8iaGf8CRjO45
         zjTY9NrAOyVEQRkP2SNv0Wh7ALQ0pQh9IANRA553UGmodjHz/DVUUboebosxzNMg92xm
         ap9ZpHV+HL8TxAx4bw8b244UeA9Ca1uIiPRujAPzG1oL8gP50xSpqvwb2eAOfnytxCUc
         k4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794453779; x=1795058579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NTrNiTU+sW63SK8STyPqhb259zjDMxSfbiBYzNCXb5g=;
        b=Z4DIcBjzRE0hYTiVMOn35iMgKfaFfOB4ZfqHI/SX6QNXa/0/AXay/73SmLrSqADVEe
         hNS0hW0SXsVp4r2hDMYpJ8dMsFPOTkrKzvICKXSdHuKKQ6uVz9lkwaBxMCZIuDHXAYnr
         HlmT45Jipd24WE+I2Ky1BZmz4Dq4bPmusIkm0dpAw67gNqwHUBKQEENL1LXpY5BAwnGf
         WiukLOON+n44nSE0B1uE4+VubRny5kpnfak5ZGOEUw3HeMBeJ3U4Y7tgmTGnZprcUavS
         BvDF5FqNnm+bv5zOLhpD0uuXu/qPXMd3/GygUSTpgLFJOSzkV2fh4wZq9KcKNSurVWLL
         kZzQ==
X-Gm-Message-State: APuU4Z+063y7w3zGD+VCD+TSzJaBW9K80yUmIzLDD9Ai6t/pNg6vjkhk
	38ATPD59vvl9bKVl7CQwm0Fa75O+dk7aRlBJO3mSsUw6dliXoZjyXYkmKejR3wjW6YI1QaO/Aes
	8LANR/V0=
X-Gm-Gg: AYBFou2nD1LdpWYNByCbg9xeHdVvYtefjEtez7O2+ojKAiAIlOGPAtIxfSpI19MMcnH
	442MD9JaTBfxcyR26Gf7FJl9U/riYHcZxpJM5/c7OE7wF5PCl4nxhbQIwFvOxDyuindzvRTND2A
	59Fd0iuV72GywbbHAbXdfHRTL9MBcWsPZDu2z5lb6IJ6Xep52JpClYNZ7kdJfGH5ladedQ7Fezk
	HEPls+8Kb5IN6FXADHdgZwoNNoLFZIcovpzaknRc7MLXWtlbqjOl5J56sqAd+E1XeZ4N6cJkh1q
	6CTY9Ij2azLOVnxVyBaynA2Px0pAliPwtplRrZlbvUP0QBgVpARC70iKpDI70ZF0tp6kvK7ZM3k
	FaASaN9vVIx7g0dpieEpeaHMSnYNgwzXQJ8NYWWWu0DMJcxT0AZ7Xd5KbISOdnUCxhz4+dpr00s
	EAShRYU2ZAaTuaWYjP6GrNSFmc1ItfqM6GYhLkqsl9IWrEQ2GMzyIU3zRSyId1KXyXy2noo5SIV
	qF6xGgaUJvJMy+zwwX5dhdng/6xIscWFIgO+0KxS3S+ooH/VDjZSxQAbLERrLkpDtthBLBwrgid
	8m6SDp9n/laTYz9UWnEr1MPdHu1fhx08N5d1kFNRXrQU4w9uNtKiOUQ3yV8sKktKwvdjCEiQ+nK
	ZThPC0QPRVows08qXa2AEy9b0fH0Fh/zsIQXafSezan8hkOZu4pePEhrcaHRd2Gm8UZZP+A8=
X-Received: by 2002:a05:7301:4184:b0:36c:ec0:23ef with SMTP id 5a478bee46e88-3768617340amr6633751eec.16.1794453779336;
        Wed, 11 Nov 2026 19:22:59 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm21340765eec.5.2026.11.11.19.22.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 19:22:59 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [RFC PATCH BlueZ 4/4] test: functional: add bearer ReadRSSI test
Date: Wed, 11 Nov 2026 19:22:50 -0800
Message-ID: <20261112032250.37687-5-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112032250.37687-1-kevin@simpleble.org>
References: <20261112032250.37687-1-kevin@simpleble.org>
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

Read the RSSI of the LE connection from both hosts, and check ReadRSSI
fails with NotConnected once disconnected.

Assisted-by: Claude:claude-opus-5.5
---
 test/functional/test_bearer.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/test/functional/test_bearer.py b/test/functional/test_bearer.py
index 59ce8ef7d..36b614348 100644
--- a/test/functional/test_bearer.py
+++ b/test/functional/test_bearer.py
@@ -283,6 +283,29 @@ def test_bearer_le_conn_params(hosts):
             assert host.bearers.get(remote.bdaddr, LE_INTERFACE, name) is None
 
 
+@le_config
+def test_bearer_le_read_rssi(hosts):
+    host0, host1 = hosts
+
+    connect_le(host0, host1)
+
+    for host, remote in peers(host0, host1):
+        wait_until(
+            lambda: host.bearers.get(remote.bdaddr, LE_INTERFACE, "Connected") is True
+        )
+
+        # The emulated controller reports -1 dBm for every connection
+        host.bearers.call(remote.bdaddr, LE_INTERFACE, "ReadRSSI")
+        reply = host.bearers.expect(f"{LE_INTERFACE}.ReadRSSI:reply")
+        assert reply.values == (-1,)
+
+    disconnect(host0, host1, LE_INTERFACE)
+
+    host0.bearers.call(host1.bdaddr, LE_INTERFACE, "ReadRSSI")
+    error = host0.bearers.expect(f"{LE_INTERFACE}.ReadRSSI:error").error
+    assert error.get_dbus_name() == "org.bluez.Error.NotConnected"
+
+
 @host_config(
     [
         Bluetoothd(conf=LE_CONF, args=ARGS),
-- 
2.54.0 (Apple Git-157)

