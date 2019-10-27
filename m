Return-Path: <SRS0=E3AB=YU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90804CA9EAF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Oct 2019 22:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3908D2064A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Oct 2019 22:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4YoPUhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfJ0WJw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Oct 2019 18:09:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54732 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfJ0WJw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Oct 2019 18:09:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id g7so7450601wmk.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Oct 2019 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TcKrltqz3V9vqAkayQGzhjCX5jPHOz3eXgen9hQzIU4=;
        b=I4YoPUhYvk9GnoOm2PqB8hdC3Z72RtqWXQvwvebkFA/DPv6m9c20hRoPfHssr3M3r4
         1pz5QnpIPHKAa2PXsPoArvcdadkV0IJwzLqZ0iI8YVxWkvSIL263ExrhSlVPi/QDgSmq
         tbrUNLwZ6UQ55gVneMtwAsdLPAFwder3L95VuHFr0IEJ6WWTICJAWT1HMMMc9JSJ+F8j
         oct2nmX3Qc/5DR8OXBlgtaAt1GYgR+P7G+oIz/oGX5zJhF2kySX487bOySNLjEiY576z
         wHdjnzLRt/ekmW/b4Uy1X2d9HC/JxN4TCpk6t4n1qn9bYZmSRYzcyePRxU6BUlLoelIs
         sbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TcKrltqz3V9vqAkayQGzhjCX5jPHOz3eXgen9hQzIU4=;
        b=GYY7fjIM0V89Ms9RP0eLmy8toaGy9qZpgQBFy3kstZAOoS0mhBH+P+F/u7hqxLSwGO
         oaJ1r5INxI1CK1b4BQevdYP2Iw/0+N8Jx8r08GHRNc4e4+I4lAx2ML+fyLrNWRPeexdd
         QWSyMZ8M3RfU9ICBjxoSPJnh2m/a5MIAgFxHNoueUm1gEcj/y05xBA722JeNal2UIaD1
         EExAGIqc9w23F9SI4aVLtw0/gDt8IG3p0DgbWX+EC1p9kLRGARaf8NWhU9Narlgk5T3E
         6/nmKD/vsS2yZP6PnM1zmo23jBVE4enpwLnwQdq41UIrfKO5l5F+BhvT7t8dH09rrEDg
         AssQ==
X-Gm-Message-State: APjAAAWPXZCxDjpELSdmqnVsa5h6jkg1VRytx0we61Y3+OEHEcBeOYuN
        hQGG38wa0tCuV3AEmB2ez/Q=
X-Google-Smtp-Source: APXvYqwHDAkJhbv5fBZpkJ+yqTONOXInaiHCpgiAfjSm9E9FowkDmvpiPTNEUeKafHyo65pbqPUzGQ==
X-Received: by 2002:a7b:c94f:: with SMTP id i15mr13722455wml.31.1572214187861;
        Sun, 27 Oct 2019 15:09:47 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id l4sm10310781wrf.46.2019.10.27.15.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Oct 2019 15:09:46 -0700 (PDT)
Date:   Sun, 27 Oct 2019 23:09:45 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20191027220945.wmb3g55wtrmqbnmz@pali>
References: <20190519082305.q7y4gpmdhvx3vzvo@pali>
 <CABBYNZJKO07p-8ufP7=4WUYS1oLhnsKY_pnP6-0SbVzi=CYZsQ@mail.gmail.com>
 <20190519212157.GB31403@amd>
 <20190607130245.mv4ch6dxnuptzdki@pali>
 <ED456CCA-CF85-48D9-B7E9-9B0BF02A32FC@holtmann.org>
 <20190708122512.qqfvtm455ltxxg3h@pali>
 <E4A6E61C-DE37-4E5D-9401-71CCE4AE2419@holtmann.org>
 <20190708210616.x2dlnzjhnplu37bz@pali>
 <D0A44CC7-CABC-408A-894E-AAD700FA9B0D@holtmann.org>
 <20190718100939.bwl26qcfxe6ppcto@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qoy4lxsks4yak3jm"
