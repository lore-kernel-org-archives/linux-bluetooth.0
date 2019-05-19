Return-Path: <SRS0=+1pe=TT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220FAC04AB4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 May 2019 17:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D808320578
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 May 2019 17:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+1SUGks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfESReo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 May 2019 13:34:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34715 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfESReo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 May 2019 13:34:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so12628624wma.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 May 2019 10:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=js9fSia3kX4O5FJhJrypV/8yBwMxu5cVd4WPmqxYK0w=;
        b=t+1SUGksHrQ3EhkV59lzqSbzOgXyOC3rpUd0BB4aI2H/APv1fKkCgcDr9d5j1Gelv2
         dP8FhGmDxlRnb9DwuC9YTYmY51pfLPxba0dmvHzmbswZep9dr7GJuQ7CpzGsnBRQWT51
         LPhpw/K9L6rMmZTH2bg1Ey27BufMB0IgHTvEDhrZi0TyU/c+tGQGiVXJmj6vpuL2YDHe
         B8k3V/CAPo/duWFpSrQxWq4BJyWuobVXRYta8WqTdGFJUgbG+SfxWJ205omceP8vAKrj
         FdqQrtJHr4jILSwrzkdMQfXFYO+NjGij4nyF4m6liYcWx6bPCbX+vExVciNORWZdBDPp
         L5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=js9fSia3kX4O5FJhJrypV/8yBwMxu5cVd4WPmqxYK0w=;
        b=XpsyRuWoX+fYbhc2U+QnzvlQhNDM9T1XhPwY2S9FDR7dEUGnRiD9BwjY2XJOVrsWbh
         DD9hIkViNP002q5z151bna9Wf6lz+3Nksa3VoNr9nCm+Wxd5p8RfQud9Y16jpoEw1RRK
         50RIFc70MZ6OPinyz9YhT9kI46SBYHlYc/0hVrX8OfQcyFn8JJQTNGwNXLDNmfAjR9WR
         Xqu9LL3LJ4rsDSQfjFonnD8w7m6b1SOB+jVGWNxjJC3QQvQI0XuvnDZoVvlT9dkNMr+v
         wOzrv0eM4fviO6lizqssIatjchf/GLtnW/GsJ5ynxSWKFv5j6/QcgNplENjH0K6C2dPN
         P0Xg==
X-Gm-Message-State: APjAAAUPyMhkvOqp2ct2xSIFNLF3wn14bO70ACIsDZmUTBFxEzDhxA8d
        H0basqv2vetieYQnyAxmIsutkwrA
X-Google-Smtp-Source: APXvYqw9jYAB922lE4aAhlzRul6lnrAWPOVNtF6h9+M3U0fMC0CcT8ATicFKB6YnqtltaM4H3QkBWg==
X-Received: by 2002:a1c:7511:: with SMTP id o17mr984309wmc.39.1558256098266;
        Sun, 19 May 2019 01:54:58 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id s11sm24175271wrb.71.2019.05.19.01.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 May 2019 01:54:57 -0700 (PDT)
Date:   Sun, 19 May 2019 10:54:56 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20190519085456.spa4nqkteic42u34@pali>
References: <20190504171550.llqfv5674gxd3bnn@pali>
 <20190506151651.pu2us2fgsf7w2vos@pali>
 <20190516183429.ql3hxtnmiabcq7tj@pali>
 <CABBYNZLJB0bK7o=Tvf9mhb5U41xAin6SdPY9=76AuEvpEiA_8g@mail.gmail.com>
 <20190519082305.q7y4gpmdhvx3vzvo@pali>
 <CABBYNZJKO07p-8ufP7=4WUYS1oLhnsKY_pnP6-0SbVzi=CYZsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zdleugkuny5ohshi"
