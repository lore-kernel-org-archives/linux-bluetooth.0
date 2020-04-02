Return-Path: <SRS0=u1pM=5S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E53C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 16:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD4F2063A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 16:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vNGmarv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389681AbgDBQIW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:08:22 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:23329 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388972AbgDBQIW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Apr 2020 12:08:22 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200402160820epoutp04658d91317bb76ffce05abba119f071e5~CDHGKmiGJ2098420984epoutp04M
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2020 16:08:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200402160820epoutp04658d91317bb76ffce05abba119f071e5~CDHGKmiGJ2098420984epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585843700;
        bh=POEl2r7JobfMB67H2cfm0UkHBjpYejU95TGk+z5mOqw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=vNGmarv51n+phvLApiEHDIkGNntTZLHGBonS8d7fEIoIpYLA9MNPF0oJlM78N5X2u
         lEaVLHoMsAFdq30vQQoC7v+kNixUKCxFjhjz/xHwkF0JT+VqEFjdC5GDlq+b+TxaZ2
         0InDdAJPqlBrWLNtbnBRM3b9M9fpagnXkCQezkzs=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200402160819epcas5p22c58c57d77431479328e70fcb21f17a7~CDHFDCEPu1590715907epcas5p25;
        Thu,  2 Apr 2020 16:08:19 +0000 (GMT)
X-AuditID: b6c32a4b-ae3ff70000001280-dc-5e860df32250
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.F8.04736.3FD068E5; Fri,  3 Apr 2020 01:08:19 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: Re: [PATCH BlueZ] mesh: Add check for valid netkey index
Reply-To: anupam.r@samsung.com
From:   Anupam Roy <anupam.r@samsung.com>
To:     "Gix, Brian" <brian.gix@intel.com>
CC:     Semun Lee <semun.lee@samsung.com>,
        Dohyun Pyun <dh79.pyun@samsung.com>,
        Nitin Jhanwar <nitin.j@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        AMIT KUMAR JAISWAL <amit.jaiswal@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <9038a2fe4daafd90def2444d71c8914c6a64a688.camel@intel.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200402160037epcms5p5c94d5798e7611c11e795c51bc39b5a6b@epcms5p5>
Date:   Thu, 02 Apr 2020 21:30:37 +0530
X-CMS-MailID: 20200402160037epcms5p5c94d5798e7611c11e795c51bc39b5a6b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZdlhTQ/czb1ucwbVJIhbvuqazWayYsZrN
        Ysn3j2wWc671MVtsW9fObHFs01MmBzaPxXteMnn0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJX
        xo1VK1gKfmhXTJn5n62BsVeti5GTQ0LAROLt8Sa2LkYuDiGB3YwSZ399Zuli5ODgFRCU+LtD
        GKRGWMBTYt7zO+wgtpCAnMTiqWvZQEqEBTQlbm5MAQmzCahL/Hq4gwXEFhFQk7h4/QAzyEhm
        gZeMEvOOLGeB2MUrMaP9KZQtLbF9+VZGEJtTwF3i2eM9UHFRiZur37LD2O+PzWeEsEUkWu+d
        ZYawBSUe/NzNCDNn64KnYMskBLoZJV7vWM8E4UxhlPh48S0TRJW5xP/ut2AdvAK+ElPnbAXb
        wCKgKvHy6COozS4S0+7uAIszC2hLLFv4mhnkS2agL9fv0ocokZWYemodE0QJn0Tv7ydMMI/t
        mAdjK0lsvT6fFcKWkOjbvAsq7iFxcssvJkhAn2SSWHnwOdsERoVZiLCehWTzLITNCxiZVzFK
        phYU56anFpsWGOellusVJ+YWl+al6yXn525iBCcTLe8djJvO+RxiFOBgVOLhZTzYGifEmlhW
        XJl7iFGCg1lJhNdxBlCINyWxsiq1KD++qDQntfgQozQHi5I47yTWqzFCAumJJanZqakFqUUw
        WSYOTqkGRuNHvX6l5q1r7y77+clp2buYmzWJIsnv+Oo5rtd57e7IfNMabldTbbabte0vr+zX
        P+9Z/Dhs10UbXyvfeGLKPMPZV0ut+i6LrfBO1/CaPbv68a/0zjlujtp1/c0bPKqXaWjsjZn+
        00Zaad0WTR77twmvam6F+ukLcLXzTmN0rmZWPcsyv261EktxRqKhFnNRcSIArXfmZSIDAAA=
