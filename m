Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251653F2100;
	Thu, 15 Oct 2026 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089075; cv=none; b=oEpVHp9+cav+8ahLubTvVS2RKTUUgaIng0iLG63R0OBXdMKFXNiMspPYF+kQzknCna1zNNGN14ZPdWBsnMgnN2P5+8YGCTazloicLR1RUNguVT0QgkvnDHHZOMay9xRse2ZXSI0EVUjv0DENCWnzgcktkuJyS3RBFOSG+UZPYWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089075; c=relaxed/simple;
	bh=XnqirTAOIyOEUEjM5gZAlIddME/VKFHHyuu7S7qv8SU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8UkD1f4CbzPzGFkLedV7QE4jQcwvA0izfrQxM0NOdb8GqnyFEIEWUeQRD6OwQpW8gBgULsb2luM0B0d6T7QjcoupwO0PqHRE1ApIClh0rMrnrlyD4U6dJi59J27X7r4DErp6LENKbd4N9rgTZ2qaG8Oln+lS4D5ApT5IExmveQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dE1Vtecx; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dE1Vtecx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792089065; x=1792348265;
	bh=12AmhKHxbLCv2FSRsicB7sk85Z0FKPCHLGV0cKefTJM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dE1VtecxiVIuKGRpV70GWCQBPPq7Qp2vPmfdR0o/S3epOlwdd8+uMDKry4U/G+7pT
	 gJO2EfoUpwAHMI4gfuyLwhFnYyBkqfxcYxgztLCtkTG0V6s6+IrO2ePT0WPKwALX1g
	 aubJlIyTmm/m/ivut8hkcc4lzSIdPatf6TeYB/Fk/Kp3Lt2C/3D8Op7RVW1zccc4vN
	 SDMzqVJkMxF6G19AEjryidejDGxE2V/Lcs6zFM4EwJ3+q5GqBsDtklbf4PGga7OBEF
	 6kk08O64YrFvbkSAiIhUjWTIZ7IFLBkMbmcIBLHzCBfT6THvVWoZy4bLwzn+FfWF8A
	 Da7f+fZLU/i8Q==
Date: Thu, 15 Oct 2026 18:31:02 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: cochcoder <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
Message-ID: <kSgAQJi1qQPQmEKSbh2o-nT3b7dFTdU4_Ld1BZi90BsBSb0XUbXGREvCaB_PRJMmy7os8opcmtBtv3GvRQNiHHa9yGzSRT7Q8CciGPx6DfA=@proton.me>
In-Reply-To: <CABBYNZJJf3owtAwGs4OuL6+YZz+zuY_kewKFDZPQdfcF-xyFFA@mail.gmail.com>
References: <20261013031943.489829-1-cochcoder@proton.me> <CABBYNZJJf3owtAwGs4OuL6+YZz+zuY_kewKFDZPQdfcF-xyFFA@mail.gmail.com>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: a3097f93aaebcf5e0019e21bc2121149c39ca427
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for flagging this. I've sent v3 as a two-patch series:
the security fix first, followed by the dependent zero-ID RFC.

Security fix:
https://lore.kernel.org/r/20261015181624.48318-1-cochcoder@proton.me

Zero-ID RFC:
https://lore.kernel.org/r/20261015181624.48318-2-cochcoder@proton.me

Thanks,
Kyle


On Tuesday, October 13th, 2026 at 10:44 AM, Luiz Augusto von Dentz <luiz.de=
ntz@gmail.com> wrote:

> Hi Kyle,
>=20
> On Mon, Oct 12, 2026 at 11:20=E2=80=AFPM Kyle Pepper <cochcoder@proton.me=
> wrote:
> >
> > A nonconforming ASHA peer sends identifier-zero credit indications
> > that are discarded, reducing usable transmit credits until audio stalls=
.
> >
> > Tolerate only exact-size credit indications for a connected LE CoC.
> > Preserve the channel reference, lock and credit-overflow checks and do
> > not send a response with identifier zero. Other zero-ID commands and
> > BR/EDR signaling remain unchanged.
> >
> > Core Vol 3 Part A section 4 forbids identifier zero. This is an
> > interoperability RFC requiring maintainer agreement, not a conformance
> > fix or a claim of automatic stream recovery.
> >
> > Assisted-by: OpenCode:gpt-6.1-sol
> > Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> > ---
> > Submission review notes (not part of the commit message):
> > Core specification forbids identifier zero. This is a narrow opcode
> > interoperability exception, not a conformance fix. N8 captures contain
> > zero-ID credit indications. Native malformed/overflow/teardown and
> > lockdep/KASAN coverage and exception policy remain review gates.
> >
> >  net/bluetooth/l2cap_core.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 49a998804..1a0868437 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -5328,6 +5328,12 @@ static inline int l2cap_le_credits(struct l2cap_=
conn *conn,
> >
> >         l2cap_chan_lock(chan);
> >
> > +       /* Tolerate identifier-zero credits only for a live LE CoC. */
> > +       if (!cmd->ident &&
> > +           (!credits || chan->state !=3D BT_CONNECTED ||
> > +            chan->mode !=3D L2CAP_MODE_LE_FLOWCTL))
> > +               goto unlock;
> > +
> >         max_credits =3D LE_FLOWCTL_MAX_CREDITS - chan->tx_credits;
> >         if (credits > max_credits) {
> >                 BT_ERR("LE credits overflow");
> > @@ -5923,11 +5929,21 @@ static inline void l2cap_le_sig_channel(struct =
l2cap_conn *conn,
> >
> >         BT_DBG("code 0x%2.2x len %d id 0x%2.2x", cmd->code, len, cmd->i=
dent);
> >
> > -       if (len !=3D skb->len || !cmd->ident) {
> > +       if (len !=3D skb->len) {
> >                 BT_DBG("corrupted command");
> >                 goto drop;
> >         }
> >
> > +       if (!cmd->ident) {
> > +               if (cmd->code !=3D L2CAP_LE_CREDITS ||
> > +                   len !=3D sizeof(struct l2cap_le_credits))
> > +                       goto drop;
> > +
> > +               /* Credits have no response or identifier-matched trans=
action. */
> > +               l2cap_le_credits(conn, cmd, len, skb->data);
> > +               goto drop;
> > +       }
> > +
> >         err =3D l2cap_le_sig_cmd(conn, cmd, len, skb->data);
> >         if (err) {
> >                 struct l2cap_cmd_rej_unk rej;
> >
> > base-commit: 964430c038967fd06643e866f68115664e1a1bd1
>=20
> Sashiko flagged a problem with this:
>=20
> https://sashiko.dev/#/patchset/20261013031943.489829-1-cochcoder%40proton=
.me
>=20
> --
> Luiz Augusto von Dentz
> 