Content-Disposition: inline
In-Reply-To: <20190718100939.bwl26qcfxe6ppcto@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--qoy4lxsks4yak3jm
Content-Type: multipart/mixed; boundary="s4prwwkve52x2625"
Content-Disposition: inline


--s4prwwkve52x2625
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 18 July 2019 12:09:39 Pali Roh=C3=A1r wrote:
> On Friday 12 July 2019 20:59:22 Marcel Holtmann wrote:
> > Hi Pali,
> >=20
> > >>>>>>>>> to be honest, I would rather see WBS implementation finally
> > >>>>>>>>> reach PA before we start digging into this.
> > >>>>>>>>=20
> > >>>>>>>> First I want to finish improving A2DP codec support in pulseau=
dio. Later
> > >>>>>>>> I can look at HSP/HFP profiles. Ideally it should have modular=
/plugin
> > >>>>>>>> extensible design. So the aim is that adding new codec would b=
e very
> > >>>>>>>> simple, without need to hack something related to mSBC/WBC, Au=
riStream
> > >>>>>>>> or any other codec.
> > >>>>>>>=20
> > >>>>>>> Well HSP don't have support for codec negotiation, but yes a mo=
dular
> > >>>>>>> design is probably recommended.
> > >>>>>>>=20
> > >>>>>>>> But for AuriStream I need to set custom SCO parameters as desc=
ribed
> > >>>>>>>> below and currently kernel does not support it. This is why I'=
m asking
> > >>>>>>>> how kernel can export for userspace configuration of SCO param=
eters...
> > >>>>>>>=20
> > >>>>>>> We can always come up with socket options but we got to see the=
 value
> > >>>>>>> it would bring since AuriStream don't look that popular among
> > >>>>>>> headsets, at least Ive never seem any device advertising it like
> > >>>>>>> apt-X, etc.
> > >>>>>>=20
> > >>>>>> Pali clearly has such device and he is willing to work on it. Su=
rely
> > >>>>>> that means it is popular enough to be supported...?
> > >>>>>=20
> > >>>>> Just put AT+CSRSF=3D0,0,0,0,0,7 to google search and you would se=
e that
> > >>>>> not only I have such device...
> > >>>>>=20
> > >>>>> So I would really would like to see that kernel finally stops blo=
cking
> > >>>>> usage of this AuriStream codec.
> > >>>>=20
> > >>>> we need to figure out on how we do the kernel API to allow you thi=
s specific setting.
> > >>>=20
> > >>> Hi Marcel! Kernel API for userspace should be simple. Just add two
> > >>> ioctls for retrieving and setting structure with custom parameters:
> > >>>=20
> > >>> syncPktTypes =3D 0x003F
> > >>> bandwidth =3D 4000
> > >>> max_latency =3D 16
> > >>> voice_settings =3D 0x63
> > >>> retx_effort =3D 2
> > >>>=20
> > >>> Or add more ioctls, one ioctl per parameter. There is already only =
ioctl
> > >>> for voice settings and moreover it is whitelisted only for two valu=
es.
> > >>=20
> > >> it is not that simple actually. Most profiles define a certain set o=
f parameters and then they try to configure better settings and only fallba=
ck to a specification defined default as last resort.
> > >=20
> > > Ok. I see that there is another "example" configuration for AuriStream
> > > with just different syncPktTypes =3D 0x02BF and bandwidth =3D 3850.
> > >=20
> > > So it really is not simple as it can be seen.
> >=20
> > currently the stepping for mSBC and CVSD are hard-coded in esco_param_c=
vsd and esco_param_msbc arrays in hci_conn.c and then selected by the ->set=
ting parameter.
> >=20
> > So either we provide an new socket option (for example BT_VOICE_EXT) or=
 we extend BT_VOICE to allow providing the needed information. However this=
 needs to be flexible array size since we should then be able to encode mul=
