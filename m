Received: from mail-10698.protonmail.ch (mail-10698.protonmail.ch [79.135.106.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DAB72602
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791284438; cv=none; b=WPsnND9E6QEfeSAROHwyvk0bjYUJQXSc4g12n2lS4VKd/khFCT0+rUAtYhhA5Bc6B4zpbgav567Qp9ks8k2ATU4DRM4LzQTZejbuX85kEUMVF6uhYzLqLrgIVnvIMXbyeQEvzyrG5YDC1qvkD4hMgoa5SwY9wg1CVnWnD0ljcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791284438; c=relaxed/simple;
	bh=CstqVf7qbwr1IJ2+Y4rA4Jvoytx2dNE8SphheBb3WmY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcYE6kzzciiKB6n8pihIzqzAajo72gFRMR9kBP+DJoneD39P5llRrnDtS3Zv9hugjWXJITZWxfYynd3tzw4Yf04mbshzwP9VWUF8lk9fiykFDu6sFAhZsRytHiNxR0BwT5/kFMfb6snG4chlVf0vVx7ZnEA3ClLqUjXXAbyC3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nMK13pGK; arc=none smtp.client-ip=79.135.106.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nMK13pGK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791284427; x=1791543627;
	bh=CstqVf7qbwr1IJ2+Y4rA4Jvoytx2dNE8SphheBb3WmY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nMK13pGKZ8tlDRc4Jf4wldBCcAGGtExkGXwfQ4Qu4YLdvjQQ8vI7QSGqfTuHOhUXm
	 kp0kDUuaWwS43mBNbL2YCmUZ5UeOv2xDUv43KbSXSGoJ7xAvR2ceJIyvHooksTdx7f
	 SZspwpi2IbYP9GJ99Ku8s/gLZ4Z7cGI0oG2D7wPQPUTRDcdUwPfrlaRPjC12pIvRbd
	 jNjzK0UOMMqWvD8S15u3kEKPsLk8SVS57ZDHB6ckCyDBtZg+hevJ1Xl/joGLMGN2Dy
	 tmnTEWcb7ZCFJBJHcLWnyPvxDJo6R+SWcpSInMya2v9uQO6ZdbeDAISpUm/e21UHXd
	 FTUJPo/qdqeTA==
Date: Tue, 06 Oct 2026 11:00:24 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: dt <derektern@proton.me>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH BlueZ v2 1/3] transport: Preserve Release on late BAP ready
Message-ID: <PYDC9kPUFiayBviaLIJziLbacU4BWxj1nr2x3XTYoyuEajR8F_65ogs4D3OS3dMS7pzzn-x-4ekzVz2lfDRlyviCh5T-ZRm6GV-wtf-Ud0s=@proton.me>
In-Reply-To: <1u4ljEAFqePjPZEbN-y_9BTWLNsqBnUqRAbQRokpIgWxUtdGlZtDC3gN8xIf4ovMpyIQ_UKBvvo2U1qgLrd7AHY8a2x1weRU9PUXtwSzUbc=@proton.me>
References: <1u4ljEAFqePjPZEbN-y_9BTWLNsqBnUqRAbQRokpIgWxUtdGlZtDC3gN8xIf4ovMpyIQ_UKBvvo2U1qgLrd7AHY8a2x1weRU9PUXtwSzUbc=@proton.me>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: d9a15674421ebdc4459e57494f7d10d05944e2bc
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>

A late stream-ready event can reach bap_resume_complete() after Release
has queued Disable. It then replies to Release with an Acquire payload
and drops the Disable request ID. Client disconnection can subsequently
free the owner while the Disable callback still refers to it.

Only complete pending Acquire/TryAcquire requests from this path. Leave
Release and its request ID for the Disable callback or cancellation.

Fixes: 466fce0209a3 ("transport: handle BAP Enabling state correctly when r=
esuming")
Assisted-by: Codex:GPT-6
---
 profiles/audio/transport.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 8cfc98a52..e001f7315 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1965,8 +1965,16 @@ static void bap_resume_complete(struct media_transpo=
rt *transport)
 =09if (!owner)
 =09=09return;
=20
-=09if (owner->pending)
+=09if (owner->pending) {
+=09=09const char *member;
+
+=09=09member =3D dbus_message_get_member(owner->pending->msg);
+=09=09/* A late ready event must not complete a pending Release. */
+=09=09if (strcmp(member, "Acquire") && strcmp(member, "TryAcquire"))
+=09=09=09return;
+
 =09=09owner->pending->id =3D 0;
+=09}
=20
 =09if (transport->fd < 0) {
 =09=09media_transport_remove_owner(transport);
--=20
2.56.0


