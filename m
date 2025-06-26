Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EB71C4A24
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jun 2025 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750953674; cv=pass; b=rwnW/T1rociIeFlBKSCIUFmhPtSAGNKUgL83d/2G3nSQde2mSMqPw80ihcPlk9GFVbLcmf/2zKQI0l867BQMhtE0D2R+eDw2htVwxPKOJHtWl/TPSHMZyjI7yv6eImrB7r8uvwArxmrnByc3DzEM+dtvImzL0kXsAsNFkQ+jTqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750953674; c=relaxed/simple;
	bh=kI/jCcoKnTed8ZPZuNrMoBHZQ0WoBfGDaUKPXVMFt/A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kbAL44lvIwqyu1fjxWHwpnuzqbLT3WiGkInv8kFP+vDLlu3DHQmB+t4+fwkO9RMbXETYx+94sZEGag5ECg/Kbyq2kMXaPjD0ulfApbvd3Na2Q0dUpsWk9bVy8iHYJ7N+2GcdvuQmFvab2cYesKNTOFNZkhB2FR7paYRCHnxL428=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=eMlMpg6R; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="eMlMpg6R"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bSk1g30fVz49Q6r;
	Thu, 26 Jun 2025 19:00:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1750953656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3RSsKpzAPGJ6NRTkop13UkahmtuEKmdUtG8418gwW1k=;
	b=eMlMpg6RuZH/fCpYXmGd6fmlW1lY9QaS5Iry/yi5bjaLnMFDQjnqgiF1EWA5MnBeaUo/vn
	fEwGIY/gBaTZrn5frHZlktdUB1OyF+WFzF07MgltrvLoZA6XdwGwPXJBEwCy30zpJj24Ee
	EJN89lnddb5FjYuwrNLAv5ISTb4PJ1xq/RbJRRA88HiHoV4X/2q06LPP3gHFTwd5sQ6LPE
	RkR6wU1g6HWNjo0Ts94T07pMkz/Rdo5zgjR40hyq5jR5WtLZsooM/x/Ix0X9oJS/4FLm2V
	kbVJiJUAEV/FfD23YsxDFoSTOQH6v5caGc+XX/xUWSbgrhyJl93vZGqByWwvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1750953656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3RSsKpzAPGJ6NRTkop13UkahmtuEKmdUtG8418gwW1k=;
	b=jbFNguMGDHr2pR+NiT16/jk2FumclyeYpBm3O7qdQmvax2zl4CUdun4Qi91hsc1PTQtx9b
	iMk2CW43G/2QikjMZcwUEaaKGtWAE22UpGPlXkP23/cOv36FIOgmWkcu/3gMs/VbNODjUU
	6TM+BzPGLueoOgQ3IIvMJoOUo5/U74YuQKQhU/13MydtPcjl+HbxV/T+xBPGecSFV279y5
	GwX17se0O3RHrGL9Jz4wPfM/zWXv4V60uOeI+e2YFiLnVVIMPtnwlAkZisVWe5j0PgQ8dm
	+itT6d+/AekuKBld6KIcDE7X8fg7c81BF3wiujgk7TdF0v1bH92wmCRfn83+0Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1750953656; a=rsa-sha256;
	cv=none;
	b=sYDi312RVcul+C9JNkMuAupY7GE7ibWSs4RJZhWHZYfeoxbBwqrQOPL8S/Z6pPSfzxG26/
	lrQUSHopKNduR4ArLDRe/XXQttqNUS2YfsWGOTq1lKtmB2sO1h1B1dototV8vvH0vRgGyR
	FsAAwAcYuQLeK2z4pZgfXXilsJp0NrZNvM8AN7Ixvfd/cN0xZqDXVXKn7w2sktOo6/KbJI
	S/xcpgINZIw87Hg+yb894H844EpKW+283ucf9N9RmztQg3oVTOSLDO9Ph3eyjLlffRfW84
	lPQ+C7J6T8d1Z5EbDzzCxGVi1uVNt/ZIMRJfpmibXvDMy5eV/zta2ThuHuYaSA==