tiple stepping that are tried in order.
> >=20
> > My preference is that we extend BT_VOICE and not introduce a new socket=
 option. So feel free to propose how we can load the full tables into the S=
CO socket. I mean we are not really far off actually. The only difference i=
s that currently the tables are in the hci_conn.c file and selected by the =
provided voice->setting. However nothing really stops us from providing the=
 full table via user space.
>=20
> Ok. I will look at it and I will try to propose how to extend current
> BT_VOICE ioctl API for supporting all those new parameters.

Below is inline MIME part with POC patch which try to implement a new
IOCTL (currently named BT_VOICE_SETUP) for configuring voice sco
settings.

It uses flexible array of parameters <tx_bandwidth, rx_bandwidth,
voice_setting, pkt_type, max_latency, retrans_effort>, but with
maximally 10 array members (due to usage of static array storage). cvsd
codec uses 7 different fallback settings (see voice_setup_cvsd), so for
POC 10 should be enough.

Because a new IOCL has different members then old BT_VOICE I rather
decided to introduce a new IOCTL and not hacking old IOCTL to accept two
different structures.

Please let me know what do you think about this API, if this is a way
how to continue or if something different is needed.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--s4prwwkve52x2625
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="sco.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/blue=
tooth.h
index fabee6db0abb..0e9f4ac07220 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -122,6 +122,19 @@ struct bt_voice {
 #define BT_SNDMTU		12
 #define BT_RCVMTU		13
=20
+#define BT_VOICE_SETUP		14
+#define BT_VOICE_SETUP_ARRAY_SIZE 10
+struct bt_voice_setup {
+	__u8 sco_capable:1;
+	__u8 esco_capable:1;
+	__u32 tx_bandwidth;
+	__u32 rx_bandwidth;
+	__u16 voice_setting;
+	__u16 pkt_type;
+	__u16 max_latency;
+	__u8 retrans_effort;
+};
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_c=
ore.h
index 094e61e07030..8f3c161da1c4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -477,7 +477,7 @@ struct hci_conn {
 	__u8		passkey_entered;
 	__u16		disc_timeout;
 	__u16		conn_timeout;
-	__u16		setting;
+	struct bt_voice_setup voice_setup[BT_VOICE_SETUP_ARRAY_SIZE];
 	__u16		le_conn_min_interval;
 	__u16		le_conn_max_interval;
 	__u16		le_conn_interval;
@@ -897,8 +897,8 @@ static inline struct hci_conn *hci_lookup_le_connect(st=
ruct hci_dev *hdev)
 }
=20
 int hci_disconnect(struct hci_conn *conn, __u8 reason);
-bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
-void hci_sco_setup(struct hci_conn *conn, __u8 status);
+int hci_setup_sync(struct hci_conn *conn, __u16 handle);
+int hci_sco_setup(struct hci_conn *conn, __u8 status);
=20
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *ds=
t,
 			      u8 role);
@@ -920,7 +920,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, b=
daddr_t *dst,
 struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 				 u8 sec_level, u8 auth_type);
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t =
*dst,
-				 __u16 setting);
+				 struct bt_voice_setup *voice_setup);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_typ=
e,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index bd4978ce8c45..0aa2ad98eb80 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -35,30 +35,6 @@
 #include "smp.h"
 #include "a2mp.h"
=20
-struct sco_param {
-	u16 pkt_type;
-	u16 max_latency;
-	u8  retrans_effort;
-};
-
-static const struct sco_param esco_param_cvsd[] =3D {
-	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a,	0x01 }, /* S3 */
-	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007,	0x01 }, /* S2 */
-	{ EDR_ESCO_MASK | ESCO_EV3,   0x0007,	0x01 }, /* S1 */
-	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0x01 }, /* D1 */
-	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0x01 }, /* D0 */
-};
-
-static const struct sco_param sco_param_cvsd[] =3D {
-	{ EDR_ESCO_MASK | ESCO_HV3,   0xffff,	0xff }, /* D1 */
-	{ EDR_ESCO_MASK | ESCO_HV1,   0xffff,	0xff }, /* D0 */
-};
-
-static const struct sco_param esco_param_msbc[] =3D {
-	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d,	0x02 }, /* T2 */
-	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008,	0x02 }, /* T1 */
-};
-
 /* This function requires the caller holds hdev->lock */
 static void hci_connect_le_scan_cleanup(struct hci_conn *conn)
 {
@@ -250,7 +226,7 @@ int hci_disconnect(struct hci_conn *conn, __u8 reason)
 	return hci_abort_conn(conn, reason);
 }
