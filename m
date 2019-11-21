Return-Path: <SRS0=kdk/=ZN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CE3C432C3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 22:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96ED720692
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 22:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ww7HBrEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfKUWpE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:45:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40511 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKUWpE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Nov 2019 17:45:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id 4so3079057wro.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2019 14:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aaNsRwTGI6D2fnRl5EPReNz2/y/6eubM902kmLVI/gw=;
        b=Ww7HBrEgeR0PVKW81z2pzhgUYg13wDLOTPLo6dGWJV9Qyxts8n77qfkNjdCjziD0z4
         8Jp+111Wq46COKXfvQkP0gZabDT3oSkmxJZE+qGdqtoQZjufmH37pTfASuIGU4e1Sopr
         PZ1e4Q/9XKHRfidNv2s3ISxsY/Npz6sTqecvdn9x4BmlwTNiBVHLUjVYfxTn1M63iFQx
         g853RbDSWubOZEv1x3zyIRa9z9ImCqXfTLx18un6rNKCszKupxkYSf4EJ8d46FufL6mB
         LW1Dk4R3LiFmRYTdfA2wMtmIOvXJbkfi1PjGQqOI3m5dZCQBeS8YgWyN/YtJg8r2BWmk
         gHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aaNsRwTGI6D2fnRl5EPReNz2/y/6eubM902kmLVI/gw=;
        b=E1H3yTz5+U2XIj0ohDXfyDE4Euqum9L7D9H3RuSzVsEed7QN2Bf5ghbzhLfQXPy/de
         2iwfyp5c/n1rNLWzhjVqLleyO4d5SdStCyAsC9xcF2qsH+Ib/ktaa3Uz9vWfvtsvT/L3
         EPjXQG5g195f/IkeonqT1K+gjZVVoh9b7MzRRMqYoXkmSgUrfSR5efrkj0RWZuMOVyYD
         JWAGv8AMCzK4x8dqIoqR59N+I3X1PbAkxXG9YA7qOhKK8nj7gRLIGpDdyTmdmPIzu87A
         aLIqaJuUOpSGpTpBWm/kcwxahmjxDvjdFEVkjNNnXw9RumdB1opwb8MOosmdbLJmpyWh
         yORQ==
X-Gm-Message-State: APjAAAUKYGe/H8gEdTMHP8W2U4na4E2fCMZWzZ+n+WF8F+zChRjdIQDk
        w9mqBWD8rlUsjdwJNy+PbXbQLjhF
X-Google-Smtp-Source: APXvYqw6xGtppeYaza2FtAQNZ1GjvCnNM+gbxMBYXo601DnHAndsv78kAWC5tlWocLP92X82gOFWQw==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr14301122wre.286.1574376297270;
        Thu, 21 Nov 2019 14:44:57 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q15sm1300488wmq.0.2019.11.21.14.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 14:44:56 -0800 (PST)
Date:   Thu, 21 Nov 2019 23:44:55 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20191121224455.orhslaa6zdmlwe43@pali>
References: <20190708122512.qqfvtm455ltxxg3h@pali>
 <E4A6E61C-DE37-4E5D-9401-71CCE4AE2419@holtmann.org>
 <20190708210616.x2dlnzjhnplu37bz@pali>
 <D0A44CC7-CABC-408A-894E-AAD700FA9B0D@holtmann.org>
 <20190718100939.bwl26qcfxe6ppcto@pali>
 <20191027220945.wmb3g55wtrmqbnmz@pali>
 <1CFFA8EF-1B2A-466E-8901-BFB849F20442@holtmann.org>
 <20191119171342.mwfzszu7xwabi7to@pali>
 <392B6AA9-7512-472A-8F22-D86F2A7F1EDC@holtmann.org>
 <20191120074411.xtyw34kb3gc73zvk@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="syu3v4gdnyxk7gmy"
Content-Disposition: inline
In-Reply-To: <20191120074411.xtyw34kb3gc73zvk@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--syu3v4gdnyxk7gmy
Content-Type: multipart/mixed; boundary="h4eu27lltioth4pn"
Content-Disposition: inline


--h4eu27lltioth4pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 20 November 2019 08:44:11 Pali Roh=C3=A1r wrote:
> I was playing with another suggestion for API:
>=20
> +#define BT_VOICE_SETUP		14
> +struct bt_voice_pkt_type {
> +	__u8 capability; /* 0x01 - SCO; 0x02 - eSCO */
> +	__u8 retrans_effort;
> +	__u16 pkt_type;
> +	__u16 max_latency;
> +};
> +struct bt_voice_setup {
> +	__u16 voice_setting;
> +	__u16 pkt_types_count;
> +	__u32 tx_bandwidth;
> +	__u32 rx_bandwidth;
> +	struct bt_voice_pkt_type pkt_types[];
> +};
>=20
> So voice_setttings, pkt_types_count and badwidth would not be repeated
> as it is same for every pkt_type/retrans_effors/max_latency.
>=20
> But above uses C99 flexible arrays, so I do not know if API kernel <-->
> userspace API is allowed to use C99 flexible arrays.
>=20
> But getsockopt/setsockopt functions are possible to write with above
> API.

