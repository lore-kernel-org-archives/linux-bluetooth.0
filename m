Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1913AC2B
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="gs6r7lDX"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398226F8B
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 11:17:06 -0800 (PST)
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SRpV65X6gz49PwQ;
	Fri, 10 Nov 2023 21:16:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1699643823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ad89is8S4Xs44Impy7sOpGotzNRO+80w7ZhwphXWVjY=;
	b=gs6r7lDX6RBFgQiUaBW/U8X2MhUs/sxgPwbyyoDa5YcjTm9l3A7KX9UqOhQM/Bu36sipxf
	o/GQJHmm9XEVig9aQZPeqjldyb7AeK3TOBpW0kulQJ750wsomhOWrQgIYmSBPWMUpCwuwB
	hTEDuLT8QzHytb5y+AqXgJdU8WczjWpdj1fHDKI95j4xr2n/CXv8TQDsc4a8j6AMnvp0Vk
	Hw56YPeoNZiu8EuQMK7ViIZD9H5wI3eUG/CAZuVTNUqDqOofmtherXWQzA5LxpoE8OR45M
	FZN+A5YguLUzzSNKfcByoiwvU9ZADbGHk92qJwVlwLn0GyhQm/3vqiad5gkhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1699643823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ad89is8S4Xs44Impy7sOpGotzNRO+80w7ZhwphXWVjY=;
	b=b5qoh6PDE21S1TxPV2Fl5ZLjltiJknEnL+vEEVvqwIe2Xhe290lmkycOFxRgyajIJS7yR5
	V1Jiq/cp4sY49tiVwA2FxdTlbQtvyhExBBOfBnIjcCAdcg+WTeQfNlYBs+q/I7zZhTl1JC
	nlRG4YbC2P1unF190DVHS4bP1QNgpPbJouFeVOSkMYwB2sabsA4Z8BTeDAqa6Uz6M3UJta
	L4yVcj4GBUjHbwZfhQciBPEJNQ3IqJBDC52d/RaXqD73+V82m+Rhhyfa2KVCLTamXuS5sQ
	KgjlMUXr9JYf4y9z3MNIJu4LMLZeI9Yyed9F+Vvth1xDf4hRw0VEvbCUKg0g0g==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1699643823; a=rsa-sha256;
	cv=none;
	b=DRJRM182SJhZExL26UqIYQMDPk+N9wVt8Fgfgaqvjxb3y6BcSv7RLjqqaoy/XASeTBEQGb
	cgpx18ND24t7LUj9+xZKH3u0w3Z5seoU8k63LsmP2+skmgXmSa0sNIaPOmX+Qamehoux3N
	bNuezyWY5luMw0ebq7Y/Dw960Wi6nmCFe7Iu8G3Qs3vj3cIKO0vrbNvyJQuFpTOj0t1H+f
	gNeCigvPzjk2GcXN1Xf87nhUyAt7IU8J5CczOy7/BCv27ARiEcqxFe3/BCvo+KZkK0PD5C
	K/S96vCD3lS/uENkmxo5z62wd8SLbR/LKzfJ7RPGYn52VnPvZ9hubB9AEA0FUw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <846df13370485318d1814b13656e483e09a6de35.camel@iki.fi>
Subject: Re: a2dp delay reporting
From: Pauli Virtanen <pav@iki.fi>
To: Ethan White <ethan@braneaudio.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 10 Nov 2023 21:16:59 +0200
In-Reply-To: <94061775-df7e-4aa5-b760-94a28a13667f@braneaudio.com>
References: <b7c90f4c-8868-42ea-86c0-3f9f2b0f27e0@braneaudio.com>
	 <94061775-df7e-4aa5-b760-94a28a13667f@braneaudio.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2023-11-09 kello 16:36 -0600, Ethan White kirjoitti:
> On 10/17/23 13:10, Ethan White wrote:
> > Hi,
> >=20
> > How do I inform Bluez of my a2dp transport delay?=C2=A0 The media-api=
=20
> > document shows a Delay property for the MediaTransport1 interface but=
=20
> > attempts at writing this property yield the following error:
> >=20
> > org.freedesktop.DBus.Error.PropertyReadOnly: Property 'Delay' is not=
=20
> > writable
> >=20
> >=20
> > Reviewing profiles/audio/transport.c a2dp_properties (Bluez 5.70) I fin=
d=20
> > that the delay property does not have a set function:
> >=20
> > line 846: { "Delay", "q", get_delay_reporting, NULL,=20
> > delay_reporting_exists },
> >=20
> >=20
> > What am I missing here?=C2=A0 How an I supposed to inform the a2dp sour=
ce of=20
> > my playback delay?=C2=A0 Thanks for any help.
> >=20
> > Regards,
> > Ethan
>=20
> I'm currently using org.bluez.Media1 RegisterEndpoint to expose my a2dp=
=20
> sink to a2dp sources.  I use org.bluez.MediaTransport1 Acquire to get=20
> the transport.  I can write the 'Volume' property of=20
> org.bluez.MediaTransport1 to change the audio source volume.  However,=
=20
> writing to the 'Delay' property of the org.bluez.MediaTransport1=20
> interface yields only errors as this property appears to be read-only=20
> despite bluez/docs/media-api.rst showing this property to be read/write.

It looks to me updating the delay value for local A2DP sink endpoints
is not implemented.

The underlying parts in the AVDTP code for sending delay reports on the
other hand seem to be in place, so it might not be too hard to make it
work in the DBus interface. Maybe the DBus property set callback could
just call `avdtp_delay_report` and it'd work.

> When using busctl from the host running my a2dp sink to inspect the=20
> transport I get a dash '-' in place of a numerical value:
> host:~$ busctl introspect  org.bluez=20
> /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/fd0
> NAME                                TYPE      SIGNATURE RESULT/VALUE=20
>                         FLAGS
> org.bluez.MediaTransport1           interface -         -=20
>                         -
> .Acquire                            method    -         hqq=20
>                         -
> .Release                            method    -         -=20
>                         -
> .TryAcquire                         method    -         hqq=20
>                         -
> .Codec                              property  y         2=20
>                         emits-change
> .Configuration                      property  ay        6 128 1 4 131=20
> 232 0                     emits-change
> .Delay                              property  q         -=20
>                         emits-change
> .Device                             property  o=20
> "/org/bluez/hci0/dev_E8_78_65_F2_14_24" emits-change
> .State                              property  s         "active"=20
>                         emits-change
> .UUID                               property  s=20
> "0000110b-0000-1000-8000-00805f9b34fb"  emits-change
> .Volume                             property  q         64=20
>                         emits-change writable
> org.freedesktop.DBus.Introspectable interface -         -=20
>                         -
> .Introspect                         method    -         s=20
>                         -
> org.freedesktop.DBus.Properties     interface -         -=20
>                         -
> .Get                                method    ss        v=20
>                         -
> .GetAll                             method    s         a{sv}=20
>                         -
> .Set                                method    ssv       -=20
>                         -
> .PropertiesChanged                  signal    sa{sv}as  -=20
>                         -
>=20
> Does Bluez allow an a2dp sink to report its playback delay to the a2dp=
=20
> source via the org.bluez.MediaTransport1 Delay property?  Is there some=
=20
> other way to communicate this delay back to the audio source for proper=
=20
> lip-sync with video?
>=20
> Regards,
> Ethan
>=20

--=20
Pauli Virtanen