Message-ID: <9e997563aa6bb21c87fed41b89e9691465207d15.camel@iki.fi>
Subject: Re: [PATCH BlueZ bluez] shared/bap: Set stream to idle when I/O is
 disconnected
From: Pauli Virtanen <pav@iki.fi>
To: Yang Li <yang.li@amlogic.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Date: Thu, 26 Jun 2025 19:00:52 +0300
In-Reply-To: <28726e2c-aa65-4e64-b2a4-98d59ed5270f@amlogic.com>
References: <20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com>
	 <CABBYNZK=5-N8wcHhSp5ii8FmM5CzPFqKheKHOcCs8brNhVp_ww@mail.gmail.com>
	 <1f2fe697-6437-4000-8aa3-d09bb7090a46@amlogic.com>
	 <3ac16d0a7c5569bce0b28f18bc2245bef8ab64c2.camel@iki.fi>
	 <28726e2c-aa65-4e64-b2a4-98d59ed5270f@amlogic.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2025-06-26 kello 12:19 +0800, Yang Li kirjoitti:
> Hi Pauli,
> > [ EXTERNAL EMAIL ]
> >=20
> > Hi,
> >=20
> > ke, 2025-06-25 kello 13:24 +0800, Yang Li kirjoitti:
> >=20
> > [clip]
> > > When music is paused on the pixel 9 phone, the CIS link gets
> > > disconnected. As the transport state changes from ACTIVE to IDLE, the
> > > stream state transitions from config to qos.
> > >=20
> > >     > HCI Event: Disconnect Complete (0x05) plen 4           #1425 [h=
ci0]
> > > 49.572089
> > >             Status: Success (0x00)
> > >             Handle: 512 Address: 6A:AB:51:47:3B:80 (Resolvable)
> > >               Identity type: Random (0x01)
> > >               Identity: E8:D5:2B:59:57:A6 (Static)
> > >             Reason: Remote User Terminated Connection (0x13)
> > >     bluetoothd[2313]: src/shared/bap.c:stream_io_disconnected() strea=
m
> > > 0x1f9fc20 io disconnected
> > >     bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream
> > > 0x1f9fc20 dir 0x01: releasing -> config
> > >     bluetoothd[2313]: src/shared/bap.c:stream_notify() stream 0x1f9fc=
20
> > > state 1
> > >     bluetoothd[2313]: profiles/audio/transport.c:bap_state_changed()
> > > stream 0x1f9fc20: releasing(6) -> config(1)
> > >     bluetoothd[2313]:
> > > profiles/audio/transport.c:transport_update_playing()
> > > /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 State=3DTRANSPORT_STATE_ACT=
IVE
> > > Playing=3D0
> > >     bluetoothd[2313]:
> > > profiles/audio/transport.c:media_transport_remove_owner() Transport
> > > /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 Owner :1.1
> > >     bluetoothd[2313]: profiles/audio/transport.c:media_owner_free() O=
wner
> > > :1.1
> > >     bluetoothd[2313]:
> > > profiles/audio/transport.c:media_transport_suspend() Transport
> > > /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 Owner
> > >     bluetoothd[2313]: profiles/audio/transport.c:transport_set_state(=
)
> > > State changed /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1:
> > > TRANSPORT_STATE_ACTIVE -> TRANSPORT_STATE_IDLE
> > >     bluetoothd[2313]: src/shared/bap.c:stream_disable() stream 0x1f9f=
c20
> > AFAICS the bug appears to be:
> >=20
> > - bap.c:stream_disable() should do nothing if stream is
> >    not ENABLING or STREAMING
> >=20
> > since it's called from bt_bap_stream_disable() which is called on
> > transport suspend which should be noop for BAP server if stream is
> > already gone.
>=20
> Following your suggestion, I updated the |stream_disable()| function,=20
> which successfully resolved the issue.
>=20
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -2059,7 +2059,9 @@ static uint8_t stream_disable(struct bt_bap_stream=
=20
> *stream, struct iovec *rsp)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Sink can autonomously tran=
sit to QOS while source needs to go to
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Disabling until BT_AS=
CS_STOP is received.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (stream->ep->dir =3D=3D BT_BAP_S=
INK)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (stream->ep->dir =3D=3D BT_BAP_S=
INK &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (stream->ep->stat=
e =3D=3D BT_ASCS_ASE_STATE_ENABLING ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stream->ep-=
>state =3D=3D BT_ASCS_ASE_STATE_STREAMING))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);

