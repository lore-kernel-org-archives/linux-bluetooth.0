Return-Path: <SRS0=9IM7=WP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8390EC3A59B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 05:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC8F21852
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 05:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ICq+/7F2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbfHSF7S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:59:18 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:38726 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfHSF7S (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Aug 2019 01:59:18 -0400
X-Greylist: delayed 1425 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Aug 2019 01:59:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WbQtgzy5DrWhnvadq5frc9uWpB7Vi3D0inCzYgOrAVA=; b=ICq+/7F2MKdfEPIAE8de51/LT
        7CopgC7C89XNL29qBLe2h3stRkCeyv7r/wCFeRUh7H17Zk/zao11T2p3MhUSSa+VTmDHVOz4r7DLh
        Sm98VmQPwjnjbVQFGhzr+uzWhDsFJ1XRXQMkva6LVOluQiI0HRn31sCCWdigTyB1ero/0=;
Received: from hsvpn34.hotsplots.net ([176.74.57.181] helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hzaKJ-0002Qh-8a; Mon, 19 Aug 2019 07:35:31 +0200
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hyBMr-0003y2-J7; Thu, 15 Aug 2019 10:44:21 +0200
Date:   Thu, 15 Aug 2019 10:44:19 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     csonsino <csonsino@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/1] bluetooth: validate BLE connection interval updates
Message-ID: <20190815104419.161177fa@kemnade.info>
In-Reply-To: <138296C5-49FA-475D-9618-FC8D241B8823@holtmann.org>
References: <f9176553-d4d5-c2e0-ecd7-937cac0d8098@gmail.com>
        <138296C5-49FA-475D-9618-FC8D241B8823@holtmann.org>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0/wm7a4AECkZFPlvUVAk=jG"; protocol="application/pgp-signature"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--Sig_/0/wm7a4AECkZFPlvUVAk=jG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 6 Jul 2019 15:34:34 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Carey,
>=20
> > Problem: The Linux bluetooth stack yields complete control over the BLE
> > connection interval to the remote device.
> >=20
> > The Linux bluetooth stack provides access to the BLE connection interval
> > min and max values through /sys/kernel/debug/bluetooth/hci0/
> > conn_min_interval and /sys/kernel/debug/bluetooth/hci0/conn_max_interva=
l.
> > These values are used for initial BLE connections, but the remote device
> > has the ability to request a connection parameter update. In the event
> > that the remote side requests to change the connection interval, the Li=
nux
> > kernel currently only validates that the desired value is within the
> > acceptable range in the bluetooth specification (6 - 3200, correspondin=
g to
> > 7.5ms - 4000ms). There is currently no validation that the desired value
> > requested by the remote device is within the min/max limits specified in
> > the conn_min_interval/conn_max_interval configurations. This essentially
> > leads to Linux yielding complete control over the connection interval to
> > the remote device.
> >=20
> > The proposed patch adds a verification step to the connection parameter
> > update mechanism, ensuring that the desired value is within the min/max
> > bounds of the current connection. If the desired value is outside of the
> > current connection min/max values, then the connection parameter update
> > request is rejected and the negative response is returned to the remote
> > device. Recall that the initial connection is established using the loc=
al
> > conn_min_interval/conn_max_interval values, so this allows the Linux
> > administrator to retain control over the BLE connection interval.
> >=20
> > The one downside that I see is that the current default Linux values for
> > conn_min_interval and conn_max_interval typically correspond to 30ms and
> > 50ms respectively. If this change were accepted, then it is feasible th=
at
> > some devices would no longer be able to negotiate to their desired
> > connection interval values. This might be remedied by setting the defau=
lt
> > Linux conn_min_interval and conn_max_interval values to the widest
> > supported range (6 - 3200 / 7.5ms - 4000ms). This could lead to the same
> > behavior as the current implementation, where the remote device could
> > request to change the connection interval value to any value that is
> > permitted by the bluetooth specification, and Linux would accept the
> > desired value.
> >=20
> > Signed-off-by: Carey Sonsino <csonsino@gmail.com> =20
>=20
> patch has been applied to bluetooth-next tree.
>=20
There are devices which require low connection intervals for usable operati=
on,
e.g. BLE smartcard readers. having 30ms instead of 7.5ms means speed four t=
imes
lower.

Other devices might want to set the connection interval  to high values to =
save
power.

So if the device is not allowed to set the connection interval to such valu=
es,
how should the driver sitting on top of the gatt dbus interface of bluetoot=
hd
set such things?

The debugfs nodes are not necessarily available in distro kernels. Anything
sitting on top of gatt dbus interface does not have access to the connectio=
n handle
and cannot call hci_le_conn_update() to set things to nice values.

Using l2cap sockets instead of the dbus gatt interface is also not a viable=
 altenative
because it interferes with bluetoothd.

So IMHO this patch causes regressions and should be reverted.

Sorry for stepping out this late.

Regards,
Andreas

--Sig_/0/wm7a4AECkZFPlvUVAk=jG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl1VG2MACgkQl4jFM1s/
ye8NHxAAlBmgxN5V1adiofEggaQYZGboR+crJgLpHmlfZo7JjSdz4A9T04rUG/5i
i4t/kyFyKmzSXjc+YWr4JEA9EuA+goUMxuIhE4v+QhHDOZ+JSRd7GQnWBbVCOUw9
3VXc47389ZwhiDTUQAl3hHJY12q+nOfK9YJyicO8kI1vjlGonR96gid5PQtdlWzi
24SMkjfQRIPZ7C4kUuWshw+KaY5UPW/MIzYP6/Ot7re92UQpzVqDwZbwkVVqdgrE
EAB9PUjOjXuKijb5awezoM+hnnQOD94JjCzO1cqTbwjfMOr2o3N3vrfKOecPGVf8
xMH+VCZYd2R1f5toLVTjU4HI7lMA/j6qwNF+/6P2oC+YCInzl+4pbHAog/0rGKj1
sskhv4KK+T9soMKJXxCSSDayQjX6d8Pg9kasnmq7g2je6A+188DCp0plDGy9eWlM
ilrehTca+TWuhbWQ9ky4/o/iQ/pCT6QjN8iJ4hs0yj++Yl2WozKdp9mczJx+MJKD
X1chg2w9sLKpirvTXk8W7qW9D3CTMr3AG2DKwGWXVJF+YH58qU450FwdmrWxRDD9
EglXZdFYOBvLKwXeq66877NpWTXvPCrCLWOQ0S8LFDz/eHkCp0Z1H6KOXpwjZo6c
Jj/InjAhmAY2lOq6+vtvU0J0DY1Qqki/adJPoVwOpkFFa3kges0=
=SrE9
-----END PGP SIGNATURE-----

--Sig_/0/wm7a4AECkZFPlvUVAk=jG--
