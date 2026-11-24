Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540875;
	b=nroe2KQ4lax0hCsYl9K2M1H5rO5Wxehz2mh8Wc02+CR2CksyzjyVig5FJaPElH1wN27Y
	 fGHAiUKsAXZomwhlMS87IFJMlrO+vULXVb1W/Hu/Tyc8wK8PDzuqIwSD+fu6+YFmkBLbI
	 vN+dXSXEOiLW4nJGp7GMl66aMJE1HWqL04/+/r6EUZW12e0MzrYaxcCC7DygnfaokKEMm
	 cqOfx5XQUStgtETqVo1lRX+AIan5+geigsYbTu/eNG06dz31RthhNxPGY0pCU1HK7zVvr
	 2ldNflNFvVU60F2jBDpW9eT59GHtD0oOvMWMRVgQdHMmT6pORGa+bscznEX1oBJUnDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540875;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=2/6ySiDGwni9RpELdfQluGW4uegOP0fKwnNv2RVOXCI=;
	b=ogPREsxkLb7A9Mv+F0Dcn/WDttAX9IUU0lbCtTNp2sOb6OnBeDPJKDG/O7sKjA24m5ve
	 w00bqa8Dae7Jv3k0AltwGXUMHqZBqi9vjlZ4Sq4F2mKBTsjE0mGHq4bVAujpWPvmlbumP
	 +DWCW7AVVYJ4NKUBd2oenkYAQua6JhGp8DWia4iKFxIhXlzdKYO/FIz4BNE+hAhgtJn8i
	 kNYtzkSP6eMalWkN7Pdd3DslSx+R9yNAGWsb5E2U5h+7cC99gNcnMFiQe3zByJ7jC1Jie
	 6Gc4lY5JikWELy96LsEEBFdsd3pyn+L86PODvlCb1nlzSnMfURlUDhnmb2tP/fL89eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=kRu5bUQG;
	arc=none smtp.remote-ip=185.70.43.100
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AA1606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 17:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37AA1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=kRu5bUQG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795540871; x=1795800071;
	bh=2/6ySiDGwni9RpELdfQluGW4uegOP0fKwnNv2RVOXCI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kRu5bUQGzUp853vvlpjGnNuxxkmUQ6oLMOTs73X3X26kT/kJwiYmHDmeD+Y7/DzjU
	 ZgeShInvWxupP6v1uC5Sq5iQ6GmeI+p4ZDOXsxIRCOzs3W9DOj8+AbLV6PvdSeKKeE
	 NgRVk3yidbrwhq1G1dfws0Hsp6+gKf7m2IuTQZoLx73R34LwyVcixZHTDqWWahFHc4
	 CKQQuY0xOgynYyRfjWBdHIQVvmw/n+z+Pqio0nAgnlFbGtynTMqrDGTbWS2gPA2+hm
	 jsRC05sw9eimb/1oRf1kGRHyum7zHJiIIh/BYbGHpQDnbZl33uwfL2JMq3sAn1snRy
	 dms1Uz/rlsIhA==
Date: Tue, 24 Nov 2026 17:20:55 +0000
To: Arun Raghavan <arun@arunraghavan.net>
From: cochcoder <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [RFC PATCH RESEND] asha: use robust streaming connection parameters
Message-ID: <WUthOy_PV6V8FWqN--CeTaWpb0S2EcRN0wKqiNV3owQKOJuehZGp3kUNFsylWP3NEkpttAo7vxXG9tGgwbj2bmAlkglXRg7uxEqucs1MGLg=@proton.me>
In-Reply-To: <182c2e78-8c98-4686-beee-9b45dfa02d34@app.fastmail.com>
References: <20261028133204.262169-1-cochcoder@proton.me> <182c2e78-8c98-4686-beee-9b45dfa02d34@app.fastmail.com>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 83dcc321679735c849b2bcaf5895d7a714ce1fec
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

Hi Arun,=20
Since BlueZ already uses the
10-event latency and 1-second timeout=20
from Android, I am withdrawing
this RFC for now. Thanks for pointing
out that reference.=20
Thanks,
Kyle



On Sunday, November 15th, 2026 at 9:23 PM, Arun Raghavan <arun@arunraghavan=
.net> wrote:

> On Wed, 28 Oct 2026, at 6:32 AM, Kyle Pepper wrote:
> > The tested renderer requests a six-second supervision timeout and
> > latency of five events. Use these values instead of the one-second
> > timeout and ten-event latency that accompanied link failures.
> >
> > Assisted-by: OpenCode:gpt-6.1-sol
> > ---
> > Resending unchanged after automated CI PR2667 expiry; no source changes=
.
> > Previous submission:
> > https://lore.kernel.org/linux-bluetooth/20261013035111.522738-1-cochcod=
er@proton.me/
> > Earlier remote functional, lowercase checkpatch, Codacy Security Scan
> > and
> > outer-CI failures remain unresolved. Historical local passes do not
> > establish remote success; no new hardware or functional test is claimed=
.
> >
> > Submission review notes (not part of the commit message):
> > Local validation is for base 7428ca2df9356363079db0f48412c20cbdb9471f.
> > Compatibility with newer upstream tips has not been verified locally.
> > October 9 N8/UB500 trials independently restore timeout 1 s and latency
> > 10. Completed HCI values change as intended; the variants have five and
> > four supervision timeouts respectively. Restoring latency 5 / timeout 6=
 s
> > restores short streaming. These are device-tested values, not universal=
ly
> > optimal ASHA defaults. STATUS and the other downstream fixes stayed on.
> >
> >  profiles/audio/asha.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
> > index 8e625fdca3..409b4f20b5 100644
> > --- a/profiles/audio/asha.c
> > +++ b/profiles/audio/asha.c
> > @@ -50,6 +50,9 @@
> >  #define ASHA_MIN_MTU 163
> >  /* The default of 672 does not work */
> >  #define ASHA_CONNECTION_MTU 512
> > +#define ASHA_CONN_INTERVAL 0x0010 /* 20 ms in 1.25 ms units */
> > +#define ASHA_CONN_LATENCY 0x0005
> > +#define ASHA_SUPERVISION_TIMEOUT 0x0258 /* 6 s in 10 ms units */
> >
> >  struct bt_asha_device {
> >  =09struct bt_asha *asha;
> > @@ -162,10 +165,8 @@ unsigned int bt_asha_device_start(struct
> > bt_asha_device *asha_dev,
> >  =09int ret;
> >
> >  =09btd_device_set_conn_param(asha_dev->device,
> > -=09=09=090x0010 /* min interval =3D 1.25ms intervals =3D> 20ms */,
> > -=09=09=090x0010 /* max interval =3D 1.25ms intervals =3D> 20ms */,
> > -=09=09=090x000A /* 10 events' latency */,
> > -=09=09=090x0064 /* 1s timeout */);
> > +=09=09=09ASHA_CONN_INTERVAL, ASHA_CONN_INTERVAL,
> > +=09=09=09ASHA_CONN_LATENCY, ASHA_SUPERVISION_TIMEOUT);
>=20
> These values may not make sense globally as the notes above mention.
>=20
> The 10 event / 1s come from here, fwiw: https://cs.android.com/android/pl=
atform/superproject/+/android-latest-release:packages/modules/Bluetooth/sys=
tem/bta/hearing_aid/hearing_aid.cc;l=3D453
>=20
> -- Arun
> 
