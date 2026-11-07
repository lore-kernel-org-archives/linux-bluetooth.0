Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794013282;
	b=jnebQ8Jae2PEn3ueBhS21RHTfOFRLUjRkwE6EHzFrV6/vpsEYcDqx3opcYsaOjILZ5f7
	 fBHho5njKZdI3pAthErrWE4GICFLeZgbu609/eDnocoj5CsWykBlrZ/DOWJuKe8hKY7h5
	 pJNOljWvQMr23IHetXiohRNuq2zTe+TE0rgRI7AR2getx2ZPpDWZFcdzGf+AgPmNQYhvS
	 jmFPdLKPlJbU7vL5etatp7C2RyCB+q47SsHzUmikvG0CZP6A2gDaBDcP5qjU3MS/Znmjy
	 ZZ7iTpcmTLknlDx4/ReL1TYg2mQoi4YdKxPg3endoQEGRVKiU/NFhYldzbhGISEde9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794013282;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=XZ/WePNlnAsJM8co8zvlKAhXgKtIh7kZFyOZEgJBiPI=;
	b=hmx+ckdWxOFuox5NjrIXaIr5Z8EZdAaSHI0N6pv+4T1eYnlrPXKfFoSiGcx7RoSylvix
	 YKSdwnPSP2c2xseQg61bY6tnEot3StoC4fivZPV9TUHahpsPI6Ru/GKPzjOLbOuG6Nj2J
	 V3RsdXU+b082/PwB8bUbzB7EEefLxWHvJFAjNhdY5GkjSauZirWlTtsK5RVlDCGvHSoZY
	 wV43ISoZR4pYCpBBw9UKdLUNqQJDUdTbaZJ4MlyY/XTgNO2qXaIuX7Yp8bhv5z/gF+EFT
	 Mv5bpmYOkGXTV7E/4rfYHxYh2faBBTqOtVEXttRPll2z1GwZUpajojGqAVFQ0w8VkRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b="DF/RM306";
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C334606A326
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 01:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C334606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=DF/RM306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794013278; x=1794272478;
	bh=XZ/WePNlnAsJM8co8zvlKAhXgKtIh7kZFyOZEgJBiPI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DF/RM306YLO17MXR88K4d7gZI/Z8Skp7IJiRkxhm4sd+VX0tXPCbHorNgFJjRCD1O
	 zOohkkD3nr+Ums1odR4tscKjTUiPYBn/dzZtOohYdAOd1lowTXrYS/D0u8zSxXae6Z
	 dRocbXDUj3RgRka1a7o7upAI0gMWq/aY5PQplPIAEvZvdcD9cK76IsKb7PxWMUZ9eL
	 xK60DqZHasAlzBcasGpHooMWG2gdBstpHy72hiyYomM4q0Iikub0kA0e2YiTK2yYua
	 Txephx/D3E1DcaSGVzU89o6SwDCt/9+4KK6BKlUI3H4RNYTaQK/M9ECZegp3UljEvl
	 hH4bQUJ8h5bwQ==
Date: Sat, 07 Nov 2026 01:01:13 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: marcel@holtmann.org, luiz.von.dentz@gmail.com
Subject: [PATCH v2] shared/asha: prime volume before starting audio
Message-ID: <20261107010019.1162372-1-cochcoder@proton.me>
In-Reply-To: <20261028133131.262033-1-cochcoder@proton.me>
References: <20261028133131.262033-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 45eb925f48a7960bef35196d4be1b0c5536120bf
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Prime the Volume characteristic with the cached volume before START so
both volume inputs are initialized when audio starts. Keep the write
best effort so a rejected volume write does not prevent START.

Assisted-by: OpenCode:gpt-6.1-sol
Assisted-by: Codex:gpt-6
---
v2: Drop the standalone mock test and redundant failure log.

Previous version:
https://lore.kernel.org/linux-bluetooth/20261028133131.262033-1-cochcoder@p=
roton.me/

The unchanged local harness rejects baseline and passes this version,
including ASan/UBSan and LTO checks. Full make check is blocked by an SDP
debug-symbol linker failure also reproduced on unchanged upstream.
No volume-only hardware ablation or new remote CI result is claimed.

 src/shared/asha.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/asha.c b/src/shared/asha.c
index 79bb29bf9a..6310a8357d 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -262,6 +262,9 @@ unsigned int bt_asha_start(struct bt_asha *asha, bt_ash=
a_cb_t cb,
 =09=09return 0;
 =09}
=20
+=09/* Some renderers require a Volume write before START. */
+=09bt_asha_set_volume(asha, asha->volume);
+
 =09ret =3D asha_send_acp(asha, acp_start_cmd, sizeof(acp_start_cmd), cb,
 =09=09=09user_data);
 =09if (ret < 0)

base-commit: a8067198717b38391ca183ed7f41a69ec4b81b6e
--=20
2.56.0


