Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429486;
	b=NyiW8upuoGG3xq6WDyXNBsDGPG1TpLAuSpLyXGXw0OJg6kmePLeCjD/hNK4kKL7QiMjx
	 8I1nBowwyqVUYAiWkiibJyx6iwkin63+ii6Okgm7qk8GdO4cvksK2caEdXd4lCkTsou4l
	 STJoh72bvCyY94D21cvNlQ2WReaZE2daNiopGYyilpRbDmyu9D3DvHmOMkqV8UAd3Fw/J
	 725PqksZUTQ1WGhyZGj+/2y45ot7ehVeu+UdI356BoAtgHKA2xGO7eDz4AD6MHnMJddBr
	 8gAFs0+/BoX/hhubj2DA5xMu5hnFq7qKL4t+7GQTaxij8YNM2lF9xe9dNJP2JQeyf7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k4vpl5CIWPRR3McGqf24wqAb3Ni8sas+WF1OQebhfYE=;
	b=JCUxiyjikAvJCKNXVJhuwHdC0KvG3tfbgv/OJ/Kp/kLv+qoNYNXIhSb53AvRcf9Fvh3l
	 +IReQtGcvm2stRFaCL6hj+AL5vQxjLMDW2WexdYI5Jd2MXMAkrQ6xOOZUEAAga8/YSXdS
	 DtBJ8BTRLC5lxP5P0xBlDf9z0RRc4mkzeohq2N1AQULQ8mZncvcx07KvBa4YFzDcpzIv5
	 voKmhva6Wa+q3CG0OnVhRc41hgvbMewrC9YzRybZOrGQ41ElCkfku76dRSnEiYm2TKy8o
	 QBkSf31ianTPkoYCY970ueqLakPZuLLXzZIF8uP3vEMF34uX0d1OzSn7piqb5275aLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YargjPSp;
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B10B60A3809
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B10B60A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YargjPSp
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7d2dc9a7b52so1990476137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429485; x=1795034285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k4vpl5CIWPRR3McGqf24wqAb3Ni8sas+WF1OQebhfYE=;
        b=YargjPSpW4qniW8OsWdpFaAx/gkw5dR7q2INpMjbgC2KNATzQmSinrAhzYdB549cmh
         AruyrEuQKwRbOGxa7s0QG5rUNfaL3u316mYr+QdfHAjt3D0nXwpAPMowaQJGpyeTbiFB
         Z1kl+EwJCQ78kPOzgNj6TSYUy4DD6eFFLCFdWw8QlZqD7tTbzUeIPBvru8HBlV+gV6uB
         u0jGmEAOWYavpt5NwCp2MpGAS9RjurBRreRc+ZHWR1Dg88Rau/NkA0C72uXsxWMHXBUE
         8h7rq7letIZwGqUV3xCShhlnaIdssxymwsQgcq0zqLpUvq74EbmTPbTcLppKvUm7Xgey
         SJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429485; x=1795034285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k4vpl5CIWPRR3McGqf24wqAb3Ni8sas+WF1OQebhfYE=;
        b=SMwIUlX0CKOMeUAXTAsApWmgaE8+JcQO+C3OK39FyiwTknWE/OG9zEz8uEIXTYzhpd
         v0ehAvs0DODcHXYGz7xxAlTtuu1AldOhf425O6zck0kIKkSDdptiuQep4gj8u8JS5RVO
         NWgaju1TcdTL1OBqTpoIWB572Nd6timFzF5vW0WhcYnvLworC70R9YPQFjz+8Re5bE3a
         Rsf5N+ZlXnURV395rDKReZpbls5N1L1iAntxhD3HgB7ZsJGijlUK6PnW6PGWR5CkZyxl
         xSr0AT1IyFhgT9kTtCRuzp6W/mLRuW4yIks6q1G3VCy5X85OMuJjv61GR5xeZH15DtMd
         ofUw==
X-Gm-Message-State: APuU4Z92RyCTq6o03P+eMtF+pw0Dr79kmEF6gteNb7UdZyk8CPvQQXXB
	DbuUTNtPxwcPGIGYV2ZPrsgIZ0Ck/rnsvPJ/QKI+NgPDIYEuxe2h3fQG9RjiRA==
X-Gm-Gg: AYBFou3HUnLzzEOJ0VybQCYigulneHjSI2s1sI2CM09XWYWEIiQqDLa7P9PStN2MDHu
	qj9f+426GAOrhXWhjeoGoRubGmmlPXbCHdbiJXyzBmuxU/NfWoIkW+0qk51B59826gWAHbYtKZM
	U1+EZMXi6v6rsCl/gWeXlJBfw5NQfKxRxlIGgfdkhEuZpFvNUBrdvmXJf5YZedKt3+zuTmTbCAY
	wQ7uvFsEYuIp5DWa4kffqg+pmJ2jwmBSgzzjhLv5Uq0NX69vte9tnhaUIRbq9nhB7K2a4KzshD4
	yUdXjEfJ8KizdDmYwxC72utJjHHtYf216qlSLM8e1j69qJXubLWzR6I3KSjFg9HexsD0w1JEsp9
	0CpqD4Jt+3DPBYtVadEvvtR6Rk9Z7TIt/V8FXHMOXMPxt1+0pORFhN8tbg0UoqMhcIPWAtneCee
	eije9CBkcJR4OB884EeaR/c8jLnzCVRzY5GnzadUzG+kjlUTn6/K60irm4vf5rufZEN67j4wQKQ
	Oo9VcSV1+adBiFa3gto8MXqqXnw3PxGyoe79Itd7jn1ecbHnsm3o1dKrUUlePI8b+8rLHyT/kIU
	hQQyH9O/bYs9LD9ZIvERrpIzS2tc3Fg2p89cRPufLcLBwd9bB7QsXJyKDrhOCK3harfsxw4W61C
	HDJeJ+ShQYIJQqNmC8a9oQ275tCQ7o8Z1gFzL/9vRr71/XBtYyeJq9OF7tovGkz2H6hY0yuPQyr
	WI1+8=
X-Received: by 2002:a05:6102:c13:b0:7d2:cbb5:71f9 with SMTP id ada2fe7eead31-7d4fb255e87mr1649973137.7.1794429484822;
        Wed, 11 Nov 2026 12:38:04 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.38.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:38:04 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 8/8] test: functional: Cover releasing a shared owner
Date: Wed, 11 Nov 2026 15:37:42 -0500
Message-ID: <538e5b07cb02dc132e90dbee0a2e48c4abe1ebb8.1794428234.git.luiz.von.dentz@intel.com>
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
index 13e969a4a845..09bcfe9436ee 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -853,6 +853,38 @@ def test_bap_unicast_duplex_disable_one(duplex_hosts):
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

