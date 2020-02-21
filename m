Return-Path: <SRS0=Dxuj=4J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCD4C35640
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Feb 2020 09:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C2C207FD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Feb 2020 09:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.in header.i=@phytec.in header.b="OSYwSUpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgBUJoV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:44:21 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:45852 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgBUJoV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Feb 2020 04:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.in; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.in; t=1582278260; x=1584870260;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JPFRN8ed/TOwqYtL3M0bijRVUv6sG3iZse74zf/mTuE=;
        b=OSYwSUpCohcjw+ai7nzhfeLYuPQQdcGUbH0jWxtJGSIGDeUY1Eu7xasu7jZU1lB6
        CGbeRjktWVbeMJGpLIJ1tad6xmNe33rYhI3RVU/71nS5Tj1M5uCXALQpmPFmmHl9
        2X2anafmQSexeaWDYAow8trU8xoCo8lyFxaSTPoFdEs=;
X-AuditID: c39127d2-06fff70000001a8a-ab-5e4fa673a50a
Received: from tumirnix.phytec.de (tumirnix.phytec.de [172.16.0.38])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 37.59.06794.376AF4E5; Fri, 21 Feb 2020 10:44:19 +0100 (CET)
X-Disclaimed: 1
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: <e9577a1d890c83da99c8dcc2908fff680c9ecb7e.camel@intel.com>
References: <e9577a1d890c83da99c8dcc2908fff680c9ecb7e.camel@intel.com>,
        <OF2849A126.CB6B1F2C-ONC1258514.0028F058-C1258514.0028F05A@phytec.de>
Subject: Re: mesh-cfgclient Node is not attached
From:   Mahaboob Nazeer SK <nazeer.m@phytec.in>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-ID: <OFA1C38C14.B5366C1E-ONC1258515.00350A6C-C1258515.00350A6E@phytec.de>
Date:   Fri, 21 Feb 2020 10:39:20 +0100
X-Mailer: Lotus Domino Web Server Release 9.0.1FP7 August  17, 2016
X-MIMETrack: Serialize by http on Tumirnix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 21.02.2020 10:39:20,
        Serialize complete at 21.02.2020 10:39:20,
        Serialize by Router on Tumirnix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 21.02.2020 10:39:20
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWyRoBBTbd4mX+cQc9vG4sVM1azWcy51sfs
        wOSxeM9LJo/Pm+QCmKK4bFJSczLLUov07RK4MqZsOctY8ECgYv2FxcwNjCd4uxg5OSQETCRu
        b//G2MXIxSEksJtR4v6uv4wQCX6JT39a2UBsXgFBiZMzn7CA2MICvBKb3s4Gq+EUEJLouNrJ
        ClEvJjFh3S9miLi7xNGHR5khhvYzShxtWskE0WwgsWveMrAiNgFdiZUXHoINEhFQk7h4/QBY
        nBmoef/8rywQiwMles+dZAexWQRUJbZuvswGscxZYvGfCywgCyQEGpgk5t/9BeRwADWrS6yf
        JwQxR1ti2cLXzBMYhWch+WEWQtUsJFULGJlXMQrlZiZnpxZlZusVZFSWpCbrpaRuYgSG9eGJ
        6pd2MPbN8TjEyMTBeIhRgoNZSYRXjccvTog3JbGyKrUoP76oNCe1+BCjNAeLkjjvBt6SMCGB
        9MSS1OzU1ILUIpgsEwenVAPjbJ5+ttM3fVf/z3ohc/Nu66uV3ho+L3X3+n3W+WsdE1ix4yCH
        1DUfUdbggxyHT97V4XG3v2gbI3Xo1LFyRSFtobNZ4X63Xvv4XC/5vXJGzJ4LYrE1H3wiNJU/
        zw22ET34itXs9T73esPu60sF3NjmbWFy8jw/jduQfWLycoGH/hs9orhd0yqVWIozEg21mIuK
        EwEmKNImWQIAAA==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

That was helpful. Its working now,i am able to=20
discover the unprovisioned nodes.

Thank you.


-----linux-bluetooth-owner@vger.kernel.org wrote: -----
To: "nazeer.m@phytec.in" <nazeer.m@phytec.in>, "linux-bluetooth@vger.kernel=
.org" <linux-bluetooth@vger.kernel.org>
From: "Gix, Brian"=20
Sent by: linux-bluetooth-owner@vger.kernel.org
Date: 02/21/2020 12:25AM
Subject: Re: mesh-cfgclient Node is not attached

Hi Mr Nazeer,

On Thu, 2020-02-20 at 08:27 +0100, Mahaboob Nazeer SK wrote:
> Hi,
>=20
> I was trying to provision a node using a mesh-cfgclient.
>=20
> I have successfully ran create and i was able to get configuration=20
> files in the .config.
>=20
> [mesh-cfgclient]# create=20
> Mesh network configuration exists (/home/nazeer/.config/meshcfg/config=5F=
db.json)
>=20
> After that i have tried to discover the unprovisioned node but i get=20
> Node is not attached message.
>=20
> [mesh-cfgclient]# discover-unprovisioned on
> Node is not attached
> [mesh-cfgclient]#

The problem you describe is probably due to the daemon not finding an appro=
priate BT controller to attach to.=20
This led to the "Attach" failing after the "Create", and then none of the c=
ommands to the node are able to be
sent.


There are a couple of options here:

1. If you have a single BT Controller (v4 or newer) you will need to disabl=
e the main bluetooth daemon so that
the bluetooth-meshd daemon has access to it:
$ sudo systemctl disable bluetooth
$ sudo systemctl stop bluetooth

2. If you have *multiple* BT controllers, make sure the bluetooth daemon ha=
sn't automatically claimed them all:
In /etc/bluetooth/main.conf, make sure AutoEnable=3Dfalse (reboot may then =
be required)


In the future, we will be doing work to enable co-existance and controller =
sharing for single controller
systems. However, this will require some changes in the kernel.


>=20
> Could you please let me know if weather there are some=20
> more steps involved to discover and provision a node or if am missing som=
ethings.
>=20
> Thank you.

Regards,

--Brian Gix

