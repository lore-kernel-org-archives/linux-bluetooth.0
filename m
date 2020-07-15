Return-Path: <SRS0=eiFZ=A2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FD4C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 08:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD5B20657
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 08:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mpAXdMG0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LCQWndut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgGOI7G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:59:06 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:60363 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729952AbgGOI7F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jul 2020 04:59:05 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5F74A39C;
        Wed, 15 Jul 2020 04:59:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 15 Jul 2020 04:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm1;
         bh=grCkdD2jWEA7onIL8+JQxWBTuTayEwlI232LXSaOf/A=; b=mpAXdMG0Axyw
        7CSwPzMx88d7FkwpGytvD0Nt4qW176ehshE47ZlSjcAc14Sz9Fxr1oMuXTU/YQiY
        rZWJFyrr43saTgNYN641JBdeSWNUvY8aVAPia8hr+9sc6XN6mZde/wWk0DUQn1WO
        PLCbHnZr/K6JYZtMH65OHImiFrIm75iaU6tLBlHWK93WjrJK4maYObdp1DxmQtyl
        6lsP3P7LE90eh82GX6myVgiZyHMd2CuSe7EiaVCtnm0FtVM15DYgpqX3A9S4DASG
        UVvGbTMiWOf4BAvogr+b/FSzQyVa9r+x55qipf7t9izza7dTm64UvORR3/AFeRIS
        ltofovgWiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=grCkdD2jWEA7onIL8+JQxWBTuTayE
        wlI232LXSaOf/A=; b=LCQWndutDSHn1WlTEgvmfS7WvXTuzsVVioHxWFxGBwplK
        Nhu12F+I1Gh1d7yJdhAbbAqs3wnKMB90B7gmFfmu6Ly1h84lr0rxYsB0ug7Q0m9K
        ufvhue16B4ilVugY31y+VPp/62DCruRY60cMrEgCpMpVeVyV9fV9VQzjvgj0kdcV
        xdRXRnLfXdftu7L7+z9/jZsG4PquegYqiP6hWIUjpQZLE8/ls0FHq8jUVI8eyZHl
        2Jc2OILFeajUWTSo9/YBy1WmjM0FUKBUR/b+EmnRhk1ePpJp8qFY42JFDYYyXhRT
        3eit3M1nWTvUA5n4os/Gn94b5CTjXlzD3ia5DmB6A==
X-ME-Sender: <xms:V8UOXwi5nTujcGzJ_3tkeZ58bn889prrRcEJzVsIimRao0IwmbbNqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrfedvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepje
    eifedvueelfffgjeduffdvgefhiefgjefgvddvfeduvefffeevfffhgfekieffnecukfhp
    peejkedrheehrdegkedrfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:V8UOX5AUu-HGzlGEKkOASqj9de61zssuzbqb4aFWEVOr_bf6EKYAow>
    <xmx:V8UOX4F5Qf2sVkNbTEnXhCHDo1bu5eEnBl1G2wRv68ak8uX97i1m4w>
    <xmx:V8UOXxQO2s14nv1Jeof1i6sv6HzVLqSsPyH8BIO-KJ5cNEP_w2fZ2w>
    <xmx:WMUOX7bl2SZNrON5kNka-NLYuo7SMwq6eaco_RQQGXpnNmRK9o4GOA>
Received: from vm-mail.pks.im (x4e37301f.dyn.telefonica.de [78.55.48.31])
        by mail.messagingengine.com (Postfix) with ESMTPA id B4EFB30600B2;
        Wed, 15 Jul 2020 04:59:02 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 4c2231ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 15 Jul 2020 08:58:58 +0000 (UTC)