Same applies to BT_BAP_SOURCE too. Only the check on top of function
needs change.

>=20
> > >     bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream
> > > 0x1f9fc20 dir 0x01: config -> qos
> > >     ATTbluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 51 #1426
> > > [hci0] 49.585656
> > >         ATT: Handle Value Notification (0x1b) len 46
> > >           Handle: 0x007b Type: Sink ASE (0x2bc4)
> > >             Data[44]:
> > > 01010002050a00204e00409c00204e00409c000600000000130201030202010503030=
0000003042800020501
> > >               ASE ID: 1
> > >               State: Codec Configured (0x01)
> > >               Framing: Unframed PDUs supported (0x00)
> > >               PHY: 0x02
> > >               LE 2M PHY preffered (0x02)
> > >               RTN: 5
> > >               Max Transport Latency: 10
> > >               Presentation Delay Min: 20000 us
> > >     ...
> > >     bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 24 #1427 [hc=
i0]
> > > 49.585725
> > >         ATT: Handle Value Notification (0x1b) len 19
> > >           Handle: 0x007b Type: Sink ASE (0x2bc4)
> > >             Data[17]: 0102010010270000025000050a00204e00
> > >               ASE ID: 1
> > >               State: QoS Configured (0x02)
> > >               CIG ID: 0x01
> > >               CIS ID: 0x00
> > >     ...
> > >=20
> > > when playback resumes on the phone, it attempts to set the ASE state =
to
> > > Codec. However, since the stream has already transitioned from config=
 to
