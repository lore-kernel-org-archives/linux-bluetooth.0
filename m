Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADEC286D57
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902675; cv=none; b=dnHJLlf4OkEF6Ip2h4iMMaFaInr4IVe8YQlO9SGlKnZ3jzUP76LnSkE7XyA73VKOULqmEhkZNCzJF9nT0GKFae21Ia4uLXXOLkuyMlPXWsKyZLUs8VLGmLRkME0eO5VDECpVspv7gFfmlA6bMDP704cnCcVG4d/j/gfbQa4hqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902675; c=relaxed/simple;
	bh=rM7f9YtJpUo45JZqI6GvW5vBlGx5DTyRZb5/rW1ne94=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nI7r99BvuEW20VNcvG7FKMi9daqLEUx28t/YilzvJuAHKUMPgdtEa0sktBEY/cy2BMC3ePtPjUxUMobxr/LLRxyAzY17mCSjMri0uPWxRULRoinW9wGGhQjuBY2vFaar2+pNnTACQJnItoeq3zAUR665Hs6X4lz78i2WUE6rQCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org; spf=pass smtp.mailfrom=fluentlogic.org; dkim=pass (2048-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b=xVjp+gXd; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b="xVjp+gXd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluentlogic.org;
	s=protonmail; t=1777902670; x=1778161870;
	bh=rU76RWnwf0tdsESPu3m21CAee2AF7CDR6Jvx+uPJLiA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=xVjp+gXdoEmKXua0maN+ADzBgphL71tzTD7VREBhz4iBuQATa7phWi3xyMmrur2J8
	 HxBGMCtirNmGyDlj84khku3C0oMYb3L+q6x8bqS6H7Gy7LX1aHitOC+aNsC3YdVl1s
	 64JW7yFV88TyrXnpxtWVxDq34TXeuGbOB7dttMXCn3OqIXXjsbdC44YkEcIiswFc/+
	 WEXohapmQfk23qw5FdVe6DRW2hY/XdWFmF+QO8IbY61zJPYkMsoQCKFXyPxksKY1GB
	 q9aVF6cCCshUTNof95RMO2k2HNqPNhEr+17fl68fGMatkBgBDsqq2hOLmJx7xHQDed
	 3kt0KRdu0YUSw==
Date: Mon, 04 May 2026 13:51:06 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: admin <admin@fluentlogic.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [SECURITY] BlueZ sdp.c signed integer underflow in SDP sequence parsing (8.1 HIGH)
Message-ID: <ZgWmfG6CS-u2_HPDI1pPPbm4Q8YdH7I2nyjgRojT45C7wW7KwOMs7_TRD5TeC9jz0K3fHhN4MPoyL66KdgxLIPQxo9ofTvgumVqXhtsb13o=@fluentlogic.org>
In-Reply-To: <CABBYNZLV8-8YYwDEAno4_WBNEv-hcERL_NvwMfHBnLK4ZDZ+7g@mail.gmail.com>
References: <ygH6bncNsvf-0Hco92Ae11Lw8-jOfekFO6O3bUvFK8w0DTueny_rwJIF6ffZg2G_XCB4v8h8xRIcAL2b_KwaweNcGa231ZQDHCMpzyvR5i8=@fluentlogic.org> <CABBYNZLV8-8YYwDEAno4_WBNEv-hcERL_NvwMfHBnLK4ZDZ+7g@mail.gmail.com>
Feedback-ID: 121058281:user:proton
X-Pm-Message-ID: f1c32aceaee359c7c660a995ee3ba3aadd86c02b
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

                                                                           =
                     =20
  To: Luiz Augusto von Dentz
  Cc: linux-bluetooth@vger.kernel.org                                      =
                                              =20
  Subject: Re: [SECURITY] BlueZ sdp.c signed integer underflow in SDP seque=
nce parsing
                                                                           =
                                              =20
  =E2=96=8E Yes, I'd like to send a fix.                                   =
                                                      =20
                                                                           =
                                              =20
  Here it is =E2=80=94 single-hunk patch, no indentation changes:          =
                                                      =20
                                                                           =
                                              =20
  From: Martin Brodeur <admin@fluentlogic.org>                             =
                                              =20
  Subject: [PATCH] sdp: fix signed integer overflow in sdp_extract_seqtype(=
)
                                                                           =
                                              =20
  bt_get_be32() returns uint32_t. Assigning directly to the int *size  para=
meter sign-extends values greater than INT_MAX to negative, which bypasses =
the sequence-length sanity checks in extract_seq() and  sdp_extract_pdu() c=
allers.
                                                                           =
                                              =20
  Store the result in a uint32_t first and return an error if the value  ex=
ceeds INT_MAX. This closes the residual paths not covered by  commit 31e4fb=
1.                                                                         =
                               =20
  =20
  Reported-by: Martin Brodeur <admin@fluentlogic.org>                      =
                                              =20
  ---                                      =20
   lib/bluetooth/sdp.c | 10 +++++++++-
   1 file changed, 9 insertions(+), 1 deletion(-)                          =
                                              =20
  =20
  @@ -1249,7 +1249,15 @@ int sdp_extract_seqtype(...)                      =
                                              =20
                        return 0;          =20
                }                                                          =
                                              =20
  -             *size =3D bt_get_be32(buf);  =20
  +             {                                                          =
                                              =20
  +                     uint32_t val32 =3D bt_get_be32(buf);
  +                                                                        =
                                              =20
  +                     if (val32 > INT_MAX) {
  +                             SDPERR("Sequence length overflow");
  +                             return 0;
  +                     }                                                  =
                                              =20
  +                     *size =3D (int) val32;
  +             }                                                          =
                                              =20
                scanned +=3D sizeof(uint32_t);

  ---
  The full .patch file is at /tmp/0001-sdp-fix-signed-integer-overflow.patc=