Date:   Wed, 15 Jul 2020 10:59:47 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH] Bluetooth: Fix updating connecton state in `hci_encrypt_cfm`
Message-ID: <0df5bf3eac160de28b9493a8959510980a8a8e8b.1594803508.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Starting with the upgrade to v5.8-rc3, I've noticed I wasn't able to
connect to my Bluetooth headset properly anymore. While connecting to
the device would eventually succeed, bluetoothd seemed to be confused
about the current connection state where the state was flapping hence
and forth. Bisecting this issue led to commit 3ca44c16b0dc ("Bluetooth:
Consolidate encryption handling in hci_encrypt_cfm"), which refactored
`hci_encrypt_cfm` to also handle updating the connection state.

The commit in question changed the code to call `hci_connect_cfm` inside
`hci_encrypt_cfm` and updating the connection state. But the conversion
didn't keep old behaviour of when the connection state is updated, which
now causes us to not properly update it anymore.

Fix the issue by adding another parameter to the function that allows
callers to specify whether the connection state should be updated, which
allows us to restore previous behaviour.

Fixes: 3ca44c16b0dc ("Bluetooth: Consolidate encryption handling in hci_enc=
rypt_cfm")
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 include/net/bluetooth/hci_core.h | 4 ++--
 net/bluetooth/hci_event.c        | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_c=
ore.h
index cdd4f1db8670..9abcc4a89abc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1381,13 +1381,13 @@ static inline void hci_auth_cfm(struct hci_conn *co=
nn, __u8 status)
 		conn->security_cfm_cb(conn, status);
 }
=20
-static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
+static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status, __u=
8 update_state)
 {
 	struct hci_cb *cb;
 	__u8 encrypt;
=20
 	if (conn->state =3D=3D BT_CONFIG) {
-		if (status)
+		if (update_state)
 			conn->state =3D BT_CONNECTED;
=20
 		hci_connect_cfm(conn, status);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cfeaee347db3..483d35eda2f1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2931,7 +2931,7 @@ static void hci_auth_complete_evt(struct hci_dev *hde=
v, struct sk_buff *skb)
 				     &cp);
 		} else {
 			clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
-			hci_encrypt_cfm(conn, ev->status);
+			hci_encrypt_cfm(conn, ev->status, 0);
 		}
 	}
=20
@@ -3016,7 +3016,7 @@ static void read_enc_key_size_complete(struct hci_dev=
 *hdev, u8 status,
 		conn->enc_key_size =3D rp->key_size;
 	}
=20
-	hci_encrypt_cfm(conn, 0);
+	hci_encrypt_cfm(conn, 0, 1);
=20
 unlock:
 	hci_dev_unlock(hdev);
@@ -3134,7 +3134,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hd=
ev, struct sk_buff *skb)
 	}
=20
 notify:
-	hci_encrypt_cfm(conn, ev->status);
+	hci_encrypt_cfm(conn, ev->status, !ev->status);
=20
 unlock:
 	hci_dev_unlock(hdev);
--=20
2.27.0


--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl8OxYIACgkQVbJhu7ck
PpRjOxAAhU43UIvw1uWfrB0Sl/6And9SXbT580tLQWc33qgJrgKEAr4ec5bIX5c5
UsNgmtmzkmw2Ka1xgvBPr/g4TMC6UQOwdvi+nCYWVtjyDZ0cogkvAZQGyUg3Re74
xfrO/Ef9PMrpGE3RlnctiOlut2blCK6SyGM37KYFI7Ec/20GTlDmQlkBY0BkZlyL
d4VcwQQ5jtRXaT6YQOPghJP7ksohNA18QxP9DfUKYStZT9J5FW2XybsQF9Um5R7B
xPv3BtYIpmWB44/n1dhZCHd6Tk20uWnsLgD2L0/xRx4J8KMLVr4OtqhqijoVGL2O
TFGZNKvwb9YAN8HTxlqPDEBMv1nu5bPEAI9LUTIjcQZDPMxiNMTq1xesjoPuHeKu
g6sB8p9fDgT/n3FlcZZpshweechp1U5tFcqN/3wlsqWTBvk1cVrMsK6IHyMJH/WE
LB47DtyjLtMG8T41B545kTPccMRClPoQPohoBmFWS5JriAS+1pFAxs+EkUp8dDwT
u0H6QKfokFF0gyeYDlbz+YsdP68nq78YtWhjRb7fCmF7Vu7Q8AhUdosNRNcVgemM
b0vl/L7rh+Dgj2kNVXSsrb7VWfjcntyua4EMjemW8M+5bFT2MFWtyfA5wSg40X5F
QCSkF/HFKGy+0cTZHjQH/AVFeYMfkXxPoO9z8Jv5ROD5gn+4Zls=
=q2aI
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
