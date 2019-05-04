Return-Path: <SRS0=nVHi=TE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82762C43219
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 May 2019 17:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FB6206DF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 May 2019 17:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NA3LXZRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfEDRQB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 May 2019 13:16:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35257 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfEDRQB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 May 2019 13:16:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15so6046879wrb.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 May 2019 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=H67xNX2AqTNoWbo8PTMVhFSrmab2VRGkLcplzdy7i6U=;
        b=NA3LXZRi27JGzC5JWbMWeO1mS9EJfQKVif9/4z3EH9eQqGk+i6m0nU5JWb2YR94yw0
         0QP9GNKXPd/v+BvSYeBStLK9EI7e4WUoncOqL2yVcU04oZgtQiwblOyib6LkhuxsZ1Ug
         79uQfildDN66nbO19j7cPbmZo8mpjSq7aXGAeC7qiIpCdimimi4lk3JsjkacyYrhDhJz
         zql/zugRJMTf2tkA+f/eV31Mb2ZS1TE+6x7xpprobYKKc1yuSKnvcB58cyZFhqIAxRi2
         GXblOZOp+ZEtdTOl9F8BsVXkIeIO5p5ftHWFNVSSt0DelbgJNnYAvqHOToJNv57lOV+z
         GA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=H67xNX2AqTNoWbo8PTMVhFSrmab2VRGkLcplzdy7i6U=;
        b=hqVqrxRNVtR3pV7Lu9lXtBBhVedLqcAg5EdUYYF0eWylXcZcJj4TFpu/5YAal3IMj6
         J5Nkv3V9BZFeNLiROxR2HHCFRUPxKpJnoOZ/mtodBw8Sn/mfpC7y+7sCM5dd3trU2ecq
         NXIqIAVgZClSMQM6yT1x1lf9qIpZXvNAUP1w6ym8PMEgbtzuwTLI8YrCUSvf9Y+5oHPf
         l4a+pHvM/WmgC25yyBy67iJOkxKnaI5xri5JPX/HEqJMMKWSYxot3yGPKljz/PbOD0Ky
         RYALzBgf6JE48R3o5AHbBXynX+V7o2tD7yMwGz/2ef4tFD2ET8Vxmiqm3Qdzs+J0Vrt+
         wgkQ==
X-Gm-Message-State: APjAAAVrxYrBVoec00ksUvWVcCMGf/uoslpNfYAVkddBllV0/z+zVXqL
        9EOK6GXVlQGZxYl481CtJaS1XCSrBLc=
X-Google-Smtp-Source: APXvYqyptHrJjZ2/OXy62RlUnLJmMRlUNIFE2cvJZV6Cm28+2lrNE5tCsAnpEr+1C4Rhc5MagD/geQ==
X-Received: by 2002:a05:6000:1201:: with SMTP id e1mr12087916wrx.49.1556990158558;
        Sat, 04 May 2019 10:15:58 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b11sm10640281wmh.29.2019.05.04.10.15.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 May 2019 10:15:57 -0700 (PDT)
Date:   Sat, 4 May 2019 19:15:50 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20190504171550.llqfv5674gxd3bnn@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4u4kv4z6rwjwab6y"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--4u4kv4z6rwjwab6y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I found out that more bluetooth headsets supports AuriStream codec in
bluetooth HSP/HFP profile. It is proprietary CSR codec described as some
ADPCM variant with better quality as default CVSD codec.

Headset announce their support by sending command AT+CSRSF, in sixth
number with first or second bit set (counted from zero). E.g.:

  AT+CSRSF=3D0,0,0,0,0,7

Codec is then selected by host with sending:

  +CSRFN: (6,4)
  OK

And answer from headset is acknowledged by another:

  OK


Problem is that on Linux after issuing these AT commands I cannot longer
connect to SCO socket. connect() fails with Protocol Error.

And in btmon is following error:

    > HCI Event: Synchronous Connect Complete (0x2c) plen 17
            Status: Invalid LMP Parameters / Invalid LL Parameters (0x1e)


In some CSR SKD is example how to activate it and there is code which
seems to sets following HCI connection parameters:

  syncPktTypes =3D 0x003F
  bandwidth =3D 4000
  max_latency =3D 16
  voice_settings =3D 0x63
  retx_effort =3D 2

