Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636360;
	b=KUu2ZmE4FPsvUMDkdzqITFxcDNeKAFsKNaSDXjNjQNBX/yFhrHDeST+cDYQ71BtaNCw5
	 MdPVXJvRQ2zVKSUy5CZ3JKMWFQ20ySW1rlUAR/eVdZ5HPRL+ULTUxytGnyRsdUTyBsS4R
	 tMqfw6qYRf4mqmNrRy3FzNM0KwGTZgV3nhVOa7wEn/K5Vl9XjEU3zaL/PNb1qLH2X0Z//
	 j7li/3l4x+1y8gvjFGpAkPTu7N8vth9HgABaeI8arjmsb6sUQLv8/wAKq0JrzHMZxlFuQ
	 XE9elXuSrjSNyJzYr0qd94xyPZ9yn2uxIyt0hlb5ZiBezALOLhArhKu5jHghdIvVG+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636360;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=JI+2sH+Uu1ZOvGzPhcQFUiy4/8whn4kWR/+yXjsmH2A=;
	b=ZvVOiXpw4/7xMLyX4VSBiAhx/kHmT5/iqndMVhDuoTbLnQMYbvc38Ky1CPoGHeqOBufV
	 X9LUDoLcLleMSH0yy3YU2cp3+T/C2XnQskTs17xjTfOs1+LU6SIPoRZm4c10my0ExjpzK
	 ypSmc1MSOjFqRDay3jrrR2KAfj5t310RzmB6EgfoQP6kQu/Lnf9srh9+cDZMxP8vEoXNA
	 ZrZTLbg0jxackLyZw0cMxxBe2AvJyRMcaE0q7FsFL+WJkH2qcEUu+Ft1ILyAwVkNFKvgf
	 qiriOsJqIlbhKaF0YMEuQrjLD/aq/PsP6Yr+UYQZ+zXhvZUkxesdqaGOU+CexUoDHLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=Stc+VYRm;
	arc=none smtp.remote-ip=109.224.244.123
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497EB606A329
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 06:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 497EB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=Stc+VYRm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794636353; x=1794895553;
	bh=JI+2sH+Uu1ZOvGzPhcQFUiy4/8whn4kWR/+yXjsmH2A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Stc+VYRmdk8WvDG0TvfGqt/Rea1MEiNvinVj1xNwjTepofmFzfWFjAM83clxcGRr3
	 6QuzEG3y+trxK44DY2dULss2a0IemRcGw0hw7oY4Nb3Bl8wt4b8qj4KMbk+hjGXKp7
	 K2GpE2tkzEaSl1JOVdxVjd4blryn9Kyz0diJLyGogRaRkcK+1QnxOnSKy3x/Rd00yN
	 bjoo4aXMKDlgzZcbQsgym6KJfovKjYB8M1GlUSMjBflFXcLVaLwgJdFuBjo5KhsVBb
	 7E1Do1t2M1RdAWpC1sV0Mxl1NTwK3yUytSBJ/m6EiN93ZZqOTexlFwMUq1zzqPpXQ7
	 yr/P3vgSbGbIg==
Date: Sat, 14 Nov 2026 06:05:49 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 1/2] Bluetooth: L2CAP: Restrict LE credits to connected CoCs
Message-ID: <4278a9caf4dc8e949092452c141a5be465ec77e1.1794617024.git.github.filter194@slmail.me>
In-Reply-To: <4278a9caf4dc8e949092452c141a5be465ec77e1.1794550328.git.github.filter194@slmail.me>
References: <20261113030556.75484-1-cochcoder@proton.me> <4278a9caf4dc8e949092452c141a5be465ec77e1.1794550328.git.github.filter194@slmail.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 5415ea1f0499e80b9d9d46183518e4f6cb0473ee
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

Do not let credit indications change fixed channels or complete pending
connection setup. Validate the channel state and mode before accounting
credits, checking overflow or invoking its resume callback.

Fixes: fad5fc89594d ("Bluetooth: Add LE flow control discipline")
Assisted-by: LLM
Signed-off-by: Kyle Pepper <cochcoder@proton.me>
---
Changes in v12:
- Reject the deferred ECRED batch when an accepted child closes before
  the connection response; close all siblings instead of disconnecting earl=
y.
- Patch 1 is unchanged.

Previous v11 (no cover letter):
https://lore.kernel.org/linux-bluetooth/4278a9caf4dc8e949092452c141a5be465e=
c77e1.1794550328.git.github.filter194@slmail.me/

Review:
https://sashiko.dev/#/patchset/4278a9caf4dc8e949092452c141a5be465ec77e1.179=
4550328.git.github.filter194%40slmail.me

 net/bluetooth/l2cap_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 09ff32394..4e8aec98e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5464,6 +5464,11 @@ static inline int l2cap_le_credits(struct l2cap_conn=
 *conn,
=20
 =09l2cap_chan_lock(chan);
=20
+=09if (chan->state !=3D BT_CONNECTED ||
+=09    (chan->mode !=3D L2CAP_MODE_LE_FLOWCTL &&
+=09     chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL))
+=09=09goto unlock;
+
 =09max_credits =3D LE_FLOWCTL_MAX_CREDITS - chan->tx_credits;
 =09if (credits > max_credits) {
 =09=09BT_ERR("LE credits overflow");

base-commit: da3cc02587c629420603df4395179ec82955c941

