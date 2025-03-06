Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17FB249E5
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293180; cv=none; b=M4MIckFUMXtCzyKVggEjGgmjuJao476QRqv70Fa00IWd7hb7RvlxbFner5synNwxIvCkoc0GMUAVW32agSQhgoZRUIzBrGUW5hrFOVlaAiE5oV//6whuti6AkSCP/Mv87QWCWiO6eZA9M5urh8GVBX89qtWiGJ+9G7TQtxc2Yuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293180; c=relaxed/simple;
	bh=t0SnVHPk7DLXFtemNM8+YWQUR1lVzIlVAtGrnvz8QNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tb5MSbTFDH6QuUY+XvQs9te5LGpxtiovevg3DUa6AveCFkgGTAjjzwGwBe2NTyrVHUMuvE5iDqbsrVSU+Vb9l4omVx9LQAHI4lKnT0LMqdLTln3Txy7bhw2LrujJtcItQkCkJtQYnN+LF9CDod9z5O7iEsgSRSo0OwjisNmS/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzVIgpxz; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzVIgpxz"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bcb48b0a4so7849441fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Mar 2025 12:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741293177; x=1741897977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0s8+FrqnpQ63GrGxk8guABta0ChKwDEBGHV1Y7rsso=;
        b=NzVIgpxzotAI7FHCMlQ+rVvvoDHHUmPbF+FYXYcWSy/q7PThbHZUZ7OyT0ksxM+Id1
         lA1VPxfq9JpiBOEM6GIfWhW40TQUuhnaNXcyp/rDvvIGv5+UuBLTuZy2T36Fey+K6RR0
         oB3GJ2yNQsLFOKHvH+D2x0ZssyDC0+wwGMBXq9GQXO3bzA9oQvO/sDHn4hkXTTNIwiJr
         sMRuQHY+HSUcAmq82QHsWGLP4MB8ax5OdCrfqzS+sCyrhlfkq5BV1IVVjyBSNglmYv0i
         cTB4sdPNVmyRReQF2EQfivG9Kzlofm0ik9RW92phq29fcFCgl549yxrInuIO35JOBbck
         Wb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741293177; x=1741897977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0s8+FrqnpQ63GrGxk8guABta0ChKwDEBGHV1Y7rsso=;
        b=NN9jH2jUHtdWf9TDngd1grPIdbNcpPKItSEahAhk1EUDLGnGnju2lL/HFSDOpzaMOT
         HmjXgcCexMHvk4pJYoLHQ9idi4fGc/qt5J7lrhs8tdBzLosU5ljIRfkxVGI8eWb8HlRR
         C7cmuUgZMYCGf+Gsel2Elc/okmALljeJ+4ZP52DcAMt64cN4m2UW4Lnu87zPIufI+Wg9
         pQF5EPgSq3xL+3nZYG3Y12LJPOfgodEHm+YpsrS4mZawPISQW9K1kklGG8hPwLI4c62o
         sqsH1QZ9cWS18mdKTN3auMwCQprsWCa+TXxXC9dfpFoGrqsHVE+WD4l/dOmiRQTQUqc4
         B2YQ==
X-Gm-Message-State: AOJu0Ywr7tNVy1r5dyGfXtg6VZtDRPlywPejNjcS7gGJ8R3UWfAZvloe
	nDRytQJanhlq9pNFTXk64T11nUWDsRWbgJ1W1Ogd1Tqae9opRRDK64VlofOyiUpuW1WS8E51RPP
	eF6ddVJDI2sF10Ba6yYrghaekPts=
X-Gm-Gg: ASbGncvxyLCezuz+sQRZc4vpVsCxdn0g5tvwU2OREBXnJoQ/YRqyKb1t9BA9shmwCbP
	VSZRfnBlsqi8Z+awevPFGEjoqEkMAglsknAmS7vkUL+tLCx9AY/nc+bKDammi64v1dpws10+ZdA
	Uw42lD1HVT5vCav40QItlXgHUu
X-Google-Smtp-Source: AGHT+IGeStP1hP+ByrGhh4NaoQi2DfGqbNzq6rYmlsJlF3jHtyusjcsTARQEinwwi5G/x4LyVAMJL2jnkTH6KYhf+4E=
X-Received: by 2002:a2e:b8d2:0:b0:308:eb58:6580 with SMTP id
 38308e7fff4ca-30bf46387a6mr1750991fa.33.1741293176409; Thu, 06 Mar 2025
 12:32:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1b2a8e408573624a7b5e5e792c7e89c8315811e3.1741190102.git.pav@iki.fi>
 <7cc0c544b498337e6591610be16e9361687e0196.1741190102.git.pav@iki.fi>
 <CABBYNZ+rW_Wh+dVL9fF8uvNiQdt5351PoMR3Mb9-G8OaVWzwxQ@mail.gmail.com> <6a0b6a9b460780f86b7ac70f173e86398dcf14f7.camel@iki.fi>
