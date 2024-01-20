Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8865EC9
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jan 2024 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705776064; cv=pass; b=AUzb/f53W0yRxzCcx357jEn5VSwmdhQb2WTDRKq6BZK9ddMp8RaWATwbEw/JlJBT2hURG3s0sb/cDvGD7KoANHiHqQIKhvgj5rLwbS/TrNajadACt4FWqFsbr5TIr0FoG9DoCpp9MbndMIaRagJrQAqbvlXLysnlKPWY6XQAZYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705776064; c=relaxed/simple;
	bh=5dfIVHITivj2b72q8/Zn+UIhLXP4yOiofiaC9j8cqDw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rt94Eo5Wah8+z/3t6TxE50o6mdDsSNkJR1FYDFjPIFbYBMhn1uilkzHQplVoN7L1Uj2IAw7VVuXDXBZSeU0IqsFD0kL1HOLB5I9trwbVIUeCFfStK/itpjlwKcvUuF3SGQNpc1UBP9Ypz55yG995rNKO+JLBz7XzFKDKXmk56X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=S4PbCXuV; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="S4PbCXuV"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4THQKX5HlCz49Ptk;
	Sat, 20 Jan 2024 20:40:48 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1705776050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5DvUIU2X3HaVycy5a2n0BoMwX6+yRH0EV/RXb6CBGKg=;
	b=S4PbCXuV46nGCj6F8PJP7DwxMgm4tUOOKZVdk820XcyWh7YC+tYXGuGg2lOVtHryChroFG
	IWZ/F8tDaMSNwbARkKIs2zsGUZcQvGYhwnbdluAS6WMlGlvVra7g81NtjhfkVRpvyqZNu8
	5dBoX/SunQo/7PMqFYmljdWcu2noK4jMgbfMj4BROVe//RVZ/g1/KwodhRIH4cv84hqWC8
	5hQeOsdn+NvUmmod99/6HRgJGoRcuZtrdMR9guKemsvvQnA3180WexGb+gFhVMa21J40nZ
	2jD3GMirdmMGUlasRvZcAHAl4UXnmsw+QlA1BEe+O1e6YTJmx3M5Disv/WNL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1705776050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5DvUIU2X3HaVycy5a2n0BoMwX6+yRH0EV/RXb6CBGKg=;
	b=NZrvC+7SYeSY1q3J/thxk4DeS/6YZxse4Ic1yzQ7z43FtD3YUK1DwZu4Uyo2AlvYmpgYFH
	WWfi60cRFAZulhNt18IqnxtqCZhOHMlyzyIy9YWJqtqGj5xM29+r2WjlwDoJdJc58ksgTf
	u0M5wreK9f8V0pIaNmCMK32kHHXFkqZpX+1ptiWkGf147elVLGsekCli83+0JeQ42KyyCA
	TiurXrtCsCSo1zEZVgIKz0AUtgeeMLnhmCm63SpG+jNxX88yKbA+Yv1KUbT+M/dAHKRgvW
	9qqsUCqM1vELQ9FHtGEXWXM2tOqgQsIGmP57BeeFL1SQfa7VvGEQ51Sa10JmGQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1705776050; a=rsa-sha256;
	cv=none;
	b=EsnbWceUELLN9as0qMxyEov+GegUPz4FNxTog2gGoToaZKR8sokPLJBVZ29Kxwisw9CZUJ
	kY3USCipEPllp6gqvbzo43CK/k+9ilAEuMKYPCs/YUeuGihZJ9HNUdJ2r28ym71VLbfw4b
	4adtb7CH6b5VwdOSaIh4Wcg1kX9bdQ2gnWJ9wQQiWE/WeLkoHFNBqdvZL3EGTySth1xc9q
	k3hn5Q6EfXWPtO8wd05K9kUOzg+PdkEnxN2uEHhxdQLOPF5BI9Fi7ko+zdLJqdj6+ldjtz
	ITFlwaV7n5m8a/aJAIju3oIDyI5+WXNbWKYzaKqsn3qoFaLbvNW1Vef1kXBqQA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <e5e90163396ecd6091616274cbe08e7d613df32f.camel@iki.fi>