> > > qos, the phone ends up disconnecting the connection.
> > >=20
> > >     bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 12  #1433 [h=
ci0]
> > > 60.216004
> > >         ATT: Handle Value Notification (0x1b) len 7
> > >           Handle: 0x0087 Type: ASE Control Point (0x2bc6)
> > >             Data[5]: 0101010000
> > >               Opcode: Codec Configuration (0x01)
> > >               Number of ASE(s): 1
> > >               ASE: #0
> > >               ASE ID: 0x01
> > >               ASE Response Code: Success (0x00)
> > >               ASE Response Reason: None (0x00)
> > >     bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 51 #1434 [hc=
i0]
> > > 60.226086
> > >         ATT: Handle Value Notification (0x1b) len 46
> > >           Handle: 0x007b Type: Sink ASE (0x2bc4)
> > >             Data[44]:
> > > 01010002050a00204e00409c00204e00409c000600000000130201030202010503030=
0000003042800020501
> > >               ASE ID: 1
> > >               State: Codec Configured (0x01)
> > >               Framing: Unframed PDUs supported (0x00)
> > >               PHY: 0x02
> > >               LE 2M PHY preffered (0x02)
> > >               RTN: 5
> > >               Max Transport Latency: 10
> > >               Presentation Delay Min: 20000 us
> > >               Presentation Delay Max: 40000 us
> > >               Preferred Presentation Delay Min: 20000 us
> > >               Preferred Presentation Delay Max: 40000 us
> > >               Codec: LC3 (0x06)
> > >               Codec Specific Configuration: #0: len 0x02 type 0x01
> > >                 Sampling Frequency: 16 Khz (0x03)
> > >               Codec Specific Configuration: #1: len 0x02 type 0x02
> > >                 Frame Duration: 10 ms (0x01)
> > >               Codec Specific Configuration: #2: len 0x05 type 0x03
> > >              Location: 0x00000003
> > >                 Front Left (0x00000001)
> > >                 Front Right (0x00000002)
> > >               Codec Specific Configuration: #3: len 0x03 type 0x04
> > >                 Frame Length: 40 (0x0028)
> > >               Codec Specific Configuration: #4: len 0x02 type 0x05
> > >                 Frame Blocks per SDU: 1 (0x01)
> > >=20
> > >     ...
> > >=20
> > >     > HCI Event: Disconnect Complete (0x05) plen 4           #1445 [h=
ci0]
> > > 63.651497
> > >           Status: Success (0x00)
> > >           Handle: 16 Address: 6A:AB:51:47:3B:80 (Resolvable)
> > >             Identity type: Random (0x01)
> > >             Identity: E8:D5:2B:59:57:A6 (Static)
> > >           Reason: Remote User Terminated Connection (0x13)
> > >=20
> > > Introducing a check in the stream logic to distinguish between Unicas=
t
> > > and Broadcast would indeed make it easier to handle different stream
> > > types cleanly.
> > > However, if we temporarily ignore Unicast caching, a simpler and clea=
ner
> > > approach would be to transition the stream directly to IDLE when I/O =
is
> > > disconnected.
> > This disconnect callback is used for all the roles: unicast client,
> > unicast server, broadcast. All of those require different handling, so
> > it's probably most clear to split it.
> >=20
> >=20
> > For unicast server:
> >=20
> > The behavior has to follow BAP v1.0.2 Sec. 5.6.8 and ASCS Table 3.2.
> > Transition to IDLE is only allowed from RELEASING --- but one can as
> > well go to CONFIG like it is in current master.
> >=20
> > CIS loss from STREAMING should go to QOS, and I think it currently does
> > so, via bap_stream_set_io.
> >=20
> >  From a brief look, the current version in master is maybe OK, although
> > one could test the above case again with stream_disable() fix.
> >=20
> >=20
> > For unicast client:
> >=20
> > The current version in master is probably OK, although one could double
> > check it again.
>=20
>=20
> I've added type checking and made the following modifications. Please=20
> check if this meets the requirements. I believe that unicast source and=
=20
> broadcast source are active behaviors, so there's no need to change the=
=20
> stream state through I/O status.

Please don't change the unicast behavior, unless you are fixing a
deviation from the specification, or can explicitly show there is no
change in behavior.

I understand this patch is about fixing the behavior on BIS loss.

> @@ -6584,10 +6584,15 @@ static bool stream_io_disconnected(struct io=20
> *io, void *user_data)
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBG(stream->bap, "stream %p i=
o disconnected", stream);
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (stream->ep->state =3D=3D BT_ASC=
S_ASE_STATE_RELEASING)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (stream->lpac->type =3D=3D BT_BA=
P_SINK &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt_bap_stre=
am_get_state(stream) =3D=3D=20
> BT_ASCS_ASE_STATE_RELEASING) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 bt_bap_stream_set_io(stream, -1);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (stream->lpac->type =3D=3D BT_BA=
P_BCAST_SINK)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bt_bap_stream_set_io(stream, -1);

This doesn't look right vs. unicast server. What performs the
transitions to IDLE/CONFIG/QOS for unicast Source? See BAP Sec 5.6.7
and 5.6.8.

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>  =C2=A0}
>=20
> > > Once the Unicast caching issue is properly resolved, we can revisit a=
nd
> > > introduce stream-type-based handling accordingly.
> > >=20
> > > > > +       stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
> > > > >=20
> > > > > -       bt_bap_stream_set_io(stream, -1);
> > > > >           return false;
> > > > >    }
> > > > >=20
> > > > >=20
> > > > > ---
> > > > > base-commit: ae1b7f6ba805f82742bbc32ff275e268248ef9f8
> > > > > change-id: 20250624-bap_for_big_sync_lost-63476c679dbb
> > > > >=20
> > > > > Best regards,
> > > > > --
> > > > > Yang Li <yang.li@amlogic.com>
> > > > >=20
> > > > >=20
> > > > >=20
> > > > --
> > > > Luiz Augusto von Dentz
> > --
> > Pauli Virtanen
