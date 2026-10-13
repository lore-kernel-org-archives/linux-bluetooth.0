Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8C1F3BAC
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 03:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863497; cv=none; b=pHCV8CciEZO6Kbs+o3+kZYrab0GDqIXon5xbdiWopxJHgJJ5EtcBrJeYauhwMmvz0me00T/JP73qa2Yy6lTHUR2X5LRyGfGLJ5aK203s6okbvV8jp38DFl+oMYgYvV/RkKGH34APaXZdgyspbf4vniRb+8WRFq+tI/vVsoksIP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863497; c=relaxed/simple;
	bh=ctlwSAaC20XVntO0eA3ch752o9MSQmF25Bc9OcxG2jI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NspPtNhWbrBrv9Sqefrt2FmkcpRbnJg7NPd6YI0oOXuhKg3r1YFoHUd5tssTud9qg89uFQqUL9ATDfdvVZcOPf2x563+PZPYX75ClbuFT/zCUBtxBvAGpVQyxpp/62HAs7QvfnRoGPXDNKyKDZTvlwmKieztvT/oMVoqF7QEumc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kw4+c49S; arc=none smtp.client-ip=79.135.106.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kw4+c49S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791863492; x=1792122692;
	bh=ctlwSAaC20XVntO0eA3ch752o9MSQmF25Bc9OcxG2jI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kw4+c49S/BWfd/2lRYns800eXvfpsduP7NdmxJgzECRWSk5LmhZ8N4xRN7R22vjH1
	 UkiSVnHaU79J9rH5lF40nR0NIZuCY5zCsJehaLpoWo9h2y2gMn2jTQ+jByjEkOG1TG
	 WDpOc5WtNPZMk4gajxQqK0tDTTbpcwFBkN2y7Gl3eKGdEyr1fqeOpX4+iMVwraN+oT
	 1kDtjOMH0ldkSrM9fnGYdvsoi8Wxae9vXWQH1juSDEjFID63zkgoqX4R5QXAAEM4SB
	 g4rIYfC3sY2Hp/OztLoQrwx0t/bk1KSIdtLLiz2MI2Slj/T0qsBUjtmBRDg0C7LG5V
	 JcGvbWyo5mSEg==
Date: Tue, 13 Oct 2026 03:51:27 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [RFC PATCH] asha: use robust streaming connection parameters
Message-ID: <20261013035111.522738-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 298057700c7c0360a5349d6d57c9b1d11c0ba958
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The tested renderer requests a six-second supervision timeout and
latency of five events. Use these values instead of the one-second
timeout and ten-event latency that accompanied link failures.

Assisted-by: OpenCode:gpt-6.1-sol
---
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