Content-Disposition: inline
In-Reply-To: <CABBYNZJKO07p-8ufP7=4WUYS1oLhnsKY_pnP6-0SbVzi=CYZsQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--zdleugkuny5ohshi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 19 May 2019 11:45:02 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Sun, May 19, 2019 at 11:23 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> >
> > On Sunday 19 May 2019 11:16:00 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Thu, May 16, 2019 at 9:34 PM Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
> > > >
> > > > Ping, can you comment anything related to hardcoded bandwidth?
> > > >
> > > > I would really like to take next step how to expose API for changing
> > > > bandwidth as linux kernel currently does not allow to receive and
> > > > transmit voice encoded by AuriStream codec.
> > >
> > > Didn't even know such codec existed, anyway that is not using the
> > > standard AT commands so it is kind hard to figure out how to set it up
> > > properly,
> >
> > Yes, AT+CSRSF is not standard AT command, but CSR extension. Also there
> > are e.g. more headsets which support Apple extensions to AT commands...
> > And Apple has public documentation for it.
> >
> > > to be honest, I would rather see WBS implementation finally
> > > reach PA before we start digging into this.
> >
> > First I want to finish improving A2DP codec support in pulseaudio. Later
> > I can look at HSP/HFP profiles. Ideally it should have modular/plugin
> > extensible design. So the aim is that adding new codec would be very
> > simple, without need to hack something related to mSBC/WBC, AuriStream
> > or any other codec.
>=20
> Well HSP don't have support for codec negotiation, but yes a modular
> design is probably recommended.

Agree.

> > But for AuriStream I need to set custom SCO parameters as described
> > below and currently kernel does not support it. This is why I'm asking
> > how kernel can export for userspace configuration of SCO parameters...
>=20
> We can always come up with socket options but we got to see the value
> it would bring

As wrote in previous emails, CSR SDK uses following HCI settings for
AuriStream:

   syncPktTypes =3D 0x003F
   bandwidth =3D 4000
   max_latency =3D 16
   voice_settings =3D 0x63
   retx_effort =3D 2

And based on my experiments without setting bandwidth to 4000, connect()
syscall fails.

> since AuriStream don't look that popular among
> headsets, at least Ive never seem any device advertising it like
> apt-X, etc.

I have never seen advertised AuriStream codec too. I just wanted to
figure out what that mysterious AT+CSRSF means and figure out that it is
CSR's custom HFP codec.

Anyway, seems that there are lot of headsets with AuriStream codec. Put
AT+CSRSF=3D0,0,0,0,0,7 to google search and would get lot of results of
people who pasted bluetooth logs.

So implementation of AuriStream can be really useful as it is already
widely used.

> > > > On Monday 06 May 2019 17:16:51 Pali Roh=C3=A1r wrote:
> > > > > Ccing more people...
> > > > >
> > > > > do you have idea why for custom SCO HFP codec is needed to change
> > > > > Transmit and Receive bandwidth in HCI Setup Synchronous Connection
> > > > > packet?
> > > > >
> > > > > And how to expose API for userspace applications so they can chan=
ge
> > > > > hardcoded kernel bandwidth? Why is there value 8000?
> > > > >
> > > > > Without changing hardcoded value 8000 to 4000 I'm unable to open =
SCO
> > > > > socket for AuriStream codec in HFP profile.
> > > > >
> > > > > On Saturday 04 May 2019 19:15:50 Pali Roh=C3=A1r wrote:
> > > > > > Hello,
> > > > > >
> > > > > > I found out that more bluetooth headsets supports AuriStream co=
dec in
> > > > > > bluetooth HSP/HFP profile. It is proprietary CSR codec describe=
d as some
> > > > > > ADPCM variant with better quality as default CVSD codec.
> > > > > >
> > > > > > Headset announce their support by sending command AT+CSRSF, in =
sixth
> > > > > > number with first or second bit set (counted from zero). E.g.:
> > > > > >
> > > > > >   AT+CSRSF=3D0,0,0,0,0,7
> > > > > >
> > > > > > Codec is then selected by host with sending:
> > > > > >
> > > > > >   +CSRFN: (6,4)
> > > > > >   OK
> > > > > >
> > > > > > And answer from headset is acknowledged by another:
> > > > > >
> > > > > >   OK
> > > > > >
> > > > > >
> > > > > > Problem is that on Linux after issuing these AT commands I cann=
ot longer
> > > > > > connect to SCO socket. connect() fails with Protocol Error.
> > > > > >
> > > > > > And in btmon is following error:
> > > > > >
> > > > > >     > HCI Event: Synchronous Connect Complete (0x2c) plen 17
> > > > > >             Status: Invalid LMP Parameters / Invalid LL Paramet=
ers (0x1e)
> > > > > >
> > > > > >
> > > > > > In some CSR SKD is example how to activate it and there is code=
 which