h=20


Best,
Martin Brodeur Ottawa Canada    =20



On Monday, May 4th, 2026 at 9:34 AM, Luiz Augusto von Dentz <luiz.dentz@gma=
il.com> wrote:

> Hi,
>=20
> On Sun, May 3, 2026 at 7:25=E2=80=AFPM admin <admin@fluentlogic.org> wrot=
e:
> >
> > To: linux-bluetooth@vger.kernel.org        Subject: [SECURITY] BlueZ sd=
p.c signed integer underflow in SDP sequence parsing (8.1 HIGH)
> >
> >   linux-bluetooth,
> >
> >   Reporting a residual signed integer underflow in BlueZ 5.86 HEAD that
> >   was not fully addressed by commit 31e4fb1.
> >
> >   AFFECTED FILE: lib/bluetooth/sdp.c lines 1213, 1262, 1392
> >
> >   ROOT CAUSE:
> >   bt_get_be32() returns uint32_t. The result is stored into an int*
> >   target, sign-extending values >0x7FFFFFFF to negative. High-level
> >   paths in extract_seq() and sdp_extract_pdu() have seqlen<0 guards,
> >   but the residual paths introduced or left unpatched in 5.86 HEAD
> >   remain unprotected. An adjacent attacker sending a crafted SDP
> >   response with an oversized sequence length field triggers negative
> >   seqlen, bypassing subsequent size checks and corrupting heap metadata=
.
> >
> >   ATTACK:
> >   Pre-pairing, no authentication required. Auto-triggered on Bluetooth
> >   device discovery. Adjacent attacker sends malformed SDP PDU during
> >   scan =E2=80=94 signed underflow =E2=80=94 heap corruption =E2=80=
=94 potential RCE or DoS
> >   in bluetoothd.
> >
> >   CVSS 3.1: AV:A/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H =3D 8.1 HIGH
> >   CWE-191: Integer Underflow
> >
> >   REMEDIATION:
> >   Add seqlen<0 guards at lines 1213, 1262, 1392. Store bt_get_be32()
> >   result in uint32_t and validate against INT_MAX before signed cast.
> >
> >   Also reported to security@bluez.org.
>=20
> You were supposed to report only to security@bluez.org, fixes should
> only be disclosed to linux-bluetooth. Now that it is published there
> is no taking it back. Anyway, do you want to send a fix as well?
>=20
> >   Martin Brodeur                       Ottawa Canada
> >   Independent security researcher
> >
>=20
>=20
> --
> Luiz Augusto von Dentz
> 
