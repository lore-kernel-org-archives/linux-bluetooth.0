Return-Path: <SRS0=ag/l=4U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD9CC3F2C6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Mar 2020 09:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F00F21556
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Mar 2020 09:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pkdfR/zY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgCCJSm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:18:42 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:25990 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgCCJSm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Mar 2020 04:18:42 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200303091839epoutp01a8436f9d56247b109783c093fa9c2dc3~4wK1KsYBK1317413174epoutp013
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2020 09:18:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200303091839epoutp01a8436f9d56247b109783c093fa9c2dc3~4wK1KsYBK1317413174epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583227119;
        bh=ZoLNa8PP5iYSgmbROvel1rlhezQxVdwVpKLLSToMCNU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=pkdfR/zYEKbnI8maJjFgmn+gwT0ztWlSclboWfM9bKnY4GAR3WfqLRdtE2wJePKI0
         Yeqc5qyFutn/q1aQSKd+4/bs4xjUsScV7iF017Lt5HbpqsJ+DtCQDkyhvLAsZ19HdU
         nF/2WgZoM6SMaBNhlF3+0tsP/gWyhKUyqgKR1vuA=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200303091839epcas5p3c6d563ff71dd1e9f5a1b750457aedd48~4wK01nqWT2840928409epcas5p3H;
        Tue,  3 Mar 2020 09:18:39 +0000 (GMT)
X-AuditID: b6c32a4a-769ff70000014ee5-6d-5e5e20ef6922
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.4D.20197.FE02E5E5; Tue,  3 Mar 2020 18:18:39 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: Re: Regarding OOB authentication method & action for Mesh
 provisioner
Reply-To: anupam.r@samsung.com
From:   Anupam Roy <anupam.r@samsung.com>
To:     "Gix, Brian" <brian.gix@intel.com>
CC:     "Stotland, Inga" <inga.stotland@intel.com>,
        "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        Semun Lee <semun.lee@samsung.com>,
        Dohyun Pyun <dh79.pyun@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Nitin Jhanwar <nitin.j@samsung.com>,
        AMIT KUMAR JAISWAL <amit.jaiswal@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <f2ea1cd7ff4a84671a53c518e3bdbabc286343cd.camel@intel.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200303091825epcms5p128183f5a0fb4790eba71edcf306cf7d0@epcms5p1>
Date:   Tue, 03 Mar 2020 14:48:25 +0530
X-CMS-MailID: 20200303091825epcms5p128183f5a0fb4790eba71edcf306cf7d0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7bCmhu57hbg4g3fvOC3edU1ns1gxYzWb
        xZLvH9ksmje9YrGYc62P2WL9yhPsFtvWtTNbHNv0lMmBw2PxnpdMHn1bVjF6XPl2gsXj8ya5
        AJYoLpuU1JzMstQifbsErozzG36zFGzSqZi/dTprA+NlrS5GTg4JAROJ+9tns3YxcnEICexm
        lDh9fydbFyMHB6+AoMTfHcIgNcICERJne6cxgthCAnISi6euBSsRFtCUuLkxBSTMJqAu8evh
        DhYQW0RATeLi9QPMICOZBR4xSWxvX8gMsYtXYkb7UxYIW1pi+/KtYDM5Bdwlzt1rYYeIi0rc
        XP0Wzn5/bD4jhC0i0XrvLNQcQYkHP3czwszZuuAp2DIJgW5Gidc71jNBOFMYJT5efMsEUWUu
        8b/7LVgHr4CvxLT7z9hAbBYBVYnnnffZIGpcJPZfOgF2HbOAtsSyha+ZQb5kBvpy/S59iBJZ
        iamn1jFBlPBJ9P5+wgTz2I55MLaSxNbr81khbAmJvs27oOIeEl9P7GKBBHQ3s8TvS8vZJzAq
        zEKE9Swkm2chbF7AyLyKUTK1oDg3PbXYtMAoL7Vcrzgxt7g0L10vOT93EyM41Wh57WBcds7n
        EKMAB6MSD+8Phtg4IdbEsuLK3EOMEhzMSiK8vpzRcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        J7FejRESSE8sSc1OTS1ILYLJMnFwSjUwhoSnfWaRvKf4327dQt2Zb7WjN12uD3jTkVvksYJh
        gZm5eXz35J9FGyrmZScEP7y2sfn4kc9uvjf/yqbejZ88+87vYD0RYb4NC4K0Sz6bH1zQpTDP
        LPycWqX3v5MrJ89M42d6dslW6VPoz5imqqNHHWPn9aQpVGzJar2TUX2bLdEgfjqDftYxJZbi
        jERDLeai4kQAbqG8MzEDAAA=