> > > > > > seems to sets following HCI connection parameters:
> > > > > >
> > > > > >   syncPktTypes =3D 0x003F
> > > > > >   bandwidth =3D 4000
> > > > > >   max_latency =3D 16
> > > > > >   voice_settings =3D 0x63
> > > > > >   retx_effort =3D 2
> > > > > >
> > > > > > I figured out that voice_settings can be configured via setsock=
opt()
> > > > > > SOL_BLUETOOTH + BT_VOICE. But for some unknown reason linux ker=
nel
> > > > > > accept only two whitelisted values: 0x0003 and 0x0060.
> > > > > >
> > > > > > So I tried to set 0x0003 value (BT_VOICE_TRANSPARENT).
> > > > > >
> > > > > > In btmon I saw that kernel really changed "Air Coding Format" f=
rom CVSD
> > > > > > to Transparent, but I still got same "Invalid LMP Parameters" e=
rror.
> > > > > >
> > > > > > I tried to remove that whilelist from BT_VOICE option via patch=
 below:
> > > > > >
> > > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > > > index 9a580999ca57..06db91de4f23 100644
> > > > > > --- a/net/bluetooth/sco.c
> > > > > > +++ b/net/bluetooth/sco.c
> > > > > > @@ -231,7 +231,7 @@ static int sco_connect(struct sock *sk)
> > > > > >     else
> > > > > >             type =3D SCO_LINK;
> > > > > >
> > > > > > -   if (sco_pi(sk)->setting =3D=3D BT_VOICE_TRANSPARENT &&
> > > > > > +   if ((sco_pi(sk)->setting & SCO_AIRMODE_MASK) =3D=3D SCO_AIR=
MODE_TRANSP &&
> > > > > >         (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev)))=
 {
> > > > > >             err =3D -EOPNOTSUPP;
> > > > > >             goto done;
> > > > > > @@ -836,13 +836,6 @@ static int sco_sock_setsockopt(struct sock=
et *sock, int level, int optname,
> > > > > >                     break;
> > > > > >             }
> > > > > >
> > > > > > -           /* Explicitly check for these values */
> > > > > > -           if (voice.setting !=3D BT_VOICE_TRANSPARENT &&
> > > > > > -               voice.setting !=3D BT_VOICE_CVSD_16BIT) {
> > > > > > -                   err =3D -EINVAL;
> > > > > > -                   break;
> > > > > > -           }
> > > > > > -
> > > > > >             sco_pi(sk)->setting =3D voice.setting;
> > > > > >             break;
> > > > > >
> > > > > >
> > > > > > Btmon now really showed Settings as 0x63, but still did not wor=
ked.
> > > > > > Again exactly same HCI error.
> > > > > >
> > > > > > Next I tried hacking linux kernel to customize packet type and =
max
> > > > > > latency. But even I changed these values I still got that HCI e=
rror.
> > > > > >
> > > > > > After I changed tx_bandwidth and rx_bandwidth to 4000 (as descr=
ibed in
> > > > > > above connection parameters), connect() syscall for that SCO so=
cket
> > > > > > succeeded and I started getting voice microphone data on that s=
ocket.
> > > > > >
> > > > > > And it worked also with voice settings 0x0003 with active in-ke=
rnel
> > > > > > whitelist.
> > > > > >
> > > > > > Patch which is needed is following: Change bandwidth to 4000:
> > > > > >
> > > > > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > > > > index bd4978ce8c45..2dd4d0412971 100644
> > > > > > --- a/net/bluetooth/hci_conn.c
> > > > > > +++ b/net/bluetooth/hci_conn.c
> > > > > > @@ -283,8 +283,8 @@ bool hci_setup_sync(struct hci_conn *conn, =
__u16 handle)
> > > > > >
> > > > > >     cp.handle   =3D cpu_to_le16(handle);
> > > > > >
> > > > > > -   cp.tx_bandwidth   =3D cpu_to_le32(0x00001f40);
> > > > > > -   cp.rx_bandwidth   =3D cpu_to_le32(0x00001f40);
> > > > > > +   cp.tx_bandwidth   =3D cpu_to_le32(4000);
> > > > > > +   cp.rx_bandwidth   =3D cpu_to_le32(4000);
> > > > > >     cp.voice_setting  =3D cpu_to_le16(conn->setting);
> > > > > >
> > > > > >     switch (conn->setting & SCO_AIRMODE_MASK) {
> > > > > >
> > > > > > I have really no idea what it does with headset. But without th=
is patch
> > > > > > I'm not able to switch HSP codec from CVSD to AuriStream.
> > > > > >
> > > > > > Is somebody able to explain how above change can allow opening =
SCO
> > > > > > socket?
> > > > > >
> > > > > > Because without it I'm not able to activate AuriStream codec, c=
ould you
> > > > > > consider allowing userspace (via some setsockopt=C5=88 to chang=
e bandwidth?
> > > > > > Because now it is hardcoded in kernel source code.
> > > > > >
> > > > > > For more details here is btmon output with default bandwidth wh=
ich is
> > > > > > failing:
> > > > > >
> > > > > >   $ sudo ./monitor/btmon
> > > > > >   Bluetooth monitor ver 5.50
> > > > > >   =3D Note: Linux version 4.9.0-9-amd64 (x86_64)
> > > > > >   =3D Note: Bluetooth subsystem version 2.22
> > > > > >   =3D New Index: XX:XX:XX:XX:XX:XX (Primary,USB,hci0)
> > > > > >   =3D Open Index: XX:XX:XX:XX:XX:XX
> > > > > >   =3D Index Info: XX:XX:XX:XX:XX:XX (Intel Corp.)
> > > > > >   @ MGMT Open: bluetoothd (privileged) version 1.14
> > > > > >   @ MGMT Open: btmon (privileged) version 1.14
> > > > > >   < HCI Command: Setup Synchronous Connection (0x01|0x0028) ple=
n 17
> > > > > >           Handle: 34
> > > > > >           Transmit bandwidth: 8000
> > > > > >           Receive bandwidth: 8000
> > > > > >           Max latency: 13
> > > > > >           Setting: 0x0003
> > > > > >             Input Coding: Linear
> > > > > >             Input Data Format: 1's complement
> > > > > >             Input Sample Size: 8-bit
> > > > > >             # of bits padding at MSB: 0
> > > > > >             Air Coding Format: Transparent Data
> > > > > >           Retransmission effort: Optimize for link quality (0x0=
2)
> > > > > >           Packet type: 0x0380
> > > > > >             3-EV3 may not be used
> > > > > >             2-EV5 may not be used
> > > > > >             3-EV5 may not be used
> > > > > >   > HCI Event: Command Status (0x0f) plen 4
> > > > > >         Setup Synchronous Connection (0x01|0x0028) ncmd 1
> > > > > >           Status: Success (0x00)
> > > > > >   > HCI Event: Max Slots Change (0x1b) plen 3
> > > > > >           Handle: 34
> > > > > >           Max slots: 1
> > > > > >   > HCI Event: Synchronous Connect Complete (0x2c) plen 17
> > > > > >           Status: Invalid LMP Parameters / Invalid LL Parameter=
s (0x1e)
> > > > > >           Handle: 34
> > > > > >           Address: XX:XX:XX:XX:XX:XX (Creative Technology, Ltd.)
> > > > > >           Link type: eSCO (0x02)
> > > > > >           Transmission interval: 0x00
> > > > > >           Retransmission window: 0x00
> > > > > >           RX packet length: 0
> > > > > >           TX packet length: 0
> > > > > >           Air mode: u-law log (0x00)
> > > > > >   > HCI Event: Max Slots Change (0x1b) plen 3
> > > > > >           Handle: 34
> > > > > >           Max slots: 5
> > > > > >
> > > > > > And here is btmon output with above kernel patch which changes =
bandwidth to 4000:
> > > > > >
> > > > > >   $ sudo ./monitor/btmon
> > > > > >   Bluetooth monitor ver 5.50
> > > > > >   =3D Note: Linux version 4.9.0-9-amd64 (x86_64)
> > > > > >   =3D Note: Bluetooth subsystem version 2.22
> > > > > >   =3D New Index: XX:XX:XX:XX:XX:XX (Primary,USB,hci0)
> > > > > >   =3D Open Index: XX:XX:XX:XX:XX:XX
> > > > > >   =3D Index Info: XX:XX:XX:XX:XX:XX (Intel Corp.)
> > > > > >   @ MGMT Open: bluetoothd (privileged) version 1.14
> > > > > >   @ MGMT Open: btmon (privileged) version 1.14
> > > > > >   < HCI Command: Setup Synchronous Connection (0x01|0x0028) ple=
n 17
> > > > > >           Handle: 34
> > > > > >           Transmit bandwidth: 4000
> > > > > >           Receive bandwidth: 4000
> > > > > >           Max latency: 13
> > > > > >           Setting: 0x0003
> > > > > >             Input Coding: Linear
> > > > > >             Input Data Format: 1's complement
> > > > > >             Input Sample Size: 8-bit
> > > > > >             # of bits padding at MSB: 0
> > > > > >             Air Coding Format: Transparent Data
> > > > > >           Retransmission effort: Optimize for link quality (0x0=
2)
> > > > > >           Packet type: 0x0380
> > > > > >             3-EV3 may not be used
> > > > > >             2-EV5 may not be used
> > > > > >             3-EV5 may not be used
> > > > > >   > HCI Event: Command Status (0x0f) plen 4
> > > > > >         Setup Synchronous Connection (0x01|0x0028) ncmd 1
> > > > > >           Status: Success (0x00)
> > > > > >   > HCI Event: Max Slots Change (0x1b) plen 3
> > > > > >           Handle: 34
> > > > > >           Max slots: 1
> > > > > >   > HCI Event: Synchronous Connect Complete (0x2c) plen 17
> > > > > >           Status: Success (0x00)
> > > > > >           Handle: 38
> > > > > >           Address: XX:XX:XX:XX:XX:XX (Creative Technology, Ltd.)
> > > > > >           Link type: eSCO (0x02)
> > > > > >           Transmission interval: 0x10
> > > > > >           Retransmission window: 0x02
> > > > > >           RX packet length: 40
> > > > > >           TX packet length: 40
> > > > > >           Air mode: Transparent (0x03)
> > > > > >   < SCO Data TX: Handle 38 flags 0x00 dlen 48
> > > > > >   < ACL Data TX: Handle 34 flags 0x00 dlen 18
> > > > > >         Channel: 105 len 14 [PSM 0 mode 0] {chan 0}
> > > > > >           61 ef 15 0d 0a 2b 56 47 4d 3d 34 0d 0a d4        a...=
=2E+VGM=3D4...
> > > > > >   > HCI Event: Number of Completed Packets (0x13) plen 5
> > > > > >           Num handles: 1
> > > > > >           Handle: 34
> > > > > >           Count: 1
> > > > > >   > SCO Data RX: Handle 38 flags 0x00 dlen 24
> > > > > >   > SCO Data RX: Handle 38 flags 0x00 dlen 24
> > > > > >   > SCO Data RX: Handle 38 flags 0x00 dlen 24
> > > > > >   < SCO Data TX: Handle 38 flags 0x00 dlen 48
> > > > > >   > HCI Event: Max Slots Change (0x1b) plen 3
> > > > > >           Handle: 34
> > > > > >           Max slots: 5
> > > > > >
> > > > > > ... and SCO data are coming on SCO socket.
> > > > > >
> > > > >
> > > >
> > > > --
> > > > Pali Roh=C3=A1r
> > > > pali.rohar@gmail.com
> > >
> > >
> > >
> >
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--zdleugkuny5ohshi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXOEZ3gAKCRCL8Mk9A+RD
Us0ZAJ9i2Fvxpsm6xen5+kvGCkxc1FiUyQCgpCMZMaaFlRGPrmSZAElbsxV7BEg=
=0NYI
-----END PGP SIGNATURE-----

--zdleugkuny5ohshi--
