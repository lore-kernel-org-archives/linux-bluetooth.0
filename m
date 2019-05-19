Return-Path: <SRS0=+1pe=TT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197E0C04AB4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 May 2019 17:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAA620644
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 May 2019 17:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaLP245L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfESRcR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 May 2019 13:32:17 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:44412 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfESRcQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 May 2019 13:32:16 -0400
Received: by mail-oi1-f173.google.com with SMTP id z65so8358253oia.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 May 2019 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jLnkz4WQArf9xHeGFNBgYfW6dFZP0sxSzqONN44V+lM=;
        b=KaLP245LXvveyvQRt/AmR+9gaTS7p7VY54zsfyAEmTPaAIzELGxcWgOxqroARZ4MgP
         WSDMGr8o61u76dhDpX5J8fZ8BiTPEeui8T/BgKZQfJZPs646CJv7+DxgcPqhyolSd8mm
         It3+DJrRKKveXF4oWcj7I85qhbv/SEfFDg0r2+yjY3TNbHO7tR1J+t4YnXJWKNqyjt79
         AZmO9+f/FnTHSDHBK0f98hZJtb9s676AbYDM23SN490FFCiaqhEC4btM5RFsrAUJtuuu
         hvMZyIgrjClonoRCcT0qAy/nw0GfcAz7q9Vc3Fy5Yr8VUU1aYwg7Be1XT2BGNBJg6jQT
         kjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jLnkz4WQArf9xHeGFNBgYfW6dFZP0sxSzqONN44V+lM=;
        b=IpDV5ugt0gjZLfMwQ33eSxyfh/O8vqMLDAf2LGmdNfPfMnaO7KMzLQVbq7jTSJDJ4T
         disi7/AEeLKuoGJHRs03auhd6Dv21gRkcQnCzYCcIEBfBZoawbGQkpmpv008wqQYSY31
         JWgIHukAyEt4uuwgk1J2z6vVZLKr6dUN5BYFVpPE1hklZupvzroeJGxwpJDHucbjXZOa
         n7P4fYqhmFQ6+riFxYe7SvnUkFbMnaqTZ470E0yY5Qe2WYTQYJt6eI3g1lBGYkrg/M2p
         Yuu4wMz3Y77dwfAX+TfUcdvrEaNVdewPKAVhJht7GojNkhgLzLoQLlzIr5zLJzHEvFCr
         m2hg==
X-Gm-Message-State: APjAAAWupXq+C1AKFo6nKNbzDVYBOw/wzCy3tBGnwdcqCnpab7KpHtAw
        GzHbzZNJPts7M+syIDgaoQvEY2/ot+fSkc+dMMCMF9Zi8zM=
X-Google-Smtp-Source: APXvYqzG6QebvMKSJuGJDDMzWEqz9W3Ak7NW4NzMH3VfnQEXdaI0yA3+L4tf/WaLysNJLP3sWl/JE+ZM3vf0tkOi+vc=
X-Received: by 2002:aca:b255:: with SMTP id b82mr18361151oif.82.1558255514488;
 Sun, 19 May 2019 01:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190504171550.llqfv5674gxd3bnn@pali> <20190506151651.pu2us2fgsf7w2vos@pali>
 <20190516183429.ql3hxtnmiabcq7tj@pali> <CABBYNZLJB0bK7o=Tvf9mhb5U41xAin6SdPY9=76AuEvpEiA_8g@mail.gmail.com>
 <20190519082305.q7y4gpmdhvx3vzvo@pali>
In-Reply-To: <20190519082305.q7y4gpmdhvx3vzvo@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 19 May 2019 11:45:02 +0300
Message-ID: <CABBYNZJKO07p-8ufP7=4WUYS1oLhnsKY_pnP6-0SbVzi=CYZsQ@mail.gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sun, May 19, 2019 at 11:23 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> On Sunday 19 May 2019 11:16:00 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Thu, May 16, 2019 at 9:34 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
> > >
> > > Ping, can you comment anything related to hardcoded bandwidth?
> > >
> > > I would really like to take next step how to expose API for changing
> > > bandwidth as linux kernel currently does not allow to receive and
> > > transmit voice encoded by AuriStream codec.
> >
> > Didn't even know such codec existed, anyway that is not using the
> > standard AT commands so it is kind hard to figure out how to set it up
> > properly,
>
> Yes, AT+CSRSF is not standard AT command, but CSR extension. Also there
> are e.g. more headsets which support Apple extensions to AT commands...
> And Apple has public documentation for it.
>
> > to be honest, I would rather see WBS implementation finally
> > reach PA before we start digging into this.
>
> First I want to finish improving A2DP codec support in pulseaudio. Later
> I can look at HSP/HFP profiles. Ideally it should have modular/plugin
> extensible design. So the aim is that adding new codec would be very
> simple, without need to hack something related to mSBC/WBC, AuriStream
> or any other codec.

