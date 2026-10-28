Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194345;
	b=q6YEv2Pcxyu7Jg8yRaQnqsr4FFYFFGq40PifMC6lHxy6I/yYjWdw/A2tBCBMDlOd2USB
	 rpQFzrfhjdMUVFrTLlDd6QjZqZH9b/OXnKB+Fs5boyqhkKhBonpMTsstoHFsvripRyAqZ
	 iFNPIPgZjZL/b1EZexEGSkuRJxYo2p6Nzpay/Z8QjfgEd310Z46Hm/z/KjaIdwUVBDvJG
	 FDHCxjDqyOVnFEPOCTk6GAw3LzreCAuk3CzwY3hbFJDbJS+rtUDt0cqfXwubPil+CCVOx
	 BMafUFUOdJ6bd1056addaE1sNU8EdUgq1JftxEE9JCPAZ9mh49PHVBW8qcGKl9r6Jow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194345;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3aqfuf1Q6jsGEGkvSvkSLyy7MKrwBDlllW702WbVQ0Y=;
	b=Vf4b2u4eJ5FYwyyt0fcKV1vZK6aQ/EUlcfDL3QqpSoptLQ+xBVC1SOtKn1scqFXZhowe
	 N2cdJymheggg+FIS1rgkn05blb36GRAYs8FEc33Up1VRfbk9ip4v8wTw1aYQcfZxeVVlZ
	 HLR9YcVdpx3J8F4LGXcSgCs356h8ANpyvbeR6SrXuCwdxBOZ5cDha3Wfee1cqmUbk04Ev
	 qNkh0+z2y6vQT05OYx18QS3wIRLlTW5qylal85y2Ez5hx1jwQd/2afooiSwUKuR7nzYNq
	 n2HrGQNGFez0Cf2p1RlZZFFIFbkf36dLyVTCWg/WuvylNlhKR0F+OkTk9bDl6G+mZ1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=VNCD3XGZ;
	arc=none smtp.remote-ip=109.224.244.121
Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A5606A325
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 13:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 564A5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=VNCD3XGZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793194340; x=1793453540;
	bh=3aqfuf1Q6jsGEGkvSvkSLyy7MKrwBDlllW702WbVQ0Y=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VNCD3XGZQDxOwWALzf/TiyBjvWlP/uqCFNM9jerXvBraXTPxiIyHUXa7E0y4yRYDo
	 SCwzF8wY4u08ewfqr7TEAEEidNz6sm/oorUwKSzV1nTSNG17RBLww+drmcwBxNRCaj
	 p1TZFELcseShZc7AkmaCS7FJuVvhr84RRYrMkZlrU4SB4NYzeDNBAJw2YyH0tRIA5f
	 s7eaH4xYf/UDbQHKakojLtGf4en5k6l0skf9FrfUI5ibjejtxW7aEEkfhR0vQOlxaS
	 TGatliNZfreycXYoxKRSfJUfzRvQW+KRn0VAh0nBWpLd7F/regzG01Kvlpp7MUvroK
	 b+ue35VjaQu7g==
Date: Wed, 28 Oct 2026 13:32:16 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [RFC PATCH RESEND] asha: use robust streaming connection parameters
Message-ID: <20261028133204.262169-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 9c294a00ec9dc14cc91246049f44b8a7e9d07e0c
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

The tested renderer requests a six-second supervision timeout and
latency of five events. Use these values instead of the one-second
timeout and ten-event latency that accompanied link failures.

Assisted-by: OpenCode:gpt-6.1-sol
---
Resending unchanged after automated CI PR2667 expiry; no source changes.
Previous submission: https://lore.kernel.org/linux-bluetooth/20261013035111=
.522738-1-cochcoder@proton.me/
Earlier remote functional, lowercase checkpatch, Codacy Security Scan and
outer-CI failures remain unresolved. Historical local passes do not
establish remote success; no new hardware or functional test is claimed.

Submission review notes (not part of the commit message):
Local validation is for base 7428ca2df9356363079db0f48412c20cbdb9471f.
Compatibility with newer upstream tips has not been verified locally.
October 9 N8/UB500 trials independently restore timeout 1 s and latency
10. Completed HCI values change as intended; the variants have five and
four supervision timeouts respectively. Restoring latency 5 / timeout 6 s
restores short streaming. These are device-tested values, not universally
optimal ASHA defaults. STATUS and the other downstream fixes stayed on.

 profiles/audio/asha.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
index 8e625fdca3..409b4f20b5 100644
--- a/profiles/audio/asha.c
+++ b/profiles/audio/asha.c
@@ -50,6 +50,9 @@
 #define ASHA_MIN_MTU 163
 /* The default of 672 does not work */
 #define ASHA_CONNECTION_MTU 512
+#define ASHA_CONN_INTERVAL 0x0010 /* 20 ms in 1.25 ms units */
+#define ASHA_CONN_LATENCY 0x0005
+#define ASHA_SUPERVISION_TIMEOUT 0x0258 /* 6 s in 10 ms units */
=20
 struct bt_asha_device {
 =09struct bt_asha *asha;
@@ -162,10 +165,8 @@ unsigned int bt_asha_device_start(struct bt_asha_devic=
e *asha_dev,
 =09int ret;
=20
 =09btd_device_set_conn_param(asha_dev->device,
-=09=09=090x0010 /* min interval =3D 1.25ms intervals =3D> 20ms */,
-=09=09=090x0010 /* max interval =3D 1.25ms intervals =3D> 20ms */,
-=09=09=090x000A /* 10 events' latency */,
-=09=09=090x0064 /* 1s timeout */);
+=09=09=09ASHA_CONN_INTERVAL, ASHA_CONN_INTERVAL,
+=09=09=09ASHA_CONN_LATENCY, ASHA_SUPERVISION_TIMEOUT);
=20
 =09ret =3D asha_connect_socket(asha_dev, cb, user_data);
=20

base-commit: 7428ca2df9356363079db0f48412c20cbdb9471f