I played more with C99 flexible arrays and seems that gcc supports it
without any problems. I'm sending another attempt of API implementation,
now with more fields which are needed for Enhanced Setup Synchronous
Connection command. This command is not supported by kernel yet, but
should be easy to add it. So my ioctl API is prepared for it. Enhanced
Setup Synchronous Connection command would be needed to use hardware
mSBC codec encoder/decoder.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--h4eu27lltioth4pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sco.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/blue=
tooth.h
index fabee6db0abb..29590c6749d5 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -116,12 +116,49 @@ struct bt_voice {
 	__u16 setting;
 };
=20
-#define BT_VOICE_TRANSPARENT			0x0003
-#define BT_VOICE_CVSD_16BIT			0x0060
-
 #define BT_SNDMTU		12
 #define BT_RCVMTU		13
=20
+#define BT_VOICE_SETUP		14
+#define BT_VOICE_PKT_TYPE_CAP_SCO	BIT(0)
+#define BT_VOICE_PKT_TYPE_CAP_ESCO	BIT(1)
+struct bt_voice_pkt_type {
+	__u8 capability; /* bitmask of BT_VOICE_PKT_TYPE_CAP_* */
+	__u8 retrans_effort;
+	__u16 pkt_type;
+	__u16 max_latency;
+};
+#define BT_VOICE_SETUP_FEATURE_CONFIG		BIT(0) /* Additional configuration =
fields after voice_settings are set (including other features) */
+#define BT_VOICE_SETUP_FEATURE_ADD_SCO		BIT(1) /* Can use Add Synchronous =
Connection */
+#define BT_VOICE_SETUP_FEATURE_SETUP_SCO	BIT(2) /* Can use Setup Synchrono=
us Connection */
+#define BT_VOICE_SETUP_FEATURE_ENH_SETUP_SCO	BIT(3) /* Can use Enhanced Se=
tup Synchronous Connection */
+struct bt_voice_setup {
+	__u16 voice_setting;
+	__u8 features; /* bitmask of BT_VOICE_SETUP_FEATURE_* */
+	__u8 pkt_types_count;
+	__u32 tx_bandwidth;
+	__u32 rx_bandwidth;
+	__u32 input_bandwidth;
+	__u32 output_bandwidth;
+	__u8 tx_coding_format[5];
+	__u8 rx_coding_format[5];
+	__u8 input_coding_format[5];
+	__u8 output_coding_format[5];
+	__u16 tx_codec_frame_size;
+	__u16 rx_codec_frame_size;
+	__u16 input_coded_data_size;
+	__u16 output_coded_data_size;
+	__u8 input_pcm_data_format;
+	__u8 output_pcm_data_format;
+	__u8 input_pcm_msb_position;
+	__u8 output_pcm_msb_position;
+	__u8 input_data_path;
+	__u8 output_data_path;
+	__u8 input_unit_size;
+	__u8 output_unit_size;
+	struct bt_voice_pkt_type pkt_types[];
+};
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_c=
ore.h
index 094e61e07030..c99236e3a6d2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -477,7 +477,7 @@ struct hci_conn {
 	__u8		passkey_entered;
 	__u16		disc_timeout;
 	__u16		conn_timeout;
-	__u16		setting;
+	const struct bt_voice_setup *voice_setup;
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
+				 const struct bt_voice_setup *voice_setup);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_typ=
e,
@@ -1164,6 +1164,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_lsto_capable(dev)      ((dev)->features[0][7] & LMP_LSTO)
 #define lmp_inq_tx_pwr_capable(dev) ((dev)->features[0][7] & LMP_INQ_TX_PW=
R)
 #define lmp_ext_feat_capable(dev)  ((dev)->features[0][7] & LMP_EXTFEATURE=
S)
+#define lmp_ulaw_capable(dev)      ((dev)->features[0][1] & LMP_ULAW)
+#define lmp_alaw_capable(dev)      ((dev)->features[0][1] & LMP_ALAW)
+#define lmp_cvsd_capable(dev)      ((dev)->features[0][2] & LMP_CVSD)
 #define lmp_transp_capable(dev)    ((dev)->features[0][2] & LMP_TRANSPAREN=
T)
 #define lmp_edr_2m_capable(dev)    ((dev)->features[0][3] & LMP_EDR_2M)
 #define lmp_edr_3m_capable(dev)    ((dev)->features[0][3] & LMP_EDR_3M)