Well HSP don't have support for codec negotiation, but yes a modular
design is probably recommended.

> But for AuriStream I need to set custom SCO parameters as described
> below and currently kernel does not support it. This is why I'm asking
> how kernel can export for userspace configuration of SCO parameters...

We can always come up with socket options but we got to see the value
it would bring since AuriStream don't look that popular among
headsets, at least Ive never seem any device advertising it like
apt-X, etc.

> > > On Monday 06 May 2019 17:16:51 Pali Roh=C3=A1r wrote:
> > > > Ccing more people...
> > > >
> > > > do you have idea why for custom SCO HFP codec is needed to change
> > > > Transmit and Receive bandwidth in HCI Setup Synchronous Connection
> > > > packet?
> > > >
> > > > And how to expose API for userspace applications so they can change
> > > > hardcoded kernel bandwidth? Why is there value 8000?
> > > >
> > > > Without changing hardcoded value 8000 to 4000 I'm unable to open SC=
O
> > > > socket for AuriStream codec in HFP profile.
> > > >
> > > > On Saturday 04 May 2019 19:15:50 Pali Roh=C3=A1r wrote:
> > > > > Hello,
> > > > >
> > > > > I found out that more bluetooth headsets supports AuriStream code=
c in
> > > > > bluetooth HSP/HFP profile. It is proprietary CSR codec described =
as some
> > > > > ADPCM variant with better quality as default CVSD codec.
> > > > >
> > > > > Headset announce their support by sending command AT+CSRSF, in si=
xth
> > > > > number with first or second bit set (counted from zero). E.g.:
> > > > >
> > > > >   AT+CSRSF=3D0,0,0,0,0,7
> > > > >
> > > > > Codec is then selected by host with sending:
> > > > >
> > > > >   +CSRFN: (6,4)
> > > > >   OK
> > > > >
> > > > > And answer from headset is acknowledged by another:
> > > > >
> > > > >   OK
> > > > >
> > > > >
> > > > > Problem is that on Linux after issuing these AT commands I cannot=
 longer
