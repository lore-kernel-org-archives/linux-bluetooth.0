Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986C4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Nov 2021 14:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81273611C3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Nov 2021 14:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhKDOYP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Nov 2021 10:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhKDOYK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Nov 2021 10:24:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43E7C061195;
        Thu,  4 Nov 2021 07:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Content-Transfer-Encoding:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=WN/ujEcHjPq3/eyCBRPoMjOxpmZhIyjhS0FG0tklxYs=; t=1636035568; x=1637245168; 
        b=Rfk3fE6jmgfrdntpO8GiIfu6xViU/14LsmrIf6/oXUU3SpeM4uREI4fSYRACdcxxkeNahGqIt5W
        AQM660hlPspShX6KttKrlQFESP/PHDkSgn8nbPX0x0n/8lS6s895bUCDzZoyiPg2O26IoDLOIhUhc
        xdcWqlA42D5Rfoy5/RW7KCHLOLYr4gtDQB6m3oXQgfAyYVFiyQYdaZ2K4bVb7IdQGDbA6HCzRsrMQ
        cnuDZTH8q9MMAHeXRObKKfoqOhj705UeRFzldxY/nPqZowSYDFa7eWiW/GrEwmV6AD48VnBnOYsgg
        jY6HrjKgvkWpTTrdsdizQGJnakTjk1objwog==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1midaM-00AxDe-D8;
        Thu, 04 Nov 2021 15:19:22 +0100
Message-ID: <3f318d3b8b03c6cde8a871e802689fa4e90107be.camel@sipsolutions.net>
Subject: Re: Userspace enumeration hang while btusb tries to load firmware
 of removed device
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Marcel Holtmann <marcel@holtmann.org>, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Date:   Thu, 04 Nov 2021 15:19:20 +0100
In-Reply-To: <20211104132828.GA1557201@rowland.harvard.edu>
References: <df021873788acdb64e1311289e9ca6dc3f169616.camel@sipsolutions.net>
         <20211103182303.GB1529362@rowland.harvard.edu>
         <BCD95F43-3C6E-4B50-9228-9F2AD93BBBA4@holtmann.org>
         <fae44c06e8e8d24b21b60a096e7294bc37444b12.camel@sipsolutions.net>
         <20211104132828.GA1557201@rowland.harvard.edu>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pu7SQGswM4zvicT9p32a"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-malware-bazaar-2: OK
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--=-pu7SQGswM4zvicT9p32a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-11-04 at 09:28 -0400, Alan Stern wrote:
> On Thu, Nov 04, 2021 at 10:34:22AM +0100, Benjamin Berg wrote:
> > Hi Marcel and Alan,
> >=20
> > On Wed, 2021-11-03 at 20:31 +0100, Marcel Holtmann wrote:
> > > > I'm not familiar with the btusb driver, so someone on the=20
> > > > linux-bluetooth mailing list would have a better idea about this.=
=20
> > > > However, it does look as though btusb keeps the device locked durin=
g the=20
> > > > entire 10-second period while it tries to send over the firmware, a=
nd it=20
> > > > doesn't abort the procedure when it starts getting disconnection er=
rors=20
> > > > but instead persists until a timeout expires.  Keeping the device l=
ocked=20
> > > > would certainly block lsusb.
> > > >=20
> > > > In general, locking the device during a firmware upload seems like
> > > > the right thing to do -- you don't want extraneous transfers from
> > > > other processes messing up the firmware!  So overall, it appears th=
at
> > > > the whole problem would be solved if the firmware transfer were
> > > > aborted as soon as the -ENODEV errors start appearing.
> > >=20
> > > the problem seems to be that we hitting HCI command timeout. So the
> > > firmware download is done via HCI commands. These commands are send
> > > to the transport driver btusb.c via hdev->send (as btusb_send_frame).
> > > This triggers the usb_submit_urb or queues them via data->deferred
> > > anchor. All this reports back the error properly except that nobody
> > > does anything with it.
> > >=20
> > > See hci_send_frame() last portion:
> > >=20
> > >         err =3D hdev->send(hdev, skb);                               =
             =20
