Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794500981;
	b=UC5XbPCep3CumtduV/c23h4paAGsOPb4Kxe6XD7Y2BoOey79lnrFbb7iqzaf+Xda3Xek
	 D2wXEXs6FECp2jqX9jn8xwvfohZCBaqck33I3Hapf3/C7NslBjepLOfZWYssWNky9XbW3
	 XTrj5Er6Unj6zEQHrCWiXQ7kYHTPhMWeYTYtw0+CnHDUTqNezbrcBf+vNRDaD0NWYB5Fg
	 538/A1wvpTqQHrzrNk4QvXsE5qy5v2BHTaS9AX713tzKSYsmqPdUsOWqEHfIgBSXqhL6G
	 rI1/fw3UIyx1mDPCCaadKEFj0dVwoJHcBWZdhn7c/ASbY/LbcXM+Lys69FNPwzfQJaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=r+mqQbEiOREfGn1U9esW4gUO68LkwDpfPkYPgJOspDE=;
	b=W06uWmxD8+KTxHdeMtn938a6Hn9daSaRXDlkqI473KPVf47XcJ6VPogM9EogMsDqBkaC
	 ui3Af+7HaAQ0M49KyRet1dTJeOe0QSJzf2qQ/qyMI0tKniGTO2Rk9l3AqTpX4zhKkM5mG
	 h7Ckdn17KJyRCzQo4TYecXtpYRxpOBXol9K3tQTfG8tw7Iy6EsJEVnNfWNieECBaQK3TH
	 T442a0LN80ImfxOFBY5WhcqqkH5148KnKsnQmOy36EjBVDOpSHEim4/JjZaTQaOrk/ufO
	 5G+0NK7LVW2+h89R3tH8NPsaXvDnfSZPdJDFqolMluOa0NaVbTbRyit4BtagVxZE+XA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SwLueL0W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.174
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752FF606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 16:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 752FF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SwLueL0W
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-53a448f86e0so2547291b6e.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 08:29:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794500980; cv=none;
        d=google.com; s=arc-20260327;
        b=W9LQgmpVDEOsgqLBZ/FURvW7EV4A91bbf5+3Ii4mnNjcveSUcxfkiaafwqUBfSp19X
         pe6MfcuP3Pp1hPeDWz9Yx+8U3H1+uohqd2uQSrXgul1AeFp/1QBeihlp/i7My3qtQrcp
         sm6GVJuUqt1hq5o7dBlX13HbMcI8pRo8pVuZqRX1qWoiViLcGkEIuuQTenQzIH1gnjc+
         a8ZRyf/z4GWMcvUrsU7ENEC8Sof6VCzUV/s2Xq86DBujMhus8JWa+OMnaI27IvjQGyNH
         k2h3yOshovg/NSMOI7gZkvodDv+Yodzp3aq3qSebd3m6ezIfOWC7qWN0L2t2+eKLzD+1
         xAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r+mqQbEiOREfGn1U9esW4gUO68LkwDpfPkYPgJOspDE=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=RUZNi9bigp16ZgD6K3yT6/CcyCQmjDyf8Y+6YpWlPna1ApVLuz02fCDCbAdccOYhnJ
         7F60+z/3VFK1gdm8O+rXZD+Off1FV5bCfqN7ASjF9XhC593RJ3h+Uo8+rUMNpqEResSN
         eLLCxyv2Jq44unNoa7nTXcCiRpiyRts0VbK/X0Y7YQY/qVwX2J64KqQPVbCciN2t66Ga
         4aOqtMPQ8sZ3tqcJXDITIPLycGpAWAVQ0a+msUUjgPPkoXByCjen/D2+fAvu4tXKrX/a
         /BkvL+tbVM7uKBuNquxZSSBCsGEjv+9YzqlX1pvTU/gHevxePXAADJeVkgYww67t69Il
         UT2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794500980; x=1795105780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r+mqQbEiOREfGn1U9esW4gUO68LkwDpfPkYPgJOspDE=;
        b=SwLueL0WFAUPEseN9BPD04sYcnAm+jNIdKY1fNYMrFaa99+tM+TlSmlYyw5FBdxtvx
         Iuiib1DqZBI6cc8mpXsrFt8r1MV9UOD2hxjxB0GA3sXRC49tcxXC2JEzkmgsABt1bDBO
         zY6BiWxATAENxGIYT1SFBl1ileH98MXmBqRaTrk1sCsVUUZ4riDlnHb9Rq49PTVTnDvF
         2YqbGzycStZDhuwmBJlAOHuzaykDIS/E5Ryacv3jYE7vmC/uVyvwa26VgXH0HJ56gWqv
         JLaybZvRi7D/5T7U5OaPjEZ2z5zs0ndVwX/D/H3PHIfmWb1GTNCguFCbgTGnrNsd/J/E
         77QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500980; x=1795105780;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+mqQbEiOREfGn1U9esW4gUO68LkwDpfPkYPgJOspDE=;
        b=0YzwP6zLrDvCJ8/9HDT5vp/62SzQlRbJYR1mD2fVIgqnd3H7RWca3NqKY78Jl5X/tH
         1UFC41QJTs1lodVAX0WOd1Hwo70QTd/cG6dK+6bFRYpOzG6EOQZncok0g7dJvAtZKyKP
         cCfnGJI8uI9mK51L9BtNZvpFMokuRq0TzNIIQA+ChMhHmtoBUsnEDV9I2mqPOJ7tZSgf
         zedZ2H/0LhTZ0X2NqXzoJ53l2dDMFXXg5eOqOdQ+qqpDaVVhtEhu4VZmghgj6GHWtJpY
         AUSh3oSaXNaCTXvcKj364ka61eIvurOzBCmcH1SYz/BkoTyvsWDRsLn92iOEtCb8K2W+
         V7nw==
