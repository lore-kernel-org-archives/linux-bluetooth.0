Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF994E80A5
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554580; cv=none; b=I4pQFvbsMGaXWsv6aC6bSIZRJt83IUSFA8tdB15QU6QKKXchcCuzDNyrk3bHs3E+OsQGR0D/m5db5YaSmNX5RzO0uLDOhNXoF+VoI6JUYDuZqtO1mXyRAuPeFC2JlVzTMizbV/w+kwPjh/yd2VxHhQruwZO8I1VYpUJXRsQ6xFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554580; c=relaxed/simple;
	bh=G/FiRrHPRGhNfkF2o+LinHCrBF66r0nwgPvOeV0sCcI=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xd96LjCvwy7yH2kEyMGMk6KWhCl7eycU5p5KD3Xv7owRSMljt3rys8gAHgHg0cq01yZb0pUo3eUgHhScwT05Wn0HaAj46drAABbQGUczarip3d9Qy44I0KqXlzVksSQifxg7/RNY25WwZVlODQFg1Xnfift6rmCKKkYWAtGY4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dbZfyB/l; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dbZfyB/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789554568; x=1789813768;
	bh=G/FiRrHPRGhNfkF2o+LinHCrBF66r0nwgPvOeV0sCcI=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dbZfyB/laUDqqYGBLSoaCK0V/fBQU1/Y34OFVfj2EvPVKZ9wlOn8fcXFE+xRURgI9
	 qBCkC9WWxu/ki8yVy8UET94xhWCKKr9FCShgLrZ/26kuHRIhm2jp8YHYuJgWZtdeuX
	 nSpSD2M0nguV8tV+mMSMBSVDwEaNh6Mx87D+jeMHE09N7L67LYD8KU+UgG/r3hcclJ
	 Mveuh3pknyK2nWc8Ce3XmtGuCVt4n5IMulksmnvOPmNuetFhr2Iqh2qEcwRviQXzTp
	 dHWlFbXw0YtKB0rP0/LpuI6c+z6mV/X0FZmUXKH8cd5s/Sf6Owx4RokCc9PHf5ul24
	 BxRty/xzne92g==
Date: Wed, 16 Sep 2026 10:29:22 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: dt <derektern@proton.me>
Subject: [PATCH BlueZ 1/2] shared/bap: Skip local metadata Config callbacks
Message-ID: <VPeeCvkuNkEcQo9M5HlwGnyftq-hu4hT1wqkc3pjPtao6HWEoFu2rWyFMtz0K6vG4l2DDbyg4ZfvO5CQb2zR44-UcNh3l6qOfjf90ThTyxg=@proton.me>
In-Reply-To: <IGuo_ED6hoZcdNfKi5TCkYNNfYCJKn1CUSYS4a4ZNZ9WjaZCMI3rmBzLoslV22TvEjShB4iyBBAec3nrM4mMGI_r8dHKBUfAGLjZxXmgfIE=@proton.me>
References: <IGuo_ED6hoZcdNfKi5TCkYNNfYCJKn1CUSYS4a4ZNZ9WjaZCMI3rmBzLoslV22TvEjShB4iyBBAec3nrM4mMGI_r8dHKBUfAGLjZxXmgfIE=@proton.me>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: 0b42539c045fe34b7463abf6501633d9eee57cd2
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
 src/shared/bap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 891a2f4fd..44cfd1ab4 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2278,6 +2278,11 @@ static uint8_t stream_metadata(struct bt_bap_stream =
*stream, struct iovec *meta,
 =09util_iov_free(stream->meta, 1);
 =09stream->meta =3D util_iov_dup(meta, 1);
=20
+=09/* Local client metadata does not confirm the peer codec config. */
+=09if (stream->client &&
+=09=09bt_bap_stream_get_state(stream) =3D=3D BT_BAP_STREAM_STATE_CONFIG)
+=09=09return 0;
+
 =09switch (bt_bap_stream_get_state(stream)) {
 =09case BT_BAP_STREAM_STATE_IDLE:
 =09=09/* Initial metadata */
--=20
2.55.0


