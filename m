Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794014648;
	b=cNvBzil4a0axMGp/Pwgniondf4b69av5wemTM3uihmRNMSmiVrjfL96KTqjNSo5bRjcT
	 MGR8rfgUKrvzV50GiyhF/YJ/5sGCSVpdhVPSk/PJ7pV5ka3E1W/ZcJ0hhyPLtQWcBGvSD
	 xQIgOO+S3F1UpPTK8yaWJ95qo+tSwCjI/bjKXydf0IlQDoGgoXleuFTurKeD2rzHlRSwu
	 DRevFfU9j6jkkLXgrOftyFkgO01iyczDS9p57pE+sTznxLZwTBMyV1yIpRry70s6n7a5M
	 9+THvcSI+BGUV1OulbwWNWJsvESxsmtJkLbgQwRYnEDsUwuRN3KgADWi/leMl0Q9UwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794014648;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=/HxfhwQL2If022086B0t59Y/gBaKOCdXLnDbgXxuaPU=;
	b=bx1JkiYfpDiYQ/u5Px2pejYF5mZFH3d0+f5GMZhaw1aHqxK8/Ya+nHYklXWZk/4K6y0r
	 K8wDdfykN5Mp0+1Re6oge4YWoWbsdWQP75Mef5MNASsxKM5tCW7uOTmZRg0oyUvSKrRra
	 EvVYNGxzWfFOlKG0VZVqXSc37pMLz+92/pPh/RXcLe9tylAPQ/9ELmt2bhSQ+ZjfS9MBg
	 hZhG0NpmaRCLQ4b6T1ZB5oWOOvdJwfYojaTNVCsncA4rl+SCVaJwv4cnE5Bg2ItHb1zxl
	 mZ8x6qzzcFqAN7YtlPgGCqWrMfuMWAqHsXjMCwa6TWOtg3/fHKwHnvhFIhGwoVWplyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=vxB4Qhj6;
	arc=none smtp.remote-ip=79.135.106.119
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111FC606A32D
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 01:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 111FC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=vxB4Qhj6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794014643; x=1794273843;
	bh=/HxfhwQL2If022086B0t59Y/gBaKOCdXLnDbgXxuaPU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=vxB4Qhj6lhqnrGBVpXSAtgh87ZVxiji61s9qCSHDKANuJrK+gWEQgxKhKf/s+rxow
	 XPb9iTfmB7px3GT77Sd7vrIAm20grublvW0sEGwz+HX+bkv2FySlyIyomdF6/kAoay
	 mncGbiUOt22jPJ+1hpUhXPs3mH59DTG0EiMFqn26/r0TTyzEYrMTHyMnkh8+fTW+dq
	 3iTIeLFphm5N8YgkAwqv1QuqVFRUsxgNSorAMtPtGPapoBHFCvbAp+0AhUJ65l9UHz
	 ujrmIkVfBt3dF1yvR9yZwfQ7xRYFdg2owXwFK1D7FBWAfyEyROqFvNwnZF0vZKCaPL
	 xbqfV0X5FihPA==
Date: Sat, 07 Nov 2026 01:24:00 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com
Subject: [PATCH BlueZ v2] shared/asha: Send STOP without a response
Message-ID: <20261107012310.1224254-1-cochcoder@proton.me>
In-Reply-To: <20261028133034.261833-1-cochcoder@proton.me>
References: <20261028133034.261833-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 29c84de7d07afe0211f1934f2e7fea8b3517fb9a
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

Avoid leaving a STOP Write Request pending after local state has been
reset. Send a Write Command using the existing helper instead.

ASHA specifies Write with response for STOP; this changes that procedure
and needs renderer STOP/restart validation.

Fixes: 9948168cca15 ("shared/asha: Don't wait for status notification on st=
op")
Assisted-by: OpenCode:gpt-6.1-sol
Assisted-by: Codex:gpt-6
---
v2: Drop the standalone mock test and redundant state-reset comment.
Keep the unchanged regression harness as local evidence.
Previous submission: https://lore.kernel.org/linux-bluetooth/20261028133034=
.261833-1-cochcoder@proton.me/

The ASHA AudioControlPoint table specifies Write with response for STOP.
Maintainer agreement on this deviation and renderer STOP/restart evidence
remain open. The local mock cannot establish protocol interoperability.
https://source.android.com/docs/core/connect/bluetooth/asha#AudioControlPoi=
nt

Pristine source fails the expected local mock assertion. Sent and reduced
source pass; reduced source also passes ASan/UBSan and LTO. Full make check
was not rerun: the preceding baseline review reproduced an SDP linker
failure. No new hardware, remote CI or acceptance result is claimed.

 src/shared/asha.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/asha.c b/src/shared/asha.c
index 79bb29bf9a..f1edc06444 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -284,8 +284,8 @@ unsigned int bt_asha_stop(struct bt_asha *asha)
=20
 =09asha->state =3D ASHA_STOPPED;
=20
-=09ret =3D asha_send_acp(asha, acp_stop_cmd, sizeof(acp_stop_cmd), NULL,
-=09=09=09NULL);
+=09ret =3D asha_send_acp_without_response(asha, acp_stop_cmd,
+=09=09=09=09=09     sizeof(acp_stop_cmd));
 =09asha_set_send_status(asha, false);
=20
 =09/* We reset our state without waiting for a response */

base-commit: a8067198717b38391ca183ed7f41a69ec4b81b6e
--=20
2.56.0


