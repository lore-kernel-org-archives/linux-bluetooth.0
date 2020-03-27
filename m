Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DE3C2D0E5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 13:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403152074F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 13:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ijsnsre/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgC0NzO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:55:14 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21940 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0NzO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 09:55:14 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200327135508epoutp0338dee1b3468f0fa455ebabc55666748c~ALbFPcXZY2170921709epoutp03K
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 13:55:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200327135508epoutp0338dee1b3468f0fa455ebabc55666748c~ALbFPcXZY2170921709epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585317308;
        bh=8OqB5H+xQz46g5VC9hu+/njXuWdGo4Z60XVy4PPiurE=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=ijsnsre/XVTGOkiIXq7jmvLBtRydBagWtMBYw/aM5camI/WLCoKcpiK3QEZhu2js4
         IPx9WmfOK7Q3Jc6/EkyZylGln2zUMUUw9LE1lrEnUY9nQeQm9QYF8tdTiTNHUUi+RZ
         8WV5xRcB+OK2xEmOR96qe/M42sr367qsX2ES1i8E=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200327135507epcas5p3e46165b3d2c6f8019a2aa7dd32fe74e5~ALbD_GFfE1479014790epcas5p3b;
        Fri, 27 Mar 2020 13:55:07 +0000 (GMT)
X-AuditID: b6c32a49-89bff700000012ae-97-5e7e05baad3c
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.16.04782.AB50E7E5; Fri, 27 Mar 2020 22:55:06 +0900 (KST)
Mime-Version: 1.0
Subject: RE: RE: Re: Mesh Key Refreshment procedure from Config client
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
In-Reply-To: <20200327053515epcms5p1cd532ff3b1ac4b97d375a6336e3ded50@epcms5p1>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200327134742epcms5p46a971a1f5653956a287898e01a296dee@epcms5p4>
Date:   Fri, 27 Mar 2020 19:17:42 +0530
X-CMS-MailID: 20200327134742epcms5p46a971a1f5653956a287898e01a296dee
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZdlhTS3cXa12cwd43FhbvuqazWSz5/pHN
        onnTKxaLOdf6mC22rWtntji26SmTA5vH4j0vmTz6tqxi9Pi8SS6AOYrLJiU1J7MstUjfLoEr
        Y9+dL4wF/0QrOprOsDUwHhbsYuTkkBAwkfi/azF7FyMXh5DAbkaJf7fWADkcHLwCghJ/dwiD
        1AgLuEms+PuUGcQWEpCTWDx1LRtIibCApsTNjSkgYTYBdYlfD3ewgNgiAnoSO+7sZAQZySzw
        klHiUPt0NohdvBIz2p+yQNjSEtuXb2UEsTkF/CQ+r53PDhEXlbi5+i2c/f7YfEYIW0Si9d5Z
        ZghbUOLBz92MMHO2LgC5jQvI7maUeL1jPROEM4VR4uPFt0wQVeYS/7vfgnXwCvhKHH0wiRXE
        ZhFQlViyYS8rRI2LxO2Pv8GuYxaQl9j+dg4zyJfMQF+u36UPUSIrMfXUOiaIEj6J3t9PmGAe
        2zEPxlaS2Hp9PtRICYm+zbug4h4SX0/sYoEE9DxmifWnfzFOYFSYhQjrWUg2z0LYvICReRWj
        ZGpBcW56arFpgWFearlecWJucWleul5yfu4mRnAy0fLcwTjrnM8hRgEORiUe3hVXa+OEWBPL
        iitzDzFKcDArifA+jayJE+JNSaysSi3Kjy8qzUktPsQozcGiJM47ifVqjJBAemJJanZqakFq
        EUyWiYNTqoExe+acQvs7eVVnkspP1MrymCr9EW0qbpud4xPu8fDpLiHjzN3rTlpfy9HvmRM2
        9U3ITc4rh3MuHcl6Wdw0bYu66dQKZ50S8xfSC+7++WdTd/uDYFZolrdT3+UzryU1FrKqHHRM
        9kxk19jTGFjwws5sR9x801c5T/ivHn78O3bJailtrm8ck/4osRRnJBpqMRcVJwIAd0TgiyID
        AAA=