> > > > > connect to SCO socket. connect() fails with Protocol Error.
> > > > >
> > > > > And in btmon is following error:
> > > > >
> > > > >     > HCI Event: Synchronous Connect Complete (0x2c) plen 17
> > > > >             Status: Invalid LMP Parameters / Invalid LL Parameter=
s (0x1e)
> > > > >
> > > > >
> > > > > In some CSR SKD is example how to activate it and there is code w=
hich
> > > > > seems to sets following HCI connection parameters:
> > > > >
> > > > >   syncPktTypes =3D 0x003F
> > > > >   bandwidth =3D 4000
> > > > >   max_latency =3D 16
> > > > >   voice_settings =3D 0x63
> > > > >   retx_effort =3D 2
> > > > >
> > > > > I figured out that voice_settings can be configured via setsockop=
t()
> > > > > SOL_BLUETOOTH + BT_VOICE. But for some unknown reason linux kerne=
l
> > > > > accept only two whitelisted values: 0x0003 and 0x0060.
> > > > >
> > > > > So I tried to set 0x0003 value (BT_VOICE_TRANSPARENT).
> > > > >
> > > > > In btmon I saw that kernel really changed "Air Coding Format" fro=
m CVSD
> > > > > to Transparent, but I still got same "Invalid LMP Parameters" err=
or.
> > > > >
> > > > > I tried to remove that whilelist from BT_VOICE option via patch b=
elow:
> > > > >
> > > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > > index 9a580999ca57..06db91de4f23 100644
> > > > > --- a/net/bluetooth/sco.c
> > > > > +++ b/net/bluetooth/sco.c
> > > > > @@ -231,7 +231,7 @@ static int sco_connect(struct sock *sk)
> > > > >     else
> > > > >             type =3D SCO_LINK;
> > > > >
> > > > > -   if (sco_pi(sk)->setting =3D=3D BT_VOICE_TRANSPARENT &&
> > > > > +   if ((sco_pi(sk)->setting & SCO_AIRMODE_MASK) =3D=3D SCO_AIRMO=
DE_TRANSP &&
> > > > >         (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev))) {
> > > > >             err =3D -EOPNOTSUPP;
> > > > >             goto done;
> > > > > @@ -836,13 +836,6 @@ static int sco_sock_setsockopt(struct socket=
 *sock, int level, int optname,
> > > > >                     break;
> > > > >             }
> > > > >
> > > > > -           /* Explicitly check for these values */
> > > > > -           if (voice.setting !=3D BT_VOICE_TRANSPARENT &&
> > > > > -               voice.setting !=3D BT_VOICE_CVSD_16BIT) {
> > > > > -                   err =3D -EINVAL;
> > > > > -                   break;
> > > > > -           }
> > > > > -
> > > > >             sco_pi(sk)->setting =3D voice.setting;
> > > > >             break;
> > > > >
> > > > >
> > > > > Btmon now really showed Settings as 0x63, but still did not worke=
d.
> > > > > Again exactly same HCI error.
> > > > >
> > > > > Next I tried hacking linux kernel to customize packet type and ma=
x
> > > > > latency. But even I changed these values I still got that HCI err=
or.
> > > > >
> > > > > After I changed tx_bandwidth and rx_bandwidth to 4000 (as describ=
ed in
> > > > > above connection parameters), connect() syscall for that SCO sock=
et
> > > > > succeeded and I started getting voice microphone data on that soc=
ket.
> > > > >
> > > > > And it worked also with voice settings 0x0003 with active in-kern=
el
> > > > > whitelist.
> > > > >
> > > > > Patch which is needed is following: Change bandwidth to 4000:
> > > > >
> > > > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > > > index bd4978ce8c45..2dd4d0412971 100644
> > > > > --- a/net/bluetooth/hci_conn.c
> > > > > +++ b/net/bluetooth/hci_conn.c
> > > > > @@ -283,8 +283,8 @@ bool hci_setup_sync(struct hci_conn *conn, __=
u16 handle)
> > > > >
> > > > >     cp.handle   =3D cpu_to_le16(handle);
> > > > >
> > > > > -   cp.tx_bandwidth   =3D cpu_to_le32(0x00001f40);
> > > > > -   cp.rx_bandwidth   =3D cpu_to_le32(0x00001f40);
> > > > > +   cp.tx_bandwidth   =3D cpu_to_le32(4000);
> > > > > +   cp.rx_bandwidth   =3D cpu_to_le32(4000);
> > > > >     cp.voice_setting  =3D cpu_to_le16(conn->setting);
> > > > >
> > > > >     switch (conn->setting & SCO_AIRMODE_MASK) {
> > > > >
> > > > > I have really no idea what it does with headset. But without this=
 patch
> > > > > I'm not able to switch HSP codec from CVSD to AuriStream.
> > > > >
> > > > > Is somebody able to explain how above change can allow opening SC=
O
> > > > > socket?
> > > > >
> > > > > Because without it I'm not able to activate AuriStream codec, cou=
ld you
> > > > > consider allowing userspace (via some setsockopt=C5=88 to change =
bandwidth?
> > > > > Because now it is hardcoded in kernel source code.
> > > > >
> > > > > For more details here is btmon output with default bandwidth whic=
h is
> > > > > failing:
> > > > >
> > > > >   $ sudo ./monitor/btmon
> > > > >   Bluetooth monitor ver 5.50
> > > > >   =3D Note: Linux version 4.9.0-9-amd64 (x86_64)
> > > > >   =3D Note: Bluetooth subsystem version 2.22
> > > > >   =3D New Index: XX:XX:XX:XX:XX:XX (Primary,USB,hci0)
> > > > >   =3D Open Index: XX:XX:XX:XX:XX:XX
> > > > >   =3D Index Info: XX:XX:XX:XX:XX:XX (Intel Corp.)
> > > > >   @ MGMT Open: bluetoothd (privileged) version 1.14
> > > > >   @ MGMT Open: btmon (privileged) version 1.14
> > > > >   < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen =
17
> > > > >           Handle: 34
> > > > >           Transmit bandwidth: 8000
> > > > >           Receive bandwidth: 8000
> > > > >           Max latency: 13
> > > > >           Setting: 0x0003
> > > > >             Input Coding: Linear
> > > > >             Input Data Format: 1's complement
> > > > >             Input Sample Size: 8-bit
> > > > >             # of bits padding at MSB: 0
> > > > >             Air Coding Format: Transparent Data
> > > > >           Retransmission effort: Optimize for link quality (0x02)
> > > > >           Packet type: 0x0380
> > > > >             3-EV3 may not be used
> > > > >             2-EV5 may not be used
> > > > >             3-EV5 may not be used
> > > > >   > HCI Event: Command Status (0x0f) plen 4
> > > > >         Setup Synchronous Connection (0x01|0x0028) ncmd 1
> > > > >           Status: Success (0x00)
> > > > >   > HCI Event: Max Slots Change (0x1b) plen 3
> > > > >           Handle: 34
> > > > >           Max slots: 1
> > > > >   > HCI Event: Synchronous Connect Complete (0x2c) plen 17
> > > > >           Status: Invalid LMP Parameters / Invalid LL Parameters =
(0x1e)
> > > > >           Handle: 34
> > > > >           Address: XX:XX:XX:XX:XX:XX (Creative Technology, Ltd.)
> > > > >           Link type: eSCO (0x02)
> > > > >           Transmission interval: 0x00
> > > > >           Retransmission window: 0x00
> > > > >           RX packet length: 0
> > > > >           TX packet length: 0
> > > > >           Air mode: u-law log (0x00)
> > > > >   > HCI Event: Max Slots Change (0x1b) plen 3
> > > > >           Handle: 34
> > > > >           Max slots: 5
> > > > >
> > > > > And here is btmon output with above kernel patch which changes ba=
ndwidth to 4000:
> > > > >
> > > > >   $ sudo ./monitor/btmon
> > > > >   Bluetooth monitor ver 5.50
> > > > >   =3D Note: Linux version 4.9.0-9-amd64 (x86_64)
> > > > >   =3D Note: Bluetooth subsystem version 2.22
> > > > >   =3D New Index: XX:XX:XX:XX:XX:XX (Primary,USB,hci0)
> > > > >   =3D Open Index: XX:XX:XX:XX:XX:XX
> > > > >   =3D Index Info: XX:XX:XX:XX:XX:XX (Intel Corp.)
> > > > >   @ MGMT Open: bluetoothd (privileged) version 1.14
> > > > >   @ MGMT Open: btmon (privileged) version 1.14
> > > > >   < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen =
17
> > > > >           Handle: 34
> > > > >           Transmit bandwidth: 4000
> > > > >           Receive bandwidth: 4000
> > > > >           Max latency: 13
> > > > >           Setting: 0x0003
> > > > >             Input Coding: Linear
> > > > >             Input Data Format: 1's complement
> > > > >             Input Sample Size: 8-bit
> > > > >             # of bits padding at MSB: 0
> > > > >             Air Coding Format: Transparent Data
> > > > >           Retransmission effort: Optimize for link quality (0x02)
> > > > >           Packet type: 0x0380
> > > > >             3-EV3 may not be used
> > > > >             2-EV5 may not be used
> > > > >             3-EV5 may not be used
> > > > >   > HCI Event: Command Status (0x0f) plen 4
> > > > >         Setup Synchronous Connection (0x01|0x0028) ncmd 1
> > > > >           Status: Success (0x00)
> > > > >   > HCI Event: Max Slots Change (0x1b) plen 3
> > > > >           Handle: 34
> > > > >           Max slots: 1
> > > > >   > HCI Event: Synchronous Connect Complete (0x2c) plen 17
> > > > >           Status: Success (0x00)
> > > > >           Handle: 38
> > > > >           Address: XX:XX:XX:XX:XX:XX (Creative Technology, Ltd.)
> > > > >           Link type: eSCO (0x02)
> > > > >           Transmission interval: 0x10
> > > > >           Retransmission window: 0x02
> > > > >           RX packet length: 40
> > > > >           TX packet length: 40
> > > > >           Air mode: Transparent (0x03)
> > > > >   < SCO Data TX: Handle 38 flags 0x00 dlen 48
> > > > >   < ACL Data TX: Handle 34 flags 0x00 dlen 18
> > > > >         Channel: 105 len 14 [PSM 0 mode 0] {chan 0}
> > > > >           61 ef 15 0d 0a 2b 56 47 4d 3d 34 0d 0a d4        a....+=
VGM=3D4...
> > > > >   > HCI Event: Number of Completed Packets (0x13) plen 5
> > > > >           Num handles: 1
> > > > >           Handle: 34
> > > > >           Count: 1
> > > > >   > SCO Data RX: Handle 38 flags 0x00 dlen 24
> > > > >   > SCO Data RX: Handle 38 flags 0x00 dlen 24
> > > > >   > SCO Data RX: Handle 38 flags 0x00 dlen 24
> > > > >   < SCO Data TX: Handle 38 flags 0x00 dlen 48
> > > > >   > HCI Event: Max Slots Change (0x1b) plen 3
> > > > >           Handle: 34
> > > > >           Max slots: 5
> > > > >
> > > > > ... and SCO data are coming on SCO socket.
> > > > >
> > > >
> > >
> > > --
> > > Pali Roh=C3=A1r
> > > pali.rohar@gmail.com
> >
> >
> >
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
Luiz Augusto von Dentz