> > >         if (err < 0) {                                               =
           =20
> > >                 bt_dev_err(hdev, "sending frame failed (%d)", err);  =
           =20
> > >                 kfree_skb(skb);                                      =
           =20
> > >         }
> > >=20
> > > And that is it. We are not checking for ENODEV or any error here.
> > > That means the failure of the HCI command gets only caught via the
> > > HCI command timeout. I don=E2=80=99t know how to do this yet, but you=
 would
> > > have to look there to fail HCI command right away instead of waiting
> > > for the timeout.
> >=20
> > Hmm, true, I don't see a "sending frame failed" error message during
> > the firmware download though.
>=20
> It is in the log you posted:
>=20
> [Mi Nov 3 11:55:23 2021] Bluetooth: hci0: Failed to send firmware data (-=
110)
> [Mi Nov 3 11:55:23 2021] Bluetooth: hci0: sending frame failed (-19)
>=20
> But this occurred after the timeout, so maybe you had in mind something=
=20
> occurring earlier.

Yep, that one happens when the driver tries to reset the device. We
need to catch the error earlier in order to avoid the 10s wait.

> >  You are right that this codepath is
> > loosing the error, but this does not seem to be the scenario we are
> > running into while loading the firmware. This error only happens later
> > on from the btintel_reset_to_bootloader function.
> >=20
> > What seems to happen in the posted log is that the URB is initially
> > submitted just fine and the transfer errors out afterwards.
> > Unfortunately, the btusb_tx_complete is only used for statistics
> > (stat.err_tx is increased) and has no further error handling that could
> > abort the firmware upload.
>=20
> While detecting the errors during URB completion would be nice, it isn't=
=20
> necessary.  Things would work just as well if the disconnect error were=
=20
> detected during submission of the following URB.

Ah, good point. The in-flight interrupt URB responsible of retrieving
the event from the device will fail. It should be sufficient to inject
a hardware error event at that point in order to fix this.

As such, a simple solution may be to call hci_reset_dev from inside
btusb_intr_complete and btusb_submit_intr_urb when the URB submission
fails (for "err !=3D -EPERM").

Benjamin

--=-pu7SQGswM4zvicT9p32a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmGD6+gACgkQq6ZWhpmF
Y3AkQhAAzRq4lXZtxK94NtTtW9Ttz29oPk7qz6F+KCukh2FnOXbWUGe9RoymEDto
fukQ7nbAtR13+oEQS7kxgFLzlKug8eYAAm4Zl33n1tHaEj/XZFXnwLhEUsInre0w
Mo8OQ+WveebOtyrfSSaFH/kTVqr0Vjin6bcSZs/A3rQCgJVDuiU2l4qf41FhKSEk
H2U7xtvq8vEjrXNMLjb3amaHBkt1SP3pDulf6vSd7ZmLoVrql8g2668634oiMM0R
iLkS+b6zqOwy+p6BLP8QNzCDAQ2tdTuQuAD/6WJyoHqDAyw847mfmMOTxEhJqi7w
yMz/EIBrlJItc2eL+jNRdlmEnvXZEIo8Jhgu8mR+dzAr4IK6F1aebhz7xC60tVDF
qqyvneRxKxae8TvRvJX4Krm0QyDzSPRmsiVjOC548MauIr5V0SPsMFCiULM1GiBC
a3U2JuW0vkCtO6gh1c50PUbDxv89LC+EogTf7fCEIuYLvW8J9rtnXJgm8XMlmHZe
C3w5jOIK1PWKaQg4ZjpNe2XSB411SfPLc/bhzpKrAsMVzPMRmwsB3rrZ+yKSfJYQ
wFeVK1SSzksWNdakTGuQUCPJeGFxdHzgcG+6eH0Tjn2EsmjeQfM43aiOnSORM90W
LUMuFq6XxxlTaGTDMV4XUl36e88SnXl8JehB4OQJJvTzhIrcVsM=
=WDUA
-----END PGP SIGNATURE-----

--=-pu7SQGswM4zvicT9p32a--

