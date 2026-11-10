Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349171;
	b=eq+EsJo3fKy2v6BVyBQxXfapLg76Nl50qMaUhUW+RBrl/zVE2fg81sJM0XvBrbtsumve
	 00N8o0Hybr1HcoHdpAOMfOjrMAWc1qxeJIuZWWnAaJbFis290wVnhYNHzdy2HClX0yais
	 M0LoxMD4ttl5Ov4aPxox0ufdGnz40rdrMmXD3lDVo7jF1qQNHpg+s3tkiQwcXSMBLPqNu
	 VP19XHsDkQYHn6zSb2UEyTWQgYBgYmeNUitkS3V8SmCjsFj+KvHQXSx1noO6Avx6JSRHR
	 ouCuztm4uZNwRZFKJrPH94wr/dUHjgnui4gFuMOv30+9xtecBixKgZksX/BrfKheofg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jm5t7CcKRggaYTwrs+D/CTwGS/RGw/WjZV97DBZc6mE=;
	b=ybi8SNtt763Yk2wV2JjGewcHsaaYa4gQkbgWiISLbj5a3Ato7iLtSeT83/qrWMMQZg0W
	 SkZG8EeSYJrXelmXmyKaZ+WPj4XhPrYDs2X8Qv2EsILH4ZvYmqTiXmbPZJKuPDs3K+KyI
	 GJ3ctIiCjX0tb/5J6Pm6G0tRDbc8sr3wHb0b0PvHU8Kd4ONPkIeJ3AP3JCdnbriplkQpV
	 x4LgjnvwftwJHuJWzycnzYwKKxt0yF0DN5aSgKpXjNv26O7xLU80aB0jh4Rq5InRWBeLW
	 2d0coxA1J3af4N+TTrQpG/wn809WXxAYVM9i76416EOpgyFFopRngCwMXYk5QJEUfUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cBXKeg04;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9CB606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A9CB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cBXKeg04
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eac01ff101so915875e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349170; x=1794953970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Jm5t7CcKRggaYTwrs+D/CTwGS/RGw/WjZV97DBZc6mE=;
        b=cBXKeg04b1pPOXRKGW/l6a4EL+tYFNtXLuQRqWBraXEGBhJwpul8HTzF66ZhvgxPRX
         EZ1j+PWNlXEiW2SYwC1eB75YF1WJLycNJrHzROAMd3xUnbMEK0FYQkcST6NMssYv5mP1
         eYDEoqC/O3qoSRC4vI23qGCT8P/GJlkICAFaQeqsp3sYadZOcy8lVhmwPx6ymuH73ZO6
         Wq8gl9jwg3IuhPVwfakdqz6fge7o7R0bLULPjlrCkFeUuXvBe3wDLCn2M7nPc+4r4qrQ
         0WwDMwhJUEsqNOnC9SqRByKk0ccXHcNhs2F6ez5PCIdUtw89PBO7pBUUqU7w6LcrRvpG
         gchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349170; x=1794953970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Jm5t7CcKRggaYTwrs+D/CTwGS/RGw/WjZV97DBZc6mE=;
        b=llOrG7S7ew/0BjH5ujNItiaNNRkgZB81ac0y17CsTeMKUtBnTiBhit4eE7AX8bwgkP
         RUbR1TEjWVrIGcwuMq6924nARXwdsU0Tz/pUqHY3RAYdQA3ZEMa/0z6INioLN1SC8BCC
         E27wCdHqo4jWVjp0rwNldKTOE3GwwvezVUi9BCuHYsbP5n3WbRkY3hovVQ8wDXgWNr2k
         MJLTHamKFoEq8GVuoXNXBUf2jO29joIB/QlX9L254Yiq2lPe6swSTVV5HxfeRIDrohFh
         GhYWDzJ1rvuBFq1RzsO0FxkTXxybJlQvUE0jC1vVicvQC/If2tkQ5OU786eeX2nEsrJG
         Skog==
X-Gm-Message-State: APuU4Z+9sNwCqpOkCwKW32XM3nAcysgW1Ki7XH/fk4HgxUCDPnFxZ+aK
	HLxooDgVjyrWNI7w8Y0SvJe+1oiB1cO341JfONFxSri3z3na1UBpxSTRLW+7sA==
X-Gm-Gg: AYBFou1tPLII+IJsP+eAtgM6syPOdeF5CW6Uc6+KmPSbUwxp/XFm1Ng/dNDELbkikIB
	hYoJGqFl3aBuPp8DOU7EqcZOKKj9UV2bVZ9hPSjoQ6+kCGU1TmUUtMtuKFaz1FqqHBzwTQ6dRuy
	pESK5d/6fyZmVbHFBxFG4MuJAa3gnUMfGbMBqgWgBk0xAfsApbUM0dVYA5YBFSeur/f26caQZnI
	TUfQJiK1gTL+17SDTrXKYgWw4/0L1F2gobMRGQRt/DI38ZCZzBa3ZObOgHk9jaWEBi/TRk2GECM
	H1mVx2lhJzddV+RRph+0jUOzA1N6jrU+DhexKYpLktfYlOljoMea9q0eqktfOuiP4dTUM/4Yoh8
	oejlWS+K37H4SDxf0kEzZm+CLMp4AUZO12Vmq6MrZyFZ4PJ7NZ0D4mUBQ9KTzYNkF3HdUyosOew
	z2kRUq/iiI7FhsZWFSmYGOqeEEPt685wS2tz5yqvm5QL+KwQgBKTjD1QBpgLiil7iwobw5Mg5qx
	v3EEv3Z4Xv0cYSb0aJu5rVt3xp27vHPdzHAQTlmx0kvvFQEQdolzaoakCH3/lh80uGYeFO3hrpL
	e8/RRZ+1Ogtkia6yRBO5Ks81iQMkFSVfttVWomblJOWUXu8hUvBvBVCLUmr9Ofi55iXCp4u+6rb
	HM6tXiMPyYbwQGWDV1MDIyk4rCw7RDY2AEdkqeS8/MeJxD6pdKeIq90igbFkIctbmpPpVKdYu9v
	05VCs=
X-Received: by 2002:a05:6122:3d0b:b0:5c9:66f7:2f23 with SMTP id 71dfb90a1353d-5ee1c29a86amr142565e0c.2.1794349170192;
        Tue, 10 Nov 2026 14:19:30 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/5] test: functional: Cover clearing a cached configuration
Date: Tue, 10 Nov 2026 17:19:08 -0500
Message-ID: <27d5df93d5ee1e9605954a8e51106054149d9fa2.1794348982.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794348982.git.luiz.von.dentz@intel.com>
References: <cover.1794348982.git.luiz.von.dentz@intel.com>
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
index 324304204caf..74b8efdab13f 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -733,6 +733,29 @@ def test_bap_unicast_duplex_enable_one(duplex_hosts):
         assert state == "active", f"{path} {state} once the Sink ASE released"
 
 
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
 # Broadcast code used by the broadcast scripts, see BCAST_CODE in
 # client/player.c
 BCAST_CODE = (
-- 
2.56.0

