Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41865C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 05:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1E0206DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 05:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TiDOxJvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgC0Fhc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 01:37:32 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:36382 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgC0Fhb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 01:37:31 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200327053729epoutp02a251386b6aebef1a6612d477fa040e0b~AEokqHWY22722327223epoutp02H
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 05:37:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200327053729epoutp02a251386b6aebef1a6612d477fa040e0b~AEokqHWY22722327223epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585287449;
        bh=FgXvwoRMRkzlkHOYeH9xM83ZWvZJ8X0TwOU7ANoV25I=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=TiDOxJvOWBJwuJ3jIUNj79jrIkuV9qnS7GFVhtAd9sEvCdq0X1SE6uuOFq1zKCNbr
         iftVj2hMDUGTl4KhqZn4+fN22GBtlEshORO432C0IYdSjciM2EPN9NAMtJapRTyxeR
         yyr2MLK+busIr7W5uek/aYkk0mPDb9QBrVZDfwRw=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200327053728epcas5p216e9834c46bb1c7a3b177379ce6f967c~AEokP52O71848018480epcas5p2s;
        Fri, 27 Mar 2020 05:37:28 +0000 (GMT)
X-AuditID: b6c32a4b-acbff70000001280-b3-5e7d9118dcd4
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.D7.04736.8119D7E5; Fri, 27 Mar 2020 14:37:28 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: Mesh Key Refreshment procedure from Config client
Reply-To: anupam.r@samsung.com
From:   Anupam Roy <anupam.r@samsung.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Dohyun Pyun <dh79.pyun@samsung.com>,
        Semun Lee <semun.lee@samsung.com>,
        AMIT KUMAR JAISWAL <amit.jaiswal@samsung.com>,
        Nitin Jhanwar <nitin.j@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <81d243b6c593e1edb6b36be87898fc57e1e5f0f2.camel@intel.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200327053515epcms5p1cd532ff3b1ac4b97d375a6336e3ded50@epcms5p1>
Date:   Fri, 27 Mar 2020 11:05:15 +0530
X-CMS-MailID: 20200327053515epcms5p1cd532ff3b1ac4b97d375a6336e3ded50
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZdlhTQ1diYm2cwfLDWhbvuqazWSz5/pHN
        onnTKxaLOdf6mC22rWtntji26SmTA5vH4j0vmTz6tqxi9Pi8SS6AOYrLJiU1J7MstUjfLoEr
        o+3rRraCW9wVZ3bOZ25gnMHZxcjJISFgInFq0Ua2LkYuDiGB3YwSfydeYO1i5ODgFRCU+LtD
        GKRGWMBJ4tH1Y6wgtpCAnMTiqWvZQEqEBTQlbm5MAQmzCahL/Hq4gwXEFhHQk9hxZycjyEhm
        gZeMEofap7NB7OKVmNH+lAXClpbYvnwrI8gcTgF3ibdTsiDCohI3V79lh7HfH5vPCGGLSLTe
        O8sMYQtKPPi5mxFmzNYFT5lBdkkIdDNKvN6xngnCmcIo8fHiWyaIKnOJ/91vGSH+8pWYNjkA
        JMwioCpx8fNZqHtcJJ7M/gn2I7OAtsSyha+ZQcqZgX5cv0sfokRWYuqpdUwQJXwSvb+fMMG8
        tWMejK0ksfX6fFYIW0Kib/MuqLiHxNcTu1ggwXyLSaL7x2/WCYwKsxAhPQvJ5lkImxcwMq9i
        lEwtKM5NTy02LTDOSy3XK07MLS7NS9dLzs/dxAhOJFreOxg3nfM5xCjAwajEw9vQVhMnxJpY
        VlyZe4hRgoNZSYT3aSRQiDclsbIqtSg/vqg0J7X4EKM0B4uSOO8k1qsxQgLpiSWp2ampBalF
        MFkmDk6pBsaqIElOs4r0XkltvUPvD0RJijRU9TPOZroSdeXprhM/ndbPe1kX6+1l0jflQc0z
        q9tNPx9Pv8nUf//Y3YLp22U0+8vsyqO7NV1uBNifMdmwmqWx4lesaNM3zk3P8vI+cVZ+Ybv7
        wvDRl/M9VZviity+bfBh/SG3Vm2Lo/SD9bE/DgtcZUo3DldiKc5INNRiLipOBAD4Z5DkIAMA
        AA==
X-CMS-RootMailID: 20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b
References: <81d243b6c593e1edb6b36be87898fc57e1e5f0f2.camel@intel.com>
        <20200326144743epcms5p401053700dae86ae93749df5fc77a2807@epcms5p4>
        <20200304153920epcms5p47e26659f715177b0244f18c71e4b5fed@epcms5p4>
        <20200326145252epcms5p2b9b6bded2e2a5d9c68e680e9de403662@epcms5p2>
        <CGME20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p1>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

>=20
>Hi Anupam,
>=20
>On Thu, 2020-03-26 at 20:22 +0530, Anupam Roy wrote:
>> Hi ,
>>  Presently, I am trying to check *Key Refreshment Procedure* from Mesh C=
onfig client.
>>=20
>> For checking the operation, I did following steps
>>  - Create Subnet in Config client at Net index 1
>>  - Add SubNetKey to Local Node at Net Index 1
>>  - Add SubNetKey to Remote Node at Net Index 1
>>=20
>=20
>Please try to add two steps more here:
>   - Update Subnet 1 (subnet-update command in main menu)
I missed mentioning above step in my email. Actually, before updating netke=
y to remote, I did update local subnet.
But yes, I missed out below step (Updating netkey to local node). Will give=
 it a try now. Much thanks=21

>   - Update NetKey 1 for a local node (switch to config menu)
>=20
>>  - Update Netkey to remote Node in Net index 1
>>=20
>> After updating the Netkey, I believe, config client has to either send o=
ut SNB with KeyRefreshment(KR) Flag=3D1 & secured with updated NetKey (i.e =
by subnet->net_key_upd id)
>> or send out =22Config Key Refresh Phase Set=22 with transition parameter=
, set to 2. I could not find the later provision in cfgclient menu.
>> However, Config Client seems to be not sending out Secure Network Beacon=
 as well. So KR procedure seems to be not progressing at my setup at presen=
t.
>>=20
>> Any hint of what could be missing will be really helpful=21 Thank You.
>>=20
>=20
>Best Regards,
>Inga
=C2=A0
