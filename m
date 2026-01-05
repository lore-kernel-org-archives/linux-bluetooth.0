Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F713314DE
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767644443; cv=pass; b=CXw1pweoV5iw1uSOTufXlud+vwoW3PQzJmjZx+i1iT420s+tlQ+MnMAGyI+5phxsXi2cGxP7jTf2oNibhxvmJ7ulbknF7ugW1Bf+93ZcsM3cch0rvUQykbek7H+guaGT0yQxjaBLdg9Cq9H2oazNq8gzKTDjA+YUafTMJVyOsB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767644443; c=relaxed/simple;
	bh=95l8WSh0rJobw7b1v8cRHfWUu8Zpl2re0KYedQ4TJyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tcQqvgl3goRNeK3wHEh26jwZnjREGa9IWs3A4gHDWTOgEthJIhppgKybnXo2QlMG7gjFKhwR3aU7KOSQNSX3zmvGyOEWEdKjEK6IADVwlQtC1nykP+2Ai6DFoeQIP+rtUK3f/OS/fNfOqu407YkagQ0v4cxhXQIlRxSH7iswg+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Bc4w9eZ/; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Bc4w9eZ/"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4dlQfF1cYYz49PxB;
	Mon, 05 Jan 2026 22:20:37 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1767644437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEuxk8XgC335TU92Sj8gMqbY+TPDwI63Km2fFwdi5HY=;
	b=Bc4w9eZ/ugAfu5vK7XNUhxzrLgv59zIKXVvVtK7oa17gBLbhBNyP7O9VJA9EWp1td1z45R
	7neewTIsv9s/MPSyc1V0MfAJhSEBAFYVI6AiKOKxP2V6onKMy4amSVS3+L2aQSjDaThC4d
	M3uEdTwzNYBQ8YkrMXt8auXuBW2+s24kIg1OAvqu/l740iXHbrOtMoZhPOtxVz2Bby+6mb
	64jjMKNN0alyxODf87b5k0yRXAYJ9fMkQBD4cWnf6SN0D2pudpt/tCLpx565Au20XCZaFP
	UlgimkBbKaNFQ9VDMwv8QJ7UMYz/keeh7P6Y/Fnl1FeSK7qHXA3bqUUC0Nqntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1767644437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEuxk8XgC335TU92Sj8gMqbY+TPDwI63Km2fFwdi5HY=;
	b=IA7pi7mjqn3S87cUgjDKhaaSmDGuKb6pNeGAMBJMV25fKofiPFzMscsye30yE+L6fJ1lss
	0Wp3o4jK02+OQ0MxqqQn/xAhzqzeR0p8DMdlUlGg1BjqsMyvLXffnybYKkGAb8G4anC/mz
	Flc0bVfUTHDvcKobqGkRRgsGZkP6zUyQVCIQabMDVb+Qisq+QeFdDx3oVvxWOQEREND2bo
	3dtQzBJkedsSPcue6FaGY5FMfBcwQmLn3LNWPGefkdgFakkxlo8W1WEWFjUZcep+huy5kT
	+JYk1zY1lvg43QOZ+z14oCQnRGLVtinqz5AMTqIimBBRjNhcrgKPnKlkzi/tSQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1767644437;
	b=D9Sz+yXdr1husTgodLMO7LZg4oBgsjTMI9UTWSJN3cxr2D3rrxWit24EXCeytEnfTI3sMM
	X4SEDoq1GRQPI8LfhVe8V3e/mZ+U927hGBmj+S18JLq9na8AE5mDHG3xLCqkXkgat/pJNh
	vFNe10kwodp8sfYMsrqk1xjNPWWaoO2QoIld5fRkxCmimusYjiZAViliqK2Cqgq5I3xtqm
	+jJbv4teEskvl4+MrRD4XoysgMemEypbm0qR27PA3B0Yg4pKN7PIysWIThDIFKpyAbplc6
	UCO9omulbswzGLa9yR8fVOcjoSeScX7k+zMoTu4AKglbbnuD5o4ZNvtG2tvWSg==