=20
-static void hci_add_sco(struct hci_conn *conn, __u16 handle)
+static int hci_add_sco(struct hci_conn *conn, __u16 handle)
 {
 	struct hci_dev *hdev =3D conn->hdev;
 	struct hci_cp_add_sco cp;
@@ -262,17 +238,21 @@ static void hci_add_sco(struct hci_conn *conn, __u16 =
handle)
=20
 	conn->attempt++;
=20
+	if ((conn->voice_setup[0].voice_setting & SCO_AIRMODE_MASK) =3D=3D SCO_AI=
RMODE_TRANSP)
+		return -EOPNOTSUPP;
+
 	cp.handle   =3D cpu_to_le16(handle);
 	cp.pkt_type =3D cpu_to_le16(conn->pkt_type);
=20
-	hci_send_cmd(hdev, HCI_OP_ADD_SCO, sizeof(cp), &cp);
+	return hci_send_cmd(hdev, HCI_OP_ADD_SCO, sizeof(cp), &cp);
 }
=20
-bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
+int hci_setup_sync(struct hci_conn *conn, __u16 handle)
 {
 	struct hci_dev *hdev =3D conn->hdev;
 	struct hci_cp_setup_sync_conn cp;
-	const struct sco_param *param;
+	const struct bt_voice_setup *voice_setup;
+	int err;
=20
 	BT_DBG("hcon %p", conn);
=20
@@ -281,41 +261,41 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 hand=
le)
=20
 	conn->attempt++;
=20
-	cp.handle   =3D cpu_to_le16(handle);
+	err =3D -EINVAL;
+	for (; conn->attempt <=3D ARRAY_SIZE(conn->voice_setup); conn->attempt++)=
 {
+		voice_setup =3D &conn->voice_setup[conn->attempt - 1];
=20
-	cp.tx_bandwidth   =3D cpu_to_le32(0x00001f40);
-	cp.rx_bandwidth   =3D cpu_to_le32(0x00001f40);
-	cp.voice_setting  =3D cpu_to_le16(conn->setting);
+		/* last valid entry in array */
+		if (!voice_setup->sco_capable && !voice_setup->esco_capable)
+			return err;
=20
-	switch (conn->setting & SCO_AIRMODE_MASK) {
-	case SCO_AIRMODE_TRANSP:
-		if (conn->attempt > ARRAY_SIZE(esco_param_msbc))
-			return false;
-		param =3D &esco_param_msbc[conn->attempt - 1];
-		break;
-	case SCO_AIRMODE_CVSD:
-		if (lmp_esco_capable(conn->link)) {
-			if (conn->attempt > ARRAY_SIZE(esco_param_cvsd))
-				return false;
-			param =3D &esco_param_cvsd[conn->attempt - 1];
-		} else {
-			if (conn->attempt > ARRAY_SIZE(sco_param_cvsd))
-				return false;
-			param =3D &sco_param_cvsd[conn->attempt - 1];
+		if (!lmp_esco_capable(conn->link) && !voice_setup->sco_capable)
+			continue;
+
+		if (lmp_esco_capable(conn->link) && !voice_setup->esco_capable)
+			continue;
+
+		if ((voice_setup->voice_setting & SCO_AIRMODE_MASK) =3D=3D SCO_AIRMODE_T=
RANSP &&
+		    (!lmp_esco_capable(conn->link) || !lmp_transp_capable(hdev) || !lmp_=
esco_capable(hdev))) {
+			err =3D -EOPNOTSUPP;
+			continue;
 		}
+
 		break;
-	default:
-		return false;
 	}
=20
-	cp.retrans_effort =3D param->retrans_effort;
-	cp.pkt_type =3D __cpu_to_le16(param->pkt_type);
-	cp.max_latency =3D __cpu_to_le16(param->max_latency);
+	if (conn->attempt > ARRAY_SIZE(conn->voice_setup))
+		return err;
=20
-	if (hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp) < 0)
-		return false;
+	cp.handle         =3D cpu_to_le16(handle);
+	cp.tx_bandwidth   =3D cpu_to_le32(voice_setup->tx_bandwidth);
+	cp.rx_bandwidth   =3D cpu_to_le32(voice_setup->rx_bandwidth);
+	cp.voice_setting  =3D cpu_to_le16(voice_setup->voice_setting);
+	cp.pkt_type       =3D cpu_to_le16(voice_setup->pkt_type);
+	cp.max_latency    =3D cpu_to_le16(voice_setup->max_latency);
+	cp.retrans_effort =3D voice_setup->retrans_effort;
=20
-	return true;
+	return hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp);
 }
