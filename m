Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1B914F9FB
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745250185; cv=pass; b=GqZJlNlV30SDz6Q7rurbUeN2xk3tCoPf4Hhlq82aIQ4Vn+iSEpOCjpOKL/Lqi4bJcUuXSlRo8IZrdzm6+TYIaYHdsTisAzIY/ylVn131ZCg3PbeLgpaHLHVUvEJlorUstseZV9SddBbHiYCoKc84jA2lDxzrZwn6Kib9eexk8+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745250185; c=relaxed/simple;
	bh=5P4DeIzDHNTyA24FsNHkyBbOfNIhCgjamo3cITZICOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j79NgB9m8UPnaW7tfIXTj3tv6lc7s0Kxjmx1Yy2NXnBOEkuudNf2OGiDJr6Iwej6SrP6TCUskUz8zaLUAhsmBT2DUB1vnPou84QtvsctTNWRY95vZ0anDay2kI2/zTmHxbPDlIDd8l0Wz8nBmYPgRHRihQXRyqeT6bOPJzeUr1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=B59zJYqn; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="B59zJYqn"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Zh8lN3Scvz49Q5l;
	Mon, 21 Apr 2025 18:42:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745250176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fOOm3rVHsguds6IxOMwaISAiWEpD9gJQWXV8T0kj9gI=;
	b=B59zJYqnHBnPFbwWDAMWGdy154TJmEw1fB3zS2tIm+Z+gFrKz8uMksZ1RrHl9k+ZjeUHa8
	K2tG5q1WQxZDHYijWrwfsQjilkZ6hssBbDIE6O4XCNSjKUKDXvlrOIGxyqaaVw30alYmqk
	/Tg9jJvk+aptZKC3RPDhEwxrvFCWge062cgTyVvM+S6C7Ff9P2+QlMJ6cNiTZ+LqoCSjna
	rTLYqGMeCp3cFNkqeJ0RF0YXEmL/jwTk6DsEedzldIbmqzSu5/OeuyFzAMyGduOGESMQiA
	4StvFkofyPn4UF2dsDHXWfkPJzWEUcM0tHd+g+cMgYndtgFpir/J7J57b++Crw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745250176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fOOm3rVHsguds6IxOMwaISAiWEpD9gJQWXV8T0kj9gI=;
	b=mDHpwojiSB4MwLjR0BdZattpyAoCmc+4zYMH6omTHtBsflIPoQSheLqrEdMC8oPzRGlufZ
	IaUyin1SWt5bqylj7d+gWdJ7/b5lRSzB6C2iEypqQQZU7btTYT+9PKLDM2sdlqvwpuo595
	yqs+0ynQrSM+wvEErZCUtso4Si/WjxOT4fjXjWsiEh/hqE2wf5IX/cFqgTTWmALr86Z3FR
	lZpnqZAmDeuvN+VnR3x9TQx4Wf8eQMYMXoV+0EXhUkhD0yc0OZeEJayz7yXp8hhT1cQ7Gr
	3prIX/pY+U7vy8oToQhkb8Qsf4B8V09c6Gl9ZCdPU9RYjY1WM2UG5CXvzEgKAg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745250176; a=rsa-sha256;
	cv=none;
	b=s6bS6gEZv7Wdv0LT4Fd2OHM6d6awjOOpkefMefpZZPR1o3rFOsHfoINpUoNnHeGbyIdzzH
	9xmVLTKo9FNfPli44DScs/91oKAGmJsxYuhPieU1DWpbUGRTSeXJXHEGzsJdBq6q4zh4Hf
	hzW+kFsQ9blVm95kWMUBpMh69aZ7aoZeSJgVktGtZcxMDJ4NiRQNdxSGL9Wq9IbnT8NHle
	AOT/QE57ISXqXfIysGITjT1xPoY5Pt4CYEwbDQuK2AhTdS4Lcgcjz6WJJzzgtEe2FuCKfb
	/yIZN0Ax7fYMdAOylhm4GStTmuPrBnUFq8xTtfic96aj8WXVRbvTnkJUGm5a0A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <b172e66316a34d9c86122233e0d2a5461f9e00f8.camel@iki.fi>
Subject: Re: [PATCH BlueZ 2/2] media: implement SupportedFeatures property
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 21 Apr 2025 18:42:53 +0300
In-Reply-To: <CABBYNZ+CVKheEVCPJnpdhTDr+ReOUTZwXyD0O8eAvZuM+GYGiA@mail.gmail.com>
References: 
	<fb302ed17cf2a4331d7ca57529cdbdde80376d82.1745233468.git.pav@iki.fi>
	 <ebc8762f1d7d65b9fb414d2b538985b23546ab57.1745233468.git.pav@iki.fi>
	 <CABBYNZ+CVKheEVCPJnpdhTDr+ReOUTZwXyD0O8eAvZuM+GYGiA@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2025-04-21 kello 10:37 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Mon, Apr 21, 2025 at 7:05=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Add org.bluez.Media.SupportedFeatures. The value tx-timestamping is
> > hardcoded as it is currently always enabled.
> > ---
> >  profiles/audio/media.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >=20
> > diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> > index 69c6dc671..df36bc2df 100644
> > --- a/profiles/audio/media.c
> > +++ b/profiles/audio/media.c
> > @@ -3340,8 +3340,28 @@ static gboolean supported_uuids(const GDBusPrope=
rtyTable *property,
> >         return TRUE;
> >  }
> >=20
> > +static gboolean supported_features(const GDBusPropertyTable *property,
> > +                                       DBusMessageIter *iter, void *da=
ta)
> > +{
> > +       static const char * const features[] =3D { "tx-timestamping" };
> > +       DBusMessageIter entry;
> > +       size_t i;
> > +
> > +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
> > +                               DBUS_TYPE_STRING_AS_STRING, &entry);
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(features); ++i)
> > +               dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING=
,
> > +                                                       &features[i]);
>=20
> That doesn't really handle if the kernel doesn't support it or setting
> SO_TIMESTAMPING fails in case the kernel is too old? We might need to
> have a MGMT flag indicating that kernel has support for it otherwise,
> that said perhaps it would actually be better to have a socket option
> since for the likes of SCO sockets we actually need hardware support
> as well.

I was thinking the application itself can do necessary kernel checks.

I see now application can now also find running BlueZ version from
adapter modalias, so this is then not so urgently needed.

netdev has some way to indicate supported timestamping flags,=C2=A0it may b=
e
it's not applicable to bluetooth, but probably would be good to check
first if that can be used before adding new MGMT flags.

>=20
> > +       dbus_message_iter_close_container(iter, &entry);
> > +
> > +       return TRUE;
> > +}
> > +
> >  static const GDBusPropertyTable media_properties[] =3D {
> >         { "SupportedUUIDs", "as", supported_uuids },
> > +       { "SupportedFeatures", "as", supported_features },
> >         { }
> >  };
> >=20
> > --
> > 2.49.0
> >=20
> >=20
>=20

--=20
Pauli Virtanen