Message-ID: <7126bb812e05c324970c04604b5377e84a0e54f2.camel@iki.fi>
Subject: Re: [PATCH BlueZ 1/3] shared/bap: add bt_bap_stream_is_server
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 05 Jan 2026 22:20:35 +0200
In-Reply-To: <CABBYNZ+t35ShsD2C+Hee8tOLpBgsq4L+keS6bozqPr5m+rn6ig@mail.gmail.com>
References: <cover.1767559459.git.pav@iki.fi>
	 <ce1ecf069f0856ff58471bbc39c6e38ad4acf0a9.1767559459.git.pav@iki.fi>
	 <CABBYNZJ5gFe1N-NGU-ni7TybTraCh3yFDjwSEzYUzeC84_Kqyg@mail.gmail.com>
	 <afee37a9062cab55f853b25ec1550eab005d6306.camel@iki.fi>
	 <CABBYNZ+t35ShsD2C+Hee8tOLpBgsq4L+keS6bozqPr5m+rn6ig@mail.gmail.com>
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

ma, 2026-01-05 kello 14:29 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Mon, Jan 5, 2026 at 2:09=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
> >=20
> > Hi,
> >=20
> > ma, 2026-01-05 kello 13:45 -0500, Luiz Augusto von Dentz kirjoitti:
> > > Hi Pauli,
> > >=20
> > > On Sun, Jan 4, 2026 at 3:51=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wr=
ote:
> > > >=20
> > > > Add function for determining whether a given stream is a BAP Server
> > > > stream or not.
> > > > ---
> > > >  src/shared/bap.c | 6 ++++++
> > > >  src/shared/bap.h | 2 ++
> > > >  2 files changed, 8 insertions(+)
> > > >=20
> > > > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > > > index 6a35e4e1d..d0425318c 100644
> > > > --- a/src/shared/bap.c
> > > > +++ b/src/shared/bap.c
> > > > @@ -4270,6 +4270,12 @@ uint8_t bt_bap_stream_get_type(struct bt_bap=
_stream *stream)
> > > >         return 0x00;
> > > >  }
> > > >=20
> > > > +bool bt_bap_stream_is_server(struct bt_bap_stream *stream)
> > > > +{
> > >=20
> > > It is probably a good idea to check if the stream is valid first
> > > before attempting to check if the client field is valid.
> >=20
> > Yes
> >=20
> > > > +       /* Stream is a BAP Server stream (not Broadcast or BAP Clie=
nt) */
> > > > +       return !stream->client;
> > >=20
> > > Hmm, so the assumption here is that stream->client is set for
> > > broadcast as well? Perhaps the terminology is misleading here, perhap=
s
> > > initiator would have been better, otherwise this may be confused with
> > > BAP client/server role which only applies to unicast, anyway Im fine
> > > rewording it later but I think it would be clearer to have something
> > > like bt_bap_stream_is_initiator.
> >=20
> > Yes, client=3Dtrue is set for bcast in bap_bcast_stream_new().
> >=20
> > This is intented to returns whether the stream is BAP Unicast Server
> > stream, hence the is_server() suffix, but maybe it's slightly strange
> > API with broadcast.
> >=20
> > Maybe bt_bap_stream_is_initiator() is clearer here,
> >=20
> > Local is Initiator Sink (Unicast only) -> MICP
> > Local is Initiator Source (Unicast or Broadcast) -> VCP
> > Local is Acceptor Sink (Unicast or Broadcast) -> VCS
> > Local is Acceptor Source (Unicast only) -> MICS
> >=20
> > where Initiator is assumed to also be Commander, with the definitions
> > from CAP.
>=20
> Yep, I guess that is clearer than reusing the client in the context of
> stream, or perhaps MICP/VCP have role definitions for these?

MICP/VCP have role definitions but they appear equivalent to just
Client/Server but in different words. AFAIK they don't associate them
with BAP streams.

I'd maybe go with CAP terminology here.

> >=20
> > > > +}
> > > > +
> > > >  static void notify_pac_removed(void *data, void *user_data)
> > > >  {
> > > >         struct bt_bap_pac_changed *changed =3D data;
> > > > diff --git a/src/shared/bap.h b/src/shared/bap.h
> > > > index 80e91f10a..983b9d9a6 100644
> > > > --- a/src/shared/bap.h
> > > > +++ b/src/shared/bap.h
> > > > @@ -113,6 +113,8 @@ struct iovec *bt_bap_pac_get_metadata(struct bt=
_bap_pac *pac);
> > > >=20
> > > >  uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
> > > >=20
> > > > +bool bt_bap_stream_is_server(struct bt_bap_stream *stream);
> > > > +
> > > >  struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac=
);
> > > >=20
> > > >  /* Session related function */
> > > > --
> > > > 2.52.0
> > > >=20
> > > >=20
> > >=20
> >=20
> > --
> > Pauli Virtanen
>=20
>=20

--=20
Pauli Virtanen