In-Reply-To: <6a0b6a9b460780f86b7ac70f173e86398dcf14f7.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 6 Mar 2025 15:32:43 -0500
X-Gm-Features: AQ5f1JoOT06Rb-0ZzXBFxoGLOX4HBUQrVLXaRXQoppeEmi-G8Wq4NRx2Km2yA7c
Message-ID: <CABBYNZ+r0n-UhhVBmRr+0nLnzKYwY5D5rj4TMkf=1KwS7XdQrA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] sco-tester: check sent SCO data is received at bthost
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Mar 6, 2025 at 2:37=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ke, 2025-03-05 kello 13:58 -0500, Luiz Augusto von Dentz kirjoitti:
> > On Wed, Mar 5, 2025 at 10:58=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > When sending data, also check that the data is received by bthost.
> > > ---
> > >  tools/sco-tester.c | 47 ++++++++++++++++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 45 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/sco-tester.c b/tools/sco-tester.c
> > > index 7f37ca5cf..9886481ff 100644
> > > --- a/tools/sco-tester.c
> > > +++ b/tools/sco-tester.c
> > > @@ -318,10 +318,51 @@ static void client_connectable_complete(uint16_=
t opcode, uint8_t status,
> > >                 tester_setup_complete();
> > >  }
> > >
> > > +static void bthost_recv_data(const void *buf, uint16_t len, uint8_t =
status,
> > > +                                                               void =
*user_data)
> > > +{
> > > +       struct test_data *data =3D user_data;
> > > +       const struct sco_client_data *scodata =3D data->test_data;
> >
> > I had to add the following change in order to pass with these changes:
> >
> > +       /* Ignore empty packet as that is used to confirm NOCP is being
> > +        * generated.
> > +        */
> > +       if (!len)
> > +               return;
> > +
> >
> > Now I wonder if this may be a problem since it does show up as a data
> > packet even though it is empty, I guess for the purpose of HFP
> > streaming it shouldn't cause problems but if someone attempts to do
> > packet based checks like this it may stop working.
>
> It's probably a change in behavior if the controller interprets the
> zero-length packet as an instruction to send zero-filled SCO packet
> (with valid CRC etc) over the air. I'm not sure what the controllers do
> here.
>
> The timer causes a small hiccup at startup, but that is only once per
> controller index added. Since then the controller is not spec-
> compliant, maybe it is OK and there could be a quirk...

Yeah, that said we could perhaps add a quirk to mark Sync Flow Control
as supported, rather than adding one for saying it is broken, that way
we can enable it only in the controllers that are known to work
otherwise there is always a chance that controllers don't behave as
expected.

> >
> > > +       --data->step;
> > > +
> > > +       tester_print("Client received %u bytes of data", len);
> > > +
> > > +       if (scodata->send_data && (scodata->data_len !=3D len ||
> > > +                       memcmp(scodata->send_data, buf, len)))
> > > +               tester_test_failed();
> > > +       else if (!data->step)
> > > +               tester_test_passed();
> > > +}
> > > +
> > > +static void bthost_sco_disconnected(void *user_data)
> > > +{
> > > +       struct test_data *data =3D user_data;
> > > +
> > > +       tester_print("SCO handle 0x%04x disconnected", data->handle);
> > > +
> > > +       data->handle =3D 0x0000;
> > > +}
> > > +
> > > +static void sco_new_conn(uint16_t handle, void *user_data)
> > > +{
> > > +       struct test_data *data =3D user_data;
> > > +       struct bthost *host;
> > > +
> > > +       tester_print("New client connection with handle 0x%04x", hand=
le);
> > > +
> > > +       data->handle =3D handle;
> > > +
> > > +       host =3D hciemu_client_get_host(data->hciemu);
> > > +       bthost_add_sco_hook(host, data->handle, bthost_recv_data, dat=
a,
> > > +                               bthost_sco_disconnected);
> > > +}
> > > +
> > >  static void setup_powered_callback(uint8_t status, uint16_t length,
> > >                                         const void *param, void *user=
_data)
> > >  {
> > >         struct test_data *data =3D tester_get_data();
> > > +       const struct sco_client_data *scodata =3D data->test_data;
> > >         struct bthost *bthost;
> > >
> > >         if (status !=3D MGMT_STATUS_SUCCESS) {
> > > @@ -334,6 +375,9 @@ static void setup_powered_callback(uint8_t status=
, uint16_t length,
> > >         bthost =3D hciemu_client_get_host(data->hciemu);
> > >         bthost_set_cmd_complete_cb(bthost, client_connectable_complet=
e, data);
> > >         bthost_write_scan_enable(bthost, 0x03);
> > > +
> > > +       if (scodata && scodata->send_data)
> > > +               bthost_set_sco_cb(bthost, sco_new_conn, data);
> > >  }
> > >
> > >  static void setup_powered(const void *test_data)
> > > @@ -740,8 +784,6 @@ static gboolean sco_connect_cb(GIOChannel *io, GI=
OCondition cond,
> > >                 ssize_t ret =3D 0;
> > >                 unsigned int count;
> > >
> > > -               data->step =3D 0;
> > > -
> > >                 sco_tx_timestamping(data, io);
> > >
> > >                 tester_print("Writing %u*%u bytes of data",
> > > @@ -751,6 +793,7 @@ static gboolean sco_connect_cb(GIOChannel *io, GI=
OCondition cond,
> > >                         ret =3D write(sk, scodata->send_data, scodata=
->data_len);
> > >                         if (scodata->data_len !=3D ret)
> > >                                 break;
> > > +                       data->step++;
> > >                 }
> > >                 if (scodata->data_len !=3D ret) {
> > >                         tester_warn("Failed to write %u bytes: %zu %s=
 (%d)",
> > > --
> > > 2.48.1
> > >
> > >
> >
> >
>


--=20
Luiz Augusto von Dentz
