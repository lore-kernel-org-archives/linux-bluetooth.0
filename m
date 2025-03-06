Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C7DDA8
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289837; cv=pass; b=HjBHTQT+3U7rhHib1UDAEn6ia9jot49RaSI0W5qdcDqWSx3oO3Mkw8b8DmXenEwXZZ5VJGYIp+aqE9hR7LACqTstF+IWe9/Ko45Z/PSk2yEHOhzafqTYyYCUwiTwENmZg7koZflQR99iQxdZNPDQlsc621/4YSI3hu4Wt7E/sdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289837; c=relaxed/simple;
	bh=YguD3tnedBOgKXiWTEZAxlawx8ba0X+dcnkNFVLMdcw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AIvflFXKFXJOqJpGst3xZtgikYiWSwIzTUQqCammHCca962u5uOgq+jnsnEY5oOtXHgSuwcIwUjGWwT7Y9T3a3pbNRNnzYa6X+v3TN9MwPwDxWI8pi8Pm1JCpX7swumADwTxAMeNV6kMk7c4q4Z/GxILWCwbHy0dNbZcZbjygrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=eXunudo2; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="eXunudo2"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z806w2GMgz49Q3S;
	Thu,  6 Mar 2025 21:37:12 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1741289832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SC6OCRo2Un91f4vxLoTz4VKIIkrlnkHt+F1HKDe31y4=;
	b=eXunudo2wMFBh9QlOWeY3Di/1x9eWXjFjn6we33j4lt8sbT6SarXb6NxdxHVRK3hSh1iTu
	v/ixPI1Ns/+JvQvBik22JkbbZp9E/b+4Y+Az/rztv4aQMp8E/mcPaQlk9jwNp5riCbJ4PA
	CtjbiR063oSH1P+CEs00ij45PfaTcff6jDnufix/2oxiPRDH7BmfMgQhWbozQ23CArReH1
	rSmgs3kt3Q+EoZ+4GdxMeuhCl5rmvqosiKmrGGKZ4ddDMTM3sFM8Mio72bpeEk9m+wBVrf
	RVcy+/yfKVBnVE+IoO14tGV2WXIeFJZdpn7oPBYo+EJsmYFY2esTUBU0+S4iCg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1741289832; a=rsa-sha256;
	cv=none;
	b=hGebewG0j96r7bS2+Xz95tYUWjOTANrFkiMftyw30Krcj/jK0LL18Wl4ARIm7rc4yLuHy0
	u5HLuSA41+tFJ5RTS9SAEroGEXW2rEFSBNPZhmHZmzot9OHq/GQ04bS0daSnEHZAMbHa6E
	w9eiq0+fBYZFZl9Z31bXgIuxCDgYU1xWA85Tp9AT1T4/ForKEMkxmcS3loEhJ5PhxpQ37h
	6Rj845vpNSXD4ajZ/DcYlSfeMFwMbMvyBfnN6wQy57pL0Ecl+Rp8IkcvgNWaCddGoy4hgA
	GAGvKxwMBakkIL6Owoh+T8Uh3d3gORHpxXROY6STTYSvJ9KsPDyEJiGg4G3Tag==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1741289832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SC6OCRo2Un91f4vxLoTz4VKIIkrlnkHt+F1HKDe31y4=;
	b=AZ+qQp0aRC+QrL9LtGJu/8NcuFX307zq/6upLlocGel1KBCr/OaQne9yxhZxolS1QEOnLT
	lR4iBvN4/0IYXYZlx852QDO7Gdz2XfNA1V285r+eha08WjxlOPNHcD2d6xda3MiBDgHNTc
	9jcCYkjegP3xJ/irRN0h4rzmMiJPB78aIuSuxWVC/IvBDedS97qbHtPrOBfdUlG3RVAgDm
	HeXFZmjMBVmC3GUP6qnP6dsb08dedd/D00+M3WUVvxbC2UjAQb13+VonG1hkc8tcNJF3j5
	yfF4bTHdYNdFcFPMfkQlW5iFzyUqy340guZ1E3lR6wwUr1GsE76aVOWZqQqI6g==
Message-ID: <6a0b6a9b460780f86b7ac70f173e86398dcf14f7.camel@iki.fi>
Subject: Re: [PATCH BlueZ 3/3] sco-tester: check sent SCO data is received
 at bthost
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 06 Mar 2025 21:37:11 +0200
In-Reply-To: <CABBYNZ+rW_Wh+dVL9fF8uvNiQdt5351PoMR3Mb9-G8OaVWzwxQ@mail.gmail.com>
References: 
	<1b2a8e408573624a7b5e5e792c7e89c8315811e3.1741190102.git.pav@iki.fi>
	 <7cc0c544b498337e6591610be16e9361687e0196.1741190102.git.pav@iki.fi>
	 <CABBYNZ+rW_Wh+dVL9fF8uvNiQdt5351PoMR3Mb9-G8OaVWzwxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2025-03-05 kello 13:58 -0500, Luiz Augusto von Dentz kirjoitti:
> On Wed, Mar 5, 2025 at 10:58=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > When sending data, also check that the data is received by bthost.
> > ---
> >  tools/sco-tester.c | 47 ++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 45 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tools/sco-tester.c b/tools/sco-tester.c
> > index 7f37ca5cf..9886481ff 100644
> > --- a/tools/sco-tester.c
> > +++ b/tools/sco-tester.c
> > @@ -318,10 +318,51 @@ static void client_connectable_complete(uint16_t =
opcode, uint8_t status,
> >                 tester_setup_complete();
> >  }
> >=20
> > +static void bthost_recv_data(const void *buf, uint16_t len, uint8_t st=
atus,
> > +                                                               void *u=
ser_data)
> > +{
> > +       struct test_data *data =3D user_data;
> > +       const struct sco_client_data *scodata =3D data->test_data;
>=20
> I had to add the following change in order to pass with these changes:
>=20
> +       /* Ignore empty packet as that is used to confirm NOCP is being
> +        * generated.
> +        */
> +       if (!len)
> +               return;
> +
>=20
> Now I wonder if this may be a problem since it does show up as a data
> packet even though it is empty, I guess for the purpose of HFP
> streaming it shouldn't cause problems but if someone attempts to do
> packet based checks like this it may stop working.

It's probably a change in behavior if the controller interprets the
zero-length packet as an instruction to send zero-filled SCO packet
(with valid CRC etc) over the air. I'm not sure what the controllers do
here.

The timer causes a small hiccup at startup, but that is only once per
controller index added. Since then the controller is not spec-
compliant, maybe it is OK and there could be a quirk...

>=20
> > +       --data->step;
> > +
> > +       tester_print("Client received %u bytes of data", len);
> > +
> > +       if (scodata->send_data && (scodata->data_len !=3D len ||
> > +                       memcmp(scodata->send_data, buf, len)))
> > +               tester_test_failed();
> > +       else if (!data->step)
> > +               tester_test_passed();
> > +}
> > +
> > +static void bthost_sco_disconnected(void *user_data)
> > +{
> > +       struct test_data *data =3D user_data;
> > +
> > +       tester_print("SCO handle 0x%04x disconnected", data->handle);
> > +
> > +       data->handle =3D 0x0000;
> > +}
> > +
> > +static void sco_new_conn(uint16_t handle, void *user_data)
> > +{
> > +       struct test_data *data =3D user_data;
> > +       struct bthost *host;
> > +
> > +       tester_print("New client connection with handle 0x%04x", handle=
);
> > +
> > +       data->handle =3D handle;
> > +
> > +       host =3D hciemu_client_get_host(data->hciemu);
> > +       bthost_add_sco_hook(host, data->handle, bthost_recv_data, data,
> > +                               bthost_sco_disconnected);
> > +}
> > +
> >  static void setup_powered_callback(uint8_t status, uint16_t length,
> >                                         const void *param, void *user_d=
ata)
> >  {
> >         struct test_data *data =3D tester_get_data();
> > +       const struct sco_client_data *scodata =3D data->test_data;
> >         struct bthost *bthost;
> >=20
> >         if (status !=3D MGMT_STATUS_SUCCESS) {
> > @@ -334,6 +375,9 @@ static void setup_powered_callback(uint8_t status, =
uint16_t length,
> >         bthost =3D hciemu_client_get_host(data->hciemu);
> >         bthost_set_cmd_complete_cb(bthost, client_connectable_complete,=
 data);
> >         bthost_write_scan_enable(bthost, 0x03);
> > +
> > +       if (scodata && scodata->send_data)
> > +               bthost_set_sco_cb(bthost, sco_new_conn, data);
> >  }
> >=20
> >  static void setup_powered(const void *test_data)
> > @@ -740,8 +784,6 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOC=
ondition cond,
> >                 ssize_t ret =3D 0;
> >                 unsigned int count;
> >=20
> > -               data->step =3D 0;
> > -
> >                 sco_tx_timestamping(data, io);
> >=20
> >                 tester_print("Writing %u*%u bytes of data",
> > @@ -751,6 +793,7 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOC=
ondition cond,
> >                         ret =3D write(sk, scodata->send_data, scodata->=
data_len);
> >                         if (scodata->data_len !=3D ret)
> >                                 break;
> > +                       data->step++;
> >                 }
> >                 if (scodata->data_len !=3D ret) {
> >                         tester_warn("Failed to write %u bytes: %zu %s (=
%d)",
> > --
> > 2.48.1
> >=20
> >=20
>=20
>=20