X-CMS-RootMailID: 20200401112015epcas5p10545143f69c22449f559818476845cc5
References: <9038a2fe4daafd90def2444d71c8914c6a64a688.camel@intel.com>
        <82b707704e1863c43748adce03057d2252fea59a.camel@intel.com>
        <1585740006-9569-1-git-send-email-anupam.r@samsung.com>
        <20200402140519epcms5p3608d451804bf03eefc34ce77b04ab0aa@epcms5p3>
        <CGME20200401112015epcas5p10545143f69c22449f559818476845cc5@epcms5p5>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

>Hi Anupam,
>On Thu, 2020-04-02 at 19:35 +0530, Anupam Roy wrote:
>> Hi Brian,
>>=20
>> > Hi Anupam,
>> > On Wed, 2020-04-01 at 16:50 +0530, Anupam Roy wrote:
>> > > This patch adds validation of net key index, which will be
>> > > used to send message to nodes. Return error in case net key index
>> > > is not valid. This avoids message encryption using device key
>> > > and further processing of the message.
>> > > ---
>> > >  mesh/model.c =7C 9 +++++++++
>> > >  1 file changed, 9 insertions(+)
>> > >=20
>> > > diff --git a/mesh/model.c b/mesh/model.c
>> > > index 9455833..6cc1dc5 100644
>> > > --- a/mesh/model.c
>> > > +++ b/mesh/model.c
>> > > =40=40 -546,6 +546,7 =40=40 static bool msg_send(struct mesh_node *n=
ode, bool credential, uint16_t src,
>> > >  	uint8_t dev_key=5B16=5D;
>> > >  	uint32_t iv_index, seq_num;
>> > >  	const uint8_t *key;
>> > > +	struct keyring_net_key net_key;
>> > >  	uint8_t *out;
>> > >  	uint8_t key_aid =3D APP_AID_DEV;
>> > >  	bool szmic =3D false;
>> > > =40=40 -578,8 +579,16 =40=40 static bool msg_send(struct mesh_node *=
node, bool credential, uint16_t src,
>> > >  		=7D
>> > > =20
>> > >  		net_idx =3D appkey_net_idx(node_get_net(node), app_idx);
>> > > +		if (net_idx =3D=3D NET_IDX_INVALID) =7B
>> > > +			l_debug(=22no net key for (%x)=22, net_idx);
>> > > +			return false;
>> > > +		=7D
>> >=20
>> > This *might* be a valid =22sanity=22 test...  Although an App Key shou=
ld never be allowed to be added, or exist
>> > unless the bound netkey already exists.  I think the only way an App K=
ey might exist without it's bound
>> > netkey
>> > is if the daemon private node.json file was hand edited, which is not =
technically allowed.
>> >=20
I think, this check is not required as explained.
>> > >  	=7D
>> > > =20
>> > > +	if (=21keyring_get_net_key(node, net_idx, &net_key)) =7B
>> > > +		l_debug(=22no net key for (%x)=22, net_idx);
>> > > +		return false;
>> > > +	=7D
>> >=20
>> > This check is invalid. Only an authorized Config Clients / Provisioner=
s have Key Rings, which is used to
>> > send
>> > AddKey, UpdateKey and Provisioning data to remote nodes.  The keyring =
is restricted to nodes which have
>> > full
>> > network configuration privleges....  Adding this would require *all* n=
odes in the network to be privleged
>> > nodes, which would then allow them to make changes outside the Provisi=
oner/ Config Client control.
>> >=20
>>  Thanks you for your input. The intention was to validate 'Net Key Index=
' for DevKeySend messages, sent by
>> *Config client/Provisioner* app specifically.
>>  Actually, one observation I had is that, even though, Config client sup=
plies the 'Net Key Index', & daemon
>> passes it all the way to msg_send(), eventually, it seems, it is ignored=
 & encryption key is picked up from
>> the primary subnet. Also, I noticed that Config client seems to allow de=
leting a created subnet (subnet-
>> delete <net key index>) at present, at any point of time.
>
>You are correct in finding this bug...  It was found in paralell by Przemy=
s=C5=82aw=20Fierek,=20and=20should=20be=20fixed=20as=0D=0A>of=20this=20comm=
it:=0D=0A>=0D=0A>=20=20=20commit=2084a9b6ce4b66a2ba21cce8e4b0c3c6e097a5493a=
=0D=0A>=20=20=20Author:=20Przemys=C5=82aw=20Fierek=20<przemyslaw.fierek=40s=
ilvair.com>=0D=0A>=20=20=20Date:=20=20=20Tue=20Mar=2031=2014:09:08=202020=
=20+0200=0D=0A>=0D=0A>=20=20=20=20=20=20=20mesh:=20Add=20net=20key=20index=
=20to=20sar=20structure=0D=0A>=20=20=20=20=20=20=20=0D=0A>=20=20=20=20=20=
=20=20This=20patch=20adds=20net=20key=20index=20to=20struct=20mesh_sar.=20T=
his=20fixes=20problem=20with=0D=0A>=20=20=20=20=20=20=20using=20invalid=20n=
etwork=20key=20to=20encrypt=20application=20messages.=0D=0A>=0D=0A>=0D=0A>I=
f=20you=20check=20out=20the=20current=20tip,=20hopefully=20it=20will=20solv=
e=20the=20problem=20you=20found=20where=20the=20incorrect=20(primary=0D=0A>=
subnet)=20key=20was=20used=20instead=20of=20the=20requested=20net=20key.=0D=
=0A>=0D=0AOkay,=20got=20it,=20thanks.=0D=0ASince=20we=20plan=20to=20use=20t=
he=20net=20key=20index,=20will=20the=20below=20sanity=20check=20stand=20val=
id(in=20case=20of=20app_idx=20=3D=3D=20APP_IDX_DEV_REMOTE)?=0D=0AAs=20it=20=
may=20save=20some=20un-necesary=20processing=20of=20the=20message=20payload=
=20in=20case=20net=20key=20index=20is=20*Not*=20valid=20or=20*subnet*=20is=
=20deleted=20by=20Config=20Client.=20Please=20share=20your=20opinion.=20Tha=
nks=0D=0A=0D=0A>>=20=20I=20am=20not=20sure=20if=20*Not=20using*=20the=20'Ne=
t=20Key=20Index'=20by=20the=20daemon=20is=20by=20design.=0D=0A>>=20=0D=0A>>=
=20Anyways,=20I=20got=20what=20you=20explained=20about=20*authorized=20apps=
=20having=20Keyring=20access*.=20In=20such=20case,=20I=20think,=20the=0D=0A=
>>=20keyring=20check=20would=20make=20sense=20only=20in=20the=20following=
=20condition.=20Please=20share=20your=20opinion.=20Thanks.=0D=0A>>=20=09=7D=
=20else=20if=20(app_idx=20=3D=3D=20APP_IDX_DEV_REMOTE)=20=7B=0D=0A>>=20=20=
=20=20=20=20=20=20=20if=20(=21keyring_get_remote_dev_key(node,=20dst,=20dev=
_key))=0D=0A>>=20=20=20=20=20=20=20=20=20=20=20=20=20return=20false;=0D=0A>=
>=20=09=09=09=0D=0A>>=20=20=20=20=20=20=20=20=20key=20=3D=20dev_key;=0D=0A>=
>=20=09=09=09=0D=0A>>=20=09=09/**=20Add=20Key=20Ring=20Check=20for=20valid=
=20Net=20Key=20Index=20**/=0D=0A>>=20=20=20=20=20=20=20=20=20=7D=0D=0A>>=20=
=0D=0A>>=20>=20>=20=20=09l_debug(=22(%x)=20%p=22,=20app_idx,=20key);=0D=0A>=
>=20>=20>=20=20=09l_debug(=22net_idx=20%x=22,=20net_idx);=0D=0A>>=20>=20>
