Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2DD1E520C
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742239388; cv=pass; b=DEA006KPzkdBzFNkzrZo3e/xy5rob8aUAmqxRbk55YSeh3Oepnm9CsW0CNCDLdXvxSUf28DaL+S4E8s3PozRKhh5CTeTK/3ofv7SADHwQktdUrBYoZ/xgyX0t9Si32GDObS/lV9eZz9hvYjvKolfBqXmJc4PD5h0+sC0K71H0cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742239388; c=relaxed/simple;
	bh=V+LDc91V0xLwjdX3kpqeSAH4K75syne0Ks5cdEEz9IY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ib12ANk9+SrPcIZlSc6XEQpccQQDyWpxhgoEhAtIS3hAg6f7IZreLX54sccIR+lo1qnv0Ph7TSOjJTiRB89XuNUbXmKr+nzHfz0uwphyRClFGoB7CnbWDh4B0ts6jrd7/uZ44bmTFZOaCeqoZFQLKgsN77bM3HQzJEaPJvaV0WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=aU5S/XDZ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="aU5S/XDZ"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZGlHW0fq2z49Q4l;
	Mon, 17 Mar 2025 21:23:02 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742239383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TNTaEt9+jNnNy+dYj9WVjMBqN8kZIl5YpFmivApseKg=;
	b=aU5S/XDZzyoUTBJIW7owSBKK6DYIGlv+wM0PZ5/9lH8ZPYNpq1QYdT1zpoxKl3P4Rxy873
	2uVtZpqbrUrWa1Gu5+oluqbdXOB/Ex2LaUQMv7eArJWlKssEI6fHLIxzVKKtbfPFPNLgyk
	/SHi2whw2BKWAqhqMzrJVfHnWq4hFHvFnWtHY1mc/79p5pYsoJIxsqF6imCEbI2WzY29ov
	boPwDtQuPIfZxOQrXEuqX+hAHE+Krnop+U5oirZ9hEPoH2LKx8wkwll9D1CUSxqma2jni0
	+cbTpq9Ut0dRFhA7xjcVZ2YPoIdSLBjxACM+Gs3hHHjJCpdt/Ws52texBRydgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1742239383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TNTaEt9+jNnNy+dYj9WVjMBqN8kZIl5YpFmivApseKg=;
	b=HVr2NrCjwrZuxMBO9hpu1BVHBVOcHu0aF9XHzaL90rusQTMgG7XsbxZAlYHKUvOOnavMTX
	2o/uPDuSUeIghoDi4R7I4Q1VwLyr/6PbSSJwCVkRuxUwMv+mRbN5eWBwUpkqalol8ul9hR
	xmJyAcLpMNLq+DBwZ+om3X+du/PCm1dqSZuM6A2qvGoLjMjNHS50m0CdQYkx0O427Z+w6b
	EMCXLW5RhvQtiD4YxKs4dIQMpe86j3xD57UqcHm1ULw2qyExCP5rybBZDScZiWQJubjFf3
	/JfOeR8fjrOd+7VQZErOFaB7/knA4iLyMagAsrsglkEEs/EQ5l7y8mvb1Vrj8g==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1742239383; a=rsa-sha256;
	cv=none;
	b=nBNvnO/tsdNcOl1M0/Lcn+OegiFwHr38PGppsp3lf48fnOvJUqkUBRAacjyMbldrPtj+CK
	MlmEOUdjsGiR+XYI+CT/Mo7vPqLPeal/LaPOp9tmZuqbtLF/tDBOeqpMR06jWScCXxZUaj
	OH+n3iwUZ6S6ATfTJ7IDqVZYxkEm20Af0p7WJRmXhl5H4qZFg+Xp3wsX0ndp9aV/W0A3ur
	MqKvaAFYNtvmKCcg64tAafKYnDFmlanvv9LyGhoUnlIUZGThLVcD7TjhYkUIU0nuBEtA2f
	YmsbtCE1jjmVH5YcWQT4C0U/SFIg6/baeqMTAnVFVNcdxQc0AD/H38/GNcf0gg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <a1140e27ec24065cd25b81b157a60f8055b68c89.camel@iki.fi>
Subject: Re: [RFC PATCH BlueZ 1/9] org.bluez.MediaEndpoint: removing BAP
 streams with ClearConfiguration
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 17 Mar 2025 21:23:01 +0200
In-Reply-To: <CABBYNZKVj5b7CRAU0qi1CfxGd2FabtCaQsxTUoc1yq0AabztXw@mail.gmail.com>
References: <cover.1740844616.git.pav@iki.fi>
	 <a0a8eb4d51a35f3181617303aa8f6ad8227b2bca.1740844616.git.pav@iki.fi>
	 <CABBYNZKVj5b7CRAU0qi1CfxGd2FabtCaQsxTUoc1yq0AabztXw@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
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

ma, 2025-03-17 kello 14:10 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Sat, Mar 1, 2025 at 10:58=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Allow user to remove specific streams by calling
> > ClearConfiguration(transport_path) on the endpoint.  If the path is the
> > endpoint path instead, clear all streams associated with the endpoint.
> > ---
> >  doc/org.bluez.MediaEndpoint.rst | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpo=
int.rst
> > index f2b830ab0..b81106f0b 100644
> > --- a/doc/org.bluez.MediaEndpoint.rst
> > +++ b/doc/org.bluez.MediaEndpoint.rst
> > @@ -109,6 +109,12 @@ void ClearConfiguration(object transport)
> >=20
> >         Clear transport configuration.
> >=20
> > +       **Server role:** [ISO only]
> > +
> > +       Close the stream associated with the given transport. If the
> > +       path given is the path of this endpoint, all its streams are
> > +       closed.
>=20
> This seems sort of trivial, that said we can't really guarantee the
> MediaTransports will be closed even if we send an ASCS_Release
> operation the server may still cache the codec configuration.

It does not work if we consider every ASE in Config Codec state is
associated with a transport. BAP Client=C2=A0should be able to fully contro=
l
what it transitions to QoS state, so transport =3D QoS state makes more
sense. (See also BAP =C2=A72.2.1.1 / 2.2.1.2)

Client must be able to transition from state where it e.g. uses sources
& sinks to a state where it only uses sink.

Some devices have restrictions that they cannot use sources with eg.
48kHz rate sinks together. The same devices may also always transition
all ASEs to Config Codec. As Client, we must be able to ignore some of
the configured ASEs, and transition to QoS only the ones we want to
use.

--=20
Pauli Virtanen