=20
 u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
@@ -373,24 +353,27 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 e=
div, __le64 rand,
 }
=20
 /* Device _must_ be locked */
-void hci_sco_setup(struct hci_conn *conn, __u8 status)
+int hci_sco_setup(struct hci_conn *conn, __u8 status)
 {
 	struct hci_conn *sco =3D conn->link;
+	int err =3D 0;
=20
 	if (!sco)
-		return;
+		return -EINVAL;
=20
 	BT_DBG("hcon %p", conn);
=20
 	if (!status) {
 		if (lmp_esco_capable(conn->hdev))
-			hci_setup_sync(sco, conn->handle);
+			err =3D hci_setup_sync(sco, conn->handle);
 		else
-			hci_add_sco(sco, conn->handle);
+			err =3D hci_add_sco(sco, conn->handle);
 	} else {
 		hci_connect_cfm(sco, status);
 		hci_conn_del(sco);
 	}
+
+	return err;
 }
=20
 static void hci_conn_timeout(struct work_struct *work)
@@ -1214,10 +1197,11 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hd=
ev, bdaddr_t *dst,
 }
=20
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t =
*dst,
-				 __u16 setting)
+				 struct bt_voice_setup *voice_setup)
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
+	int err;
=20
 	acl =3D hci_connect_acl(hdev, dst, BT_SECURITY_LOW, HCI_AT_NO_BONDING);
 	if (IS_ERR(acl))
@@ -1237,7 +1221,7 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev=
, int type, bdaddr_t *dst,
=20
 	hci_conn_hold(sco);
=20
-	sco->setting =3D setting;
+	memcpy(sco->voice_setup, voice_setup, sizeof(sco->voice_setup));
=20
 	if (acl->state =3D=3D BT_CONNECTED &&
 	    (sco->state =3D=3D BT_OPEN || sco->state =3D=3D BT_CLOSED)) {
@@ -1250,7 +1234,11 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hde=
v, int type, bdaddr_t *dst,
 			return sco;
 		}
=20
-		hci_sco_setup(acl, 0x00);
+		err =3D hci_sco_setup(acl, 0x00);
+		if (err) {
+			hci_conn_drop(sco);
+			return ERR_PTR(err);
+		}
 	}
