Return-Path: <SRS0=QCqs=4V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49285C3F2CE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 15:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CA0215A4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 15:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZrS60HSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgCDPjY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:39:24 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:31055 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgCDPjY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Mar 2020 10:39:24 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200304153922epoutp02971ab13b4ac197546fedc2b87e0105eb~5JAhQREbU0483304833epoutp02B
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Mar 2020 15:39:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200304153922epoutp02971ab13b4ac197546fedc2b87e0105eb~5JAhQREbU0483304833epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583336362;
        bh=YGzVamirbcGkC061kW7JKIdVzYNIieSq91DqtRtvBrM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ZrS60HSdCdqHAk8NAjkgs47JSXCzAXXEKIahOeQ+V3+6WYNT1xQY4KCBmVvaUciEW
         AHPyn3YolNoefUQfsmHRbEs9Bo9TWCEGQTpl02tF0jbNNw0oq3ShuuwWhh/JFhzDe+
         iXBpy72pJmLPZ1GbjjikN6kV6+0HO0koC7mUk5WQ=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200304153921epcas5p2642ec8ad9cb5e029bac3a3fa728e8ba3~5JAgg-0Gz1206912069epcas5p2G;
        Wed,  4 Mar 2020 15:39:21 +0000 (GMT)
X-AuditID: b6c32a49-7a9ff70000014d0e-b2-5e5fcba9f3ba
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.41.19726.9ABCF5E5; Thu,  5 Mar 2020 00:39:21 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: Regarding OOB authentication method & action for Mesh
 provisioner
Reply-To: anupam.r@samsung.com
From:   Anupam Roy <anupam.r@samsung.com>
To:     "Gix, Brian" <brian.gix@intel.com>
CC:     Semun Lee <semun.lee@samsung.com>,
        Dohyun Pyun <dh79.pyun@samsung.com>,
        AMIT KUMAR JAISWAL <amit.jaiswal@samsung.com>,
        "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        Nitin Jhanwar <nitin.j@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <5125c6f3497334112311a66442730a78cb031adf.camel@intel.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200304145232epcms5p4da58e33ac94ef3da20d94f4076865928@epcms5p4>
Date:   Wed, 04 Mar 2020 20:22:32 +0530
X-CMS-MailID: 20200304145232epcms5p4da58e33ac94ef3da20d94f4076865928
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7bCmuu7K0/FxBhcX8lm865rOZrFixmo2
        iyXfP7JZNG96xWIx51ofs8X6lSfYLbata2e2OLbpKZMDh8fiPS+ZPPq2rGL0uPLtBIvH501y
        ASxRXDYpqTmZZalF+nYJXBmLD85jKbgXWLF07ha2BsYp/l2MHBwSAiYS055GdTFycQgJ7GaU
        WHVtGQtInFdAUOLvDuEuRk4OYYEQiWkzFjOC2EICchKLp65lAykRFtCUuLkxBSTMJqAu8evh
        DhYQW0RATeLi9QPMICOZBZ4wSZx9+p4dJCEhwCsxo/0pC4QtLbF9+VawmZwC7hLNf+YzQsRF
        JW6ufssOY78/BhMXkWi9d5YZwhaUePBzNyPMnK0LnoItkxDoZpR4vWM9E4QzhVHi48W3TBBV
        5hL/u98yQjzmKzHzD9gCFgFViQMLlkItc5E43bMK7DhmAW2JZQtfM4OUMwM9uX6XPkSJrMTU
        U+uYIEr4JHp/P2GC+WvHPBhbSWLr9fmsELaERN/mXVBxD4mvJ3axQMK5h0Xiy5opzBMYFWYh
        gnoWks2zEDYvYGRexSiZWlCcm55abFpgmJdarlecmFtcmpeul5yfu4kRnGa0PHcwzjrnc4hR
        gINRiYf3xdT4OCHWxLLiytxDjBIczEoivMKmQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8k1iv
        xggJpCeWpGanphakFsFkmTg4pRoY+6dJ91lt4Zgfs6O94OmlWKGZvjciDJU/lDC8UJpopsfE
        ++C9xBT1nVnF9t+XGrXbF+/u0e8vmcW9VtDp86oNpQenct95XHk9LnOG0GuN+OnPLfcox3Xe
        37upaube8qV7v+fbHCxfbqNzzvOocZUl5/SkfWXvwu8efjdnW9O3HbzmDkW/p2tHKrEUZyQa
        ajEXFScCADPByIIvAwAA
