Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349172;
	b=fz0mOFjzus5kIzZUWbsMnDwSK6oiFEgihSSBKBGAxGjDi2QqB51YitCA+JYUnjqoe9E2
	 LbWlvCchw40gN5Oxqpbfd8DvFD/xegBlPZV+ghUvXrNKoBjcobJ2y7sGMBtWeBNM0iEql
	 4nICEfXVZnaOtVnOLtc6suyySvH/sIzNybIbiG/aFWaKBCSSU4mmCAlis7Lzqwymn6GBL
	 zRpmpti+JGPiise/4amD0h2dk9rlQVirJ3Vwkf3t9DghEZ1HuoluDcZWfrhWvobrh+Vfi
	 gvof/0oULBlRPG73SkctbZoIQD706HPKE0795JXQ65L6a40qDYMEFBJmsR03aTb+YnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O4Ri/iDrgpBoezl4SV59OjXJF2cCeDDF1R3Dw+s5N3g=;
	b=qoTsZCYCWPPoiEt7QCm7XxE0NsZHVyjnULWhnU7abF2s/Qa2m1fi+WYwGgiQ5PrwbmpB
	 SB1VN+hzV9tYTz+XgI7OjLd3HLBplF8exwywqM078QO2rT556J8szZYmTkn+c5oDP7son
	 YtfIIP8UZJjwMriUZloyQVqSBqvsGRaCkAUdHzdlb20qTMRLFBjaxpxFP0DJtk5kv/rM2
	 3BMyWd/AtcvUSOXXquxUItQ6sRzJ5+vE1NdrI4Yv+3n1MKvi3uiTMex+Et3Y+/Q95r62J
	 kxb3XjMw7RYGhZtBxm4WMtSv2dsKsJAcRn+dIl2jQVsCjWTM71/veGn1kk19CsiMOlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jKVEm4pk;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA71606A32A
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AA71606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jKVEm4pk
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5e948e56af3so967953e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349171; x=1794953971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O4Ri/iDrgpBoezl4SV59OjXJF2cCeDDF1R3Dw+s5N3g=;
        b=jKVEm4pkPizHoDaVn0mN3OhFoGnHQ7BYamo6QzcmrBm4XT1Zb+hrIqzS03ZrN5YLDD
         9xzDLRlLbNvheDMGbqSUjilQqUR1zEeCBWMlQesfi5SIY8Ar4fC9HzkNT6usVsNBvXIx
         ngQZb5lu99xDeLs2rkzJL5xoj4+K7AEvjXfp8lt+cDB09erQCUu0uhPDMV1aLHpx05yc
         x/sz93aWGpJzJUQgb7j5n7cDFQVPVhcLDfYPGtw0xLwY/Mp5S4UidYaANDxWI7Wdb5qw
         5oxBJKVqm8r2sMSqnN5BC5Imftqwc31lCe8HsFxAOVWdqy1YZ3KQvLjYHcOxSyzW/l7X
         pz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349171; x=1794953971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=O4Ri/iDrgpBoezl4SV59OjXJF2cCeDDF1R3Dw+s5N3g=;
        b=CdOZd5/PL/T2/ITh9VebpVO8ckw6m7c7MS2JsADHtWGrKWqJjuqNkVceiXnCcuIbpQ
         J1xs+VCfhvMM37CMJ6mfycyhDffb/dmFAnZ57rD4lt+Cx/fn31sixiwRp1voYDaKN1F+
         xJPS/SwTbUPplrJHTfxNBJJmjcQ8vmE0HFHOtrb3FDSb9p831miXII3PIePAnqZNdzBx
         3K/FtiBT3JKrsxzXcnjAvIqR8wGj3CVI9qLmJJzDP6NPNeE7FfAvnmbA4P535NjokxQn
         9SPBSh75a4LAwD5FVx0Sr17ubUxMsY+WEJOVYtsusA33JYjvxY0cSQ7G0zpknRJsjnjy
         NALw==
X-Gm-Message-State: APuU4Z+ge71xqB0Ai9fzCGDFc2fBmzy1kWq7axlo73h85E0xAWiDx5zm
	pUAnF1QIAygESyrYMzdzDSunvLEqLqzjXuUwnxz5sacK2I3DySzK6xmnw8f+Xg==