@@ -1592,6 +1595,15 @@ void hci_copy_identity_address(struct hci_dev *hdev,=
 bdaddr_t *bdaddr,
=20
 #define SCO_AIRMODE_MASK       0x0003
 #define SCO_AIRMODE_CVSD       0x0000
+#define SCO_AIRMODE_ULAW       0x0001
+#define SCO_AIRMODE_ALAW       0x0002
 #define SCO_AIRMODE_TRANSP     0x0003
=20
+#define lmp_voice_setting_compatible(dev, voice_setting) ( \
+	(((voice_setting) & SCO_AIRMODE_MASK) =3D=3D SCO_AIRMODE_CVSD) ? lmp_cvsd=
_capable(dev) : \
+	(((voice_setting) & SCO_AIRMODE_MASK) =3D=3D SCO_AIRMODE_ULAW) ? lmp_ulaw=
_capable(dev) : \
+	(((voice_setting) & SCO_AIRMODE_MASK) =3D=3D SCO_AIRMODE_ALAW) ? lmp_alaw=
_capable(dev) : \
+	(((voice_setting) & SCO_AIRMODE_MASK) =3D=3D SCO_AIRMODE_TRANSP) ? lmp_tr=
ansp_capable(dev) : \
+	false)
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index bd4978ce8c45..ac0e3aceac01 100644
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
+	if (conn->voice_setup->voice_setting !=3D hdev->voice_setting)
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
+	const struct bt_voice_setup *voice_setup =3D conn->voice_setup;
+	unsigned int i, j;
=20
 	BT_DBG("hcon %p", conn);
=20
@@ -281,41 +261,26 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 hand=
le)
=20
 	conn->attempt++;
=20
-	cp.handle   =3D cpu_to_le16(handle);
-
-	cp.tx_bandwidth   =3D cpu_to_le32(0x00001f40);
-	cp.rx_bandwidth   =3D cpu_to_le32(0x00001f40);
-	cp.voice_setting  =3D cpu_to_le16(conn->setting);
-
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
-		}
-		break;
-	default:
-		return false;
+	for (j =3D 0, i =3D 0; i < voice_setup->pkt_types_count && j < conn->atte=
mpt; i++) {
+		if (conn->type =3D=3D ESCO_LINK && !(voice_setup->pkt_types[i].capabilit=
y & BT_VOICE_PKT_TYPE_CAP_ESCO))
+			continue;
+		if (conn->type =3D=3D SCO_LINK && !(voice_setup->pkt_types[i].capability=
 & BT_VOICE_PKT_TYPE_CAP_SCO))
+			continue;
+		j++;
 	}
=20
-	cp.retrans_effort =3D param->retrans_effort;
-	cp.pkt_type =3D __cpu_to_le16(param->pkt_type);
-	cp.max_latency =3D __cpu_to_le16(param->max_latency);
+	if (j !=3D conn->attempt)
+		return -EINVAL;
=20
-	if (hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp) < 0)
-		return false;
+	cp.handle         =3D cpu_to_le16(handle);
+	cp.tx_bandwidth   =3D cpu_to_le32(voice_setup->tx_bandwidth);
+	cp.rx_bandwidth   =3D cpu_to_le32(voice_setup->rx_bandwidth);
+	cp.voice_setting  =3D cpu_to_le16(voice_setup->voice_setting);
+	cp.pkt_type       =3D cpu_to_le16(voice_setup->pkt_types[j-1].pkt_type);
+	cp.max_latency    =3D cpu_to_le16(voice_setup->pkt_types[j-1].max_latency=
);
+	cp.retrans_effort =3D voice_setup->pkt_types[j-1].retrans_effort;
=20
-	return true;
+	return hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp);
 }
=20
 u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
@@ -373,24 +338,38 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 e=
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
-		if (lmp_esco_capable(conn->hdev))
-			hci_setup_sync(sco, conn->handle);
+		bool can_use_add_sco =3D !(conn->voice_setup->features & BT_VOICE_SETUP_=
FEATURE_CONFIG) || (conn->voice_setup->features & BT_VOICE_SETUP_FEATURE_AD=
D_SCO);
+		bool can_use_setup_sco =3D lmp_esco_capable(conn->hdev) && (!(conn->voic=
e_setup->features & BT_VOICE_SETUP_FEATURE_CONFIG) || (conn->voice_setup->f=
eatures & BT_VOICE_SETUP_FEATURE_SETUP_SCO));
+		bool can_use_enh_setup_sco =3D false /* (conn->hdev->commands[29] & BIT(=
3)) && (!(conn->voice_setup->features & BT_VOICE_SETUP_FEATURE_CONFIG) || (=
conn->voice_setup->features & BT_VOICE_SETUP_FEATURE_ENH_SETUP_SCO)) */ ; /=
* FIXME: Enhanced Setup Synchronous Connection is unimplemented */
+		if (!lmp_voice_setting_compatible(conn->hdev, conn->voice_setup->voice_s=
etting))
+			err =3D -EOPNOTSUPP;
+#if 0
+		else if (can_use_enh_setup_sco)
+			err =3D hci_enh_setup_sync(sco, conn->handle); /* TODO */
+#endif
+		else if (can_use_setup_sco)
+			err =3D hci_setup_sync(sco, conn->handle);
+		else if (can_use_add_sco)
+			err =3D hci_add_sco(sco, conn->handle);
 		else
