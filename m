Return-Path: <SRS0=RPtH=4T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BC9C3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 15:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264CB217F4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Mar 2020 15:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HIuVrtI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCBPDU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:03:20 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:49029 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBPDU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 10:03:20 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200302150318epoutp03d27cf78cf81bff5f174547fcdf013312~4hOdUn1f52924629246epoutp03F
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2020 15:03:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200302150318epoutp03d27cf78cf81bff5f174547fcdf013312~4hOdUn1f52924629246epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583161398;
        bh=iTrZIM4noakRXQ7BOqKFrc7rIqRbZjwZQ0bI+3vqZPM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=HIuVrtI/wGl79zqnlh6X98kCGxltzs82CXPQYlBEMwK1IwPKHhtekfLQiCn8dui7i
         3Rc4my03KKBIJ58mgjbTev/+Yb6EILY0rKiYMkDSNEAm0WANJr9p9z8kNuHLT/gM7X
         fi7x7/BIJpYneP9xC0F19bb5CmGmPqRYsKnXuRZ0=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200302150317epcas5p3a0f41505fdc192a1760c59b505df3d29~4hOdA_Z6p1324313243epcas5p3P;
        Mon,  2 Mar 2020 15:03:17 +0000 (GMT)
X-AuditID: b6c32a4b-32dff70000014cad-f4-5e5d2035732f
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.41.19629.5302D5E5; Tue,  3 Mar 2020 00:03:17 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: Regarding OOB authentication method & action for Mesh
 provisioner
Reply-To: anupam.r@samsung.com
From:   Anupam Roy <anupam.r@samsung.com>
To:     =?UTF-8?B?TWljaGHFgiBMb3dhcy1SemVjaG9uZWs=?= 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Semun Lee <semun.lee@samsung.com>,
        Dohyun Pyun <dh79.pyun@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20200302142239.re57glm4ixjot7d3@mlowasrzechonek2133>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200302145518epcms5p7ec2da0403de9efa6733e12290f3cc80d@epcms5p7>
Date:   Mon, 02 Mar 2020 20:25:18 +0530
X-CMS-MailID: 20200302145518epcms5p7ec2da0403de9efa6733e12290f3cc80d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZdlhTU9dUITbO4GGbtsWS7x/ZLOZc62O2
        WL/yBLvFsU1PmRxYPPq2rGL0uPLtBIvH501yAcxRXDYpqTmZZalF+nYJXBnPN8xjKTjJX7H8
        0zXmBsZJ/F2MnBwSAiYSpy6vZgSxhQR2M0rc/JXWxcjBwSsgKPF3hzBIWFggRGLajMVQJXIS
        i6euZQMpERbQlLi5MQUkzCagLvHr4Q4WEFtEIFxiysrHQDYXB7PAREaJzXM+M0Os4pWY0f6U
        BcKWlti+fCvYTE4BJ4nz7/ZBxUUlbq5+yw5jvz82nxHCFpFovXcWao6gxIOfuxlh5mxd8JQZ
        ZJmEQDejxOsd65kgnCmMEh8vvmWCqDKX+N/9FqyDV8BX4uijCWwgNouAqsTMI41QNS4SCz/c
        BLOZBbQlli18zQzyJTPQl+t36UOUyEpMPbUOqoRPovf3EyaYx3bMg7GVJLZen88KYUtI9G3e
        BRX3kPh6Yhc4VIQEzjJKXOh9wDqBUWEWIqxnIdk8C2HzAkbmVYySqQXFuempxaYFxnmp5XrF
        ibnFpXnpesn5uZsYwWlDy3sH46ZzPocYBTgYlXh4fzDExgmxJpYVV+YeYpTgYFYS4fXljI4T
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkzjuJ9WqMkEB6YklqdmpqQWoRTJaJg1OqgVE4X84whfu8
        r9Shq8oJ3r1RRmahvouTV9/oK3wxgy82xkDk+l6OtNqj0++u5HGOvlWc6HZq43W2vkK1UP8a
        75xTebpBftWKTQsyry3vNRI6fnGxVGDY+jP2z3n7n8olTA8U+FB6MiZ6w5sIx2f/xZLU5jAa
        /F5pVKu9mDVsUY6mz/+lmfuMlViKMxINtZiLihMBt+AvbBcDAAA=
X-CMS-RootMailID: 20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b
References: <20200302142239.re57glm4ixjot7d3@mlowasrzechonek2133>
        <20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p3>
        <CGME20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p7>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Michal,
=C2=A0=0D=0A>---------=20Original=20Message=20---------=0D=0A>Sender=20:=20=
Micha=C5=82=20Lowas-Rzechonek=20<michal.lowas-rzechonek=40silvair.com>=0D=
=0A>Date=20:=202020-03-02=2019:52=20(GMT+5:30)=0D=0A>Title=20:=20Re:=20Rega=
rding=20OOB=20authentication=20method=20&=20action=20for=20Mesh=20provision=
er=0D=0A>=20=0D=0A>Hi,=0D=0A>=20=0D=0A>On=2003/02,=20Anupam=20Roy=20wrote:=
=0D=0A>>=20Also,=20I=20would=20like=20to=20know,=20whether=20there=20is=20a=
ny=20plan=20to=20Request=0D=0A>>=20external=20provisioning=20Agent=20to=20c=
hoose=20Provisioning=20method=20&=20specific=0D=0A>>=20action?=20=20The=20r=
eason=20being,=20some=20*application*=20may=20be=20interested=20in=20a=0D=
=0A>>=20particular=20Security=20level=20&=20Authentication=20action,=20depe=
nding=20on=20its=0D=0A>>=20own=20I/O=20capabilities.=0D=0A>=20=0D=0A>For=20=
the=20record,=20we=20also=20need=20this=20is=20functionality.=20One=20of=20=
the=20possible=0D=0A>scenarios=20is=20having=20a=20provisioner=20who=20does=
n't=20have=20a=20reliable=20Internet=0D=0A>connection=20and=20might=20want=
=20to=20fall=20back=20to=20(less=20secure)=20OOB=20actions=20if=0D=0A>it=20=
cannot=20obtain=20OOB=20public=20key.=0D=0A>=20=0D=0A>We've=20been=20planni=
ng=20to=20send=20a=20patch=20implementing=20a=20D-Bus=20API=20for=20that,=
=0D=0A>but=20it's=20not=20ready=20yet=20:(=0D=0A=0D=0AOkay,=20that=20would=
=20be=20nice=20&=20and=20will=20it=20allow=20application=20to=20choose=20bo=
th=20a)=20=22OOB=20Pub=20Key(With/Without)=22=20as=20well=20as=20=20b)=22OO=
B=20Auth=20Methods(IN/OUT/Static/No=20OOB)=20&=20Actions(Blink/Beep/Vibrate=
/Num/alpha=20etc.)=22?=0D=0A=0D=0A>=20=0D=0A>regards=0D=0A>--=20=0D=0A=0D=
=0A>Micha=C5=82=20Lowas-Rzechonek=20<michal.lowas-rzechonek=40silvair.com>=
=0D=0A>Silvair=20https://protect2.fireeye.com/url?k=3Dbcd496bf-e1422fc8-bcd=
51df0-0cc47a312ab0-f5d986cca20e804f&u=3Dhttp://silvair.com/=0D=0A>Jasnog=C3=
=B3rska=2044,=2031-358=20Krakow,=20POLAND
