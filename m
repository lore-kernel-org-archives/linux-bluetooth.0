Return-Path: <SRS0=OOew=SS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC333C10F13
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Apr 2019 19:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CDF206BA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Apr 2019 19:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfDPTcp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:32:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42590 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPTco (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Apr 2019 15:32:44 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id EF266808B6; Tue, 16 Apr 2019 21:32:33 +0200 (CEST)
Date:   Tue, 16 Apr 2019 21:32:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     linux-bluetooth@vger.kernel.org
Subject: Gatt server with random address does not work (everything is ok with
 public address)
Message-ID: <20190416193241.GA10277@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I adapted example-gatt-server for a project... and it works ok
(thanks), as long as public address is used. I could not configure
random address in main.conf, so I'm doing it with btmgmt:

#!/bin/bash
(
    echo power off
    sleep .1
    echo le on
    sleep .1
    echo bredr off
    sleep .1
    echo static-addr c2:34:56:78:90:ab
    #echo public-addr 00:1A:7D:DA:71:11
    #echo static-addr c2:34:56:78:90:ab
    sleep .1
    echo connectable on
    sleep .1
    echo pairable on
    sleep .1
#    echo discov on
    sleep .1
#    echo advertising on
    sleep .1
    sleep .1
    echo power on
) | sudo ../bluez/tools/btmgmt
sleep 2

With random address, it does not work: lescan from other machine
detects right address, and I can connect, but that's it, services
can't be listed.

I'm using 4.19 kernel on one side and current -next on the other side,
with bluez e4cf43fc62b4e4dbabc72d4e44e095d7a9087992, Fri Sep 7
16:25:44 2018.

And it seems I'm not the only one having this problem:
https://stackoverflow.com/questions/50707914/setup-bluez-gatt-server-with-r=
andom-address

Any ideas how to debug that? Does configuration with random address
work for you? Is there chance update to latest versions helps?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAly2LdkACgkQMOfwapXb+vIYlQCfeFqeHowBppu1no01FCefLnTP
+N4AoJr/uyDU+DMmdvlo2frKxANG5MHv
=MWyS
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