I figured out that voice_settings can be configured via setsockopt()
SOL_BLUETOOTH + BT_VOICE. But for some unknown reason linux kernel
accept only two whitelisted values: 0x0003 and 0x0060.

So I tried to set 0x0003 value (BT_VOICE_TRANSPARENT).

In btmon I saw that kernel really changed "Air Coding Format" from CVSD
to Transparent, but I still got same "Invalid LMP Parameters" error.

I tried to remove that whilelist from BT_VOICE option via patch below:

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 9a580999ca57..06db91de4f23 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -231,7 +231,7 @@ static int sco_connect(struct sock *sk)
 	else
 		type =3D SCO_LINK;
=20
-	if (sco_pi(sk)->setting =3D=3D BT_VOICE_TRANSPARENT &&
+	if ((sco_pi(sk)->setting & SCO_AIRMODE_MASK) =3D=3D SCO_AIRMODE_TRANSP &&
 	    (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev))) {
 		err =3D -EOPNOTSUPP;
 		goto done;
@@ -836,13 +836,6 @@ static int sco_sock_setsockopt(struct socket *sock, in=
t level, int optname,
 			break;
 		}
=20
-		/* Explicitly check for these values */
-		if (voice.setting !=3D BT_VOICE_TRANSPARENT &&
-		    voice.setting !=3D BT_VOICE_CVSD_16BIT) {
-			err =3D -EINVAL;
-			break;
-		}
-
 		sco_pi(sk)->setting =3D voice.setting;
 		break;
=20

Btmon now really showed Settings as 0x63, but still did not worked.
Again exactly same HCI error.

Next I tried hacking linux kernel to customize packet type and max
latency. But even I changed these values I still got that HCI error.

After I changed tx_bandwidth and rx_bandwidth to 4000 (as described in
above connection parameters), connect() syscall for that SCO socket
succeeded and I started getting voice microphone data on that socket.

And it worked also with voice settings 0x0003 with active in-kernel
whitelist.

Patch which is needed is following: Change bandwidth to 4000:

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index bd4978ce8c45..2dd4d0412971 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -283,8 +283,8 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
=20
 	cp.handle   =3D cpu_to_le16(handle);
=20
-	cp.tx_bandwidth   =3D cpu_to_le32(0x00001f40);
-	cp.rx_bandwidth   =3D cpu_to_le32(0x00001f40);
+	cp.tx_bandwidth   =3D cpu_to_le32(4000);
+	cp.rx_bandwidth   =3D cpu_to_le32(4000);
 	cp.voice_setting  =3D cpu_to_le16(conn->setting);
=20
 	switch (conn->setting & SCO_AIRMODE_MASK) {

I have really no idea what it does with headset. But without this patch
I'm not able to switch HSP codec from CVSD to AuriStream.

Is somebody able to explain how above change can allow opening SCO
socket?

Because without it I'm not able to activate AuriStream codec, could you
consider allowing userspace (via some setsockopt=C5=88 to change bandwidth?
Because now it is hardcoded in kernel source code.

For more details here is btmon output with default bandwidth which is
failing:

  $ sudo ./monitor/btmon
  Bluetooth monitor ver 5.50
  =3D Note: Linux version 4.9.0-9-amd64 (x86_64)
  =3D Note: Bluetooth subsystem version 2.22
  =3D New Index: XX:XX:XX:XX:XX:XX (Primary,USB,hci0)
  =3D Open Index: XX:XX:XX:XX:XX:XX
  =3D Index Info: XX:XX:XX:XX:XX:XX (Intel Corp.)
  @ MGMT Open: bluetoothd (privileged) version 1.14
  @ MGMT Open: btmon (privileged) version 1.14
  < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
          Handle: 34
          Transmit bandwidth: 8000
          Receive bandwidth: 8000
          Max latency: 13
          Setting: 0x0003
            Input Coding: Linear
            Input Data Format: 1's complement
            Input Sample Size: 8-bit
            # of bits padding at MSB: 0
            Air Coding Format: Transparent Data
          Retransmission effort: Optimize for link quality (0x02)
          Packet type: 0x0380
            3-EV3 may not be used
            2-EV5 may not be used
            3-EV5 may not be used
  > HCI Event: Command Status (0x0f) plen 4
        Setup Synchronous Connection (0x01|0x0028) ncmd 1
          Status: Success (0x00)
  > HCI Event: Max Slots Change (0x1b) plen 3
          Handle: 34
          Max slots: 1
  > HCI Event: Synchronous Connect Complete (0x2c) plen 17
          Status: Invalid LMP Parameters / Invalid LL Parameters (0x1e)
          Handle: 34
          Address: XX:XX:XX:XX:XX:XX (Creative Technology, Ltd.)
          Link type: eSCO (0x02)
          Transmission interval: 0x00
          Retransmission window: 0x00
          RX packet length: 0
          TX packet length: 0
          Air mode: u-law log (0x00)
  > HCI Event: Max Slots Change (0x1b) plen 3
          Handle: 34
          Max slots: 5

And here is btmon output with above kernel patch which changes bandwidth to=
 4000:

  $ sudo ./monitor/btmon
  Bluetooth monitor ver 5.50
  =3D Note: Linux version 4.9.0-9-amd64 (x86_64)
  =3D Note: Bluetooth subsystem version 2.22
  =3D New Index: XX:XX:XX:XX:XX:XX (Primary,USB,hci0)
  =3D Open Index: XX:XX:XX:XX:XX:XX
  =3D Index Info: XX:XX:XX:XX:XX:XX (Intel Corp.)
  @ MGMT Open: bluetoothd (privileged) version 1.14
  @ MGMT Open: btmon (privileged) version 1.14
  < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
          Handle: 34
          Transmit bandwidth: 4000
          Receive bandwidth: 4000
          Max latency: 13
          Setting: 0x0003
            Input Coding: Linear
            Input Data Format: 1's complement
            Input Sample Size: 8-bit
            # of bits padding at MSB: 0
            Air Coding Format: Transparent Data
          Retransmission effort: Optimize for link quality (0x02)
          Packet type: 0x0380
            3-EV3 may not be used
            2-EV5 may not be used
            3-EV5 may not be used
  > HCI Event: Command Status (0x0f) plen 4
        Setup Synchronous Connection (0x01|0x0028) ncmd 1
          Status: Success (0x00)
  > HCI Event: Max Slots Change (0x1b) plen 3
          Handle: 34
          Max slots: 1
  > HCI Event: Synchronous Connect Complete (0x2c) plen 17
          Status: Success (0x00)
          Handle: 38
          Address: XX:XX:XX:XX:XX:XX (Creative Technology, Ltd.)
          Link type: eSCO (0x02)
          Transmission interval: 0x10
          Retransmission window: 0x02
          RX packet length: 40
          TX packet length: 40
          Air mode: Transparent (0x03)
  < SCO Data TX: Handle 38 flags 0x00 dlen 48
  < ACL Data TX: Handle 34 flags 0x00 dlen 18
        Channel: 105 len 14 [PSM 0 mode 0] {chan 0}
          61 ef 15 0d 0a 2b 56 47 4d 3d 34 0d 0a d4        a....+VGM=3D4...
  > HCI Event: Number of Completed Packets (0x13) plen 5
          Num handles: 1
          Handle: 34
          Count: 1
  > SCO Data RX: Handle 38 flags 0x00 dlen 24
  > SCO Data RX: Handle 38 flags 0x00 dlen 24
  > SCO Data RX: Handle 38 flags 0x00 dlen 24
  < SCO Data TX: Handle 38 flags 0x00 dlen 48
  > HCI Event: Max Slots Change (0x1b) plen 3
          Handle: 34
          Max slots: 5

=2E.. and SCO data are coming on SCO socket.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--4u4kv4z6rwjwab6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXM3IuAAKCRCL8Mk9A+RD
UpQPAKC7ulOOBj3Dp04viWerhXxuz6YYnwCgp744dl3is16IOBdgtT/1cjilAhQ=
=0s5K
-----END PGP SIGNATURE-----

--4u4kv4z6rwjwab6y--
