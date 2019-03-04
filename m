Return-Path: <SRS0=2QA5=RH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274A8C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Mar 2019 13:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B6B20661
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Mar 2019 13:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfCDNhF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:37:05 -0500
Received: from mail.interlinx.bc.ca ([69.165.217.196]:55240 "EHLO
        server.interlinx.bc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfCDNhF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Mar 2019 08:37:05 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Mar 2019 08:37:05 EST
Received: from pc.interlinx.bc.ca (pc.interlinx.bc.ca [IPv6:fd31:aeb1:48df:0:3b14:e643:83d8:7017])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by server.interlinx.bc.ca (Postfix) with ESMTPSA id 6C6962222E
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2019 08:28:42 -0500 (EST)
Message-ID: <bb9cbbe3c6d5cafc8617e570ccd6432d4f7343e1.camel@interlinx.bc.ca>
Subject: always need to disconnect and then reconnect to get HFP functional
From:   "Brian J. Murrell" <brian@interlinx.bc.ca>
To:     linux-bluetooth@vger.kernel.org
Date:   Mon, 04 Mar 2019 08:28:41 -0500
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-epwlssRSHT49gTY6DiXj"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--=-epwlssRSHT49gTY6DiXj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi.

I'm using bluez 5.50 on the Fedora 29 4.200.6 kernel with a Jabra
Extreme2 headset.

I can always end up getting it working but it takes a bit of rigmarole.

Using bluetoothctl, when I power the headset on I get this:

[CHG] Device 50:C9:71:83:EC:70 Connected: yes

But at this point only the A2DP profile is usable.  I can switch to HFP
(i.e. using pavucontrol) but the headset is not visible as a device to
which I can change a recording device.  The "Monitor" for it is there,
but not the regular entry.

In order to rectify this I have to do the following:

[Jabra EXTREME2 v4.14.0]# disconnect 50:C9:71:83:EC:70
Attempting to disconnect from 50:C9:71:83:EC:70
Successful disconnected
[CHG] Device 50:C9:71:83:EC:70 Connected: no
[bluetooth]# connect 50:C9:71:83:EC:70
Attempting to connect to 50:C9:71:83:EC:70
Failed to connect: org.bluez.Error.Failed
[bluetooth]# connect 50:C9:71:83:EC:70
Attempting to connect to 50:C9:71:83:EC:70
Failed to connect: org.bluez.Error.Failed
[bluetooth]# connect 50:C9:71:83:EC:70
Attempting to connect to 50:C9:71:83:EC:70
[CHG] Device 50:C9:71:83:EC:70 Connected: yes
Connection successful
[CHG] Device 50:C9:71:83:EC:70 ServicesResolved: yes
[Jabra EXTREME2 v4.14.0]#=20

At this point, I can now see the headset as an option in the device
selection for an application listed in the Recording tab of
pavucontrol.

I have to go through this same rigmarole *every* single time I power on
the headset, so surely this has to be fixable.

Any ideas?  More information I can provide, etc.

Cheers,
b.


--=-epwlssRSHT49gTY6DiXj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8B/A+mOVz5cTNBuZ2sHQNBbLyKAFAlx9KAkACgkQ2sHQNBbL
yKCq8ggAmH3LAM/LjryaNH/XQ3tdQTT22YGI1bg30lg5cJ5Mz6XrBmeAFrcW6DYw
d15Cg44NcRa4+RinQTUwP1pGx6tEO4BctMvlo/JZUS0siY34aburvOOUWQe6Xzqm
dUpQMkPWmfCdZ2Dt7YYj8DvQjmAS+Bg3TiPqVBI579IeXTdYDVMVHocyPqLHqtW5
pWY65u9vmkOiKDhuAmhk50XwYI29QRu7bl5TGPaR/bjAgQ3IZWoiRqY3BbR3312n
g7Yksq1p+6gMNkcTRi8YvYmexIxN6dNelrBTEjLnTZvwQ1D+x0q+inT1WQ4ReWQi
zAYb68KPHz06WMJNn5F7aUQe39hAQw==
=XRai
-----END PGP SIGNATURE-----

--=-epwlssRSHT49gTY6DiXj--

