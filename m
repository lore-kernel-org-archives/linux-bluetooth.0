Return-Path: <SRS0=EGv/=VC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41619C5B57D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jul 2019 07:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B214921670
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jul 2019 07:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.in header.i=@phytec.in header.b="G1S+XdZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfGEHBD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jul 2019 03:01:03 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:62406 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfGEHBC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jul 2019 03:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.in; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.in; t=1562310061; x=1564902061;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AuLlZ7zAbVOzaA7+iV6q0y45tQK8OT1Izx2ZUdwQM30=;
        b=G1S+XdZoC62bl/s9W9bz95WV6JD2ds6GKHkTOC++ubTJ169r2qaqpP7d+mTRfnPp
        xUydMOuge2jWmSrzPK+9cEevfsPiWD1DMhLVjTi1hR88z8LPwatMw+I12u0qnsP1
        Ex8NuCbXeBBCfbHf26ir9ASWFqm6MCQfTwNscA+BOtQ=;
X-AuditID: c39127d2-193ff70000001aee-f9-5d1ef5ad150b
Received: from tumirnix.phytec.de (tumirnix.phytec.de [172.16.0.38])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 60.F0.06894.DA5FE1D5; Fri,  5 Jul 2019 09:01:01 +0200 (CEST)
MIME-Version: 1.0
X-Disclaimed: 1
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: <47E2CBA9-0E7D-46D7-AB94-E27B54AAE110@intel.com>
References: <47E2CBA9-0E7D-46D7-AB94-E27B54AAE110@intel.com>,
        <OFCEFD7E67.77A1AF25-ONC125842D.001694FD-C125842D.001694FE@phytec.de>
Subject: Re: Testing Bluetooth Mesh with python
From:   Mahaboob Nazeer SK <nazeer.m@phytec.in>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Jonas Remmert <J.Remmert@phytec.de>
Message-ID: <OFA0EEF328.803EDE57-ONC125842E.002572A3-C125842E.002668F9@phytec.de>
Date:   Fri, 5 Jul 2019 08:59:32 +0200
X-Mailer: Lotus Domino Web Server Release 9.0.1FP7 August  17, 2016
X-MIMETrack: Serialize by http on Tumirnix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 05.07.2019 08:59:32,
        Serialize complete at 05.07.2019 08:59:32,
        Serialize by Router on Tumirnix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 05.07.2019 08:59:32
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWyRoBBTXftV7lYg0frVCxWzFjNZjHnWh+z
        A5PH4j0vmTw+b5ILYIrisklJzcksSy3St0vgymg4NYe14DFPxYtZD9kbGOdxdTFyckgImEhs
        n9DF3MXIxSEksIdR4uL/dhaQBK+AoMTJmU9YIIr4JT79aWUDsYUFeCU2vZ3NCGJzCghJdFzt
        ZIWoEZOYsO4XM0TcVmJRy2cWiKGtjBLzl/9kh2jWl9i7bgtYEZuArsTKCw/BBokIqElcvH4A
        LM4skCfxd/J8ZogjAiXmrVkBtoBFQEXi+9Q97BDLnCUW/7kAtkBCoIFJ4tDjbUxdjBxAzeoS
        6+cJQczRlli28DXzBEbhWUj+mYVQNQtJ1QJG5lWMQrmZydmpRZnZegUZlSWpyXopqZsYgWF9
        eKL6pR2MfXM8DjEycTAeYpTgYFYS4f3+WyZWiDclsbIqtSg/vqg0J7X4EKM0B4uSOO8G3pIw
        IYH0xJLU7NTUgtQimCwTB6dUAyMnn6HAi98NS6KV1pY0nJ9bNcHlVdGxjcXT7ss1b5He+mmS
        8420c9z9OX+WX7SYdLifQb5eiSk48Igfd/zp/D/H/+8yM52ccsFh+h89Qz/z4me7GFea78+4
        msOZfKzEfhWb1M151a3PBVNmlJp0nhOJTfWrqb+4Pta/mXPmq3QWRgMFue23/iuxFGckGmox
        FxUnAgCEOz84WQIAAA==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

Thank you for that information.It's good to know.=20

Do you have any expected timeline like when this could=20
be pushed out.

--
Thanks






-----linux-bluetooth-owner@vger.kernel.org wrote: -----
To: Mahaboob Nazeer SK <nazeer.m@phytec.in>
From: "Gix, Brian"=20
Sent by: linux-bluetooth-owner@vger.kernel.org
Date: 07/05/2019 12:10AM
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Testing Bluetooth Mesh with python

Hello,

> On Jul 3, 2019, at 9:08 PM, Mahaboob Nazeer SK <nazeer.m@phytec.in> wrote:
>=20
> Hi,
>=20
> We are using Zephyr Mesh onoff example on nrf52 eval kit to test the Mesh=
 Functionality.For provisioning of the
> node we are using meshctl tool.
>=20
> But is there any other way to provision a node using a python script.I fo=
und a test-mesh script in the test folder=20
> of bluez stack ,but i was unable to provision and test a node with it.Cou=
ld you share a test procedure if any.

We are in the process of coding the Management1 D-Bus interface which inclu=
des many of the method calls required for Provisioner support.  The test-me=
sh python script does *not* work with the meshctl tool, which uses a GATT b=
ased architecture.

The D-Bus interface (as described in the doc/mesh-api.txt) works with the b=
luetooth-meshd daemon which is currently being built out, and it is entirel=
y built on Advertisement (non-GATT) based communication with other nodes.

The methods required for the Provisioner side are not quite ready to be pus=
hed out.


>=20
> --
> Thanks
>=20
>=20
>=20
>=20
>=20
