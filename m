Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EB356E045;
	Thu, 15 Oct 2026 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087977; cv=none; b=JZe67JHgYAdPIjgNyUAyQithKRibUqz8zwSrrfdaTTUC2Wl1I6F+bApnTrH/W08j6fSHlTRkfixs3ZZ9bCM0Pgb5Bm//HvW1SPdtDm1LnleBIpBuzFpWOwE0Ha0xMzPwRAa5OYjnOA9QbK4X25gefHSBMBi0g2WEEbiBA5/H4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087977; c=relaxed/simple;
	bh=710c9U7eU9Y1S5C6mErByxhx7qGUqvBCDT0nbfgn4XQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hU4i7EyPXEaBFucQR0+gTakVcE4tjO41iwC6kOzL3NQW4kjKRw2Yhr9glBjRcR4ft+caJU9ONKnFQABLIyifWHnIdaQX53rLGiWN5lVt2uhON2q1HvHA+PO+gsLuJd3yR+7ciAvztM+QtE7eGFKhIrYszdFpvETHpcOi/rH0aS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=suakTWph; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="suakTWph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792087962; x=1792347162;
	bh=mSqs4Pq6JDXmE2/w9QOwLb4bo+9DjPu5oldMoTGZ43o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=suakTWphhKf8YJCcpgA2lymTdTQkuWjnCPA9YEiyv/jvS3bTa7o0RwZgJw8Up5E3E
	 44y6Z44HlZIdZ6u+04r5roHiCRIypcm8AKjfQCYS4fUNidcj8J1OtSvEX0Pm2S3edp
	 vkNPCLwC8UgJNSaV7eZ3rCMNXBSfldHmICnIan6RUzFitzlvXfOFdEsUk7/O/cAkSL
	 PPHt7HRm2iT8wakJ6OrP66jhPB9WaKp2ui0wB+Ple1xPUFh/B+RDDcXdRzQRv/sLZm
	 jvYS+VrOgacq7t23+ofSI0SRfd32Deb4oIdBBHi4ewtbS5hQLLBb3Mrx2Ph5MM6kvn
	 WQHMAxpUdtf0A==
Date: Thu, 15 Oct 2026 18:12:32 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: cochcoder <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Bluetooth: l2cap: honor local LE connection interval range
Message-ID: <BDreMDI0qE_gkC96xMDJO-C_72nSX6WJVtpfYA8J4Q8wQDLsl4TD8f1D6nje8z81aDQMAp62-y7xGMZjQnSSshllZTZ8tkhjUdztu1qq4CM=@proton.me>
In-Reply-To: <CABBYNZ+o5P+KhPX3ndcB28u=QB_4wpOjoJfHWk0_uu-egmx=9A@mail.gmail.com>
References: <20261013033118.501182-1-cochcoder@proton.me> <CABBYNZ+o5P+KhPX3ndcB28u=QB_4wpOjoJfHWk0_uu-egmx=9A@mail.gmail.com>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 8ac57069e80088c4356fee07e1bbc23a7f1cc489
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for pointing this out. I looked at the git history and confirmed the=
 interoperability problem. I've sent a RFC v2 as 20261015043336.47734-1-coc=
hcoder@proton.me. It prefers a valid overlap but preserves the original val=
id peer request when there is no usable overlap, rather than rejecting it. =
The native controls cover overlap, fast HID, slow idle and exact-match requ=
ests. The strict-bound version rejects the HID and idle cases. The revised =
full L2CAP suite passes 115/115.



On Tuesday, October 13th, 2026 at 10:33 AM, Luiz Augusto von Dentz <luiz.de=
ntz@gmail.com> wrote:

> Hi Kyle,
>
> On Mon, Oct 12, 2026 at 11:31=E2=80=AFPM Kyle Pepper <cochcoder@proton.me=
> wrote:
> >
> > Intersect a valid peer request with the locally configured interval
> > range. Reject disjoint ranges and preserve validation of the original
> > request before applying local policy.
> >
> > Assisted-by: OpenCode:gpt-6.1-sol
> > Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> > ---
> > Submission review notes (not part of the commit message):
> > October 12 no-intersection trial accepts [16,24] and completes 30 ms
> > with STATUS 03 02 18 and normal host TX; the user hears silence. Volume
> > and multi-day acoustic comparison controls are incomplete. The working
> > intersection yields 20 ms. Maximum-only rejection failed in kernel 5
> > and is not this proposal. Generic minimum/range policy and LL-path
> > consistency remain RFC questions, not established by one renderer.
>
> I need to check the git history but I believe we tried something
> similar not long ago that created interoperability problems if we use
> strict range matching like this.
>
> >  net/bluetooth/l2cap_core.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 49a998804..49e201d3e 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -4968,6 +4968,13 @@ static inline int l2cap_conn_param_update_req(st=
ruct l2cap_conn *conn,
> >         memset(&rsp, 0, sizeof(rsp));
> >
> >         err =3D hci_check_conn_params(min, max, latency, to_multiplier)=
;
> > +       if (!err) {
> > +               /* Apply local policy only after validating the peer's =
request. */
> > +               min =3D max_t(u16, min, hcon->le_conn_min_interval);
> > +               max =3D min_t(u16, max, hcon->le_conn_max_interval);
> > +               err =3D hci_check_conn_params(min, max, latency, to_mul=
tiplier);
> > +       }
> > +
> >         if (err)
> >                 rsp.result =3D cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
> >         else
> >
> > base-commit: 964430c038967fd06643e866f68115664e1a1bd1
> >
>
>
> --
> Luiz Augusto von Dentz
>
