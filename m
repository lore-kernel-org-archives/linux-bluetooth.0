Return-Path: <SRS0=34D5=X2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110D6ECE587
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Oct 2019 12:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC0E2190F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Oct 2019 12:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbfJAM5X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:57:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:39620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732435AbfJAM5X (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Oct 2019 08:57:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3A6EAC18
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2019 12:57:21 +0000 (UTC)
Date:   Tue, 1 Oct 2019 14:57:21 +0200
From:   Matthias Gerstner <mgerstner@suse.de>
To:     linux-bluetooth@vger.kernel.org
Subject: bluez: NULL pointer dereference in bluetooth-meshd
 org.bluez.mesh.Network1.Join
Message-ID: <20191001125721.GE9771@f195.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

in the context of a review of the bluetooth-meshd D-Bus service [1] I
noticed a segmentation fault due to NULL pointer dereference. It can be
triggered in bluez version 5.51 via the following D-Bus call:

$ dbus-send --system --type=3Dmethod_call --print-reply \
  --dest=3Dorg.bluez.mesh /org/bluez/mesh org.bluez.mesh.Network1.Join \
  objpath:/org/gnome/DisplayManager \
  array:byte:1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16

After the D-Bus timeout the bluetooth-meshd will crash with the
following backtrace:

    node_init_cb (node=3D0x0, agent=3D0x0) at mesh/mesh.c:359
    359                     reply =3D dbus_error(join_pending->msg, MESH_ER=
ROR_FAILED,
    (gdb) bt
        user_data=3D0x5555555be170) at mesh/node.c:1760
        dbus=3D<optimized out>) at ell/dbus.c:216
        user_data=3D0x5555555a6e00) at ell/dbus.c:279
        user_data=3D0x5555555a7ef0) at ell/io.c:126
        at ell/main.c:642
        at mesh/main.c:205

The reason is probably that the `join_pending` data structure has
already been freed in a different function.

[1]: https://bugzilla.suse.com/show_bug.cgi?id=3D1151518

Cheers

Matthias

--=20
Matthias Gerstner <matthias.gerstner@suse.de>
Dipl.-Wirtsch.-Inf. (FH), Security Engineer
https://www.suse.com/security
Phone: +49 911 740 53 290
GPG Key ID: 0x14C405C971923553

SUSE Software Solutions Germany GmbH
HRB 247165, AG M=FCnchen
Gesch=E4ftsf=FChrer: Felix Imend=F6rffer

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE82oG1A8ab1eESZdjFMQFyXGSNVMFAl2TTTEACgkQFMQFyXGS
NVNciw//VYENl1TYJlpqy8XEydJi4jZEsRXdHHkZm02bLYXzn2RZOzJk1i7mOVpe
Akr/fnXTIB9oKYmK/zKSR3rAmqu/Dp8d7r5UMFsqfhjJ7We2EBLzojd0Ot/zaee5
WUylV/IS6A1a/iV1uFJzIQ2j1XZnPIc+xkMmIWrAntCe7zWqdPgAQOXeyCfOb9kz
MOA8D7v9h3jAg07i116QPal4FBWkvS+591378Y8PiRiy6LQJ1u1tjcBFyyFEVSn1
nWPFa/p4pIVea2+V0b4Qq4qXHt8on7Uu5cjLlETBVqfwVPGlOTBP1XXHvqgsa6gu
I+aeVlVcbPlGVQycuaUgqsyeHPoL16o1G9EfLody5mK54H20/NCzouLByX91GBbK
5CrjgrJHoaWrqCMosRwjcTHh7n5DS0eyw5azx512rohuW09XFVxwP6pSx6u8Ua70
cnWLgKGu7GG2zorpQ7zMyZr7Ono6wqGfwEcdP2ubhMXunNi6wg4FxjPXYgK/bkIT
PcSYWP10zFI3rOOO1iw4369e4lZlj2sRQVLyVXT4H7ErTew9IdWOl/JfkFpQPRhM
ZLu3RgeQjfk3uoIBS9dJMUSQhcX4TD6TbDa0OEYd0h7rdXLjLHjevap1R7CDfRWM
b2Bwge0mCDWbS3RbHXFTSttRfyd9i0pPMbfe8A6jnUdXEzDOYmw=
=19K4
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