-			hci_add_sco(sco, conn->handle);
+			err =3D -EOPNOTSUPP;
 	} else {
 		hci_connect_cfm(sco, status);
 		hci_conn_del(sco);
 	}
+
+	return err;
 }
=20
 static void hci_conn_timeout(struct work_struct *work)
@@ -1214,10 +1193,11 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hd=
ev, bdaddr_t *dst,
 }
=20
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t =
*dst,
-				 __u16 setting)
+				 const struct bt_voice_setup *voice_setup)
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
+	int err;
=20
 	acl =3D hci_connect_acl(hdev, dst, BT_SECURITY_LOW, HCI_AT_NO_BONDING);
 	if (IS_ERR(acl))
@@ -1237,7 +1217,7 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev=
, int type, bdaddr_t *dst,
=20
 	hci_conn_hold(sco);
=20
-	sco->setting =3D setting;
+	sco->voice_setup =3D voice_setup;
=20
 	if (acl->state =3D=3D BT_CONNECTED &&
 	    (sco->state =3D=3D BT_OPEN || sco->state =3D=3D BT_CLOSED)) {
@@ -1250,7 +1230,11 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hde=
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
index 609fd6871c5a..2e7156bcabc3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2601,6 +2601,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev=
, struct sk_buff *skb)
 		bacpy(&cp.bdaddr, &ev->bdaddr);
 		cp.pkt_type =3D cpu_to_le16(conn->pkt_type);
=20
+		/* FIXME: use voice_setup */
 		cp.tx_bandwidth   =3D cpu_to_le32(0x00001f40);
 		cp.rx_bandwidth   =3D cpu_to_le32(0x00001f40);
 		cp.max_latency    =3D cpu_to_le16(0xffff);
