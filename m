Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC0EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 08:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DFEB6113E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 08:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhKJIt1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Nov 2021 03:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhKJIt0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Nov 2021 03:49:26 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FC7C061764
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Nov 2021 00:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Content-Transfer-Encoding:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=PCYCC/RNhg4ttYD7JWfkCiLe1ZfilOkWpVCjBf4N4Gs=; t=1636533999; x=1637743599; 
        b=MGmFWTWTDAgQX7ZkvgRWojZFs5XLsz39Rkw6NhxBGHLqMQK8MTlkvo3fTMmoZ05Bw9/yQ+wScnb
        BBwvjdUikisrveFa0bbgMzP+7n25dol2nAjDV6vQ1C7qdFHOv6gTP3fD43dflHGsC2m+qgcXJxucu
        sRRYZdIoycRjoek6Nbb4EV2D9h2gGmdUMn7ldWxXnYegijYCamw3eqxJTZTkzEUyaW+upVQFJtCMe
        2eX4AZNl5LEZXUKOPc3zg77hXd2Lj1xmHwRgnZ7Q4KlbzWkYr1bEg7rFd8nYCO4TmfYKt/ILHNIIG
        xDuqoKSw3HXFAKXnZZW9FwSz1yTKmsqIrCiw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1mkjFc-00DIMx-Ob;
        Wed, 10 Nov 2021 09:46:36 +0100
Message-ID: <cecf89520de89bfba231c80c5ddb6b357722d6de.camel@sipsolutions.net>
Subject: Re: [PATCH 3/4] Bluetooth: hci_core: Signal TX failure if sending a
 frame failed
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Wed, 10 Nov 2021 09:46:34 +0100
In-Reply-To: <CABBYNZJ2mXOTQygWWgHMN+pkqYoY_cudqrbW6aOHozo7soUZhA@mail.gmail.com>
References: <20211109164113.65981-1-benjamin@sipsolutions.net>
         <20211109164113.65981-4-benjamin@sipsolutions.net>
         <CABBYNZJ2mXOTQygWWgHMN+pkqYoY_cudqrbW6aOHozo7soUZhA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-2OgEd1UqSFlJdGIO03+U"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-malware-bazaar-2: OK
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--=-2OgEd1UqSFlJdGIO03+U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Tue, 2021-11-09 at 15:13 -0800, Luiz Augusto von Dentz wrote:
> Hi Benjamin,
>=20
> On Tue, Nov 9, 2021 at 2:35 PM Benjamin Berg <benjamin@sipsolutions.net> =
wrote:
> >=20
> > From: Benjamin Berg <bberg@redhat.com>
> >=20
> > Call the hci_tx_error handler in case a frame cannot be send.
> >=20
> > Signed-off-by: Benjamin Berg <bberg@redhat.com>
> > ---
> >  net/bluetooth/hci_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index bbb35188e41f..8664c2fbacdb 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -4200,6 +4200,8 @@ static void hci_send_frame(struct hci_dev *hdev, =
struct sk_buff *skb)
> >         if (err < 0) {
> >                 bt_dev_err(hdev, "sending frame failed (%d)", err);
> >                 kfree_skb(skb);
> > +
> > +               hci_tx_error(hdev, -err);
>=20
> Either we do this here by calling directly hci_cmd_sync_cancel like I
> suggested previously or perhaps we should have the error returned by
> hci_send_frame otherwise the current thread still has to wait to get
> the error from req_result which perhaps is not necessary if we already
> got a proper error here just return it so the thread doesn't even need
> to sleep.

Yes, returning the error is a good idea.

I think that means doing the cancellation from hci_cmd_work. As I
understand it, the frame is sent from the main workqueue so we are not
avoiding the context switches for now. But that may well change in the
future.

Benjamin

> >         }
> >  }
> >=20
> > --
> > 2.31.1
> >=20
>=20
>=20


--=-2OgEd1UqSFlJdGIO03+U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmGLhuoACgkQq6ZWhpmF
Y3DItxAAw3woaFDSlNhG18SrMfAXkzKXjXh99qa1fJGgeOzp8EwgJum4xFZUtz0P
V3tjifzAqYpyQC9o8Lfg+ygCxlHcWwhV0btlm00O1fV8AGH+Mtecw55fwnTS6BWc
H8MUXfhnXQukG6miimtUlwP47r4WkapuPNHV1yi7kb2yTVzeoHz+2sAiYcfiTgFi
uCCECyUAvmjRdyeUt8mXakMgoEWJAm9eqmH2J/F7y04Tt59UUuzLixj1gPCT5ANb
5pOr7GGT0Hdc69qNIxaijqTd5mT82eTQYjLPFQfnWTJvm6PNCabGdUjYewGeVhuI
1nnNF31cQODD2TLhbT3I8wFc+prfbeHhiuNx0Y7HwpzP2u0/BrcbeoxniraKhia8
2WoLA7t19ShAeJW3kaMZxNlBVkUgpOY9F5TzWEWuONPCpOInDGe0kkzk5oKK2/dM
V9MzNdkjOzUWJ4YkUC24OJmtagmfMpxWlWVt0MT7ny0qqpBfIpE3zWkIbbtim3Y1
8W1JG0WkM1M87YLb5ooMDzStkOhYUc8lq8SKMwnGFqMrGsqK7uxUBkrbDpzXd5aY
/O9OSBONY8OJJyiYkFn5fSWhRuGR9vKfqmT00uauX1C5qe/pdy+jKIrVYi6s4nUq
CkBrgCYbXHETk2gXWsZDAnAfRTVzbz6ywLehfgABlmdScHkjOd4=
=9nJ8
-----END PGP SIGNATURE-----

--=-2OgEd1UqSFlJdGIO03+U--

