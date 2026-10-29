Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793242864;
	b=XhmH2QcDuEsOJBDmfX5VvoUW/KulqySVdFD3cMwUpdVEDRGoRydQtOIoVU6jna3QyAmX
	 ueq2KtCV++kAv5m/l4JR+EvSwn0iLXZIMEFP6AyFjZcLRGQYDRX8aKKX3NKnoXapeG2Xi
	 HV4gplISpi4AJmLFxljQIWA1exE3G9a+9H+IcH2WinL96H2bBbnfJX/SG5AKBbUono468
	 H874PCfKgfPXCCTd48oiV66qzW7n/ddNzaKDs7JATovP3OS9PyXoIQ93kFcmpip7kVgNO
	 ABJWVwoCne5h2LpU0rJeZunwKLw8f42Z7O1vDcbAk5slf3Z8jbjRE4aQNSsLzPZEFgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793242864;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jocVzTdqCGnFG3txOkPV6+h67AfYDrXBK6YcTLJYezg=;
	b=Syj5KBR4FjYMFm8Bh+D7vD3ojkkjRROI2i/d+SIplKtZwFBgjwqDy1XPWqknw4uWTnDY
	 JPxEsy660nSqXZ4guf9PJkwWaJiL5KQ8ZWwAePST0ON6DjyLFV2F2qH5M6xkrMk8yLqBS
	 B+Sb5HM0KP1k5ge4ed6IsjaNtTKa2hpqtq3aR7pPo0ABhtLc4D/gTRO3vU34FTtztXykp
	 jNwrnWQ9JQamfeHS/yAXUTHEyW0IQnZobcHsKUY5aKwKHNqrCdi1gSynZtf0dlg5w4e8B
	 X+5kv3OQYCPudf3dYmOH8+uo2zNxly8v4luK6EbPSySiP7PUF6uU2iPn1XF4wwVv2UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=Lu2sV4E3;
	arc=none smtp.remote-ip=79.135.106.28
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99575606A31D
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 03:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99575606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=Lu2sV4E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793242858; x=1793502058;
	bh=jocVzTdqCGnFG3txOkPV6+h67AfYDrXBK6YcTLJYezg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Lu2sV4E3EjxC3i3HtuL2qDkVvPBnf95pQSGGQgwlDmqhOuPSm7nmiVFaOXr4mcDV4
	 Ai5irYCkl3KbxvVrorLLWVSXnanH3xDUiqA8hFmP05W3PBESXiF/7HnxSHrGY7zQUT
	 vVD2QR/AwAXPPgxl5W7K9n9/USDwEjCjeJI7kDhmAKJHoK/Um1zNZtx8/Y3S+mPuDT
	 nOl/MwanCyjdWt/RRqv4zYgZyiZEPsWgk+nAwxOEy3BkJUDErna4gNbmWsTYJUM9tH
	 u334VoOXlk32bSMQlAHES/CkqQ5WZ0wdcNcbkB1L18I2c/ci/cMbIj0ZBr43W9Vg3A
	 in73ileKKuMfQ==
Date: Thu, 29 Oct 2026 03:00:53 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v3] asha: allow LE 2M PHY on the audio channel
Message-ID: <20261029030037.1300725-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 20e8b2615227cf4cb98a17469fb9e99a43957388
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

Allow LE 2M alongside LE 1M on the connected audio socket before starting
ASHA. Keep streaming if the kernel cannot set the PHY preference.

Assisted-by: OpenCode:gpt-6.1-sol
Assisted-by: Codex:GPT-6
---
Changes since v2:
- Drop the standalone PHY unit test and its build/ignore entries.
- Reuse the existing test/simple-asha playback script.

Validation: builds without warnings, 35/35 native unit binaries,
and checkpatch pass.

 profiles/audio/asha.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
index 8e625fd..d862247 100644
--- a/profiles/audio/asha.c
+++ b/profiles/audio/asha.c
@@ -88,6 +88,8 @@ static void connect_cb(GIOChannel *io, GError *err, gpoin=
ter user_data)
 =09struct connect_data *conn_data =3D user_data;
 =09struct bt_asha_device *asha_dev =3D conn_data->asha_dev;
 =09GError *gerr =3D NULL;
+=09uint32_t phys;
+=09int fd;
=20
 =09if (err) {
 =09=09error("%s", err->message);
@@ -105,6 +107,15 @@ static void connect_cb(GIOChannel *io, GError *err, gp=
ointer user_data)
 =09=09g_error_free(gerr);
 =09}
=20
+=09/*
+=09 * Allow LE 2M with LE 1M fallback. Older kernels may lack BT_PHY.
+=09 */
+=09phys =3D BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+=09=09=09BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX;
+=09fd =3D g_io_channel_unix_get_fd(io);
+=09if (setsockopt(fd, SOL_BLUETOOTH, BT_PHY, &phys, sizeof(phys)) < 0)
+=09=09DBG("Could not set LE 2M PHY preference: %s", strerror(errno));
+
 =09asha_dev->io =3D io;
=20
 =09bt_asha_start(asha_dev->asha, conn_data->cb,

base-commit: 82667d713949447d7c94725432c61b33689ae68a
--=20
2.56.0