@@ -4137,7 +4138,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev=
 *hdev,
 		if (conn->out) {
 			conn->pkt_type =3D (hdev->esco_type & SCO_ESCO_MASK) |
 					(hdev->esco_type & EDR_ESCO_MASK);
-			if (hci_setup_sync(conn, conn->link->handle))
+			if (hci_setup_sync(conn, conn->link->handle) =3D=3D 0)
 				goto unlock;
 		}
 		/* fall through */
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index ca73d36cc149..7d8443d7e30e 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2205,6 +2205,16 @@ void __hci_abort_conn(struct hci_request *req, struc=
t hci_conn *conn,
 			 */
 			rej.reason =3D HCI_ERROR_REJ_LIMITED_RESOURCES;
=20
+			if (!lmp_esco_capable(conn->hdev)) {
+				/* If HCI_OP_REJECT_SYNC_CONN_REQ is not supported then use HCI_OP_REJ=
ECT_CONN_REQ */
+				struct hci_cp_reject_conn_req rej2;
+				bacpy(&rej2.bdaddr, &rej.bdaddr);
+				rej2.reason =3D rej.reason;
+				hci_req_add(req, HCI_OP_REJECT_CONN_REQ,
+					    sizeof(rej2), &rej2);
+				break;
+			}
+
 			hci_req_add(req, HCI_OP_REJECT_SYNC_CONN_REQ,
 				    sizeof(rej), &rej);
 		}
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 9a580999ca57..a3c5cae7a2a2 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -33,6 +33,39 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/sco.h>
=20
+static const struct bt_voice_setup voice_setup_cvsd =3D {
+	.features =3D BT_VOICE_SETUP_FEATURE_CONFIG | BT_VOICE_SETUP_FEATURE_ADD_=
SCO | BT_VOICE_SETUP_FEATURE_SETUP_SCO,
+	/* TODO: Add configuration for BT_VOICE_SETUP_FEATURE_ENH_SETUP_SCO */
+	.voice_setting =3D 0x0060,
+	.tx_bandwidth =3D 8000,
+	.rx_bandwidth =3D 8000,
+	.pkt_types_count =3D 7,
+	.pkt_types =3D {
+		{ BT_VOICE_PKT_TYPE_CAP_ESCO, 0x01, EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a }=
, /* S3 */
+		{ BT_VOICE_PKT_TYPE_CAP_ESCO, 0x01, EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007 }=
, /* S2 */
+		{ BT_VOICE_PKT_TYPE_CAP_ESCO, 0x01, EDR_ESCO_MASK | ESCO_EV3,   0x0007 }=
, /* S1 */
+		{ BT_VOICE_PKT_TYPE_CAP_ESCO, 0x01, EDR_ESCO_MASK | ESCO_HV3,   0xffff }=
, /* D1 */
+		{ BT_VOICE_PKT_TYPE_CAP_ESCO, 0x01, EDR_ESCO_MASK | ESCO_HV1,   0xffff }=
, /* D0 */
+		{ BT_VOICE_PKT_TYPE_CAP_ESCO, 0xff, EDR_ESCO_MASK | ESCO_HV3,   0xffff }=
, /* D1 */
+		{ BT_VOICE_PKT_TYPE_CAP_ESCO, 0xff, EDR_ESCO_MASK | ESCO_HV1,   0xffff }=
, /* D0 */
+		{ BT_VOICE_PKT_TYPE_CAP_SCO,  0xff, EDR_ESCO_MASK | ESCO_HV3,   0xffff }=
, /* D1 */
+		{ BT_VOICE_PKT_TYPE_CAP_SCO,  0xff, EDR_ESCO_MASK | ESCO_HV1,   0xffff }=
, /* D0 */
+	},
+};
+
+static const struct bt_voice_setup voice_setup_msbc =3D {
+	.features =3D BT_VOICE_SETUP_FEATURE_CONFIG | BT_VOICE_SETUP_FEATURE_SETU=
P_SCO,
+	/* TODO: Add configuration for BT_VOICE_SETUP_FEATURE_ENH_SETUP_SCO */
+	.voice_setting =3D 0x0003,
+	.tx_bandwidth =3D 8000,
+	.rx_bandwidth =3D 8000,
+	.pkt_types_count =3D 2,
+	.pkt_types =3D {
+		{ BT_VOICE_PKT_TYPE_CAP_ESCO, 0x02, EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d }=
, /* T2 */
+		{ BT_VOICE_PKT_TYPE_CAP_ESCO, 0x02, EDR_ESCO_MASK | ESCO_EV3,   0x0008 }=
, /* T1 */
+	},
+};
+
 static bool disable_esco;
=20
 static const struct proto_ops sco_sock_ops;
@@ -65,8 +98,8 @@ struct sco_pinfo {
 	bdaddr_t	src;
 	bdaddr_t	dst;
 	__u32		flags;
-	__u16		setting;
 	struct sco_conn	*conn;
+	struct bt_voice_setup *voice_setup;
 };
=20
 /* ---- SCO timers ---- */
@@ -231,14 +264,31 @@ static int sco_connect(struct sock *sk)
 	else
 		type =3D SCO_LINK;
=20
-	if (sco_pi(sk)->setting =3D=3D BT_VOICE_TRANSPARENT &&
-	    (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev))) {
-		err =3D -EOPNOTSUPP;
-		goto done;
+	/* If setsockopt BT_VOICE_SETUP was not called or called without addition=
al features then use default parameters from CVSD or mSBC codec based on vo=
ice_setting */
+	if (!sco_pi(sk)->voice_setup || !(sco_pi(sk)->voice_setup->features & BT_=
VOICE_SETUP_FEATURE_CONFIG) || !sco_pi(sk)->voice_setup->pkt_types_count) {
+		/* If setsockopt BT_VOICE or BT_VOICE_SETUP was not called then use glob=
al voice_setting */
+		__u16 voice_setting =3D sco_pi(sk)->voice_setup ? sco_pi(sk)->voice_setu=
p->voice_setting : hdev->voice_setting;
+		const struct bt_voice_setup *source_voice_setup =3D ((voice_setting & SC=
O_AIRMODE_MASK) =3D=3D SCO_AIRMODE_TRANSP) ? &voice_setup_msbc : &voice_set=
up_cvsd;
+		size_t voice_setup_size =3D sizeof(struct bt_voice_setup) + sizeof(struc=
t bt_voice_pkt_type)*source_voice_setup->pkt_types_count;
+		bool set_only_pkt_types =3D (sco_pi(sk)->voice_setup && (sco_pi(sk)->voi=
ce_setup->features & BT_VOICE_SETUP_FEATURE_CONFIG));
+		struct bt_voice_setup *new_voice_setup =3D krealloc(sco_pi(sk)->voice_se=
tup, voice_setup_size, GFP_KERNEL);
+		if (!new_voice_setup) {
+			err =3D -ENOMEM;
+			goto done;
+		}
+		sco_pi(sk)->voice_setup =3D new_voice_setup;
+		if (set_only_pkt_types) {
+			sco_pi(sk)->voice_setup->pkt_types_count =3D source_voice_setup->pkt_ty=
pes_count;
+			memcpy(sco_pi(sk)->voice_setup->pkt_types, source_voice_setup->pkt_type=
s, sizeof(struct bt_voice_pkt_type)*source_voice_setup->pkt_types_count);
+		} else {
+			memcpy(sco_pi(sk)->voice_setup, source_voice_setup, voice_setup_size);
+			memcpy(sco_pi(sk)->voice_setup, source_voice_setup, voice_setup_size);
+			sco_pi(sk)->voice_setup->voice_setting =3D voice_setting;
+		}
 	}
=20
 	hcon =3D hci_connect_sco(hdev, type, &sco_pi(sk)->dst,
-			       sco_pi(sk)->setting);
+			       sco_pi(sk)->voice_setup);
 	if (IS_ERR(hcon)) {
 		err =3D PTR_ERR(hcon);
 		goto done;
@@ -368,6 +418,7 @@ static void sco_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
=20
+	kfree(sco_pi(sk)->voice_setup);
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
 }
