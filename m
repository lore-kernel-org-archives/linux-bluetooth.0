Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23361C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 05:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DE1206E9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 05:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bGXlcxQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgDCF5t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:57:49 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:25797 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgDCF5t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 01:57:49 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200403055745epoutp0413618a92acc17de43fbd048d9da3b059~CObRUtZ4q1220512205epoutp04h
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2020 05:57:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200403055745epoutp0413618a92acc17de43fbd048d9da3b059~CObRUtZ4q1220512205epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585893465;
        bh=ZS2jsbsrkACA+0JYyXYdZZItbPAq+3ZvkTtsKfDP9As=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=bGXlcxQ38DdHNXtBStZ3FoXyh4F4mrtPtvnE+z+0DuDiqrtudHLPy4iDPPAiIf6a/
         65p6+F25epiOkNrNaX03DoHTM/V6w45mHdOq1daLw1shyrd56WCN0osqWcGb33BM9Y
         oRd113AyHsFYfx3GCMsdAi6Augste3zok17nt8vc=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200403055745epcas5p49375a7f4d229497751f05b7e380e64b3~CObRKPKDN0867908679epcas5p4_;
        Fri,  3 Apr 2020 05:57:45 +0000 (GMT)
X-AuditID: b6c32a49-8b3ff700000012ae-71-5e86d0585b53
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.93.04782.850D68E5; Fri,  3 Apr 2020 14:57:44 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH BlueZ] mesh: Add check for valid netkey index
Reply-To: anupam.r@samsung.com
From:   Anupam Roy <anupam.r@samsung.com>
To:     "Gix, Brian" <brian.gix@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <3aa08d9a552ab02b0495b2a3970405ee082c85de.camel@intel.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200403052925epcms5p297a218e7780438e3db945d8007000b2f@epcms5p2>
Date:   Fri, 03 Apr 2020 10:59:25 +0530
X-CMS-MailID: 20200403052925epcms5p297a218e7780438e3db945d8007000b2f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7bCmum7EhbY4g62LLC1WzFjNZjHnWh+z
        A5PH4j0vmTw+b5ILYIrisklJzcksSy3St0vgytix9wlTwWLRis5p51kaGPeIdDFyckgImEjM
        /tvH1MXIxSEksJtR4vCcx6xdjBwcvAKCEn93CIPUCAu4Skyf1MYCYgsJyEksnrqWDaREWEBT
        4ubGFJAwm4C6xK+HO8BKRATUJC5eP8AMUsIs4C5x450QxCZeiRntT1kgbGmJ7cu3MoLYnEAl
        2953MkHERSVurn7LDmO/PzafEcIWkWi9d5YZwhaUePBzNyPMnK0LnjKDXC8h0M0o8XrHeiYI
        ZwqjxMeLb6Gmmkv8734L1sEr4Cvx/NRcsCtYBFQlPq3uhNrmIrHzVDcriM0soC2xbOFrqAc0
        Jdbv0ocokZWYemodE0QJn0Tv7ydMMI/tmAdjK0lsvT6fFcKWkOjbvAsq7iFxcssvaDCfYpZ4
        /2cvywRGhVmIkJ6FZPMshM0LGJlXMUqmFhTnpqcWmxYY5qWW6xUn5haX5qXrJefnbmIEpwUt
        zx2Ms875HGIU4GBU4uFlONgaJ8SaWFZcmXuIUYKDWUmE13EGUIg3JbGyKrUoP76oNCe1+BCj
        NAeLkjjvJNarMUIC6YklqdmpqQWpRTBZJg5OqQbGGJefVidnTP8r1OCw+Z1l3l6hpSYvOk/d
        K+YpXB3xIvNYXJH2jwscB2YGM17coedks0La6Z99160dtz7sn3T0smT37rOWBkflJOd6v3QQ
        jdOVPV0v4Pn+wZk18z+I3nEPfRl3/w1D7fvPq+NmrvvZ4sfj7+5a7R5hOa1kXbLs1btPL7i1
        tTM6K7EUZyQaajEXFScCAOAP7a0HAwAA
