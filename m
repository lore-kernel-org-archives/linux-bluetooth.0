Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9C37F8D6
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097050; cv=pass; b=Wf3WAXbcdPcoRZSEOQr5i3T5MlTNZkEtbjTvFFOnr7A2Q9tYFS+lMqV7+/PTqCumD/39HVjYSOYSOGHJ+2agU/dcCwNLNDhkcd4VdFxjweKUtFpkLFwfdpeu3KT/yI9rsGbcIESi+Up0KBV4bXx3MKP0CSpa7Fjs9rOnGTdwV8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097050; c=relaxed/simple;
	bh=Js3DrtMfeALuCr9jH7HT2D4yoT0pOW1O2gLxA8BF09k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FP+PnalWj7U5QrBCHD7dTnKZYjFKm5WmE4xQDhyrLkRqCV0jndQ8hiUltgkNLSDaHkjdB/1+OmJ/QikjonKedPj5ZXSXXGJ6mTlqQQusnzNOJbscWWHOrCAj/OhxSkuYyhmXwCtYU2WzJA90qztZW4yk/OKoi0zfHKKgrfi71eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qf0y7aXj; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qf0y7aXj"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65eb226b1ceso5937689d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 06:10:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781097048; cv=none;
        d=google.com; s=arc-20240605;
        b=LuCO+DnNPhVwEnxRx7NSjiIU6Cnv0ev/JOkah/Ll/NvvFI+IwR64yOma+sqX0T5rQW
         J2m5SfMdSnPnUQ4io2H2WR2Bwl++x2549VAGjvLM2K1wDJnjzi2N0coEBuQlBFF7mYQ0
         4j1TKZ3rVgvjZT3d7bby3TEWTeyLNm1hQ20f/dg4zarUQkaA7k88PL3PVhRT1C57OCM6
         Cxd9DhQFquCdcYTQArTCgGGxHiy4DaiIl1Nhz1luaMD3QqHpwHo3y0vMLYgu9J2SHJRt
         KfVsSicpp42MTliQ4F8+9jHrdGzuC7SoleNmTNws4o+O83FO64MqOkAX+oagL5gjLdFb
         3hbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lAGuphOk/bJ7apgus5loJDaLh3mBEGqJ5++hUCcRaR8=;
        fh=GEap9BR6CkTWDCt14gigHCvBi+pq/LGLk5Kefb7agb0=;
        b=VFxFIe+ldq/cFaTKr8X6L0pPGZBviU2yN1jbR0UwYiXGRKoDBk5LdKGIl03ufVJrui
         oVAqmMGkmKGT9JsJTHP/Rp2AI/R/MN40i9CduYAfeCiBhnPdVtKChouPQZXchDShkBo9
         lKKE1IKWm4ZK9BjcSA7w8CFAQ2CiooeRREAeDjyQOQpQRnP81VgT9X49LpO4/pwWxS6p
         3/LADjvZbUQBHRnF/+Ky0pxt0H8yvo95d7doPAaXu9O7ToVarPziGKks6Bb8OYHhJspV
         PoFjlLuaDW0yhSrQHwyjRSVenbIWXvsSQSifjAApI4XVqfreiy6CVtuM0VxOvz1z/bm4
         6Zew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781097048; x=1781701848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAGuphOk/bJ7apgus5loJDaLh3mBEGqJ5++hUCcRaR8=;
        b=qf0y7aXjhzPn48aA4gINXncopUTeZiDhyislpWtcxehGdMVR21ejxj4l4aioC5+1Mk
         543l1Ukx4zwXUutBd82UOqDwsymL9OQH55EjBF5wPkGFWUXwn01ySGtPDznNlbmMeC4Y
         A5D22daBh5wtuVa4oZitoOWuWvow64QYCBVNyW3ZSPS2vqJozAle9o8M/r67TJHymWen
         2erkeQSIV2r6YoCRrqR8p77qEJiLV8+aYQwA10wNBmtXhFv0JJgRgpvYVSfZAWqZHDA4
         lowwiLwBlsnpEHM5zFGc9W5kcZ1VKOj97ABTAqs2H8vAJNa6rrtOEeOcDHcAhazh6od6
         Do9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781097048; x=1781701848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lAGuphOk/bJ7apgus5loJDaLh3mBEGqJ5++hUCcRaR8=;
        b=CvvZLKfphlt6AO25HX4tb6Y+TAMTUrMRLGTfCiGwWS/sAMkkESl+Jpo7hniJNAxpql
         WjKYlnqA7i6PLGE4bueBB2tq/DaaTp3bUKyL3QmYxYySgxPBf++ncWCXbbNPPlsH0kTD
         2pumuvBgws+49OKiYYcpCQAg6ss4Z2R9SMnthMRFIGGWblGmIKGiJYXmXAKz9X7Ocs9/
         tPhhg5aXNCtrEMQVzESdwuFPp4QY6DOI65I2Is+dwrRW7qEtdHb0RwGdGxrcAVqlztjz
         2imps39Qcj/SgZQ4svgM5K07BcIBeSLsnv3b67+KCpMyTGBNdax5iQ3Rn2/YWZSB7OEO
         YS5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9l0j5x5lbKyZ3Ez84TDC2bHddnNVmElDcJKY5W/VC2jeW71m89fOrBBcd4e5h9298b9XOp4URTDaQNZe2WIC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsuIS7G8WKU41HIUTK/Frfu5l+QmfrSijtdwHR46AGDGLw1fsJ
	xnNYcZytlc9LkIg/TsdH2pfrCO/SKk801vHrC0Q+WvfsJMp71MRPa1k8kwst+focT80+h91h5h+
	oeTJIlgc0WxRCMslQrUq2qtQleiybT44=
