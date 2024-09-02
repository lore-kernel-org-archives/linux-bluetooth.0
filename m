Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB95187355;
	Mon,  2 Sep 2024 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268947; cv=none; b=NiKfdppAZXRXz0dFFQQQdPIUDrYoxyMjOkQPEee+rdkWc8UxVTADknlvJ4xbGattkbu3rd8l8ImdEZbqO1DepbR3PSyFiRuGXUXeDArYk2Kvf98u+JRx0R+ZYqEP5eHnjRcK3oCz/Z70OcrbozMS0JPczqrZNco06PKQh4crJFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268947; c=relaxed/simple;
	bh=xXSRxoBLqMmn53NEyGThH49aDQBEWaB97Ehs5ZCQHbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sR1Y9WnVEA/tn15QuHyJiaB8yXMuxkHCamAUaOXI3I9TfB8Wuc792l6mASQYo9PnTYUOs/akfFxqfBDqJni6yKfFDzUHPtyYMlWvpEeEQw4SJ1k/SKtfCmxSMS50w6MfaaH9RVANrUnVTWW4rjAjJ1e899UY2KBWPobbdRydZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=05Ja1ol6; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="05Ja1ol6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=JJRNQx3uCtDtruHeYL7QK+pnZYNa7ZPC2N20RQFGTVc=; b=05Ja1ol6KWfmVDSSME+pjVSDfE
	BMbUFpk6bDs1uyFtE3OAVp8zqvtXJZs3MoJjaKcaAzPFYHhK/2vQksbhV31rwneRk+aSkepOdxeuN
	oqIUIS+z/BUyRusWCC3Scv3VjurfFx1SMaZUFcLZAgpiYOorb2aGtv95p2tFc4RXNv/uiW6echBhD
	3blNhG+L3GIZmcQdLX9s9Ty+5So9ZmbDafVzuU/iyB8QbxATnSKXY9RPVXtShsYmG/2zD2eXe6GUG
	QkPdwoyNYktd2lDtcFVaeqiPn2tUtErbSXeHxx1oJLdSVNqBa86tXu7ytQR5zfZrktWnz7eidtLAM
	0MsCKmiA==;
Date: Mon, 2 Sep 2024 11:22:21 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, johan@kernel.org, pmenzel@molgen.mpg.de,
 jirislaby@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Adam Ford
 <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
 tomi.valkeinen@ideasonboard.com, =?UTF-8?B?UMOpdGVy?= Ujfalusi
 <peter.ujfalusi@gmail.com>, robh@kernel.org, hns@goldelico.com
Subject: Re: [PATCH v4 0/4] Bluetooth/gnss: GNSS support for TiWi chips
Message-ID: <20240902112221.1a6ac6f5@akair>
In-Reply-To: <CABBYNZ+Fz2TLSNa28H3kjVKOSA7C-XOzdQJiHdJs3FKxnq01DA@mail.gmail.com>
References: <20240606183032.684481-1-andreas@kemnade.info>
	<CABBYNZ+Fz2TLSNa28H3kjVKOSA7C-XOzdQJiHdJs3FKxnq01DA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Am Thu, 6 Jun 2024 16:04:10 -0400
schrieb Luiz Augusto von Dentz <luiz.dentz@gmail.com>:

> Hi Andreas,
>=20
> On Thu, Jun 6, 2024 at 2:30=E2=80=AFPM Andreas Kemnade <andreas@kemnade.i=
nfo>
> wrote:
> >
> > Some of these chips have GNSS support. In some vendor kernels
> > a driver on top of misc/ti-st can be found providing a /dev/tigps
> > device which speaks the secretive Air Independent Interface (AI2)
> > protocol.
> >
> > To be more compatible with userspace send out NMEA by default but
> > allow a more raw mode by using a module parameter.
> >
> > This was tested on the Epson Moverio BT-200.
> >
> > Who will take this series (1-3)? GNSS with ack from Bluetooth?
> >
> > Changes since V3:
> > - Finally remove the period from 1/4 subject
> > - include things directly for get_unaligned_le16() to fix 0-day
> > issues
> >
> > Changes since V2:
> > - Optimize waits
> > - Fix some packet analysis / checksum computation issue
> > - Adding a proposal for removing those waits as RFC
> > - Minor spell corrections and improved descriptions
> >
> > Changes since V1:
> > - Set up things for NMEA output
> > - Powerup/down at open()/close()
> > - split out logic between drivers/bluetooth and drivers/gnss
> > - leave out drivers/misc/ti-st driver removal to avoid
> >   filling up mailboxes during the iterations, this series is
> >   still a proof that it is not needed, will take the brush after
> >   this series is accepted.
> >
> >
> > Andreas Kemnade (4):
> >   gnss: Add AI2 protocol used by some TI combo chips
> >   Bluetooth: ti-st: Add GNSS subdevice for TI Wilink chips =20
>=20
> The bluetooth one looks relatively simple so I could take that one and
> push to bluetooth-next if there are no dependencies on the other
> changes.
>=20
hmm, nothing happens here. You did not ack it so Johan could not take
it. So what about taking the bluetooth patch now and the other ones can
go in for maybe 6.13? At least that would reduce spam and the poor
bluetooth ci bot will not spam complaints because it sees non-bluetotoh
patches.

Regards,
Andreas