=20
 	return sco;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 609fd6871c5a..9c39e5607a79 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4137,7 +4137,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev=
 *hdev,
 		if (conn->out) {
 			conn->pkt_type =3D (hdev->esco_type & SCO_ESCO_MASK) |
 					(hdev->esco_type & EDR_ESCO_MASK);
-			if (hci_setup_sync(conn, conn->link->handle))
+			if (hci_setup_sync(conn, conn->link->handle) =3D=3D 0)
 				goto unlock;
 		}
 		/* fall through */
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 9a580999ca57..e7bb8ae297f7 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -33,6 +33,21 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/sco.h>
=20
+static const struct bt_voice_setup voice_setup_cvsd[BT_VOICE_SETUP_ARRAY_S=
IZE] =3D {
+	{ 0, 1, 8000, 8000, BT_VOICE_CVSD_16BIT,  EDR_ESCO_MASK & ~ESCO_2EV3, 0x0=
00a, 0x01 }, /* S3 */
+	{ 0, 1, 8000, 8000, BT_VOICE_CVSD_16BIT,  EDR_ESCO_MASK & ~ESCO_2EV3, 0x0=
007, 0x01 }, /* S2 */
+	{ 0, 1, 8000, 8000, BT_VOICE_CVSD_16BIT,  EDR_ESCO_MASK | ESCO_EV3,   0x0=
007, 0x01 }, /* S1 */
+	{ 0, 1, 8000, 8000, BT_VOICE_CVSD_16BIT,  EDR_ESCO_MASK | ESCO_HV3,   0xf=
fff, 0x01 }, /* D1 */
+	{ 0, 1, 8000, 8000, BT_VOICE_CVSD_16BIT,  EDR_ESCO_MASK | ESCO_HV1,   0xf=
fff, 0x01 }, /* D0 */
+	{ 1, 0, 8000, 8000, BT_VOICE_CVSD_16BIT,  EDR_ESCO_MASK | ESCO_HV3,   0xf=
fff, 0xff }, /* D1 */
+	{ 1, 0, 8000, 8000, BT_VOICE_CVSD_16BIT,  EDR_ESCO_MASK | ESCO_HV1,   0xf=
fff, 0xff }, /* D0 */
+};
+
+static const struct bt_voice_setup voice_setup_msbc[BT_VOICE_SETUP_ARRAY_S=
IZE] =3D {
+	{ 0, 1, 8000, 8000, BT_VOICE_TRANSPARENT, EDR_ESCO_MASK & ~ESCO_2EV3, 0x0=
00d, 0x02 }, /* T2 */
+	{ 0, 1, 8000, 8000, BT_VOICE_TRANSPARENT, EDR_ESCO_MASK | ESCO_EV3,   0x0=
008, 0x02 }, /* T1 */
+};
+
 static bool disable_esco;
=20
 static const struct proto_ops sco_sock_ops;
@@ -65,7 +80,7 @@ struct sco_pinfo {
 	bdaddr_t	src;
 	bdaddr_t	dst;
 	__u32		flags;
-	__u16		setting;
+	struct bt_voice_setup voice_setup[BT_VOICE_SETUP_ARRAY_SIZE];
 	struct sco_conn	*conn;
 };
=20
@@ -231,14 +246,8 @@ static int sco_connect(struct sock *sk)
 	else
 		type =3D SCO_LINK;