@@ -486,8 +537,6 @@ static struct sock *sco_sock_alloc(struct net *net, str=
uct socket *sock,
 	sk->sk_protocol =3D proto;
 	sk->sk_state    =3D BT_OPEN;
=20
-	sco_pi(sk)->setting =3D BT_VOICE_CVSD_16BIT;
-
 	timer_setup(&sk->sk_timer, sco_sock_timeout, 0);
=20
 	bt_sock_link(&sco_sk_list, sk);
@@ -724,47 +773,100 @@ static int sco_sock_sendmsg(struct socket *sock, str=
uct msghdr *msg,
 	return err;
 }
=20
-static void sco_conn_defer_accept(struct hci_conn *conn, u16 setting)
+static void sco_conn_defer_accept(struct hci_conn *conn, const struct bt_v=
oice_setup *voice_setup)
 {
 	struct hci_dev *hdev =3D conn->hdev;
+	bool can_use_add_sco =3D !(voice_setup && (voice_setup->features & BT_VOI=
CE_SETUP_FEATURE_CONFIG)) || (voice_setup->features & BT_VOICE_SETUP_FEATUR=
E_ADD_SCO);
+	bool can_use_setup_sco =3D lmp_esco_capable(hdev) && (!voice_setup || !(v=
oice_setup->features & BT_VOICE_SETUP_FEATURE_CONFIG) || (voice_setup->feat=
ures & BT_VOICE_SETUP_FEATURE_SETUP_SCO));
+	bool can_use_enh_setup_sco =3D false /* (hdev->commands[29] & BIT(4)) && =
(!voice_setup || !(voice_setup->features & BT_VOICE_SETUP_FEATURE_CONFIG) |=
| (voice_setup->features & BT_VOICE_SETUP_FEATURE_ENH_SETUP_SCO)) */ ; /* F=
IXME: Enhanced Setup Synchronous Connection is unimplemented */
=20
 	BT_DBG("conn %p", conn);
=20
 	conn->state =3D BT_CONFIG;
=20
-	if (!lmp_esco_capable(hdev)) {
+	if (voice_setup && !lmp_voice_setting_compatible(hdev, voice_setup->voice=
_setting)) {
+		/* TODO: Throw error about incompatible setup for accept() */
+	}
+
+	if (conn->type =3D=3D ESCO_LINK && disable_esco) {
+		/* TODO: Throw error about incompatible setup for accept() */
+	}
+
+	if (can_use_add_sco && !can_use_setup_sco && !can_use_enh_setup_sco) {
 		struct hci_cp_accept_conn_req cp;
=20
+		if (voice_setup && (voice_setup->voice_setting !=3D hdev->voice_setting)=
) {
+			/* TODO: Throw error about incompatible setup for accept() */
+		}
+
 		bacpy(&cp.bdaddr, &conn->dst);
 		cp.role =3D 0x00; /* Ignored */
=20
 		hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp), &cp);
-	} else {
+	} else if (can_use_setup_sco && !can_use_enh_setup_sco) {
 		struct hci_cp_accept_sync_conn_req cp;
+		const struct bt_voice_pkt_type *pkt_types;
+		unsigned int i, pkt_type_next, pkt_types_count;
=20
 		bacpy(&cp.bdaddr, &conn->dst);
 		cp.pkt_type =3D cpu_to_le16(conn->pkt_type);
=20
-		cp.tx_bandwidth   =3D cpu_to_le32(0x00001f40);
-		cp.rx_bandwidth   =3D cpu_to_le32(0x00001f40);
-		cp.content_format =3D cpu_to_le16(setting);
-
-		switch (setting & SCO_AIRMODE_MASK) {
-		case SCO_AIRMODE_TRANSP:
-			if (conn->pkt_type & ESCO_2EV3)
-				cp.max_latency =3D cpu_to_le16(0x0008);
+		if (!voice_setup) {
+			cp.content_format =3D cpu_to_le16(hdev->voice_setting);
+			if ((hdev->voice_setting & SCO_AIRMODE_MASK) =3D=3D SCO_AIRMODE_TRANSP)
+				voice_setup =3D &voice_setup_msbc;
 			else
-				cp.max_latency =3D cpu_to_le16(0x000D);
-			cp.retrans_effort =3D 0x02;
-			break;
-		case SCO_AIRMODE_CVSD:
-			cp.max_latency =3D cpu_to_le16(0xffff);
-			cp.retrans_effort =3D 0xff;
+				voice_setup =3D &voice_setup_cvsd;
+		} else {
+			cp.content_format =3D cpu_to_le16(voice_setup->voice_setting);
+		}
+
+		if (voice_setup->features & BT_VOICE_SETUP_FEATURE_CONFIG) {
+			cp.tx_bandwidth =3D cpu_to_le32(voice_setup->tx_bandwidth);
+			cp.rx_bandwidth =3D cpu_to_le32(voice_setup->rx_bandwidth);
+		} else if ((voice_setup->voice_setting & SCO_AIRMODE_MASK) =3D=3D SCO_AI=
RMODE_TRANSP) {
+			cp.tx_bandwidth =3D cpu_to_le32(voice_setup_msbc.tx_bandwidth);
+			cp.rx_bandwidth =3D cpu_to_le32(voice_setup_msbc.rx_bandwidth);
+		} else {
+			cp.tx_bandwidth =3D cpu_to_le32(voice_setup_cvsd.tx_bandwidth);
+			cp.rx_bandwidth =3D cpu_to_le32(voice_setup_cvsd.rx_bandwidth);
+		}
+
+		if ((voice_setup->features & BT_VOICE_SETUP_FEATURE_CONFIG) && voice_set=
up->pkt_types_count) {
+			pkt_types =3D voice_setup->pkt_types;
+			pkt_types_count =3D voice_setup->pkt_types_count;
+		} else if ((voice_setup->voice_setting & SCO_AIRMODE_MASK) =3D=3D SCO_AI=
RMODE_TRANSP) {
+			pkt_types =3D voice_setup_msbc.pkt_types;
+			pkt_types_count =3D voice_setup_msbc.pkt_types_count;
+		} else {
+			pkt_types =3D voice_setup_cvsd.pkt_types;
+			pkt_types_count =3D voice_setup_cvsd.pkt_types_count;
+		}
+
+		for (pkt_type_next =3D 0, i =3D 0; i < pkt_types_count; ++i) {
+			if (conn->type =3D=3D ESCO_LINK && !(pkt_types[i].capability & BT_VOICE=
_PKT_TYPE_CAP_ESCO))
+				continue;
+			if (conn->type =3D=3D SCO_LINK && !(pkt_types[i].capability & BT_VOICE_=
PKT_TYPE_CAP_SCO))
+				continue;
+			if (!pkt_type_next)
+				pkt_type_next =3D i;
+			if (!(pkt_types[i].pkt_type & conn->pkt_type))
+				continue;
 			break;
 		}
=20
+		if (i =3D=3D pkt_types_count)
+			i =3D pkt_type_next;
+
+		cp.max_latency =3D cpu_to_le16(pkt_types[i].max_latency);
+		cp.retrans_effort =3D pkt_types[i].retrans_effort;
+
 		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
 			     sizeof(cp), &cp);
+	} else if (can_use_enh_setup_sco) {
+		/* TODO */
+	} else {
+		/* TODO: Throw error about incompatible setup for accept() */
 	}
 }