X-CMS-RootMailID: 20200401112015epcas5p10545143f69c22449f559818476845cc5
References: <3aa08d9a552ab02b0495b2a3970405ee082c85de.camel@intel.com>
        <9038a2fe4daafd90def2444d71c8914c6a64a688.camel@intel.com>
        <82b707704e1863c43748adce03057d2252fea59a.camel@intel.com>
        <1585740006-9569-1-git-send-email-anupam.r@samsung.com>
        <20200402140519epcms5p3608d451804bf03eefc34ce77b04ab0aa@epcms5p3>
        <20200402160037epcms5p5c94d5798e7611c11e795c51bc39b5a6b@epcms5p5>
        <CGME20200401112015epcas5p10545143f69c22449f559818476845cc5@epcms5p2>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,
>On Thu, 2020-04-02 at 21:30 +0530, Anupam Roy wrote:
>> Hi Brian,
>>=20
>> > You are correct in finding this bug...  It was found in paralell by Pr=
zemys=C5=82aw=20Fierek,=20and=20should=20be=20fixed=0D=0A>>=20>=20as=0D=0A>=
>=20>=20of=20this=20commit:=0D=0A>>=20>=20=0D=0A>>=20>=20=20=20commit=2084a=
9b6ce4b66a2ba21cce8e4b0c3c6e097a5493a=0D=0A>>=20>=20=20=20Author:=20Przemys=
=C5=82aw=20Fierek=20<przemyslaw.fierek=40silvair.com>=0D=0A>>=20>=20=20=20D=
ate:=20=20=20Tue=20Mar=2031=2014:09:08=202020=20+0200=0D=0A>>=20>=20=0D=0A>=
>=20>=20=20=20=20=20=20=20mesh:=20Add=20net=20key=20index=20to=20sar=20stru=
cture=0D=0A>>=20>=20=20=20=20=20=20=20=0D=0A>>=20>=20=20=20=20=20=20=20This=
=20patch=20adds=20net=20key=20index=20to=20struct=20mesh_sar.=20This=20fixe=
s=20problem=20with=0D=0A>>=20>=20=20=20=20=20=20=20using=20invalid=20networ=
k=20key=20to=20encrypt=20application=20messages.=0D=0A>>=20>=20=0D=0A>>=20>=
=20=0D=0A>>=20>=20If=20you=20check=20out=20the=20current=20tip,=20hopefully=
=20it=20will=20solve=20the=20problem=20you=20found=20where=20the=20incorrec=
t=0D=0A>>=20>=20(primary=0D=0A>>=20>=20subnet)=20key=20was=20used=20instead=
=20of=20the=20requested=20net=20key.=0D=0A>>=20>=20=0D=0A>>=20Okay,=20got=
=20it,=20thanks.=0D=0A>>=20Since=20we=20plan=20to=20use=20the=20net=20key=
=20index,=20will=20the=20below=20sanity=20check=20stand=20valid(in=20case=
=20of=20app_idx=20=3D=3D=0D=0A>>=20APP_IDX_DEV_REMOTE)?=0D=0A>>=20As=20it=
=20may=20save=20some=20un-necesary=20processing=20of=20the=20message=20payl=
oad=20in=20case=20net=20key=20index=20is=20*Not*=20valid=20or=0D=0A>>=20*su=
bnet*=20is=20deleted=20by=20Config=20Client.=20Please=20share=20your=20opin=
ion.=20Thanks=0D=0A>=0D=0A>If=20the=20App=20uses=20DevKeySend()=20with=20re=
mote=20=3D=3D=20true,=20but=20the=20node=20does=20not=20have=20the=20device=
=20key=20for=20that=20remote=0D=0A>node=20in=20it's=20keyring,=20the=20meth=
od=20will=20silently=20fail,=20and=20no=20message=20will=20be=20sent=20Over=
-the-Air.=0D=0A>=0D=0AOkay,=20I=20got=20that,=20deleting=20the=20keyring=20=
(by=20subnet-delete=20<net=20idx>)=20should=20not=20have=20any=20effect=20f=
or=20remote=20DevKeySend=20messages,=0D=0Aas=20net=20idx=20would=20be=20use=
d=20just=20to=20pick=20up=20Network=20Encryption=20Key=20from=20the=20node-=
>net->subnet.=20Thanks=20for=20clarification.=0D=0A=0D=0A>If=20the=20App=20=
wants=20to=20*respond*=20to=20an=20incoming=20command=20received=20with=20t=
he=20local=20nodes=20device=20key,=20it=20should=0D=0A>respond=20using=20De=
vKeySend()=20with=20remote=3D=3Dfalse,=20and=20net_index=20=3D=3D=20the=20n=
et_index=20from=20the=20cooresponding=0D=0A>DevKeyMessageReceived().
