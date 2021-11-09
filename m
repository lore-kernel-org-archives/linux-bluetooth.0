Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643C8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 17:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE6961152
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 17:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240708AbhKIRGn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 12:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239427AbhKIRGm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 12:06:42 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEFFC061764;
        Tue,  9 Nov 2021 09:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Content-Transfer-Encoding:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=4ZefLbsNKRWIJeD/uc4IHUZbZRNto2H4EeJCNxjeN1k=; t=1636477436; x=1637687036; 
        b=Ef2ORtNj/IJpaCmraDm3mwymqpK6VT/SnG19OVTzoU5hiOCXjPJlCcpGQqV7NHaQqsdnTIunWf9
        LI74SHqp/i2lsdFy6J24TQMrm2wCP1OUmn3Y3fPAjx811LLXF3Y9/NmZr8ybuAn7tNoxfjDIY89x8
        l6bwMmrSmUEudJsjaOSRgd1/qTGPsjQYP27b6m8mWRAOadr14PAQOXJaN+3cuCRinSTopBckh1TsU
        WWDLOV+KYzO5ubqOZgmjfADRPygWvReDnwyL9KEaAwo98a6oA/URDZDQi/7uKFK4AOiXsr3FBJ+2w
        JU/bB1Ict0KeZ/Vf6LvUoIt/tEtOyBE3io/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1mkUXH-00D227-Ev;
        Tue, 09 Nov 2021 18:03:51 +0100
Message-ID: <76ff2cb3f687fdf0ca271fe0fe084371c4288c33.camel@sipsolutions.net>
Subject: Re: Userspace enumeration hang while btusb tries to load firmware
 of removed device
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org
Date:   Tue, 09 Nov 2021 18:03:48 +0100
In-Reply-To: <20211103201138.GC1529362@rowland.harvard.edu>
References: <df021873788acdb64e1311289e9ca6dc3f169616.camel@sipsolutions.net>
         <20211103182303.GB1529362@rowland.harvard.edu>
         <BCD95F43-3C6E-4B50-9228-9F2AD93BBBA4@holtmann.org>
         <20211103201138.GC1529362@rowland.harvard.edu>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-s4OlCZHD6ZVRueWwyarj"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-malware-bazaar-2: OK
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--=-s4OlCZHD6ZVRueWwyarj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2021-11-03 at 16:11 -0400, Alan Stern wrote:
> On Wed, Nov 03, 2021 at 08:31:03PM +0100, Marcel Holtmann wrote:
> > the problem seems to be that we hitting HCI command timeout. So the=20
> > firmware download is done via HCI commands. These commands are send to=
=20
> > the transport driver btusb.c via hdev->send (as btusb_send_frame).=20
> > This triggers the usb_submit_urb or queues them via data->deferred=20
> > anchor. All this reports back the error properly except that nobody=20
> > does anything with it.
> >=20
> > See hci_send_frame() last portion:
> >=20
> >         err =3D hdev->send(hdev, skb);
> >         if (err < 0) {
> >                 bt_dev_err(hdev, "sending frame failed (%d)", err);
> >                 kfree_skb(skb);
> >         }
> >=20
> > And that is it. We are not checking for ENODEV or any error here. That=
=20
> > means the failure of the HCI command gets only caught via the HCI=20
> > command timeout. I don=E2=80=99t know how to do this yet, but you would=
 have=20
> > to look there to fail HCI command right away instead of waiting for=20
> > the timeout.
>=20
> I have no idea how all the different layers work here.  Clearly=20
> something has to signal hdev->req_wait_q after setting hdev->req_status=
=20
> to some appropriate value.  Can this be done in btusb.c, either when the=
=20
> URB is submitted or when it completes?  Or in hci_send_frame?

I submitted
  https://patchwork.kernel.org/project/bluetooth/list/?series=3D577565
for this now.

The patchset pretty much calls hci_req_sync_cancel to set req_status
and signal req_wait_q. Doing this and hooking it up in various location
appears to work reasonably well for the synchronous commands.

Benjamin

PS: The user now reported that TLP is blocking the rfkill switch after
resume. So an good workaround is to just not use TLP.

--=-s4OlCZHD6ZVRueWwyarj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmGKqfQACgkQq6ZWhpmF
Y3BO8g/+J5w8LRcVVM8jUDu+KP+kJhy9bOXENEmanf2j2QgnMY1nOi/E/VYnQ/jC
DGFxp49Y/SIDpFOvjQ+xOd9/Q22kiN6Uyz1m1/jV0ubBpkb0FxueoIdl1Kq/vSgF
sZSVGSNJrNMSgd9NSi1MyZiWI5mm02nSy/XOCrQGNn5qgmIUAYteuRz4x815Hqqd
ibelL1P5pGVwD19dKSRCH0aW7u4KWrhBKlcMtyOo1RmLQaJZ2bmAtBZoIiENEYTf
Uqs5EqPFuHLIBWX6hi4wl2r/1XwGNrWQTU9+zmCIDvs9F7NMW6jv36O+686lqSI2
H0SYV/wOvCM3mzWsCZ06rbRo2v33UhTwlp7w9z8zFPjtNRpz9eWEGFbiyZJWhwha
8HPR66UmkP9dycJfO4bXg63hKes9HQmMfI8PYHs5Hgw4vOnpIUg7a6WSGo2Ql/ae
f7d0en34fS0oOW20QEth8g/R3lUjOP9xdoT7XfN8o19yjY8GDHJ5j1RpzISzG7se
peCyOWQxsIMkbgLfz0kboB52J4QTBAQnPXrodOl5GiEU8nzveOvEJDjEJ/97invr
svpq4IHz1ztjsf5Fs2G77Fwsr9e6DvFJYhzDU7U5gZ/Bl7YprVWP5O9XU2Ek5Uaz
AZdAcKcHME5g23jE6FGPAy0XFEm+Vb/rxXDq8Pwmyb5SrlCAMtA=
=uOcD
-----END PGP SIGNATURE-----

--=-s4OlCZHD6ZVRueWwyarj--