=20
-	if (sco_pi(sk)->setting =3D=3D BT_VOICE_TRANSPARENT &&
-	    (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev))) {
-		err =3D -EOPNOTSUPP;
-		goto done;
-	}
-
 	hcon =3D hci_connect_sco(hdev, type, &sco_pi(sk)->dst,
-			       sco_pi(sk)->setting);
+			       sco_pi(sk)->voice_setup);
 	if (IS_ERR(hcon)) {
 		err =3D PTR_ERR(hcon);
 		goto done;
@@ -486,7 +495,7 @@ static struct sock *sco_sock_alloc(struct net *net, str=
uct socket *sock,
 	sk->sk_protocol =3D proto;
 	sk->sk_state    =3D BT_OPEN;
=20
-	sco_pi(sk)->setting =3D BT_VOICE_CVSD_16BIT;
+	memcpy(sco_pi(sk)->voice_setup, voice_setup_cvsd, sizeof(voice_setup_cvsd=
));
=20
 	timer_setup(&sk->sk_timer, sco_sock_timeout, 0);
=20
@@ -724,7 +733,7 @@ static int sco_sock_sendmsg(struct socket *sock, struct=
 msghdr *msg,
 	return err;
 }
=20
-static void sco_conn_defer_accept(struct hci_conn *conn, u16 setting)
+static void sco_conn_defer_accept(struct hci_conn *conn, struct bt_voice_s=
etup *voice_setup)
 {
 	struct hci_dev *hdev =3D conn->hdev;
=20
@@ -743,25 +752,12 @@ static void sco_conn_defer_accept(struct hci_conn *co=
nn, u16 setting)
 		struct hci_cp_accept_sync_conn_req cp;
=20
 		bacpy(&cp.bdaddr, &conn->dst);
-		cp.pkt_type =3D cpu_to_le16(conn->pkt_type);
-
-		cp.tx_bandwidth   =3D cpu_to_le32(0x00001f40);
-		cp.rx_bandwidth   =3D cpu_to_le32(0x00001f40);
-		cp.content_format =3D cpu_to_le16(setting);
-
-		switch (setting & SCO_AIRMODE_MASK) {
-		case SCO_AIRMODE_TRANSP:
-			if (conn->pkt_type & ESCO_2EV3)
-				cp.max_latency =3D cpu_to_le16(0x0008);
-			else
-				cp.max_latency =3D cpu_to_le16(0x000D);
-			cp.retrans_effort =3D 0x02;
-			break;
-		case SCO_AIRMODE_CVSD:
-			cp.max_latency =3D cpu_to_le16(0xffff);
-			cp.retrans_effort =3D 0xff;
-			break;
-		}
+		cp.pkt_type       =3D cpu_to_le16(voice_setup->pkt_type);
+		cp.tx_bandwidth   =3D cpu_to_le32(voice_setup->tx_bandwidth);
+		cp.rx_bandwidth   =3D cpu_to_le32(voice_setup->rx_bandwidth);
+		cp.content_format =3D cpu_to_le16(voice_setup->voice_setting);
+		cp.max_latency    =3D cpu_to_le16(voice_setup->max_latency);
+		cp.retrans_effort =3D voice_setup->retrans_effort;
=20
 		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
 			     sizeof(cp), &cp);
@@ -778,7 +774,7 @@ static int sco_sock_recvmsg(struct socket *sock, struct=
 msghdr *msg,
=20
 	if (sk->sk_state =3D=3D BT_CONNECT2 &&
 	    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
-		sco_conn_defer_accept(pi->conn->hcon, pi->setting);
+		sco_conn_defer_accept(pi->conn->hcon, &pi->voice_setup[0]);
 		sk->sk_state =3D BT_CONFIG;
=20
 		release_sock(sk);
@@ -794,8 +790,9 @@ static int sco_sock_setsockopt(struct socket *sock, int=
 level, int optname,
 			       char __user *optval, unsigned int optlen)
 {
 	struct sock *sk =3D sock->sk;
-	int len, err =3D 0;
+	int i, err =3D 0;
 	struct bt_voice voice;
+	struct bt_voice_setup voice_setup[BT_VOICE_SETUP_ARRAY_SIZE];
 	u32 opt;
=20
 	BT_DBG("sk %p", sk);
@@ -828,22 +825,56 @@ static int sco_sock_setsockopt(struct socket *sock, i=
nt level, int optname,
 			break;
 		}
=20
-		voice.setting =3D sco_pi(sk)->setting;
+		if (optlen !=3D sizeof(voice)) {
+			err =3D -EINVAL;
+			break;
+		}
+
+		if (copy_from_user((char *)&voice, optval, optlen)) {
+			err =3D -EFAULT;
+			break;
+		}
+
+		if (voice.setting =3D=3D BT_VOICE_CVSD_16BIT)
+			memcpy(sco_pi(sk)->voice_setup, voice_setup_cvsd, sizeof(voice_setup_cv=
sd));
+		else if (voice.setting =3D=3D BT_VOICE_TRANSPARENT)
+			memcpy(sco_pi(sk)->voice_setup, voice_setup_msbc, sizeof(voice_setup_ms=
bc));
+		else {
+			err =3D -EINVAL;
+			break;
+		}
+
+		break;
+
+	case BT_VOICE_SETUP:
+		if (sk->sk_state !=3D BT_OPEN && sk->sk_state !=3D BT_BOUND &&
+		    sk->sk_state !=3D BT_CONNECT2) {
+			err =3D -EINVAL;
+			break;
+		}
+
+		if (!optlen || optlen % sizeof(voice_setup[0]) !=3D 0 || optlen > sizeof=
(voice_setup)) {
+			err =3D -EINVAL;
+			break;
+		}
=20
-		len =3D min_t(unsigned int, sizeof(voice), optlen);
-		if (copy_from_user((char *)&voice, optval, len)) {
+		if (copy_from_user((char *)&voice_setup, optval, optlen)) {
 			err =3D -EFAULT;
 			break;
 		}
=20
-		/* Explicitly check for these values */
-		if (voice.setting !=3D BT_VOICE_TRANSPARENT &&
-		    voice.setting !=3D BT_VOICE_CVSD_16BIT) {
+		for (i =3D 0; i < optlen / sizeof(voice_setup[0]); i++) {
+			if (!voice_setup[i].sco_capable && !voice_setup[i].esco_capable)
+				break;
+		}
+		if (i !=3D optlen / sizeof(voice_setup[0])) {
 			err =3D -EINVAL;
 			break;
 		}
=20
-		sco_pi(sk)->setting =3D voice.setting;
+		memcpy(&sco_pi(sk)->voice_setup, voice_setup, optlen);
+		memset(&sco_pi(sk)->voice_setup + optlen, 0, sizeof(sco_pi(sk)->voice_se=
tup) - optlen);
+
 		break;
=20
 	default:
@@ -921,6 +952,7 @@ static int sco_sock_getsockopt(struct socket *sock, int=
 level, int optname,
 {
 	struct sock *sk =3D sock->sk;
 	int len, err =3D 0;
+	unsigned int voice_setup_count;
 	struct bt_voice voice;
=20
 	BT_DBG("sk %p", sk);
@@ -948,7 +980,7 @@ static int sco_sock_getsockopt(struct socket *sock, int=
 level, int optname,
 		break;
=20
 	case BT_VOICE:
-		voice.setting =3D sco_pi(sk)->setting;
+		voice.setting =3D sco_pi(sk)->voice_setup[0].voice_setting;
=20
 		len =3D min_t(unsigned int, len, sizeof(voice));
 		if (copy_to_user(optval, (char *)&voice, len))
@@ -956,6 +988,25 @@ static int sco_sock_getsockopt(struct socket *sock, in=
t level, int optname,
=20
 		break;
=20
+	case BT_VOICE_SETUP:
+		for (voice_setup_count =3D 0; voice_setup_count < ARRAY_SIZE(sco_pi(sk)-=
>voice_setup); voice_setup_count++) {
+			if (!sco_pi(sk)->voice_setup[voice_setup_count].sco_capable && !sco_pi(=
sk)->voice_setup[voice_setup_count].esco_capable)
+				break;
+		}
+
+		len =3D min_t(unsigned int, len, voice_setup_count*sizeof(sco_pi(sk)->vo=
ice_setup[0]));
+		if (copy_to_user(optval, (char *)&sco_pi(sk)->voice_setup, len)) {
+			err =3D -EFAULT;
+			break;
+		}
+
+		if (put_user(len, optlen))  {
+			err =3D -EFAULT;
+			break;
+		}
+
+		break;
+
 	default:
 		err =3D -ENOPROTOOPT;
 		break;

--s4prwwkve52x2625--

--qoy4lxsks4yak3jm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXbYVpgAKCRCL8Mk9A+RD
UvL8AKDHgzPoXn8OeenXdx9IlVAjDxTi5wCgr/i3Xy6b1rLY8OIb17pRobfAwa0=
=rqfK
-----END PGP SIGNATURE-----

--qoy4lxsks4yak3jm--
