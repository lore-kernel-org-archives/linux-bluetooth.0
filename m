Return-Path: <SRS0=LC31=TQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C71EC04AAF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 May 2019 18:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3047A20818
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 May 2019 18:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF7zNGzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfEPSef (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 May 2019 14:34:35 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:35480 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfEPSef (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 May 2019 14:34:35 -0400
Received: by mail-wr1-f49.google.com with SMTP id m3so4323740wrv.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2019 11:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uVm+eVPKad6PfI2DB9/YcKOx1XWl2+qHQAkckv8UkUg=;
        b=JF7zNGzl34z90Hy3eSiX5E1B6ImecFFaYj71+Al9kYKqG6aHNMEWwwNphdCe+OpiYV
         35+NHkrkwtgZ+71dbYdxvEUlhQnPld9KwT2RwQ7xxNzYA010OqMgzSRBETdjcFNWtK5N
         ZvCOsL0UflUkJEu++lDmjbSotF4u3vhall7ETtV+31JzcrAOWJ+Mbxh8uGnhUFiIn3EK
         g4NhWeQFIWg5cWBZXxUyhVmkRAakBbi+uYaONsLRBj21f3Vazq9gIA17IjIWDzz/MnZ6
         3CgVSCG+vXAohBJr3cmq9YGTFltR3feoTnnIJzwmbbM0pfilcFeGlbCMqrBSD86UOD7H
         ZoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uVm+eVPKad6PfI2DB9/YcKOx1XWl2+qHQAkckv8UkUg=;
        b=rklgfy51X2UImaqAq1IZHWSDXC47K+pA4f5CVE6WyZlTkH/KKmCqLxLkSsIBflrWrw
         34nE7PQe3CP0gZzdAn7XBecsmbvWx1EIQ2JFO2AKtylslvgY3H8QgHU1ev8UADcDa5sq
         f8T1ZUDUZMsMtw0+2IxzWxVpjbUZWO1yNtb8KLhBGFGVZM9K+dEnayCf9akqa+D1ARSw
         SKk/ODJjAazcBBiv6PuqpbrnLT7sg+LuVa0f5h8MP3YEdujJCmaSoQlbGlq1KvV9T8Ml
         FwCu6TX23hNPaUwLAuKbh/CzZb0rQWRxiORp3pX1qX2uewG5fpvnboXkXe9qVZhjhzjO
         FypA==
X-Gm-Message-State: APjAAAXUdk/1amnkuC+E4K43J100Zovhm3LsDiknshlfgEAgoyVFxnNs
        Gy6P0vQ4KHEpd6b/AUFtQEnFLq+G
X-Google-Smtp-Source: APXvYqzwe319B21pJcrsxfvPHxHtmPHrm6uc+uErMeUeqZQmZqAJzmaRhOhJZQSfGFhuRCcY2hlMhQ==
X-Received: by 2002:adf:eb87:: with SMTP id t7mr30299228wrn.39.1558031672842;
        Thu, 16 May 2019 11:34:32 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id l12sm5657022wmj.0.2019.05.16.11.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 11:34:30 -0700 (PDT)
Date:   Thu, 16 May 2019 20:34:29 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20190516183429.ql3hxtnmiabcq7tj@pali>
References: <20190504171550.llqfv5674gxd3bnn@pali>
 <20190506151651.pu2us2fgsf7w2vos@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xazfzfcbvugyxe3e"
Content-Disposition: inline
In-Reply-To: <20190506151651.pu2us2fgsf7w2vos@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--xazfzfcbvugyxe3e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ping, can you comment anything related to hardcoded bandwidth?

I would really like to take next step how to expose API for changing
bandwidth as linux kernel currently does not allow to receive and
transmit voice encoded by AuriStream codec.

On Monday 06 May 2019 17:16:51 Pali Roh=C3=A1r wrote:
> Ccing more people...
>=20
> do you have idea why for custom SCO HFP codec is needed to change
> Transmit and Receive bandwidth in HCI Setup Synchronous Connection
> packet?
>=20
> And how to expose API for userspace applications so they can change
> hardcoded kernel bandwidth? Why is there value 8000?
>=20
> Without changing hardcoded value 8000 to 4000 I'm unable to open SCO
> socket for AuriStream codec in HFP profile.
>=20
> On Saturday 04 May 2019 19:15:50 Pali Roh=C3=A1r wrote:
> > Hello,
> >=20
> > I found out that more bluetooth headsets supports AuriStream codec in
> > bluetooth HSP/HFP profile. It is proprietary CSR codec described as some
> > ADPCM variant with better quality as default CVSD codec.
> >=20
> > Headset announce their support by sending command AT+CSRSF, in sixth
> > number with first or second bit set (counted from zero). E.g.:
> >=20
> >   AT+CSRSF=3D0,0,0,0,0,7
> >=20
> > Codec is then selected by host with sending:
> >=20
> >   +CSRFN: (6,4)
> >   OK
> >=20
> > And answer from headset is acknowledged by another:
> >=20
> >   OK
> >=20
> >=20
> > Problem is that on Linux after issuing these AT commands I cannot longer
> > connect to SCO socket. connect() fails with Protocol Error.
> >=20
> > And in btmon is following error:
> >=20
> >     > HCI Event: Synchronous Connect Complete (0x2c) plen 17
> >             Status: Invalid LMP Parameters / Invalid LL Parameters (0x1=
e)
> >=20
> >=20
> > In some CSR SKD is example how to activate it and there is code which
> > seems to sets following HCI connection parameters:
> >=20
> >   syncPktTypes =3D 0x003F
> >   bandwidth =3D 4000
> >   max_latency =3D 16
> >   voice_settings =3D 0x63
> >   retx_effort =3D 2
> >=20
> > I figured out that voice_settings can be configured via setsockopt()
> > SOL_BLUETOOTH + BT_VOICE. But for some unknown reason linux kernel
> > accept only two whitelisted values: 0x0003 and 0x0060.
> >=20
> > So I tried to set 0x0003 value (BT_VOICE_TRANSPARENT).
> >=20
> > In btmon I saw that kernel really changed "Air Coding Format" from CVSD
> > to Transparent, but I still got same "Invalid LMP Parameters" error.
> >=20
> > I tried to remove that whilelist from BT_VOICE option via patch below:
> >=20
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > index 9a580999ca57..06db91de4f23 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -231,7 +231,7 @@ static int sco_connect(struct sock *sk)
> >  	else
> >  		type =3D SCO_LINK;
> > =20
> > -	if (sco_pi(sk)->setting =3D=3D BT_VOICE_TRANSPARENT &&
> > +	if ((sco_pi(sk)->setting & SCO_AIRMODE_MASK) =3D=3D SCO_AIRMODE_TRANS=
P &&
> >  	    (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev))) {
> >  		err =3D -EOPNOTSUPP;
> >  		goto done;
> > @@ -836,13 +836,6 @@ static int sco_sock_setsockopt(struct socket *sock=
, int level, int optname,
> >  			break;
> >  		}
> > =20
> > -		/* Explicitly check for these values */
> > -		if (voice.setting !=3D BT_VOICE_TRANSPARENT &&
> > -		    voice.setting !=3D BT_VOICE_CVSD_16BIT) {
> > -			err =3D -EINVAL;
> > -			break;
> > -		}
> > -
> >  		sco_pi(sk)->setting =3D voice.setting;
> >  		break;
> > =20
> >=20
> > Btmon now really showed Settings as 0x63, but still did not worked.
> > Again exactly same HCI error.
> >=20
> > Next I tried hacking linux kernel to customize packet type and max
> > latency. But even I changed these values I still got that HCI error.
> >=20
> > After I changed tx_bandwidth and rx_bandwidth to 4000 (as described in
> > above connection parameters), connect() syscall for that SCO socket
> > succeeded and I started getting voice microphone data on that socket.
> >=20
> > And it worked also with voice settings 0x0003 with active in-kernel
> > whitelist.
> >=20
> > Patch which is needed is following: Change bandwidth to 4000:
> >=20
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index bd4978ce8c45..2dd4d0412971 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -283,8 +283,8 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 ha=
ndle)
> > =20
> >  	cp.handle   =3D cpu_to_le16(handle);
> > =20
> > -	cp.tx_bandwidth   =3D cpu_to_le32(0x00001f40);
> > -	cp.rx_bandwidth   =3D cpu_to_le32(0x00001f40);
> > +	cp.tx_bandwidth   =3D cpu_to_le32(4000);
> > +	cp.rx_bandwidth   =3D cpu_to_le32(4000);
> >  	cp.voice_setting  =3D cpu_to_le16(conn->setting);
> > =20
> >  	switch (conn->setting & SCO_AIRMODE_MASK) {
> >=20
> > I have really no idea what it does with headset. But without this patch
> > I'm not able to switch HSP codec from CVSD to AuriStream.
> >=20
> > Is somebody able to explain how above change can allow opening SCO
> > socket?
> >=20
> > Because without it I'm not able to activate AuriStream codec, could you
> > consider allowing userspace (via some setsockopt=C5=88 to change bandwi=
dth?
> > Because now it is hardcoded in kernel source code.
> >=20
> > For more details here is btmon output with default bandwidth which is
> > failing:
> >=20
> >   $ sudo ./monitor/btmon
> >   Bluetooth monitor ver 5.50
> >   =3D Note: Linux version 4.9.0-9-amd64 (x86_64)
> >   =3D Note: Bluetooth subsystem version 2.22
> >   =3D New Index: XX:XX:XX:XX:XX:XX (Primary,USB,hci0)
> >   =3D Open Index: XX:XX:XX:XX:XX:XX
> >   =3D Index Info: XX:XX:XX:XX:XX:XX (Intel Corp.)
> >   @ MGMT Open: bluetoothd (privileged) version 1.14
> >   @ MGMT Open: btmon (privileged) version 1.14
> >   < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
> >           Handle: 34
> >           Transmit bandwidth: 8000
> >           Receive bandwidth: 8000
> >           Max latency: 13
> >           Setting: 0x0003
> >             Input Coding: Linear
> >             Input Data Format: 1's complement
> >             Input Sample Size: 8-bit
> >             # of bits padding at MSB: 0
> >             Air Coding Format: Transparent Data
> >           Retransmission effort: Optimize for link quality (0x02)
> >           Packet type: 0x0380
> >             3-EV3 may not be used
> >             2-EV5 may not be used
> >             3-EV5 may not be used
> >   > HCI Event: Command Status (0x0f) plen 4
> >         Setup Synchronous Connection (0x01|0x0028) ncmd 1
> >           Status: Success (0x00)
> >   > HCI Event: Max Slots Change (0x1b) plen 3
> >           Handle: 34
> >           Max slots: 1
> >   > HCI Event: Synchronous Connect Complete (0x2c) plen 17
> >           Status: Invalid LMP Parameters / Invalid LL Parameters (0x1e)
> >           Handle: 34
> >           Address: XX:XX:XX:XX:XX:XX (Creative Technology, Ltd.)
> >           Link type: eSCO (0x02)
> >           Transmission interval: 0x00
> >           Retransmission window: 0x00
> >           RX packet length: 0
> >           TX packet length: 0
> >           Air mode: u-law log (0x00)
> >   > HCI Event: Max Slots Change (0x1b) plen 3
> >           Handle: 34
> >           Max slots: 5
> >=20
> > And here is btmon output with above kernel patch which changes bandwidt=
h to 4000:
> >=20
> >   $ sudo ./monitor/btmon
> >   Bluetooth monitor ver 5.50
> >   =3D Note: Linux version 4.9.0-9-amd64 (x86_64)
> >   =3D Note: Bluetooth subsystem version 2.22
> >   =3D New Index: XX:XX:XX:XX:XX:XX (Primary,USB,hci0)
> >   =3D Open Index: XX:XX:XX:XX:XX:XX
> >   =3D Index Info: XX:XX:XX:XX:XX:XX (Intel Corp.)
> >   @ MGMT Open: bluetoothd (privileged) version 1.14
> >   @ MGMT Open: btmon (privileged) version 1.14
> >   < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
> >           Handle: 34
> >           Transmit bandwidth: 4000
> >           Receive bandwidth: 4000
> >           Max latency: 13
> >           Setting: 0x0003
> >             Input Coding: Linear
> >             Input Data Format: 1's complement
> >             Input Sample Size: 8-bit
> >             # of bits padding at MSB: 0
> >             Air Coding Format: Transparent Data
> >           Retransmission effort: Optimize for link quality (0x02)
> >           Packet type: 0x0380
> >             3-EV3 may not be used
> >             2-EV5 may not be used
> >             3-EV5 may not be used
> >   > HCI Event: Command Status (0x0f) plen 4
> >         Setup Synchronous Connection (0x01|0x0028) ncmd 1
> >           Status: Success (0x00)
> >   > HCI Event: Max Slots Change (0x1b) plen 3
> >           Handle: 34
> >           Max slots: 1
> >   > HCI Event: Synchronous Connect Complete (0x2c) plen 17
> >           Status: Success (0x00)
> >           Handle: 38
> >           Address: XX:XX:XX:XX:XX:XX (Creative Technology, Ltd.)
> >           Link type: eSCO (0x02)
> >           Transmission interval: 0x10
> >           Retransmission window: 0x02
> >           RX packet length: 40
> >           TX packet length: 40
> >           Air mode: Transparent (0x03)
> >   < SCO Data TX: Handle 38 flags 0x00 dlen 48
> >   < ACL Data TX: Handle 34 flags 0x00 dlen 18
> >         Channel: 105 len 14 [PSM 0 mode 0] {chan 0}
> >           61 ef 15 0d 0a 2b 56 47 4d 3d 34 0d 0a d4        a....+VGM=3D=
4...
> >   > HCI Event: Number of Completed Packets (0x13) plen 5
> >           Num handles: 1
> >           Handle: 34
> >           Count: 1
> >   > SCO Data RX: Handle 38 flags 0x00 dlen 24
> >   > SCO Data RX: Handle 38 flags 0x00 dlen 24
> >   > SCO Data RX: Handle 38 flags 0x00 dlen 24
> >   < SCO Data TX: Handle 38 flags 0x00 dlen 48
> >   > HCI Event: Max Slots Change (0x1b) plen 3
> >           Handle: 34
> >           Max slots: 5
> >=20
> > ... and SCO data are coming on SCO socket.
> >=20
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--xazfzfcbvugyxe3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXN2tMwAKCRCL8Mk9A+RD
UoJ3AJ9x/nmPLlfmd3ZpOdBJ0lbZ5uxwqQCgijnIe8a14UR5XuhTPCP9Kf4ONzg=
=+tYc
-----END PGP SIGNATURE-----

--xazfzfcbvugyxe3e--
