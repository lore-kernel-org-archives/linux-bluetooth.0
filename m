Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3F315278F
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505471; cv=pass; b=tguw7J5ptAabC0nQkWYToFZTepoIZ6OdGxKuQfaleUWaZNhPZZnmhf585+SlHyoBq7Mc04pWNgdn3VdvmErZtxOgSJDTUY8UulrJ49/YHfqwcVyvw0hv/CgaGeZ0sEt5fLweP3w0554uvPVF+OciRw+3xHkNi6vFkSknDYsBYFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505471; c=relaxed/simple;
	bh=JKWL0b+4+zUJp50SxLPqCKQocpcTlmLk8vychdPT2c0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ssiqThwaTUqwFks49u2v/V6NUU4Ac3PQwT+jrTOeUz1licbTBz5F3QPSvCED1qul8F4ZD89iYjn67bfDt2SfNLcN43eAy4VMtoFdSsil4N1q4OcTrQrDVGwdg8bovpP5/4WYJeI+YZFtN8bU+skrbtPjGjeoPXYb1aCxsHSZmuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=R7gWEkAe; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="R7gWEkAe"
Received: from monolith.lan (91-152-121-138.elisa-laajakaista.fi [91.152.121.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4W93ml1xj9z49Q0G;
	Thu, 27 Jun 2024 19:24:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1719505463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opWHvHCmLINEUApkjQSpJJVQW65eNZQW6DxdX3+uiOI=;
	b=R7gWEkAef538/W3XGSDhukUOZEDHJMIHNznM/jus2/sca+DMBH5coO1gdoNKMyoSB9rVWL
	RxtGRMlLXDQH/rEr8e4UzdZTwsoadyB6DHPwoNcLwKE3+5wJktX4AfJFi3ZEWQyok+y9iZ
	tjAnBRXNkUBnwp7jiBvy/hFpEvovw4Sd4u92dNgBHVQRSHK7vCVLjxNA96Dh6DzhBfeLVK
	AbNKXKgWIpDoE49Dca3o5IEYTIREjTQ2jJAM2+EvgM1T8Rf1LLPWhmyAdTCIUC7fte/ZCx
	qq3PDIsWkuDFW2PkE/M5vzL7JukNZ2BhDgoGAQObo7wjGJw57k35TuC+Wx9aYA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1719505463; a=rsa-sha256;
	cv=none;
	b=gcZ1jO0+14fGqbsh5x+hcW5P3Ml6w69jmaiuRCuK8ZbZ2xSN67rAYXfsBSXFx+6yAwH7cF
	Wkrup0T+GYZN4F9vEFuWQ9dThzr82vk538u4PmM46vVD9i4zYmH8fkL/uHeeqpIyK9XVuF
	Mvt2Dfz1JJxOBmyN/Pq1wezJPiVeQbzNCwIH1jZssWXiRUjvAg4A+Cugs8i3af2EQ2up8E
	K0wtY6iBOKxnY+ShiQH3TDYIFuSCprTg4PRugPEskUAniISz9hbLGK1yeUDh9zMYRosbcq
	3qIPSMG/wrJgTsRbX+TA4RETOP0FYaJ2bdq0CZbsMyO9oklGRATOJCT8sYWbvQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1719505463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opWHvHCmLINEUApkjQSpJJVQW65eNZQW6DxdX3+uiOI=;
	b=lb2tiX5xvkF1wn0Dob98xeyK8x8k28gp27hJFgftFZMxYKxwNQSnTQo5ZNbZWwiohrGM9t
	5LX3ZqRRPnKIeyX3eOQHdELqFayATE/TiPN68I6t9Y3xfSMrxAKifBHpKGRaESF2LNKrcS
	9LHHGD/mmCniq0ysaHbZyDiiN1H9uLjHVZnEui2TC7h+1hrzCI571pTkZXUTCAGCgt37OU
	aKk/bZDsHTvPWgA9drbsLz30dR5HqWH4mVsgR/1NLVyM6aaXgOPzyxdfBPa/GCxlcDjMwI
	G/w5u1RkM4awjcD4hJEXAg2NNc6CgvLaC27A1/FlKgGq642w5qDhYf9g2agYug==
Message-ID: <93bef84b37237fcc9fac8d7e7a80bd640f01d064.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth : Update the mas session structure
From: Pauli Virtanen <pav@iki.fi>
To: Amisha Jain <quic_amisjain@quicinc.com>, linux-bluetooth@vger.kernel.org
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
	quic_anubhavg@quicinc.com
Date: Thu, 27 Jun 2024 19:24:23 +0300
In-Reply-To: <8ae5c6f5-e005-42d9-ad5b-ea53a978a85a@quicinc.com>
References: <20240625063533.30536-1-quic_amisjain@quicinc.com>
	 <dac1d55c940b3a9afb971263c8195e765e77c598.camel@iki.fi>
	 <8ae5c6f5-e005-42d9-ad5b-ea53a978a85a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2024-06-26 kello 11:40 +0530, Amisha Jain kirjoitti:
> Hi,
>=20
> Correct! The problem here is manager_emit_transfer_property() is=20
> expecting the structure of type 'obex_transfer' and we are passing the=
=20
> structure of session type which will be type mismatch and inappropriate=
=20
> values will be populated in further calls in code. Hence property "Size"=
=20
> will never emit on console(obexctl) as it is not set properly and might=
=20
> cause crash/disconnection.
>=20
>  > diff --git a/obexd/src/obex.c b/obexd/src/obex.c
>  > index a4bae857f..ed219d3e7 100644
>  > --- a/obexd/src/obex.c
>  > +++ b/obexd/src/obex.c
>  > @@ -779,6 +779,9 @@ int obex_put_stream_start(struct obex_session=20
> *os, const char *filename)
>  >                  return err;
>  >          }
>  >
>  > +       if (os->size !=3D OBJECT_SIZE_DELETE && os->size !=3D=20
> OBJECT_SIZE_UNKNOWN)
>  > +               manager_emit_transfer_property(os->service_data, "Size=
");
>  > +
>  >          os->path =3D g_strdup(filename);
>  >
>=20
>=20
> One way to resolve this issue is to add the additional field in=20
> 'mas_session' so it can cast to struct 'obex_transfer'. We are adding=20
> new field 'char *path' as only transfer->path will be invoked and passed=
=20
> further.

Yes, thank you for clarification.

Although I'm not BlueZ maintainer, I think relying on type punning
mas_session and obex_transfer by adding fields so that their memory
representation is partly the same is not very good practice. Other
plugins like ftp.c seem also have similar issue.

One could consider some ways to avoid doing this, e.g. move the

        if (os->size !=3D OBJECT_SIZE_DELETE && os->size !=3D OBJECT_SIZE_U=
NKNOWN)
                manager_emit_transfer_property(os->service_data, "Size");

after each call to obex_put_stream_start in plugins/*.c
client/mns.c.=C2=A0For plugins where there's no transfer, it maybe can be
omitted.

>=20
> void manager_emit_transfer_property(struct obex_transfer *transfer,
> 								char *name)
> {
> 	if (!transfer->path)
> 		return;
>=20
> 	g_dbus_emit_property_changed(connection, transfer->path,
> 					TRANSFER_INTERFACE, name);
> }
>=20
>  >> Signed-off-by: Amisha Jain <quic_amisjain@quicinc.com>
>  >> ---
>  >>   obexd/plugins/mas.c | 4 +++-
>  >>   1 file changed, 3 insertions(+), 1 deletion(-)
>  >>
>  >> diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
>  >> index 10b972d65..71bf12ad3 100644
>  >> --- a/obexd/plugins/mas.c
>  >> +++ b/obexd/plugins/mas.c
>  >> @@ -51,6 +51,8 @@
>  >>   #define ML_BODY_END "</MAP-msg-listing>"
>  >>
>  >>   struct mas_session {
>  >> +	uint8_t notification_status;
>  >> +	char *path;
>  >>   	struct mas_request *request;
>  >>   	void *backend_data;
>  >>   	gboolean finished;
>  >> @@ -59,7 +61,6 @@ struct mas_session {
>  >>   	GObexApparam *inparams;
>  >>   	GObexApparam *outparams;
>  >>   	gboolean ap_sent;
>  >> -	uint8_t notification_status;
>  >>   };
>  >>
>  >>   static const uint8_t MAS_TARGET[TARGET_SIZE] =3D {
>  >> @@ -125,6 +126,7 @@ static void *mas_connect(struct obex_session=20
> *os, int *err)
>  >>   		goto failed;
>  >>
>  >>   	manager_register_session(os);
>  >> +	mas->path =3D NULL;
>  >
>=20
> There is no transfer already registered for mas during connection, so=20
> setting the path to NULL.
>=20
> On 6/25/2024 9:09 PM, Pauli Virtanen wrote:
> > Hi,
> >=20
> > ti, 2024-06-25 kello 12:05 +0530, Amisha Jain kirjoitti:
> > > Update the 'mas_session' structure such that
> > > manager_emit_transfer_property(os->service_data, "Size")
> > > will get the proper structure in arguments as
> > > expected like structure 'obex_transfer' and transfer->path
> > > won't be populated with inappropriate value.
> > >=20
> > > As there is no new transfer registered during mas connect,
> > > hence setting the path to NULL to avoid invoking the
> > > g_dbus_emit_property_changed() property.
> > >=20
> > > Signed-off-by: Amisha Jain <quic_amisjain@quicinc.com>
> > > ---
> > >   obexd/plugins/mas.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
> > > index 10b972d65..71bf12ad3 100644
> > > --- a/obexd/plugins/mas.c
> > > +++ b/obexd/plugins/mas.c
> > > @@ -51,6 +51,8 @@
> > >   #define ML_BODY_END "</MAP-msg-listing>"
> > >  =20
> > >   struct mas_session {
> > > +	uint8_t notification_status;
> > > +	char *path;
> > >   	struct mas_request *request;
> > >   	void *backend_data;
> > >   	gboolean finished;
> > > @@ -59,7 +61,6 @@ struct mas_session {
> > >   	GObexApparam *inparams;
> > >   	GObexApparam *outparams;
> > >   	gboolean ap_sent;
> > > -	uint8_t notification_status;
> > >   };
> > >  =20
> > >   static const uint8_t MAS_TARGET[TARGET_SIZE] =3D {
> > > @@ -125,6 +126,7 @@ static void *mas_connect(struct obex_session *os,=
 int *err)
> > >   		goto failed;
> > >  =20
> > >   	manager_register_session(os);
> > > +	mas->path =3D NULL;
> >=20
> > Maybe the problem here is that the change in commit bb160515185e
> > ("obexd: Emit Size property of transfer after open()") is not right?
> >=20
> > diff --git a/obexd/src/obex.c b/obexd/src/obex.c
> > index a4bae857f..ed219d3e7 100644
> > --- a/obexd/src/obex.c
> > +++ b/obexd/src/obex.c
> > @@ -779,6 +779,9 @@ int obex_put_stream_start(struct obex_session *os, =
const char *filename)
> >                  return err;
> >          }
> >  =20
> > +       if (os->size !=3D OBJECT_SIZE_DELETE && os->size !=3D OBJECT_SI=
ZE_UNKNOWN)
> > +               manager_emit_transfer_property(os->service_data, "Size"=
);
> > +
> >          os->path =3D g_strdup(filename);
> >=20
> > This casts os->service_data to obex_transfer which IIUC does not work
> > for most the plugins, as it's the session struct.
> >=20
> > Maybe plugins can emit the transfer property change in their open()
> > callback, for the plugins where it makes sense?
> >=20
> > >  =20
> > >   	return mas;
> > >  =20
> >=20

--=20
Pauli Virtanen
