Received: from mail-24428.protonmail.ch (mail-24428.protonmail.ch [109.224.244.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4348D51123A
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655838; cv=none; b=s70iuqz92o5CCnovUbNnSy71LhcEarGYmG0B1qs3E8N7lq9lNqXMrp9ZnMsCNzScmfmhdkL6Hgh9f2UGdVyWfnMv+lm64NPNNIIm8+otik9DkvoXMiwjFBFOlCRcQf9Y9qaNHOu9oeF5PR5XtCxLgy6ULzfZZ4Adx45ylUxAhaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655838; c=relaxed/simple;
	bh=hB6a63ZT8vaG0GXHliNlf8JFKUvAukl4f4D11VIjUe8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDE0YG1uCsv/Db5gQZuj8q4QIjyeMHya57BB2PNCmMeIXGC4oN0BXOzJ2aCklUFMU7zLWN28RH+lFCvc8PQqtmoNI7LasiL3W/j9aAiudFGQD6o867bEpPfJYezm6xRJT1kp0acxBF2HrfTMJDH+1cmFJZbYLhB2mhPdse9WTkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=N8MtCrAO; arc=none smtp.client-ip=109.224.244.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="N8MtCrAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789655827; x=1789915027;
	bh=hB6a63ZT8vaG0GXHliNlf8JFKUvAukl4f4D11VIjUe8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=N8MtCrAOt/dul6hCO0zR8xUlSPKtucNQptLonEp3JpVJYcB2qZNplRcmn4Fo0txvw
	 jLVUm9zWW2eOPg+O6XJ/CGSwLy9YKEoaIRgQCAXGEcl0HUoCAFMUTg/+lyUvdmS4uv
	 z7ZJUOuN25Zp/zn41jgmd+Ea05w22YvNVN2d/OuxYXUV/vqGCOKhNm7Sa3qgcXXOxe
	 GTbNW2FJedEhnG1C5o28R677fZhj4GNYw9ym5ESqIb9k4icHlin1JLI6ZMz7jroDEJ
	 cLtuM3a5xBCHl4y8kA7mOKLhYnDbpOChXTLq3C2GK16ZzkddtoXFVHGr6hR0cIGZcU
	 JVo+vcNvL52pA==
Date: Thu, 17 Sep 2026 14:37:00 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ v2 1/2] shared/bap: Skip local metadata Config callbacks
Message-ID: <jqqyJM7RdaKVlEMJ4PZERpmPxyPBru6C9bQXb9ycHNKYLueOCkf0-7VQY6eXP6d4insUcrxuJfEw-nvKLEfieSqZfNWpj-vxmAgUKpCLH20=@proton.me>
In-Reply-To: <CABBYNZ+tf1SZb3ONdaySGEk=n27XofWepzfg2y_VTujTUc4eCg@mail.gmail.com>
References: <IGuo_ED6hoZcdNfKi5TCkYNNfYCJKn1CUSYS4a4ZNZ9WjaZCMI3rmBzLoslV22TvEjShB4iyBBAec3nrM4mMGI_r8dHKBUfAGLjZxXmgfIE=@proton.me> <VPeeCvkuNkEcQo9M5HlwGnyftq-hu4hT1wqkc3pjPtao6HWEoFu2rWyFMtz0K6vG4l2DDbyg4ZfvO5CQb2zR44-UcNh3l6qOfjf90ThTyxg=@proton.me> <CABBYNZ+tf1SZb3ONdaySGEk=n27XofWepzfg2y_VTujTUc4eCg@mail.gmail.com>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: 3fcd76614876b2a38e46e443d92cc0aab8ab4145
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>

When reconfiguring a client stream that is already Codec Configured,
setup_config() queues Codec Configuration and then caches metadata.
stream_metadata() emits a same-state CONFIG notification for that local
update. The profile callback treats it as the peer's configuration
completion and clears config_pending before the peer has responded.

If the control point response precedes the ASE state notification, QoS
setup can run while need_reconfig is still set and fail locally.

Cache client metadata in CONFIG without emitting a state notification.
Keep genuine peer CONFIG notifications and server metadata handling
unchanged.
---
v2: Handle client CONFIG in the existing switch. Other states unchanged.
Rebased on f87a79667. The second patch contains the unchanged regressions.

 src/shared/bap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 891a2f4fd..6d351d010 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2282,6 +2282,11 @@ static uint8_t stream_metadata(struct bt_bap_stream =
*stream, struct iovec *meta,
 =09case BT_BAP_STREAM_STATE_IDLE:
 =09=09/* Initial metadata */
 =09=09break;
+=09case BT_BAP_STREAM_STATE_CONFIG:
+=09=09/* Local client metadata does not confirm the peer config. */
+=09=09if (stream->client)
+=09=09=09break;
+=09=09/* Fallthrough */
 =09default:
 =09=09/* Force state change to the same state to update metadata */
 =09=09stream_set_state(stream, bt_bap_stream_get_state(stream));
--=20
2.55.0


