Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDBD386426
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791284469; cv=none; b=nCek8pU7kMNMoQpybb3CEBBKOUE5PMPWMYBPDfFijsdAFvDr+WACAmKjQ03JTJLWPfWRokAI8D6TA87P5L5dQgSjMOaXRn8GoqaULDWj/rZ21QTv7KQRk4dHVbyJ3s3Ch3wjl2Ls41Ya/TA0VgOo8yCCGuvTKl9aP4IXandGfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791284469; c=relaxed/simple;
	bh=LBCKTZ5ROq3HgiFubQLKuPhe7mTr1ErvGiqrMpE/A+E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btgcbZMItNCUmIRHHIqn0EvmvTmrn8YbvSBLKziQJa37xQlJ97Kr3G+s3NPyvxSm513wyAJshUuRc6vBtBW8mmZAmuCdiMSBn9WhRHahDHA66ByejnJI9lDrruugv684Aaoze/kWABrT/U9ulP2cFjOcpl+S1qvPPkCbDpYwLLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WelleT4r; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WelleT4r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791284458; x=1791543658;
	bh=LBCKTZ5ROq3HgiFubQLKuPhe7mTr1ErvGiqrMpE/A+E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WelleT4rAko4N36NQiGHGensUNxh0uBcXEDIh99ehMfHxZ2r5qyD9rpd5+pJwTHz6
	 lwK/pMX3O6zmunkWVf5gBWyTYKXeg9Lvmwqlz82yxDUIfYIu+HBdpakNlnegGkEi9K
	 O6JO34TCnApQOjN+qZVd3VJEdJMLr/7I6TDziGYiobrZJIh1eXh/MOTvIVhTGcnQyQ
	 vVs2FfvK+Vd/a7xEL626GpGPyumJYBqUW/VZN0ShhUWxd3NMz3dP3W+TAC/q9whAdA
	 cyKDq36em0y+50t8urJQ/D0TrtNfUfNYSdc9s1cefX3tMXqwQA6cotnPwI7GrEgWtk
	 d6W6AE48JAFOw==
Date: Tue, 06 Oct 2026 11:00:53 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: dt <derektern@proton.me>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH BlueZ v2 2/3] bap: Recreate stream IO after an early Enable
Message-ID: <0niCWUnw7oaYyt5ZjyRxqHXF6k3rWxNVqziajeGVdkQ3AFtxsNikEGFh7dbLuFsULTWid2Egm1hAJyOhMmJ1c1jlnt_bbRvpuHmx2FbLuGg=@proton.me>
In-Reply-To: <1u4ljEAFqePjPZEbN-y_9BTWLNsqBnUqRAbQRokpIgWxUtdGlZtDC3gN8xIf4ovMpyIQ_UKBvvo2U1qgLrd7AHY8a2x1weRU9PUXtwSzUbc=@proton.me>
References: <1u4ljEAFqePjPZEbN-y_9BTWLNsqBnUqRAbQRokpIgWxUtdGlZtDC3gN8xIf4ovMpyIQ_UKBvvo2U1qgLrd7AHY8a2x1weRU9PUXtwSzUbc=@proton.me>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: 6302fe3f7b4e144ceb02372953c645e10ea2909f
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>

When reacquiring a transport, the stream can reach Enabling before its
previous CIS finishes disconnecting. Once teardown completes, IO
recreation accepts only QoS, while CIS enabling requires existing IO.
The pending Acquire consequently stalls.

Allow deferred IO recreation in Enabling too. Keep the existing CIG-busy
checks and recreate all IO before enabling CISes.

Fixes: 7feff47a9fbe ("bap: delay QoS & IO creation if CIG is busy or setups=
 configuring")
Assisted-by: Codex:GPT-6
---
 profiles/audio/bap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 928796e1e..a0e0ba60d 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2576,12 +2576,17 @@ static void update_cig_setup_io(void *data, void *m=
atch_data)
 =09struct update_cig_data *info =3D match_data;
 =09struct bt_bap_stream *stream =3D setup->stream;
 =09struct bt_bap_qos *qos =3D bt_bap_stream_get_qos(stream);
+=09uint8_t state;
=20
 =09if (qos && qos->ucast.cig_id !=3D info->cig)
 =09=09return;
 =09if (!setup->want_io || !stream || setup->io || setup->closing)
 =09=09return;
-=09if (bt_bap_stream_get_state(stream) !=3D BT_BAP_STREAM_STATE_QOS)
+
+=09/* Enable may complete while the previous IO is still disconnecting. */
+=09state =3D bt_bap_stream_get_state(stream);
+=09if (state !=3D BT_BAP_STREAM_STATE_QOS &&
+=09=09=09=09=09state !=3D BT_BAP_STREAM_STATE_ENABLING)
 =09=09return;
=20
 =09DBG("%p", setup);
--=20
2.56.0