Subject: Re: [PATCH BlueZ v1 2/2] transport: Print owner information when it
 exit or release
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Sat, 20 Jan 2024 20:40:45 +0200
In-Reply-To: <CABBYNZK4ODoPDy20jk48tPW8rnAgLdOMrhdkgMPeanSLz-x-mA@mail.gmail.com>
References: <20240117222317.1792594-1-luiz.dentz@gmail.com>
	 <20240117222317.1792594-2-luiz.dentz@gmail.com>
	 <CABBYNZK4ODoPDy20jk48tPW8rnAgLdOMrhdkgMPeanSLz-x-mA@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2024-01-17 kello 17:36 -0500, Luiz Augusto von Dentz kirjoitti:
> On Wed, Jan 17, 2024 at 5:23=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >=20
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >=20
> > This prints the owner name when it exits/quits/crash or releases a
> > transport.
> > ---
> > - Looks like there is a bug/race on codec switch it appears the likes o=
f
> >   pipewire attempts to call Release in the process which stops the
> >   acquire/resume:
> >=20
> >   bluetoothd[1774429]: profiles/audio/transport.c:transport_set_state()=
 State
> >   changed /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep1/fd8: TRANSPORT_G
> >   bluetoothd[1774429]: profiles/audio/transport.c:media_request_create(=
)
> >   Request created: method=3DAcquire id=3D50
> >   bluetoothd[1774429]: profiles/audio/transport.c:media_owner_add() Own=
er
> >   :1.133105 Request Acquire
> >   bluetoothd[1774429]: profiles/audio/transport.c:media_transport_set_o=
wner()
> >   Transport /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep1/fd8 Owner :1.5
> >   bluetoothd[1774429]: profiles/audio/transport.c:release() Owner :1.13=
3105
> >   bluetoothd[1774429]: profiles/audio/transport.c:media_owner_remove() =
Owner
> >   :1.133105 Request Acquire
>=20
> I wonder if we have a regression on BlueZ or PW for A2DP, since I
> recall this used to work just fine while switching codecs back and
> forth, but today it didn't work at all for me and I had to reconnect a
> couple of times to get it working:
>=20
> > pipewire --version
> pipewire
> Compiled with libpipewire 1.0.0
> Linked with libpipewire 1.0.0

I don't think there are any recent related changes on Pipewire side
recently. I've also not been able to reproduce the above (w/ bluez 5.72
or current master) or seen other similar reports. Maybe there is some
old bug that surfaces only in some cases.

From the above log I don't get what is going wrong, maybe if you have
the full bluetoothd log that shows what happened after connect with
timestamps that could help.

> pw.node: (bluez_output.94_DB_56_F7_F2_88.1-70) running -> error
> (Received error event)

This should only appear if:

1. Acquire DBus call returns error

2. Acquire DBus call results to NoReply timeout error

3. BlueZ initiates a transition back to inactive state for a transport
that was previously acquired

Due to the last one, the full log would be useful.

>=20
> >  profiles/audio/transport.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> > index a4696154aba5..5395985b990f 100644
> > --- a/profiles/audio/transport.c
> > +++ b/profiles/audio/transport.c
> > @@ -531,6 +531,8 @@ static void media_owner_exit(DBusConnection *connec=
tion, void *user_data)
> >  {
> >         struct media_owner *owner =3D user_data;
> >=20
> > +       DBG("Owner %s", owner->name);
> > +
> >         owner->watch =3D 0;
> >=20
> >         media_owner_remove(owner);
> > @@ -742,6 +744,8 @@ static DBusMessage *release(DBusConnection *conn, D=
BusMessage *msg,
> >         if (owner =3D=3D NULL || g_strcmp0(owner->name, sender) !=3D 0)
> >                 return btd_error_not_authorized(msg);
> >=20
> > +       DBG("Owner %s", owner->name);
> > +
> >         if (owner->pending) {
> >                 const char *member;
> >=20
> > --
> > 2.43.0
>=20
> It seems you PW calls Release after Acquire, not sure if it didn't
> like our response to Acquire or something.
>=20

--=20
Pauli Virtanen
