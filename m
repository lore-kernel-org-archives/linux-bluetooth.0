Received: from mail-24424.protonmail.ch (mail-24424.protonmail.ch [109.224.244.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31C2222A0
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Oct 2025 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761936819; cv=none; b=KiqRdt7qqxvcWRNczm3w+JL4R61nPL53I3g27A8xtp1Q0l0N6N3kLyRGDfUB6G3lfxAkIL78odvTEvkHov1MxNKCc/IzGV8KYAdGuHlnUtmvtTcQCVwd4sc3KwqCjdwS4zcPipXJsdiyLeYAPO7Fudrj0NddG7xYdEO6+gbGBIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761936819; c=relaxed/simple;
	bh=epc+N36yYRBN/+BXlx0d3dEgmjLru9gvAgqYeQHkDK0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSVuuTojuTN4+JttpE4VEJuhKXZoTUA2CarBU+CrfaQKMSkr1wyEpM87sNO4jgsOyppjEqcVGZ2ii5n/OuXScfTCkJDS0NaWWHFwvjpmrA5Smd8pi66pmtU5QwpaQN6r1uCtQVozeg2gzZCL6v1TVbjANp9du1jcrRT+EsoVbD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=l45ZKyLH; arc=none smtp.client-ip=109.224.244.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="l45ZKyLH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1761936807; x=1762196007;
	bh=6NGntmz8un72xHK3axoAzpzonW0EddFQ96ZHNC0rGqU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=l45ZKyLHNrlo12zvtaKrCzSiGpRzJ2pttJ04JRajc+o8TScjq4nHN/oheEBWBQpNW
	 Q+xFYkXIeoLwAWbobYKF/+5v9s5sf6YDUMuE13EAhPf2O2gqQ6/YQrEhxyi6N5n0Pq
	 OugL/ZtuTYJT6syIUIiZvQKFzo6pUdLE9vEA5JFxmDCCt3I4FCqXnQ3Z7VT6EPDMvA
	 Oi8OVpEpm+RAXeeEydTQNdbmYcgnCLq1bsc5v+dtBZs+DtIixois+5RpYQUPXcBgQ1
	 +lmixzltUJ5op213sbwERIzz9CVNDTxZz8jxYzONBf7RUtptb/QcHgFJIulNvvRMHY
	 aSSzh5Q00SbOA==
Date: Fri, 31 Oct 2025 18:53:22 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: Alfred Wingate <parona@protonmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 2/3] build: Fix distcheck by hardcoding non absolute paths
Message-ID: <d7p29GSiwKtOasKs2hPcT1Sr7mMC568c_Tu0HQ0hMyR3UQ8jVN6czhDeFrg6ehFPx1zzVDNr5dvr4LJvGsQ4yZnV4bP2md5Jr43fydf6C7M=@protonmail.com>
In-Reply-To: <CABBYNZLGwgwPdU1rq8i8d-TuYSn2TZphzZn8m=4PdzB+NR_s7A@mail.gmail.com>
References: <-w4Tz-HGOFe81IvBNIZkrOtGaZ6VR30rkdG0gO1KgjhxcPPSli_0wT7tBXmJ1aUbSXQrBj7g0sEEfolp4FhC5d2WJwwICWVE0oNlVa1sp_w=@protonmail.com> <DjjfVohXbHW1CnEWPzTVKg1cI0hNqpQsr4lcGCQSp7bGEd94UnW_Ym8lFlBbpOznvDA_7oEcg_txeiG9WbWlIg8Uhh2GpLtkfB6pqZIIVGY=@protonmail.com> <fmoulYbI3lrfCDbEomCGSFXsrYe7um4WSROyh7TBdV1WaBxBOgW8oYysZuVADOm_YiDbhKitNXHgHp9Y8BPvi1aHTov_8HHSc0PH_Tm7oYE=@protonmail.com> <CABBYNZLGwgwPdU1rq8i8d-TuYSn2TZphzZn8m=4PdzB+NR_s7A@mail.gmail.com>
Feedback-ID: 25092314:user:proton
X-Pm-Message-ID: 881a74cadf7ea0f36aef66b013719e498c35b754
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Luiz,

On Friday, October 31st, 2025 at 6:08 PM, Luiz Augusto von Dentz <luiz.dent=
z@gmail.com> wrote:

> Hi Alfred,
>
> On Thu, Oct 23, 2025 at 1:06=E2=80=AFAM Alfred Wingate parona@protonmail.=
com wrote:
>
> > To make sure it doesn't fail lets hardcode every path that could come
> > from pkg-config.
> > (I managed to hit issues from dbus and cups as I have them installed)
>
>
> Well if we hardcode the paths then what is the point of checking them
> to begin with? I assume we are retrieving them from pkg-config because
> they are configurable, and if they are configurable then we cannot
> hardcode them. Maybe the point is to make these paths available even
> when systemd is not? In that case AM_DISTCHECK_CONFIGURE_FLAGS should
> be conditional to not having systemd, or perhaps it just the prefix
> being used, in that case can you just do
> $${dc_install_base}/$(<original_path>)?

Firstly system paths from pkg-config are fundamentally incompatible with ho=
w distcheck works.
distcheck installs them into its own prefix (not DESTDIR!). So when pkg-con=
fig gives it a system path
it will simply not work with that assumption. This is why you can configure=
 arguments for distcheck itself
and systemd's own manual page also mentions this requirement[1].

> Additionally, to ensure that make distcheck continues to work, it is reco=
mmended to add the following to
> the top-level Makefile.am file in automake(1)-based projects:
> AM_DISTCHECK_CONFIGURE_FLAGS =3D \
>   --with-systemdsystemunitdir=3D$$dc_install_base/$(systemdsystemunitdir)

Secondly this affects --enable-systemd as well, its just not apparent as it=
s explicitly disabled for distcheck[2].

Thirdly yes it would be nicer to use $${dc_install_base}/$(<original_path>)=
. I didn't think it was possible so I didn't try,
but looking at the systemd manual it appears to be doable.

https://www.gnu.org/software//automake/manual/html_node/DISTCHECK_005fCONFI=
GURE_005fFLAGS.html
> The user can still extend or override the flags provided there by definin=
g the DISTCHECK_CONFIGURE_FLAGS
> variable, on the command line when invoking make.

Also I just noticed this, but the DISTCHECK_CONFIGURE_FLAGS already in blue=
z should be rolled into AM_DISTCHECK_CONFIGURE_FLAGS as well.
Will have to address it.

[1] https://www.freedesktop.org/software/systemd/man/latest/daemon.html#Ins=
talling%20systemd%20Service%20Files
[2] https://github.com/bluez/bluez/blob/32d740d87970fa476644aeea267663ea3c7=
4644a/Makefile.am#L753

--
Alfred Wingate