X-Gm-Message-State: APuU4Z9kD/HcfTXd0x6XMzHCQQ6ArnIdXeumyign5Ge1DbZElBzEi6n/
	tBc35f9qWU5MNYpqRO6QLowS1iyx8LcQzDj7v+hduOzEq2uBy4nVvo1cKk8DkST1Vfs2hhS8FkQ
	jFF54oPmDic10UU+DAoyzL5h4zDccruw=
X-Gm-Gg: AYBFou0B6tdwPX5z4DCOZckCroviytUjxnZad5cu5+Io6uYAh3jCJcB2FWPnkTufXIL
	kQ7Qv8BDEhUeCp0r3u4eo+tyc1us37zLqG4crbC0ULqt3aDblpHvN3HJw8yvQGcHwyL6gHNfElX
	WJLRQ9kh4wrLZ90NfHztM/f/QAGfBHYM49uiQO6inYq32GxCxCSyc8uodRYUMTYkSeUC3zqipTv
	hUSot7GV/t/dLsEi7dV2UORx7UO/HIHAfcgCTcIRFm/mq1a/MeycO7vleJ1kSI7uAA9nX5FPgRT
	pAzPcTf+Y4g3kjMDViWR44gXVzbYJleqc5C70YF+ZUmCu0L+Sk68B5Vq88QLbA3YUmgjhe+PRcg
	wwElYED787zIH6G22jmogiBKWhVXvb00+6Sxs907teA3OOguea1yUW1nUuVMMPXFtOvBCq773wS
	UiHWhaSNkic87koc1OIh4KUhm16aFlQrMnppur/1HkujPlqu1dK4dcPoBhG7w=
X-Received: by 2002:a05:6808:1a01:b0:54c:7dc0:649a with SMTP id
 5614622812f47-56b969ce452mr5930102b6e.32.1794500980319; Thu, 12 Nov 2026
 08:29:40 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111200705.3802779-2-luiz.dentz@gmail.com>
 <6af521d8.488c8742.26003.3592@mx.google.com> <CABBYNZ+dzizM9Lf1UfANaFSyiSkcOTjH6z1KRiGxKV+xvB+JfQ@mail.gmail.com>
 <8d3eb065640c99cc0c2236426d0b35f9f5dc1099.camel@iki.fi>
In-Reply-To: <8d3eb065640c99cc0c2236426d0b35f9f5dc1099.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Nov 2026 11:29:26 -0500
X-Gm-Features: AclHuK_avMmjvdpWUKu9bWuiig4cAKsU-2Kft3ah1XEYZthn3LxrpRINsLkjJBA
Message-ID: <CABBYNZKxPSwDfjAv2T6THn_F8do6zF5iYeUOC=ZoFZiJNL-_Tw@mail.gmail.com>
Subject: Re: Add support for HDT and EKS
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Nov 12, 2026 at 11:23=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> to, 2026-11-12 kello 10:37 -0500, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Wed, Nov 11, 2026 at 9:18=E2=80=AFPM <bluez.test.bot@gmail.com> wrot=
e:
> > >
> > > This is automated email and please do not reply to this email!
> [clip]
> > > FAIL functional.test_mpris_proxy::test_mpris_proxy_playback_control[l=
e-vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
> > >     Remote traceback:
> > >         Traceback (most recent call last):
> > >           File "/usr/local/lib/python3.14/dist-packages/pytest_blueze=
nv/../pytest_bluezenv/rpc.py", line 102, in server_stream
> > >             result =3D method(*msg["a"], **msg["kw"])
> > >           File "/usr/local/lib/python3.14/dist-packages/pytest_blueze=
nv/../pytest_bluezenv/env.py", line 238, in wait_load
> > >             raise RuntimeError("load failed")
> > >         RuntimeError: load failed"
> > > FAIL functional.test_mpris_proxy::test_mpris_proxy_track_control[le-v=
m2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
> > >     Remote traceback:
> > >         Traceback (most recent call last):
> > >           File "/usr/local/lib/python3.14/dist-packages/pytest_blueze=
nv/../pytest_bluezenv/rpc.py", line 102, in server_stream
> > >             result =3D method(*msg["a"], **msg["kw"])
> > >           File "/usr/local/lib/python3.14/dist-packages/pytest_blueze=
nv/../pytest_bluezenv/env.py", line 238, in wait_load
> > >             raise RuntimeError("load failed")
> > >         RuntimeError: load failed"
> >
> > This looks like a recurring problem we are hitting at github, I tried
> > investigating but it seems the controllers are not responding under
> > pytest_bluezenv, have you made any recent changes? I hope we are not
> > defaulting to UML mode since that is still experimental.
>
> This appeared to be due to Github updating their ubuntu-latest runner
> to 26.04 which breaks something in running Qemu in Docker.
>
> This comes from bluez/.github/workflows/ci.yml --- other parts of the
> CI are pinned to specific versions / images.
>
> This should fix it: https://github.com/bluez/action-ci/pull/11

Oh great, lets apply that then and check if that solves the next submission=
s.

--=20
Luiz Augusto von Dentz