=20
@@ -778,9 +880,7 @@ static int sco_sock_recvmsg(struct socket *sock, struct=
 msghdr *msg,
=20
 	if (sk->sk_state =3D=3D BT_CONNECT2 &&
 	    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
-		sco_conn_defer_accept(pi->conn->hcon, pi->setting);
-		sk->sk_state =3D BT_CONFIG;
-
+		sco_conn_defer_accept(pi->conn->hcon, pi->voice_setup);
 		release_sock(sk);
 		return 0;
 	}
@@ -794,8 +894,10 @@ static int sco_sock_setsockopt(struct socket *sock, in=
t level, int optname,
 			       char __user *optval, unsigned int optlen)
 {
 	struct sock *sk =3D sock->sk;
-	int len, err =3D 0;
+	int err =3D 0;
 	struct bt_voice voice;
+	char buffer[1536]; /* FIXME: max size */
+	struct bt_voice_setup *new_voice_setup;
 	u32 opt;
=20
 	BT_DBG("sk %p", sk);
@@ -828,22 +930,62 @@ static int sco_sock_setsockopt(struct socket *sock, i=
nt level, int optname,
 			break;
 		}
=20
-		voice.setting =3D sco_pi(sk)->setting;
+		if (optlen !=3D sizeof(voice)) {
+			err =3D -EINVAL;
+			break;
+		}
=20
-		len =3D min_t(unsigned int, sizeof(voice), optlen);
-		if (copy_from_user((char *)&voice, optval, len)) {
+		if (copy_from_user((char *)&voice, optval, optlen)) {
 			err =3D -EFAULT;
 			break;
 		}
=20
-		/* Explicitly check for these values */
-		if (voice.setting !=3D BT_VOICE_TRANSPARENT &&
-		    voice.setting !=3D BT_VOICE_CVSD_16BIT) {
+		if (!sco_pi(sk)->voice_setup) {
+			sco_pi(sk)->voice_setup =3D kzalloc(sizeof(struct bt_voice_setup), GFP_=
KERNEL);
+			if (!sco_pi(sk)->voice_setup) {
+				err =3D -ENOMEM;
+				break;
+			}
+		}
+
+		sco_pi(sk)->voice_setup->voice_setting =3D voice.setting;
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
+		/* FIXME: max size limit */
+		if (optlen < sizeof(struct bt_voice_setup) || (optlen-sizeof(struct bt_v=
oice_setup)) % sizeof(struct bt_voice_pkt_type) !=3D 0 || optlen > sizeof(b=
uffer)) {
+			err =3D -EINVAL;
+			break;
+		}
+
+		if (copy_from_user((char *)&buffer, optval, optlen)) {
+			err =3D -EFAULT;
+			break;
+		}
+
+		if (((struct bt_voice_setup *)&buffer)->pkt_types_count > (optlen - size=
of(struct bt_voice_setup)) / sizeof(struct bt_voice_pkt_type)) {
 			err =3D -EINVAL;
 			break;
 		}
=20
-		sco_pi(sk)->setting =3D voice.setting;
+		/* FIXME: should we check if disable_esco is set and in voice_setup is a=
t least one BT_VOICE_PKT_TYPE_CAP_SCO pkt_type? */
+
+		new_voice_setup =3D krealloc(sco_pi(sk)->voice_setup, optlen, GFP_KERNEL=
);
+		if (!new_voice_setup) {
+			err =3D -ENOMEM;
+			break;
+		}
+
+		memcpy(new_voice_setup, &buffer, optlen);
+		sco_pi(sk)->voice_setup =3D new_voice_setup;
+
 		break;
=20
 	default:
@@ -948,7 +1090,13 @@ static int sco_sock_getsockopt(struct socket *sock, i=
nt level, int optname,
 		break;
=20
 	case BT_VOICE:
-		voice.setting =3D sco_pi(sk)->setting;
+		/* When voice setting were not set then due to backward compatibility re=
turn something: either voice settings (if are available) or fallback to CVS=
D voice setting */
+		if (sco_pi(sk)->voice_setup)
+			voice.setting =3D sco_pi(sk)->voice_setup->voice_setting;
+		else if (sco_pi(sk)->conn)
+			voice.setting =3D sco_pi(sk)->conn->hcon->hdev->voice_setting;
+		else
+			voice.setting =3D voice_setup_cvsd.voice_setting;
=20
 		len =3D min_t(unsigned int, len, sizeof(voice));
 		if (copy_to_user(optval, (char *)&voice, len))
@@ -956,6 +1104,24 @@ static int sco_sock_getsockopt(struct socket *sock, i=
nt level, int optname,
=20
 		break;
=20
+	case BT_VOICE_SETUP:
+		if (sco_pi(sk)->voice_setup) {
+			len =3D min_t(unsigned int, len, sizeof(struct bt_voice_setup) + sizeof=
(struct bt_voice_pkt_type)*sco_pi(sk)->voice_setup->pkt_types_count);
+			if (copy_to_user(optval, (char *)sco_pi(sk)->voice_setup, len)) {
+				err =3D -EFAULT;
+				break;
+			}
+		} else {
+			len =3D 0;
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

--h4eu27lltioth4pn--

--syu3v4gdnyxk7gmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXdcTYAAKCRCL8Mk9A+RD
UnKQAKDIg69Vd4aJ0WeoTlaKHEra/QWC+QCgi9aAgA+/kANirh71k6k/vdWROUs=
=HEW+
-----END PGP SIGNATURE-----

--syu3v4gdnyxk7gmy--