X-CMS-RootMailID: 20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b
References: <f2ea1cd7ff4a84671a53c518e3bdbabc286343cd.camel@intel.com>
        <20200302142239.re57glm4ixjot7d3@mlowasrzechonek2133>
        <20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p3>
        <20200302145518epcms5p7ec2da0403de9efa6733e12290f3cc80d@epcms5p7>
        <7686b0b5ec818946fef72d8eb438460898d53c40.camel@intel.com>
        <CGME20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p1>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

 Hi Inga,
=20
>--------- Original Message ---------
>Sender : Stotland, Inga <inga.stotland=40intel.com>
>Date : 2020-03-02 22:45 (GMT+5:30)
>Title : Re: Re: Regarding OOB authentication method & action for Mesh prov=
isioner
>=20
>Hi,
>=20
>On Mon, 2020-03-02 at 16:56 +0000, Gix, Brian wrote:
>> On Mon, 2020-03-02 at 20:25 +0530, Anupam Roy wrote:
>> > Hi Michal,
>> > =20
>> > > --------- Original Message ---------
>> > > Sender : Micha=C5=82=20Lowas-Rzechonek=20<=0D=0A>>=20>=20>=20michal.=
lowas-rzechonek=40silvair.com=0D=0A>>=20>=20>=20>=0D=0A>>=20>=20>=20Date=20=
:=202020-03-02=2019:52=20(GMT+5:30)=0D=0A>>=20>=20>=20Title=20:=20Re:=20Reg=
arding=20OOB=20authentication=20method=20&=20action=20for=20Mesh=0D=0A>>=20=
>=20>=20provisioner=0D=0A>>=20>=20>=20=0D=0A>>=20>=20>=20Hi,=0D=0A>>=20>=20=
>=20=0D=0A>>=20>=20>=20On=2003/02,=20Anupam=20Roy=20wrote:=0D=0A>>=20>=20>=
=20>=20Also,=20I=20would=20like=20to=20know,=20whether=20there=20is=20any=
=20plan=20to=0D=0A>>=20>=20>=20>=20Request=0D=0A>>=20>=20>=20>=20external=
=20provisioning=20Agent=20to=20choose=20Provisioning=20method=20&=0D=0A>>=
=20>=20>=20>=20specific=0D=0A>>=20>=20>=20>=20action?=20=20The=20reason=20b=
eing,=20some=20*application*=20may=20be=20interested=0D=0A>>=20>=20>=20>=20=
in=20a=0D=0A>>=20>=20>=20>=20particular=20Security=20level=20&=20Authentica=
tion=20action,=20depending=20on=0D=0A>>=20>=20>=20>=20its=0D=0A>>=20>=20>=
=20>=20own=20I/O=20capabilities.=0D=0A>>=20>=20>=20=0D=0A>>=20>=20>=20For=
=20the=20record,=20we=20also=20need=20this=20is=20functionality.=20One=20of=
=20the=0D=0A>>=20>=20>=20possible=0D=0A>>=20>=20>=20scenarios=20is=20having=
=20a=20provisioner=20who=20doesn't=20have=20a=20reliable=0D=0A>>=20>=20>=20=
Internet=0D=0A>>=20>=20>=20connection=20and=20might=20want=20to=20fall=20ba=
ck=20to=20(less=20secure)=20OOB=0D=0A>>=20>=20>=20actions=20if=0D=0A>>=20>=
=20>=20it=20cannot=20obtain=20OOB=20public=20key.=0D=0A>>=20>=20>=20=0D=0A>=
>=20>=20>=20We've=20been=20planning=20to=20send=20a=20patch=20implementing=
=20a=20D-Bus=20API=20for=0D=0A>>=20>=20>=20that,=0D=0A>>=20>=20>=20but=20it=
's=20not=20ready=20yet=20:(=0D=0A>>=20>=20=0D=0A>>=20>=20Okay,=20that=20wou=
ld=20be=20nice=20&=20and=20will=20it=20allow=20application=20to=20choose=0D=
=0A>>=20>=20both=20a)=20=22OOB=20Pub=20Key(With/Without)=22=20as=0D=0A>>=20=
>=20well=20as=20=20b)=22OOB=20Auth=20Methods(IN/OUT/Static/No=20OOB)=20&=0D=
=0A>>=20>=20Actions(Blink/Beep/Vibrate/Num/alpha=20etc.)=22?=0D=0A>>=20=0D=
=0A>>=20The=20original=20plan=20for=20this=20was=20that=20an=20Agent=20defi=
nes=20it's=0D=0A>>=20Capabilities=20d-bus=20properties=20to=20indicate=20th=
e=20OOB=0D=0A>>=20methodologies=20it=20is=20willing=20to=20support=20*for=
=20that=20session*.=20If=20you=0D=0A>>=20*sometimes*=20want=20to=20support=
=20=22static-oob=22=20or=0D=0A>>=20=22public-oob=22=20(for=20instance,=20to=
=20do=20a=20Certificate=20lookup=20via=20a=20WAN)=0D=0A>>=20then=20for=20th=
at=20session,=20those=20capabilities=0D=0A>>=20should=20be=20included=20in=
=20the=20Agent's=20Capabilities=20array...=20=20=20and=20if=20the=0D=0A>>=
=20WAN=20is=20offline,=20and=20Certificates=20can't=20be=0D=0A>>=20retrieve=
d,=20then=20leave=20that=20capability=20out.=0D=0A>>=20=0D=0A>>=20Otherwise=
,=20yes...=20=20The=20*initiator*=20daemon=20then=20looks=20at=20the=0D=0A>=
>=20capabilities=20of=20the=20remote=20unprovisioned=20device,=0D=0A>>=20an=
d=20the=20capabilities=20of=20the=20local=20agent,=20and=20chooses=20the=20=
highest=0D=0A>>=20security=20method=20that=20can=20be=20supported=20between=
=0D=0A>>=20the=20two=20devices.=20=20But=20the=20list=20of=20available=20me=
thods=20is=20still=20under=0D=0A>>=20the=20control=20of=20the=20App.=0D=0A>=
>=20=0D=0A>=20=0D=0A>The=20daemon=20indeed=20is=20missing=20the=20dynamic=
=20acquisition=20of=20the=0D=0A>provisioner's=20agent=20capabilities.=20I=
=20think=20there=20is=20no=20need=20for=20a=20new=20D-=0D=0A>Bus=20method,=
=20the=20current=20API=20is=20sufficient.=20What=20is=20needed,=20is=20to=
=20add=0D=0A>call=20for=20GetProperty()=20request=20of=20=22Capabilities=22=
=20on=20the=20Agent=20interface=0D=0A>(in=20agent.c)=20prior=20to=20sending=
=20provisioning=20invite=20(in=20prov-initiator.c,=20=0D=0A>before=20or=20i=
n=20prov_init_open())=0D=0A>=0D=0AThanks=20for=20sharing=20your=20inputs.=
=20Actually,=20my=20point=20of=20view=20was=20allowing=20application=20to=
=20choose=20a=20particular=20methodology=20&=20action=0D=0Abased=20on=20*ca=
pabilities*=20received=20from=20the=20remote=20unprovisioned=20device=20*on=
=20runtime*=20(After=20receiving=20capabilities=20PDU=20from=20remote)=0D=
=0AIt=20seems,=20above=20may=20not=20be=20possible=20with=20the=20approach=
=20you=20have=20explained.=0D=0A=0D=0AI=20think,=20by=20exposing=20agent=20=
properties,=20daemon=20will=20surely=20taking=20into=20consideration,=20the=
=20choice=20of=20provisioning=20agent,=20however,=0D=0Achoosing=20*final=20=
method=20&=20action*=20will=20still=20be=20in=20control=20of=20daemon=20by=
=20this=20approach,=20if=20I=20am=20understanding=20it=20correctly.=0D=0AFo=
r=20instance,=20if=20both=20agent=20&=20node=20support=20OUT=20OOB=20with=
=20Blink/Beep/Vibrate,=20then=20daemon=20will=20have=20to=20internally=20de=
cide=20on=20a=20specific=20*action*,=20if=20it=20choosing=20OUT=20OOB.=0D=
=0AAlso,=20between=20OUT/IN/Static=20OOB,=20dameon=20will=20have=20to=20int=
ernally=20decide=20on=20a=20method,=20may=20be=20applying=20some=20pre-defi=
ned=20security=20level?=20Please=20let=20me=20know=20if=20I=20am=20missing=
=20something.=20Thank=20You.=0D=0A=0D=0A>Regards,=0D=0A>Inga
