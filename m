Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34A524B1F
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762929; cv=none; b=Ydksk1ZGGnZw/HaDn53vxqs0s+jdK9x94Lo/bXcnCjfd+SzibZfRjsfyoIEZj3kLFGau3ElR1SrHeer6gywY3zg9A2dI97RNJonHfkGUi+OjAkee0kpmPeM8tKFkE6fJ64PbH1UfU1ftWIjCn6sxuL0Y5HsRtyDMmG5D7XWkoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762929; c=relaxed/simple;
	bh=vxUwUD6vkFeQpYVHUCkrFraiXvY81h4bdsdzp2kJ3Ig=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=q6giGXqzkIY+EP4UY0kCjzrga6FEkwwH9NO+cW04rbizjGozx4Y+SEcrY27k9VRtW1yZ4FC/m6xUW+KZVYKE0aomr+8aNJl3tZlSdeAKMLpZ6isKRKnNGsGHVo23s6OrhxG8VoiIEqH495Q5P60JuuZVc4JhBg2Zf+AX4uj7Po0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=R2IBXwq5; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="R2IBXwq5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=agnrh2bxffavxbhdloo5wgdowm.protonmail; t=1789762914; x=1790022114;
	bh=vxUwUD6vkFeQpYVHUCkrFraiXvY81h4bdsdzp2kJ3Ig=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=R2IBXwq58rAiYR/NAcjCSR2Q1IRe+HeOThphc7KxZF2l9blPsfCYLG77xaptZcGRs
	 6TCJ9TzIXQl8TBsxV3YoLytS9MruPbRvrvboiQkd1hwvkZZLNJCvhsk7X2Xukqn/7U
	 fSdt/PQvWuJUCQrUy6NFXKcbBhEUIKFK2YkiKKp6onk+onaiKpMck6AQmq/TD2bRYF
	 a8r5k/mhWtKvnsRO8nv0+JoqpQPBr/lPqOKz7KLwXkELnDGg4cnOzqzUZgKf6O30rK
	 jtIgffDNAduzuK16Rys9hinfZ0tqgPXu3hFb8x2TgrHIeTngUJ591dPKG54zQGDyzn
	 WJVKca5jWpG9g==
Date: Fri, 18 Sep 2026 20:21:51 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ 1/3] transport: Preserve Release on late BAP ready
Message-ID: <5yh1Rc6x2sD0mB4Zq0o-3_jmYYKB43NbYyd-ZXGrHGZRN61HyoWYmLVVTTHE2-SyPhNj8g2ktGAB0Zy_Jnq-Htnc1JspqPSHvIsZDC3KFlM=@proton.me>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: 056f9c44e49680fcc22c9d61a1e7574c31ca5ff7
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
---
Based on master ebbb4ee31. The new resume test fails all three pause
variants on that base with malformed Release replies and a Disable
cleanup crash. With the series: 7 targeted functional tests and all 697
BAP unit tests pass. The tests check transport lifecycle, not audio data.

 profiles/audio/transport.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index e3f3df50e..02c5c7ac0 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1952,8 +1952,16 @@ static void bap_resume_complete(struct media_transpo=
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