X-Gm-Gg: AYBFou1a3bRS7YOmdy6hT3KffWM7ivgak4Bm0uJhswHD8m/xsC5cQ+sQolCxjheL66J
	XrkyekRfkEW9vkWxZVSvu2+SffSyaa9ipeOT5knoH+hc4TuR7hYzpu2KpKsUeoMo3y7Td3RsrWa
	YUINh42piv5mFHTmenhekbnbS94sialUY3uUbADuIBxOQRnQfJWyKhf26Gg1SmKpFtI/HpHpwZ+
	Ku9a7LUNh+w1NzXiuSkLxA/Ve+HHgC5hlCIPC6eqidXuwSsT8n5iuM8en/oe0Ytb/z4IwOHDyMc
	2MUKZmxybMIg0ew2u9kkhZsi3kP8znWMi1oyhJYUKaADKRiHz5H+pc16ERTqjvAxwfoSgrOfSLh
	TrJTkjC+XetyFTjKYa7rly8NfgIDfQuSahkmVSCA1eN1sulO4hCNVPknFjfOI+aALHcZ39SglN1
	i6k1TC9/2UHfiRGZbYesJVVv6j0QB1KpEP2vBz88ngHH5mO8exXBw1w1w1j73uxRVzfDySeBBg6
	bUs88ik5esewQjdbdflHSn9pfD474D4MMOX6SGmjE0dM30NO7gMU6ih+sXNyiJxKpQbYnnZlOlX
	xOlD/9qUidhXI8MWX/kqfCycQP4FnvaCW3pgsiTXBjWJTudx8iMHOjtTH4MzzI3jE1FO848pSMx
	oe/4GDleKfj2i4SNRHf71H/pPsHkMm7E0Ak1Sk62nVjZs6jn5rMJFNITdDX9rIOM75PCbg9NMvH
	OfE7Y=
X-Received: by 2002:a05:6102:3f8f:b0:7c3:9a36:bbda with SMTP id ada2fe7eead31-7d4edd183cfmr149447137.5.1794349171151;
        Tue, 10 Nov 2026 14:19:31 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 0/8] transport: Hand the owner over to a link still streaming
Date: Tue, 10 Nov 2026 17:19:09 -0500
Message-ID: <cover.1794349049.git.luiz.von.dentz@intel.com>
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
Message-ID: <20261110221909.V_o4NCOadGU_KsLG7tYtTRmeVXqjjtLqY3uqyDpN02A@z>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When one ASE of a shared CIS is disabled alone, e.g. a microphone closed
while media keeps playing, the transport leaving streaming took the
owner, and so the state, of its linked transport with it: the audio
server stopped the stream of the other ASE while it kept receiving data.

Hand the owner over to a link still streaming instead (not while the
transport is being released or has a pending request), and clear the
owner of desynchronized links when removing it, which fixes a
use-after-free at teardown. A unit test and functional tests cover it.

This series applies on top of "shared/bap: Don't disconnect a CIS still
used by another ASE" (1-cis-switch), as the unit test reuses the test
helpers added there.

Kannan J (2):
  transport: Hand the owner over to a link still streaming
  unit/test-bap: Add test for disabling one ASE of a shared CIS

Kannan J (2):
  transport: Hand the owner over to a link still streaming
  unit/test-bap: Add test for disabling one ASE of a shared CIS

Luiz Augusto von Dentz (6):
  transport: Clear the owner of desynchronized links when removing it
  transport: Don't hand the owner over while releasing
  doc/functional-bap: Document disabling one ASE of a shared owner
  test: functional: Cover disabling one ASE of a shared owner
  doc/functional-bap: Document releasing a shared owner
  test: functional: Cover releasing a shared owner

 doc/functional-bap.rst      | 58 ++++++++++++++++++++++++
 profiles/audio/transport.c  | 62 +++++++++++++++++++++++--
 test/functional/test_bap.py | 66 +++++++++++++++++++++++++++
 unit/test-bap.c             | 90 +++++++++++++++++++++++++++++++++++++
 4 files changed, 273 insertions(+), 3 deletions(-)

-- 
2.56.0

