Return-Path: <SRS0=eiFZ=A2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC47EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 17:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5618E2065E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 17:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aCQb6+Sc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="irZhqlqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgGOR0D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:26:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33947 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726086AbgGOR0D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jul 2020 13:26:03 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C528A5C00AB;
        Wed, 15 Jul 2020 13:25:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 15 Jul 2020 13:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ZQI5LoCLf3kW9vPX1tZGQ/TqG6j
        hunp2LIK4dsOkaTA=; b=aCQb6+Sc6xn3Tje56M8sjEbcaIJSItsgz9PtvJ74z5P
        aXEFzYyYWQLol+xjzbP7lEriNFP/cyJLqvFvVSCD0xfSxgr9NHFErl7rCpERa1Dx
        SgR7aeeo+35X70HuHitLrAUuK2yHGqvUYGGNC59W8VhakospTKe5/rKn/yC6DuwZ
        Jdmbb2Tgp8Rs3LtzCKF8oSGVl1eTVaTVwohAzCk5CetQLUGPCacWCRYm6scPI9p3
        IHF7s5dncZ2WRGfAxci8L07xqMc3gtbgtOM7SzrgWAEmJylTijhLBj8XZujMRT8c
        8U3jtFgBLmpxoOZFtnghHYIxOwUkBFGZ3MLYn+N6/KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZQI5Lo
        CLf3kW9vPX1tZGQ/TqG6jhunp2LIK4dsOkaTA=; b=irZhqlquZOHw0Di+KuJL0A
        BWHJuFc6Rvgtp7F+MqmzTPJ4Qj5TgbFnxwLzdyrwHKMyp1ruFXUTzUSJfMRiwZXX
        Fd2paJZFTnCj5tVS8/xxSfVUmGI8Njyh1lPEKKKFPrrCd78PAjefJspvrk82vPbX
        7dVVJ95Ld/WmVZmFWxxrpmOnEcwv9Gj64vFNceAfuaCevGymPbxAYHXNnV0SOlO0
        NGvMw3fG31sdQWMAJ/jqd+CA7Wx7ddqLWGyBUePOQG3kRDOBJ4PEB9QvNGL+Xcoe
        DvGLpsTYRxSKELRe7ShshmyGJHaT/Sf9CuEIFKE0giTVAYyM/uKqQ3CxaLSVpHTA
        ==
X-ME-Sender: <xms:JzwPX6SkJslMzeaJgf6APT4C9TCuHVbbjw77zLpX7Xfb0PWs1TnbdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrfedvgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrgeekrdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:JzwPX_yNhaRokr4pAMh5To7nbOCFqk14gWmF1xxkUc-W2J1rymehfw>
    <xmx:JzwPX300Hm6uqeNHdlsAr4L39vu4fT4yINIl25pSBG6NfqC_Ak6LRg>
    <xmx:JzwPX2ATJBQMUn1WmQqGybdbB0GmVY0x-yQM_WLKVSqF221VoYSqjw>
    <xmx:JzwPX7Yq5ohGKjsNKUq5VbFvVq4jocDjhpdTrexjlqPF7VLwUuwB9w>
Received: from vm-mail.pks.im (x4e37301f.dyn.telefonica.de [78.55.48.31])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3C72B30600B1;
        Wed, 15 Jul 2020 13:25:58 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 77a62e29 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 15 Jul 2020 17:25:56 +0000 (UTC)
Date:   Wed, 15 Jul 2020 19:26:45 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH] Bluetooth: Fix updating connecton state in
 `hci_encrypt_cfm`
Message-ID: <20200715172645.GA825@ncase>
References: <0df5bf3eac160de28b9493a8959510980a8a8e8b.1594803508.git.ps@pks.im>
 <CABBYNZKixtkC30bwQG-Zx5E0i1+mTRhd+8c-ns5jGBh2yiszeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <CABBYNZKixtkC30bwQG-Zx5E0i1+mTRhd+8c-ns5jGBh2yiszeA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 08:40:05AM -0700, Luiz Augusto von Dentz wrote:
> Hi Patrick,
>=20
> On Wed, Jul 15, 2020 at 7:50 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > Starting with the upgrade to v5.8-rc3, I've noticed I wasn't able to
> > connect to my Bluetooth headset properly anymore. While connecting to
> > the device would eventually succeed, bluetoothd seemed to be confused
> > about the current connection state where the state was flapping hence
> > and forth. Bisecting this issue led to commit 3ca44c16b0dc ("Bluetooth:
> > Consolidate encryption handling in hci_encrypt_cfm"), which refactored
> > `hci_encrypt_cfm` to also handle updating the connection state.
> >
> > The commit in question changed the code to call `hci_connect_cfm` inside
> > `hci_encrypt_cfm` and updating the connection state. But the conversion
> > didn't keep old behaviour of when the connection state is updated, which
> > now causes us to not properly update it anymore.
> >
> > Fix the issue by adding another parameter to the function that allows
> > callers to specify whether the connection state should be updated, which
> > allows us to restore previous behaviour.
> >
> > Fixes: 3ca44c16b0dc ("Bluetooth: Consolidate encryption handling in hci=
_encrypt_cfm")
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  include/net/bluetooth/hci_core.h | 4 ++--
> >  net/bluetooth/hci_event.c        | 6 +++---
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index cdd4f1db8670..9abcc4a89abc 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1381,13 +1381,13 @@ static inline void hci_auth_cfm(struct hci_conn=
 *conn, __u8 status)
> >                 conn->security_cfm_cb(conn, status);
> >  }
> >
> > -static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
> > +static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,=
 __u8 update_state)
> >  {
> >         struct hci_cb *cb;
> >         __u8 encrypt;
> >
> >         if (conn->state =3D=3D BT_CONFIG) {
> > -               if (status)
> > +               if (update_state)
>=20
> The intent was actually to have if (!status) as it means the
> encryption has succeeded the state can be considered connected, so I
> wonder if we really need to introduce another parameter. Anyway as it
> is broken we need to come up with a fix rather quickly.

Yeah, I kind of figured that to be the case but wanted to go with the
"safe" fix of restoring old behaviour first. I'll test whether `if
(!status)` fixes the problem I'm seeing and will send a v2 in case it
does.

Patrick

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl8PPFQACgkQVbJhu7ck
PpQrNQ//d7HU+xTNhXl70rUrLEgRtk3kZg6N6wJEb72WLk6GgHEvmBj/uyuzl4cR
Yc/aB6HHShQArmsDOh044Duc3GlTiaDQbZfzzW+EDhU9fcpZEgan1rSPtYi6faKe
1YgY/CklRuOv2FAK0I64+Vt4CYGHsONzm/0I9b5qf89GA1qjMGTvQgRxMm0+vNu7
2AvTeRcBlCqEfVUz+mfada25AeiaPVbf8Rdr+tQ8K28LxM4KJoJrbpDZ/cDE9U4R
OVr13r2q7wTOnPKuXYMVwefL+w8EXMWC0H4HZP3GklrTUMWTyV3asmr/pLzyrKKo
tlLnB+eaW/E6YrRBPFXUoxBnG7if/Rt/Ez+C8PKbF3gyr+C2COknVkbswiMnHaZU
7blAUMsHzplaUJGsKKYPnclUvjVhgGii1NdGgG2F/D1spT8a+s6UfiZ0/tajvAE6
Vv8aBKgMd3GyOG2v04aYw4gcqfbeBW2Q27SHuhK2YRmAypfi/QhzkQlG6H0lk3BH
yZ1ZWOILa/qNpsd6nz/Q7Pl7GJ1WC9t3R9Oqj2D2nwhCqHlOElUpBIJtFLEIACTA
DkJ4CFlCPcarsFdEasAesw+Pq4T4O/o7VDYUJ4ViTuxXFjP+nLPan4oVBuC2ZieK
9qB31qLwjW/GNfMs6Qvsz5OtTa/hKLnCkNC8Pgb/DUqRDeIwVpE=
=G0oM
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
