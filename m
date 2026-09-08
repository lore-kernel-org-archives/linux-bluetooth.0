Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E987C5013C4
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863300; cv=none; b=FINCW788+V8e2aKgUDtOI9zsS/DjRQzWfZutG8od93M5wLSNqdMeWnJjFOcDrYC2TNl9Ao4WAUDyZR5VSmGpdwo+k6qhO++mDxSf1SKqKtPY10cOHw0UBKJOnEmhh9fMY0vWQ1Y/9GbaAPoZDytb56TUVlavkyvLZB7jqZueMhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863300; c=relaxed/simple;
	bh=ROUNONld8M7mTh6Jf8W33gDPR1PbQs9pz20C07ZkOkc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJ2gzb0vTEzFS9GuRVZSmUQgao+8IkWqezga70jxdmFnDsiGE+tNOTUsd5SSyxBE39zmnAUU6g6jySzaYDJv1//fdziGQqNwHJ6Bc+qQvY8xKRssY1uEIrBonshn5N4W2zQYDorS/MPU41ftkkYuL76qd8PbeV/TXmCWabbXAeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=jjMvw9Vk; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="jjMvw9Vk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788863295; x=1789122495;
	bh=9h6vsFFtX/anvqGK2ZfNEj2JjM8MwEfT6oV603VtGJ4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jjMvw9VkhsbV7ZFv15VdK8SWdEQ5j+Gos+Z1AO8JFbrttPTJ/9+YOHLL3hXT9ZlEy
	 okYPqkMpm2LmwzfrARjbv34I4VeTIkr5iWfya5dNpAJzMy3V5uws0P77/PrKQhKRDC
	 0aoe5xySVIdpTuLXpGRqdnacFMXLKLRzL/3nNW0an/PHEXJUDXjlYiSlT6VHicI7MQ
	 mfgCgUqo4sPo0ed8KlH9vqwIErb8S+dkyej3OnWs4XeATyJPyplj5YtMETHj4ijVn1
	 +Wdfs63UlPDlNFIREmhKPIsZ8qew9xsBeFmwq969HlukpsfN6CJnlG82hReo1Po3sz
	 XDnrjhy7xt5Sg==
Date: Tue, 08 Sep 2026 10:28:08 +0000
To: ravindra@intel.com, vladimirkondratyev2@gmail.com
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: chandrashekar.devegowda@intel.com, chethan.tumkur.narayan@intel.com, kiran.k@intel.com, ravishankar.srivatsa@intel.com, luiz.dentz@gmail.com, marcel@holtmann.org, pmenzel@molgen.mpg.de, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
Message-ID: <20260908102758.72135-1-lsa.uz@pm.me>
In-Reply-To: <IA1PR11MB786922E0DBE2CDC8FB00C5B6DAB12@IA1PR11MB7869.namprd11.prod.outlook.com>
References: <20260902091021.20160-1-lsa.uz@pm.me> <IA1PR11MB786922E0DBE2CDC8FB00C5B6DAB12@IA1PR11MB7869.namprd11.prod.outlook.com>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 1c9c90b08787ded47bf7ba51380088a746ad40a8
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ravindra, Vladimir,

Ravindra =E2=80=94 thank you, and thank you for the freeze/thaw answer. Tha=
t was
the one thing I could not test here, this machine having no S4, and it
settles it: if D3_COLD preserves firmware then .thaw taking the normal D0
path is right, and the asymmetry with .restore is deliberate rather than an
oversight. Nothing to change on that account.

Ravindra has agreed to the two patches going as one series, with each of
you the author of your own half, the Fixes: tags kept separate, and his
rebased on top of Vladimir's. So unless Vladimir would rather not, this is
what I will send in a few days:

  1/2  Vladimir V. Kondratyev =E2=80=94 fix stale cache in set_dxstate fall=
back
       check. v4 unchanged, with Paul's Reviewed-by restored (see below)
       and my Tested-by.

  2/2  Ravindra =E2=80=94 fix PM flow for S0ix, S3 and S4. v2 rebased onto =
1/2,
       unchanged in substance.

with a cover letter carrying the per-hunk measurements from this hardware:
2/2's hunk alone leaves the missed-interrupt case failing exactly as
unpatched, 1/2's re-read fixes it, and together they do not interfere. My
Signed-off-by goes on neither patch, only on the posting; the authorship,
the Fixes: tags and the review tags are yours and stay yours.

Vladimir, if you would rather v4 stayed a standalone patch, say so and I
will leave it exactly where it is =E2=80=94 it is your patch and your call,=
 and a
word is enough.

Two things that argue for doing it, both checked rather than assumed.

First, v4 lost a tag. Paul reviewed v3 at 14:36 UTC on 3 September:

  Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
  https://lore.kernel.org/all/ff049c69-1575-4a10-91e2-cd0371c98c0d@molgen.m=
pg.de/

v4 went out at 19:22 the same day and does not carry it. Whoever applies
v4 as it stands will apply it without Paul's review. That wants fixing
whether or not the patches are combined.

Second, neither patch is moving. Both are in patchwork at state "new" and
undelegated =E2=80=94 v4 since 3 September, Ravindra's v2 since the 2nd. Tw=
o
independent changes to the same function, arriving separately, are exactly
what a maintainer defers until it is clear how they interact. One series
with an ordering and the measurements attached answers that before it is
asked, and neither of you loses anything by it.

Sergey