X-CMS-RootMailID: 20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b
References: <5125c6f3497334112311a66442730a78cb031adf.camel@intel.com>
        <f2ea1cd7ff4a84671a53c518e3bdbabc286343cd.camel@intel.com>
        <20200302142239.re57glm4ixjot7d3@mlowasrzechonek2133>
        <20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p3>
        <20200302145518epcms5p7ec2da0403de9efa6733e12290f3cc80d@epcms5p7>
        <7686b0b5ec818946fef72d8eb438460898d53c40.camel@intel.com>
        <20200303091825epcms5p128183f5a0fb4790eba71edcf306cf7d0@epcms5p1>
        <CGME20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p4>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

>Hi Anupam,
>On Tue, 2020-03-03 at 14:48 +0530, Anupam Roy wrote:
>>  Hi Inga,
>> Sender : Stotland, Inga <inga.stotland=40intel.com>
>> > On Mon, 2020-03-02 at 16:56 +0000, Gix, Brian wrote:
>> > > On Mon, 2020-03-02 at 20:25 +0530, Anupam Roy wrote:
>> > > > Hi Michal,
>> > > > Sender : Micha=C5=82=20Lowas-Rzechonek=20<=0D=0A>>=20>=20>=20>=20>=
=20=0D=0A>>=20>=20>=20>=20>=20On=2003/02,=20Anupam=20Roy=20wrote:=0D=0A>>=
=20>=20>=20>=20>=20>=20Also,=20I=20would=20like=20to=20know,=20whether=20th=
ere=20is=20any=20plan=20to=0D=0A>>=20>=20>=20>=20>=20>=20Request=0D=0A>>=20=
>=20>=20>=20>=20>=20external=20provisioning=20Agent=20to=20choose=20Provisi=
oning=20method=20&=0D=0A>>=20>=20>=20>=20>=20>=20specific=0D=0A>>=20>=20>=
=20>=20>=20>=20action?=20=20The=20reason=20being,=20some=20*application*=20=
may=20be=20interested=0D=0A>>=20>=20>=20>=20>=20>=20in=20a=0D=0A>>=20>=20>=
=20>=20>=20>=20particular=20Security=20level=20&=20Authentication=20action,=
=20depending=20on=0D=0A>>=20>=20>=20>=20>=20>=20its=0D=0A>>=20>=20>=20>=20>=
=20>=20own=20I/O=20capabilities.=0D=0A>>=20>=20>=20>=20>=20=0D=0A>>=20>=20>=
=20>=20>=20For=20the=20record,=20we=20also=20need=20this=20is=20functionali=
ty.=20One=20of=20the=0D=0A>>=20>=20>=20>=20>=20possible=0D=0A>>=20>=20>=20>=
=20>=20scenarios=20is=20having=20a=20provisioner=20who=20doesn't=20have=20a=
=20reliable=0D=0A>>=20>=20>=20>=20>=20Internet=0D=0A>>=20>=20>=20>=20>=20co=
nnection=20and=20might=20want=20to=20fall=20back=20to=20(less=20secure)=20O=
OB=0D=0A>>=20>=20>=20>=20>=20actions=20if=0D=0A>>=20>=20>=20>=20>=20it=20ca=
nnot=20obtain=20OOB=20public=20key.=0D=0A>>=20>=20>=20>=20>=20=0D=0A>>=20>=
=20>=20>=20>=20We've=20been=20planning=20to=20send=20a=20patch=20implementi=
ng=20a=20D-Bus=20API=20for=0D=0A>>=20>=20>=20>=20>=20that,=0D=0A>>=20>=20>=
=20>=20>=20but=20it's=20not=20ready=20yet=20:(=0D=0A>>=20>=20>=20>=20=0D=0A=
>>=20>=20>=20>=20Okay,=20that=20would=20be=20nice=20&=20and=20will=20it=20a=
llow=20application=20to=20choose=0D=0A>>=20>=20>=20>=20both=20a)=20=22OOB=
=20Pub=20Key(With/Without)=22=20as=0D=0A>>=20>=20>=20>=20well=20as=20=20b)=
=22OOB=20Auth=20Methods(IN/OUT/Static/No=20OOB)=20&=0D=0A>>=20>=20>=20>=20A=
ctions(Blink/Beep/Vibrate/Num/alpha=20etc.)=22?=0D=0A>>=20>=20>=20=0D=0A>>=
=20>=20>=20The=20original=20plan=20for=20this=20was=20that=20an=20Agent=20d=
efines=20it's=0D=0A>>=20>=20>=20Capabilities=20d-bus=20properties=20to=20in=
dicate=20the=20OOB=0D=0A>>=20>=20>=20methodologies=20it=20is=20willing=20to=
=20support=20*for=20that=20session*.=20If=20you=0D=0A>>=20>=20>=20*sometime=
s*=20want=20to=20support=20=22static-oob=22=20or=0D=0A>>=20>=20>=20=22publi=
c-oob=22=20(for=20instance,=20to=20do=20a=20Certificate=20lookup=20via=20a=
=20WAN)=0D=0A>>=20>=20>=20then=20for=20that=20session,=20those=20capabiliti=
es=0D=0A>>=20>=20>=20should=20be=20included=20in=20the=20Agent's=20Capabili=
ties=20array...=20=20=20and=20if=20the=0D=0A>>=20>=20>=20WAN=20is=20offline=
,=20and=20Certificates=20can't=20be=0D=0A>>=20>=20>=20retrieved,=20then=20l=
eave=20that=20capability=20out.=0D=0A>>=20>=20>=20=0D=0A>>=20>=20>=20Otherw=
ise,=20yes...=20=20The=20*initiator*=20daemon=20then=20looks=20at=20the=0D=
=0A>>=20>=20>=20capabilities=20of=20the=20remote=20unprovisioned=20device,=
=0D=0A>>=20>=20>=20and=20the=20capabilities=20of=20the=20local=20agent,=20a=
nd=20chooses=20the=20highest=0D=0A>>=20>=20>=20security=20method=20that=20c=
an=20be=20supported=20between=0D=0A>>=20>=20>=20the=20two=20devices.=20=20B=
ut=20the=20list=20of=20available=20methods=20is=20still=20under=0D=0A>>=20>=
=20>=20the=20control=20of=20the=20App.=0D=0A>>=20>=20>=20=0D=0A>>=20>=20=0D=
=0A>>=20>=20The=20daemon=20indeed=20is=20missing=20the=20dynamic=20acquisit=
ion=20of=20the=0D=0A>>=20>=20provisioner's=20agent=20capabilities.=20I=20th=
ink=20there=20is=20no=20need=20for=20a=20new=20D-=0D=0A>>=20>=20Bus=20metho=
d,=20the=20current=20API=20is=20sufficient.=20What=20is=20needed,=20is=20to=
=20add=0D=0A>>=20>=20call=20for=20GetProperty()=20request=20of=20=22Capabil=
ities=22=20on=20the=20Agent=20interface=0D=0A>>=20>=20(in=20agent.c)=20prio=
r=20to=20sending=20provisioning=20invite=20(in=20prov-initiator.c,=20=0D=0A=
>>=20>=20before=20or=20in=20prov_init_open())=0D=0A>>=20>=20=0D=0A>>=20Than=
ks=20for=20sharing=20your=20inputs.=20Actually,=20my=20point=20of=20view=20=
was=20allowing=20application=20to=20choose=20a=20particular=0D=0A>>=20metho=
dology=20&=20action=0D=0A>>=20based=20on=20*capabilities*=20received=20from=
=20the=20remote=20unprovisioned=20device=20*on=20runtime*=20(After=20receiv=
ing=0D=0A>>=20capabilities=20PDU=20from=20remote)=0D=0A>>=20It=20seems,=20a=
bove=20may=20not=20be=20possible=20with=20the=20approach=20you=20have=20exp=
lained.=0D=0A>=0D=0A>The=20provisioning=20happens=20pretty=20fast=20once=20=
the=20call=20on=20the=20Provisioner=20is=20made,=20and=20I=20am=20not=20sur=
e=20what=20the=0D=0A>advantage=20would=20be=20to=20deciding=20*after*=20rec=
eiving=20remote=20capabilities,=20which=20capabilities=20*you*=20support.=
=20=20As=0D=0A>Micha=C5=82=20mentioned,=20it=20is=20true=20that=20if=20you=
=20*usually*=20can=20support=20an=20IP=20based=20OOB=20information=20exchan=
ge,=20but=20your=0D=0A>=22WiFi=20is=20down=22,=20that=20you=20will=20want=
=20to=20do=20manual=20human=20OOB=20entry...=20=20But=20in=20that=20case,=
=20remove=20the=20capabilities=0D=0A>that=20require=20WiFi=20from=20your=20=
agent=20capabilities=20*before*=20initiating=20provisioning.=20=0D=0A>=0D=
=0AAgreed=21=0D=0A=0D=0A>>=20=0D=0A>>=20I=20think,=20by=20exposing=20agent=
=20properties,=20daemon=20will=20surely=20taking=20into=20consideration,=20=
the=20choice=20of=0D=0A>>=20provisioning=20agent,=20however,=0D=0A>>=20choo=
sing=20*final=20method=20&=20action*=20will=20still=20be=20in=20control=20o=
f=20daemon=20by=20this=20approach,=20if=20I=20am=20understanding=0D=0A>>=20=
it=20correctly.=0D=0A>>=20For=20instance,=20if=20both=20agent=20&=20node=20=
support=20OUT=20OOB=20with=20Blink/Beep/Vibrate,=20then=20daemon=20will=20h=
ave=20to=0D=0A>>=20internally=20decide=20on=20a=20specific=20*action*,=20if=
=20it=20choosing=20OUT=20OOB.=0D=0A>=0D=0A>We=20may=20have=20a=20misunderst=
anding=20of=20terms=20here.=20=20The=20application=20controls=20the=20=22ag=
ent=22,=20and=20the=20node=20(as=20managed=0D=0A>by=20the=20daemon)=20only=
=20supports=20what=20the=20agent=20tells=20it=20to=20support.=20=20The=20*r=
emote*=20device=20being=20provisioned=20is=20the=0D=0A>only=20thing=20that=
=20may=20or=20may=20not=20match=20specific=20capabilities=20on=20the=20loca=
l=20agent.=20=20And=20typically=20the=20local=0D=0A>provisioner's=20support=
=20of=20the=20various=20OUT=20OOB=20or=20IN=20OOB=20is=20simplistic=20on=20=
the=20Provisioner=20side...=20=20=0D=0A>=0D=0A>Most=20(if=20not=20all)=20re=
mote=20devices=20will=20have=20only=20*one*=20of=20Blink,=20Beep,=20Vibrate=
,=20Out=20Numeric=20or=20out=20Alphabetic.=20=0D=0A>Support=20on=20the=20Pr=
ovisioner=20will=20indeed=20auto=20select=20one=20in=20the=20rare=20case=20=
that=20it=20supports=20more=20than=20one,=20and=0D=0A>will=20select=20the=
=20highest=20security.=20=20But=20regardless,=20on=20the=20*Provisioner=20S=
ide*=20you=20will=20basically=20just=20display=20a=0D=0A>string=20like:=0D=
=0A>=22Enter=20the=20number=20of=20times=20remote=20device=20Blinked=22=20f=
or=20example.=20=20=0D=0A>=0D=0A>Same=20for=20IN=20OOB,=20except=20the=20ac=
tion=20of=20the=20Provisioner=20will=20be=20to=20display=20a=20string=20lik=
e:=0D=0A>=22Twist=20device=20X=20times=22=20because=20the=20remote=20device=
=20has=20told=20us=20it=20has=20something=20that=20can=20be=20twisted.=0D=
=0A>=0D=0A>For=20human=20entered=20OOB=20(on=20either=20side)=20we=20assume=
=20that=20the=20Provisioner=20is=20high=20functioning=20(has=20ability=20to=
=0D=0A>display=20any=20kind=20of=20string,=20and=20accept=20any=20kind=20of=
=20manual=20input)=20and=20the=20*if*=20either=20device=20is=20low=20functi=
oning=0D=0A>it=20is=20the=20unprovisioned=20device,=20which=20will=20probab=
ly=20only=20have=20a=20single=20method=20of=20accepting=20or=20outputing=20=
OOB=0D=0A>data.=0D=0A>=0D=0A>Either=20way,=20the=20Unprovisioned=20Beacon=
=20should=20tell=20the=20Provisioner=20all=20of=20the=20information=20it=20=
needs=20to=20know=0D=0A>(especially=20when=20combined=20with=20information=
=20like=20=22My=20WiFi=20isn't=20working=22)=20to=20decide=20which=20capabi=
lities=20to=0D=0A>include=20in=20it's=20agent.=0D=0A>=0D=0A>What=20we=20don=
't=20want=20is=20to=20require=20an=20additional=20human=20interaction=20req=
uiring=20a=20choice=20of=20what=20to=20use=20before=0D=0A>advancing=20to=20=
the=20input=20itself.=20We=20are=20trying=20to=20keep=20it=20to=20a=20singl=
e=20interaction.=0D=0A>=0D=0AThank=20you=20for=20such=20detailed=20explanat=
ion.=20Indeed,=20avoiding=20additional=20Human=20interaction=20will=20be=20=
desired=20to=20speed=20up=20the=20whole=20process.=0D=0A=0D=0A>>=20Also,=20=
between=20OUT/IN/Static=20OOB,=20dameon=20will=20have=20to=20internally=20d=
ecide=20on=20a=20method,=20may=20be=20applying=20some=20pre-=0D=0A>>=20defi=
ned=20security=20level?=20Please=20let=20me=20know=20if=20I=20am=20missing=
=20something.=20Thank=20You.=0D=0A>=0D=0A>Both=20the=20Output=20Action=20an=
d=20Input=20Action=20are=20arranged=20by=20value=20in=20order=20of=20level=
=20of=20security=20possible:=0D=0A>1.=20Lowest=0D=0A>=09No=20Input/No=20Out=
put=0D=0A>=0D=0A>2.=20Still=20pretty=20low=20(random=20number=20from=200-9)=
=0D=0A>=09Blink=0D=0A>=09Beep=0D=0A>=09Vibrate=0D=0A>=09Push=0D=0A>=09Twist=
=0D=0A>=0D=0A>3.=20Pretty=20Good=20(random=20number=20between=200-99999999)=
=0D=0A>=09Input=20Numeric=0D=0A>=09Output=20Numeric=0D=0A>=0D=0A>4.=20Even=
=20Better=20(random=208=20char=20string=20incorporating=200-9,=20a-z,=20A-Z=
)=0D=0A>=09Input=20Alphanumeric=0D=0A>=09Output=20Alphanumeric=0D=0A>=0D=0A=
>5.=20Best=20(Probably=20IP=20network=20delivered=20signed=20certificates=
=20or=20scanned=20barcodes)=0D=0A>=09OOB=20Public=20Key=0D=0A>=09OOB=20Stat=
ic=0D=0A>=09=0D=0A>=0D=0AYes,=20I=20can=20understand=20the=20OOB=20security=
=20level=20is=20already=20handled=20well=20in=20the=20daemon.=0D=0AThank=20=
you=20very=20much=20for=20your=20detailed=20response=21=0D=0A>>=20=0D=0A>>=
=20>=20Regards,=0D=0A>>=20>=20Inga=0D=0A=0D=0ABR,=0D=0A-Anupam=20Roy
