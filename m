Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D658C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Nov 2021 09:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C3060E9B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Nov 2021 09:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhKDJhJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Nov 2021 05:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhKDJhI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Nov 2021 05:37:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF0AC061714;
        Thu,  4 Nov 2021 02:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Content-Transfer-Encoding:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=OPpNag35nq3f5jzKifHa8+MYq8ja7qLgXfeSwdatLt4=; t=1636018470; x=1637228070; 
        b=o1fkXhK/UwTWcgaah0Rk8CiyqvxL3L1Fg+7O9JmRPvqc+TwQiDP+tzyCVr3CJvvEOW4jfPLNY6V
        E9og1UEizSQN2ub5j76g57F1em26AKntQ3AigOedN1b3EtDg1OsTPKHGjpefeorHx/TnK1sm0ROV1
        RBfHZaBRn8LO0hDienMJMY+2QxgGZ6F4rU+gnjl5GJzxyhpbTue6/RGRrkazhOZHQ4bTe7vc5PWlv
        crNlMS8SYmk7SFRLOcBQSNcdCiRzGuXhIhmhx+agHGTOpFOq9rhDr1stMWuN/mz0aztEEadQ/abNn
        sjuMikfIHJVdjPM2mkTPXJ79BvPbd/CacO7Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1miZ8a-00As0y-PU;
        Thu, 04 Nov 2021 10:34:24 +0100
Message-ID: <fae44c06e8e8d24b21b60a096e7294bc37444b12.camel@sipsolutions.net>
Subject: Re: Userspace enumeration hang while btusb tries to load firmware
 of removed device
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org
Date:   Thu, 04 Nov 2021 10:34:22 +0100
In-Reply-To: <BCD95F43-3C6E-4B50-9228-9F2AD93BBBA4@holtmann.org>
References: <df021873788acdb64e1311289e9ca6dc3f169616.camel@sipsolutions.net>
         <20211103182303.GB1529362@rowland.harvard.edu>
         <BCD95F43-3C6E-4B50-9228-9F2AD93BBBA4@holtmann.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/EP9GhlX6OidL7rLeMc8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-malware-bazaar-2: OK
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--=-/EP9GhlX6OidL7rLeMc8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcel and Alan,

On Wed, 2021-11-03 at 20:31 +0100, Marcel Holtmann wrote:
> > I'm not familiar with the btusb driver, so someone on the=20
> > linux-bluetooth mailing list would have a better idea about this.=20
> > However, it does look as though btusb keeps the device locked during th=
e=20
> > entire 10-second period while it tries to send over the firmware, and i=
t=20
> > doesn't abort the procedure when it starts getting disconnection errors=
=20
> > but instead persists until a timeout expires.  Keeping the device locke=
d=20
> > would certainly block lsusb.
> >=20
> > In general, locking the device during a firmware upload seems like
> > the right thing to do -- you don't want extraneous transfers from
> > other processes messing up the firmware!  So overall, it appears that
> > the whole problem would be solved if the firmware transfer were
> > aborted as soon as the -ENODEV errors start appearing.
>=20
> the problem seems to be that we hitting HCI command timeout. So the
> firmware download is done via HCI commands. These commands are send
> to the transport driver btusb.c via hdev->send (as btusb_send_frame).
> This triggers the usb_submit_urb or queues them via data->deferred
> anchor. All this reports back the error properly except that nobody
> does anything with it.
>=20
> See hci_send_frame() last portion:
>=20
>         err =3D hdev->send(hdev, skb);                                   =
         =20
>         if (err < 0) {                                                   =
       =20
>                 bt_dev_err(hdev, "sending frame failed (%d)", err);      =
       =20
>                 kfree_skb(skb);                                          =
       =20
>         }
>=20
> And that is it. We are not checking for ENODEV or any error here.
> That means the failure of the HCI command gets only caught via the
> HCI command timeout. I don=E2=80=99t know how to do this yet, but you wou=
ld
> have to look there to fail HCI command right away instead of waiting
> for the timeout.

Hmm, true, I don't see a "sending frame failed" error message during
the firmware download though. You are right that this codepath is
loosing the error, but this does not seem to be the scenario we are
running into while loading the firmware. This error only happens later
on from the btintel_reset_to_bootloader function.

What seems to happen in the posted log is that the URB is initially
submitted just fine and the transfer errors out afterwards.
Unfortunately, the btusb_tx_complete is only used for statistics
(stat.err_tx is increased) and has no further error handling that could
abort the firmware upload.

Benjamin

--=-/EP9GhlX6OidL7rLeMc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmGDqR4ACgkQq6ZWhpmF
Y3BychAAhhFMMj35ScIRH8jiPNBevER5QhbsjsRfBPZdYJHdr3TDfKjG//cI1kvT
DMWMR5b1kqxumDzR1wPDYtBajYDUyfA46Lz1o/BvnGQK+wX2Qn4hzIcjUEfulhgt
PgEVFhpZcqCFKaPfLDZGWkg2hXDZ6IjIRecsFk0mhb7X/1JbYWET72wCN7fepjwy
aoMIPR61gzN3D7HOdADtwKTO9KlC68I5/HmUNqGCx/yC2lfaxi3Q/9brYgB14qlA
UXh0tBWSINli6Ob+Nadbsf5/WiCOTqjaK2QSUkzUOAiNeyvMqzbXe1ld6/9nimNp
wBiFJqp4shQiKP306GPONPyEgXJT2ncmx4N5db/MAMhm5shI9QMZpa4J6zOCEP/j
/RNqj+JZBT7UZNhS6pd9jabaBu+EtBLHcsLJzex7Fr7dlRpF4vhwFj2OBtq218hx
931JK2V3TxT+0iP286yUiVjXLE8xrT1gD5yM8/TA596Dix+Xzdb1h4G65BmQOArE
iWHKYgim519c0sB7Rw+GUysSs/F+9/Jmdu0XTpOdlAW90UnbFiw9ZzZSmvmRVwFB
rtZKWHe0M9YMNt+St+lpVKjm68LA94MAXvyrxgRApGu1yfiPfYGkvI1L8K6YCSpC
SAkbm8kv3tT90wQBWGidn4gI4Ogbzhs8LdFHLebOwwnoTZnebEc=
=Tora
-----END PGP SIGNATURE-----

--=-/EP9GhlX6OidL7rLeMc8--