X-Gm-Gg: Acq92OH42quBHCKzpybTwu9mD5O4mY8AHv/F9y/UihmcDA7SNt04Di1zgm4ARqxd3R/
	AE7CdV6YMW8/fQ0tylq+zF4M0rJ24c1tryYXchVhoGogCN2QgAAQul9wAnCc8yQV3FuhLmVARY4
	2+9hE6qtFOBmzB/sTIWrpqfE59V/KkgYwz+6fDbofjqgFwn7ON5nO7t/WIMf0uX5dbpow/yI2CG
	fFKZnN5Cz1webbmSRdyI0rSuz0QO0YgRL+kObrErBdot6DNfG4IN78r0Aqj4PimWgcCgE5qvd7M
	9nGF9hieRojMVDOjbFGF7n/dLc1TwI9tWM+itRWJyNWuM3ch48YrrwV19UyuZNsBJxnh2M4dEXp
	WNw==
X-Received: by 2002:a53:a6cb:0:b0:651:8d82:acc2 with SMTP id
 956f58d0204a3-661070134d4mr18053989d50.63.1781097047943; Wed, 10 Jun 2026
 06:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609211120.3887737-1-simon.mikuda@streamunlimited.com>
 <e89af328197d3fb429c08b7a3107d7fd8e05ac00.camel@iki.fi> <ac997f34-8c43-4935-bc78-90fa5eef714b@streamunlimited.com>
In-Reply-To: <ac997f34-8c43-4935-bc78-90fa5eef714b@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Jun 2026 09:10:36 -0400
X-Gm-Features: AVVi8CcCtBBIwvDV6lzsfNKEZ1V4cYjpcdCv-jzqPhP8HWeEC-tVAI-z0EAlf5g
Message-ID: <CABBYNZ+3vm1APyYtKYbXSVYMDC4YjXDrZEmNHeTKEGMg_Stpyg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/bap: Transition ASE to QoS Configured on CIS loss
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Wed, Jun 10, 2026 at 4:03=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> this check is for ep (struct bt_bap_endpoint) that is used only for
> unicast. broadcasts use different state in struct bt_bap_stream, so it
> should be OK
>
> On 6/10/26 00:15, Pauli Virtanen wrote:
> > ti, 2026-06-09 kello 23:11 +0200, Simon Mikuda kirjoitti:
> >> stream_io_disconnected() only handled the Releasing state, leaving
> >> Enabling, Streaming and Disabling ASEs stuck when the CIS was lost
> >> unexpectedly. The ASE shall autonomously move to QoS Configured on los=
s
> >> of the CIS and notify the peer; add that transition.
> >>
> >> Fixes PTS test BAP/USR/SCC/BV-167-C
> >> ---
> >>   src/shared/bap.c | 8 ++++++++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/src/shared/bap.c b/src/shared/bap.c
> >> index deb85b264..350ed53d9 100644
> >> --- a/src/shared/bap.c
> >> +++ b/src/shared/bap.c
> >> @@ -6779,6 +6779,14 @@ static bool stream_io_disconnected(struct io *i=
o, void *user_data)
> >>      if (stream->ep->state =3D=3D BT_ASCS_ASE_STATE_RELEASING)
> >>              stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> >>
> >> +    /* On loss of the CIS the ASE shall autonomously transition to Qo=
S
> >> +     * Configured and notify the peer.
> >> +     */
> >> +    if (stream->ep->state =3D=3D BT_ASCS_ASE_STATE_STREAMING ||
> >> +                    stream->ep->state =3D=3D BT_ASCS_ASE_STATE_ENABLI=
NG ||
> >> +                    stream->ep->state =3D=3D BT_ASCS_ASE_STATE_DISABL=
ING)
> >> +            stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
> >> +

I think converting this to a switch statement might be better, as it
would allow us to handle all states, including releasing, within it.
It would be great to have test-bap cover these types of tests as well.

> >>      bt_bap_stream_set_io(stream, -1);
> >>      return false;
> >>   }
> > iirc it may be also broadcast source here, does it do the right thing?
> >
>


--=20
Luiz Augusto von Dentz
