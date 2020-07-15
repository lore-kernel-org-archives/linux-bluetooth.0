Return-Path: <SRS0=eiFZ=A2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7A1C433E4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 17:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9DA20656
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 17:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uuj0l0Os";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S2WOEQy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgGORmu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:42:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60933 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725861AbgGORmt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jul 2020 13:42:49 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EA4875C00B0;
        Wed, 15 Jul 2020 13:42:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 15 Jul 2020 13:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=TN1IJMQQ46HiqWTYBvVUnq4EMwJ
        ndD8JhUy8i6D0BcM=; b=Uuj0l0Osoe2YhvGcaDY28ahp/25GdTrq9QA3OmIKC3/
        GcAlqmdurAtp1DipmdOyCT88TrCXfqD1A5FZ12NCdPAaxTw9ghPtWDAoQv9ODhXM
        FOSH73UE4WKZNzDtplg3zbdsQaB4Unz/tU+imiFXQrWc9BaCZeSVwAv8uVclmo0b
        SCucYbgYKLMDVRm4DiSAa3c1dB1IH9DmNie8YERHgZungF8udAiJrY/scR4x9opy
        YtJ+PLhOYLn4ZCNA4/gFpwBC2esDwsS6l5D/vdvz5J398JKSsUnEqzdZfd62vgS2
        6uiH+pEfdBB/9b9m/G3BgmyYaoHg3ODQo9weRtdcPNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=TN1IJM
        QQ46HiqWTYBvVUnq4EMwJndD8JhUy8i6D0BcM=; b=S2WOEQy/mPQsf1N5W1dq+E
        bb0GwMKa7s66gnoPTx07lyINu0F2EDVKpfK3p/GcaJO1kNHW7UiCvFPk7bWvvpC0
        v8iHmCicXlW4PLkwcBHUyOeN8nyoyplrCSr7NIeEWVGq6mln2F22iZbBHfl6npFU
        WAAeWkBLB/raaPjzSVRPxPZHnkxF/+i1D5fEPk4QXEW78Kmj10RKtPQIW3dTXAbK
        ZEJtCvpQdbl6FzusjDkeS9VLg98QuimWZptm5C7ugK3aMLljWCwNUcLeZS4Yu+Hc
        pxvdi5gAaLtLQmufvxlb0uk7wyfFDFiN4qPiIj0+0Zuc6UrO1sDLb8bAZ5x8oHnw
        ==
X-ME-Sender: <xms:GEAPX8gxWgpPNzTALj3kvrwYMf-ZfQDAJNjC7SDVwWHTLI5QEoGDwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrfedvgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrgeekrdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:GEAPX1D-dg23EFNNbVKGjFHz8VUcF6zQrSi-kEP1-zGtDIAiGbjrLQ>
    <xmx:GEAPX0GARm0Hv3SZDIUK9nQfSbMBKn2dEzXP0O7wMXk7RsjSiCKTnA>
    <xmx:GEAPX9RtDr1sThF3lKlVek_vIpiMaIXQd-J7yglVGzb_waP9f5ubCQ>
    <xmx:GEAPX3YEcfAp84FTR0jkXVEoqB8lvRvL-2BysjDq4CGhUTZR5s1nbQ>
Received: from vm-mail.pks.im (x4e37301f.dyn.telefonica.de [78.55.48.31])
        by mail.messagingengine.com (Postfix) with ESMTPA id B80EB30600A6;
        Wed, 15 Jul 2020 13:42:47 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0ae5c766 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 15 Jul 2020 17:42:44 +0000 (UTC)
Date:   Wed, 15 Jul 2020 19:43:33 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH v2] Bluetooth: Fix update of connection state in
 `hci_encrypt_cfm`
Message-ID: <50fd2c75ce196196f879f8373555cc30bfc75154.1594834970.git.ps@pks.im>
References: <0df5bf3eac160de28b9493a8959510980a8a8e8b.1594803508.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <0df5bf3eac160de28b9493a8959510980a8a8e8b.1594803508.git.ps@pks.im>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Starting with the upgrade to v5.8-rc3, I've noticed I wasn't able to
connect to my Bluetooth headset properly anymore. While connecting to
the device would eventually succeed, bluetoothd seemed to be confused
about the current connection state where the state was flapping hence
and forth. Bisecting this issue led to commit 3ca44c16b0dc (Bluetooth:
Consolidate encryption handling in hci_encrypt_cfm, 2020-05-19), which
refactored `hci_encrypt_cfm` to also handle updating the connection
state.

The commit in question changed the code to call `hci_connect_cfm` inside
`hci_encrypt_cfm` and to change the connection state. But with the
conversion, we now only update the connection state if a status was set
already. In fact, the reverse should be true: the status should be
updated if no status is yet set. So let's fix the isuse by reversing the
condition.

Fixes: 3ca44c16b0dc ("Bluetooth: Consolidate encryption handling in hci_enc=
rypt_cfm")
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 include/net/bluetooth/hci_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_c=
ore.h
index cdd4f1db8670..da3728871e85 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1387,7 +1387,7 @@ static inline void hci_encrypt_cfm(struct hci_conn *c=
onn, __u8 status)
 	__u8 encrypt;
=20
 	if (conn->state =3D=3D BT_CONFIG) {
-		if (status)
+		if (!status)
 			conn->state =3D BT_CONNECTED;
=20
 		hci_connect_cfm(conn, status);
--=20
2.27.0


--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl8PQEQACgkQVbJhu7ck
PpS16g//UnlOVdhsGJy5NF7MOvpKO40nLapdxOc5qvJX37rTLkyE8GTfCKpkrHBf
XxJ1DOZWLOhqEEb0RX32L/JjuOCb+wUjAwx6+y6o7vXswFKUxxUlHRxHOGDafq6n
eD5NPcw9Lv1dSLvMzNfKVdD/hVgf1wy8Uj92SREcSob8Yzu48nrcovRYGHumhJ49
dg2XJ2a0UpnAxuwjPzcp87rChHCaAYb67yBrWokURVp34QHxjiBt4jM8hERMyD2O
BBXiJb7aODo3Wa4BFTZcHMBGraEjpgsrDe1tURBnkrn2MxaAawigwNnz4Q+KJS0S
dFUoOuhrcuNgzUGBNiY0efW7SbZ9pFO09hmCgcylb0TCxX28kpOfHX98ruxfdRbz
Z/5ayYtmQNQVQojY8TWpz8hoeLArMC8sfrK5eP6B0lpouiDBUVh+LTBrCchs+3Hv
OLe7HazD6pPPI6zX2uxLhbSzHld8aC9n088NUlwijCMENRXI30uQIYYioh2vJLsf
natq/0YZbWety2hJL1sTp6Ai0lXVpZ2yGyrI6CK+WA8J6GH7Y9Q/JJHCFHr7vcAo
5nlM9gMB4I0Hrww+DlRjFSepX7vhnZz0agD02JWQEgseEtT2cEIJz4PUg12bTvem
oe/ZHzjXUm8oKm5GI/7Z/sUEgzC77Et/IOjeyThNUkCQ3pyP7l4=
=U4vV
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
