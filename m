Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529066;
	b=OGQcKMeYnqYByoHARezkCxBhuQf6u/OYi8wSEvmWz7fK2rSDsyaiL6vZSaqzrDKJk3dl
	 g1VGG8eTFFiDh4+c5zpSuoXV6c6efC7so1ATHWiO9ULZIEkvS2jIq+4O2Js0X8sWZFN2l
	 +pQdXBFAqp2RAsPFdQaDt3n9XY+dz2SGqOfc+Q+QPuLlCcEZwH4sSDhfR6Pd5gYdLe+WF
	 VHcCLHcK4S6nby3yNhJIVuvKEapcTYGk9LWufRqRVgTkeB+KN9FZCMmQC5tGGjCNcLPAo
	 S0Wtj7gwuYBqZPvKZ9vurmEkoG1nT/bKKIbehnqF3q6t1li82n7QP877iGbpaSPgwXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529066;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=mwBkpTejtwA7SbGjHD1SEdHo9VtyCbvGU94r1kmt2bU=;
	b=lc2Zo6dySPXsMVWOyzo3pE9T2v61dN1bNPT+jX7ccbrBtJUyELzUzFr/M5k3xbS8oeN/
	 wBZOEZHnzOoNuhP9ApCBNOtAaqT2tFn/uws/ITomK3BZY+C5x+/EJGE9WhRQtjE7E5T79
	 xgb2agpJ4hezPy062AVH/S/IbwFK9i8lXc94M4taWL3gHOrKk0O54ivXL0jp878rsh2Y1
	 DATEgCqmAjYYWoIq9HYT6+cy93sy9UvqhdJb2ES277CGVzOMB8wMvutb1EjQ0SNIa38Ib
	 E5/+eBwu+82bsem328pxBnHLP8dlM2+t6GeAcWOOb8Hx4nfU6NZ6ARYw/IWNVmTXQIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=aajk5wjz3zbl5pnadgvqvseqqu.protonmail2 header.b=DUfzQ+0D;
	arc=none smtp.remote-ip=109.224.244.16
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7EC606A6AD
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C7EC606A6AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=aajk5wjz3zbl5pnadgvqvseqqu.protonmail2 header.b=DUfzQ+0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=aajk5wjz3zbl5pnadgvqvseqqu.protonmail2; t=1795529064;
	x=1795788264; bh=mwBkpTejtwA7SbGjHD1SEdHo9VtyCbvGU94r1kmt2bU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DUfzQ+0D4cwaZsiMUesHcYjw/1wcwwAwzyhUv7XeyKA+Nd2qiaKD78XKUFbqcCKM7
	 moVuJ5hKC1EuBwcx7N70cT+6Jgfo8qD6J46Zm2C1isWZgI1rp+gYwJZlFA0b/k9Gv6
	 x3Zu9hAnOGtZ7taM1QKUdwP/bPEEDk/i/Uaqx5JczPaYo8VWULwLZ22rP0vvz5BqKi
	 pBnhM5Hk0TzlJ+BOA+jeh0Ux6aPp1xrkcnhmWd1K4ttpDMvT5UwlAarr56Ky3IWoNG
	 /GOrdY3s/h7NRYGoLg6/Nyz+QGy0C/zmkChJSFooyRNj/IRoyLcJ6TzHUdYort6iQX
	 uatmF1nSEFpcA==
Date: Tue, 24 Nov 2026 14:04:18 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com
Subject: [RFC PATCH v5] Bluetooth: l2cap: prefer compatible local LE intervals
Message-ID: <20261124140405.3096828-1-cochcoder@proton.me>
In-Reply-To: <b6847b841127362e423b49f9e48118f97985865d.1795497229.git.cochcoder@proton.me>
References: <20261013033118.501182-1-cochcoder@proton.me> <20261015043336.47734-1-cochcoder@proton.me> <20261015181041.42873-1-cochcoder@proton.me> <b6847b841127362e423b49f9e48118f97985865d.1795497229.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 22b59a37cb488bebb7ef5b2893af76e3b2e9b230
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

Prefer the intersection of a valid peer interval range and local
preferences when they overlap. Otherwise retain the peer request
instead of treating an initial preference as a hard supported bound.

Validate the original request before narrowing its interval range.
Leave latency, timeout and disjoint-range acceptance unchanged.

OpenCode and Codex assisted with source review, tests and wording.

Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Changes in this revision: disclose AI assistance in the changelog.
No source changes.
Previous version: https://lore.kernel.org/r/b6847b841127362e423b49f9e48118f=
97985865d.1795497229.git.cochcoder@proton.me/

GCC/Clang W=3D1 builds and source-extracted sanitizer tests passed.
Fresh native interval/VM/controller tests were unavailable.
Policy acceptance and interoperability remain open.

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 943effc86..4f4625b97 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5089,6 +5089,17 @@ static inline int l2cap_conn_param_update_req(struct=
 l2cap_conn *conn,
 =09memset(&rsp, 0, sizeof(rsp));
=20
 =09err =3D hci_check_conn_params(min, max, latency, to_multiplier);
+=09if (!err) {
+=09=09u16 pref_min =3D max_t(u16, min, hcon->le_conn_min_interval);
+=09=09u16 pref_max =3D min_t(u16, max, hcon->le_conn_max_interval);
+
+=09=09/* Local preferences must not reject a valid peer request. */
+=09=09if (pref_min <=3D pref_max) {
+=09=09=09min =3D pref_min;
+=09=09=09max =3D pref_max;
+=09=09}
+=09}
+
 =09if (err)
 =09=09rsp.result =3D cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 =09else

base-commit: ffb95458a0f70dcab620eee0ecf5ef7750971b2f

