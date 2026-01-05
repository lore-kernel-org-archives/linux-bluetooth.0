Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A062222C9
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767640201; cv=pass; b=uUIYNE2j3gPUvIZvjtHWEmLSXoAGIZNGiaG6yVpEAJWTksSe1U6gWpc4l069X4tpCCOP0kbLiaWWlwV9sqnJasW5Ba2cwd35tMbLaLobAPS/7Ip7u6ZTcQZx2OAOn2nyFLVu1nPocTjmIF7PNbf9gmnYk+RPv83fGfYXbZfUpwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767640201; c=relaxed/simple;
	bh=W80bHikca2XsMrEUM3cG3cISyM9p7Fpy8UTrM859tp0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lw6GLTfEG9lUcyncxxaqxsr5DE+wEqNUKkf7hTBcMdL5QFi7Kq4OzNu1NH1cAr2taAwpMmI9EdOxCgiJJydcX4ayUIh6v+4m1eXuQeUC3jSRCQ2lJdJP0Vb8ArxQdNmgJWB1c7A52P2niCUctzBF0ipNg1ebEHBPVtGfEhWfDyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=e3dZKffU; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="e3dZKffU"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4dlP4Y0ZbWz49PtJ;
	Mon, 05 Jan 2026 21:09:48 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1767640189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMq6526a9yIPMZiQ/vUFVCJpEzwqWK8PhcznMZiHPOE=;
	b=e3dZKffUX1QE0T2tW+gigtgquQf0ztsxW6D5HX5rjiaIZLT8sp1qrIisX7/YBrqk1H4iVq
	IKap3hSty4GyxaubHMgCTt5qlWkMeSOz2ckWSy29p6TGjabz30K4bTnmdhrSSonQ3SnCo9
	ei1HNytuwOTpugxiR3psTTaxdD27QNRT/P2wGjYnvIFVHfw/5wo5tvW2oZr2p6kte2bSBo
	q/ZCQT50XHXB01oCVDcebVqyyFDe8T9kBUQV1zEbrn8JjuTyM8/2DReXciukIYJc1MfG8d
	wPSgesLF2m35lqnwCKikLoxcioPp3aUCfruGZ2YHnWUM21s4TL0DX+LmqipP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1767640189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMq6526a9yIPMZiQ/vUFVCJpEzwqWK8PhcznMZiHPOE=;
	b=ComBuyR6UAgUum/944VoTWSTFxLnJ1QXZgB5lFmEXf97clUJdBRD+kDRzKtdx9shApGRR6
	IiOR/E6tojaRxnhUzvafysYgt5bykKgqyCUaZxzHx0e2y6AwUdcL7b7IQIJmKjkupwoEji
	ZULZyu7wSMHHN8D4g+jViFU3NHqGlnIjw21wuGV9rH1VYTBRl5H448j2Z+NPUMOVJYhqCH
	0cIlaRE7EWMOQMR1KsBdf3Pd18XonC9S9tA9ZlxRRrowoht22lar48CsgrlWIN9tNCsaqM
	GsesfT6H8rkjbpBxvnn8sWyok9q7cp3Pgzc6AtX4vppksknXk4+/1zGICitMog==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1767640189;
	b=bAD8NWlzTZeCdwhAk6+Qh8l2AmxGYueQlvNMKhfwf7ejJBYwmTj9Ad8cVhJIHY6KbnP567
	f9vmNC3LyQgXrP6BDhpiz/5aFAttYeGMkmv+jGJO/EdeaJyHM/QrjazsSUe7K4P/w04Zlt
	GJYbbjdPsXZ/mnONu+ASz0TESda9P47nE9pWPZ69viyhYLSgZI0+Mdu2VJJDJqeuvFwoeh
	vcPWnYUHePsFtkydTDgEwmAdKq6Z+AuP4RCnaJSEMW2ej+5ZZmcUUWBbb3tYlaKBppBXwG
	5OIQjStsjP80SmpuVeLjTCDv14dnB1clRMKjGMAo5yxIP6HyWCvtBd58XjJsVw==
Message-ID: <afee37a9062cab55f853b25ec1550eab005d6306.camel@iki.fi>
Subject: Re: [PATCH BlueZ 1/3] shared/bap: add bt_bap_stream_is_server
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 05 Jan 2026 21:09:47 +0200
In-Reply-To: <CABBYNZJ5gFe1N-NGU-ni7TybTraCh3yFDjwSEzYUzeC84_Kqyg@mail.gmail.com>
References: <cover.1767559459.git.pav@iki.fi>
	 <ce1ecf069f0856ff58471bbc39c6e38ad4acf0a9.1767559459.git.pav@iki.fi>
	 <CABBYNZJ5gFe1N-NGU-ni7TybTraCh3yFDjwSEzYUzeC84_Kqyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2026-01-05 kello 13:45 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Sun, Jan 4, 2026 at 3:51=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
> >=20
> > Add function for determining whether a given stream is a BAP Server
> > stream or not.
> > ---
> >  src/shared/bap.c | 6 ++++++
> >  src/shared/bap.h | 2 ++
> >  2 files changed, 8 insertions(+)
> >=20
> > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > index 6a35e4e1d..d0425318c 100644
> > --- a/src/shared/bap.c
> > +++ b/src/shared/bap.c
> > @@ -4270,6 +4270,12 @@ uint8_t bt_bap_stream_get_type(struct bt_bap_str=
eam *stream)
> >         return 0x00;
> >  }
> >=20
> > +bool bt_bap_stream_is_server(struct bt_bap_stream *stream)
> > +{
>=20
> It is probably a good idea to check if the stream is valid first
> before attempting to check if the client field is valid.

Yes

> > +       /* Stream is a BAP Server stream (not Broadcast or BAP Client) =
*/
> > +       return !stream->client;
>=20
> Hmm, so the assumption here is that stream->client is set for
> broadcast as well? Perhaps the terminology is misleading here, perhaps
> initiator would have been better, otherwise this may be confused with
> BAP client/server role which only applies to unicast, anyway Im fine
> rewording it later but I think it would be clearer to have something
> like bt_bap_stream_is_initiator.

Yes, client=3Dtrue is set for bcast in bap_bcast_stream_new().

This is intented to returns whether the stream is BAP Unicast Server
stream, hence the is_server() suffix, but maybe it's slightly strange
API with broadcast.

Maybe bt_bap_stream_is_initiator() is clearer here,

Local is Initiator Sink (Unicast only) -> MICP
Local is Initiator Source (Unicast or Broadcast) -> VCP
Local is Acceptor Sink (Unicast or Broadcast) -> VCS
Local is Acceptor Source (Unicast only) -> MICS

where Initiator is assumed to also be Commander, with the definitions
from CAP.

> > +}
> > +
> >  static void notify_pac_removed(void *data, void *user_data)
> >  {
> >         struct bt_bap_pac_changed *changed =3D data;
> > diff --git a/src/shared/bap.h b/src/shared/bap.h
> > index 80e91f10a..983b9d9a6 100644
> > --- a/src/shared/bap.h
> > +++ b/src/shared/bap.h
> > @@ -113,6 +113,8 @@ struct iovec *bt_bap_pac_get_metadata(struct bt_bap=
_pac *pac);
> >=20
> >  uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
> >=20
> > +bool bt_bap_stream_is_server(struct bt_bap_stream *stream);
> > +
> >  struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
> >=20
> >  /* Session related function */
> > --
> > 2.52.0
> >=20
> >=20
>=20

--=20
Pauli Virtanen