X-CMS-RootMailID: 20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b
References: <20200327053515epcms5p1cd532ff3b1ac4b97d375a6336e3ded50@epcms5p1>
        <81d243b6c593e1edb6b36be87898fc57e1e5f0f2.camel@intel.com>
        <20200326144743epcms5p401053700dae86ae93749df5fc77a2807@epcms5p4>
        <20200304153920epcms5p47e26659f715177b0244f18c71e4b5fed@epcms5p4>
        <20200326145252epcms5p2b9b6bded2e2a5d9c68e680e9de403662@epcms5p2>
        <CGME20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p4>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

 
Hi Inga,

>--------- Original Message ---------
>Sender : Anupam Roy <anupam.r@samsung.com> Staff Engineer/Application S/W Group /SRI-Delhi/Samsung Electronics
>Date : 2020-03-27 11:07 (GMT+5:30)
>Title : RE: Re: Mesh Key Refreshment procedure from Config client
> 
>Hi Inga,
> 
>> 
>>Hi Anupam,
>> 
>>On Thu, 2020-03-26 at 20:22 +0530, Anupam Roy wrote:
>>> Hi ,
>>>  Presently, I am trying to check *Key Refreshment Procedure* from Mesh Config client.
>>> 
>>> For checking the operation, I did following steps
>>>  - Create Subnet in Config client at Net index 1
>>>  - Add SubNetKey to Local Node at Net Index 1
>>>  - Add SubNetKey to Remote Node at Net Index 1
>>> 
>> 
>>Please try to add two steps more here:
>>   - Update Subnet 1 (subnet-update command in main menu)
>I missed mentioning above step in my email. Actually, before updating netkey to remote, I did update local subnet.
>But yes, I missed out below step (Updating netkey to local node). Will give it a try now. Much thanks!
>

After updating the Netkey to the local node(config client) and then to the remote node, I monitored the beaconing key used by local config client.
Please note that since, only two netkeys are at presently configured in both the nodes, therefore, the key ID's are 1 (for primary netkey at index 0), 2(For Netkey at index 1) & 3(For new NetKey at index 1).

After NetKey update, The KR phase in both sides are set to 1, but it seems, the new key id (which is 3 in this case) is still *NOT used for beaconing, by the 'Config Client node'
Config Client still keeps on beaconing with key ID 1 & 2. Sharing a bit of logs for your reference.

During NetKey Update-
mesh/cfgmod-server.c:cfg_srv_pkt() CONFIG-SRV-opcode 0x8045 size 18 idx 000
key refresh phase 1: Key ID 3

Beacon Keys after NetKey update on remote Node -
mesh/net-keys.c:snb_timeout() beacon 2 for 1 nodes, period 30, obs 2, exp 3
mesh/net-keys.c:snb_timeout() beacon 1 for 1 nodes, period 20, obs 2, exp 2

Please share your opinion to check the issue further. Thank You
 
>>   - Update NetKey 1 for a local node (switch to config menu)
>> 
>>>  - Update Netkey to remote Node in Net index 1
>>> 
>>> After updating the Netkey, I believe, config client has to either send out SNB with KeyRefreshment(KR) Flag=1 & secured with updated NetKey (i.e by subnet->net_key_upd id)
>>> or send out "Config Key Refresh Phase Set" with transition parameter, set to 2. I could not find the later provision in cfgclient menu.
>>> However, Config Client seems to be not sending out Secure Network Beacon as well. So KR procedure seems to be not progressing at my setup at present.
>>> 
>>> Any hint of what could be missing will be really helpful! Thank You.
>>> 
>> 
>>Best Regards,
>>Inga

BR,
-Anupam Roy
