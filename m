Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826CFC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 08:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D328206F6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 08:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="teTG6rwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbgCaIHy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:07:54 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:58713 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCaIHy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 04:07:54 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200331080751epoutp02699f40995f4f4974a50352ba6c85b5e3~BVRAqB6_U2586525865epoutp02x
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 08:07:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200331080751epoutp02699f40995f4f4974a50352ba6c85b5e3~BVRAqB6_U2586525865epoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585642071;
        bh=NjlnHR3fhBKA0SAJqoz+Thf4YOwBmBCFjCmOwjiksXU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=teTG6rwty97J5otIRKbQYsvnmDt5gptayMwuu2zA3otfOX4sMuUE0uxXi/WiXYU9v
         ooJA22qIEYJWzckntDStyBBc4AZMABvNq7dNEM31o4WsaioXdcypS0E+sW+fWsWrqq
         FI6m9DSKcE6PO0Avi4Sy+flZTmyG6dQhhKJE1Rus=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200331080751epcas5p1e24e145fd56bb9efd21277fc55e64777~BVRAH6--O1706517065epcas5p1V;
        Tue, 31 Mar 2020 08:07:51 +0000 (GMT)
X-AuditID: b6c32a4a-353ff700000012aa-fc-5e82fa57194d
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.4D.04778.75AF28E5; Tue, 31 Mar 2020 17:07:51 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: RE: Re: Mesh Key Refreshment procedure from Config client
Reply-To: anupam.r@samsung.com
From:   Anupam Roy <anupam.r@samsung.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
CC:     Dohyun Pyun <dh79.pyun@samsung.com>,
        Semun Lee <semun.lee@samsung.com>,
        Nitin Jhanwar <nitin.j@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        AMIT KUMAR JAISWAL <amit.jaiswal@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <f10ab3eeb9691d20544d0a65b08027fe2de3c26a.camel@intel.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200331080503epcms5p58d933114e7cd69177727a293eef3ba5b@epcms5p5>
Date:   Tue, 31 Mar 2020 13:35:03 +0530
X-CMS-MailID: 20200331080503epcms5p58d933114e7cd69177727a293eef3ba5b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZdlhTSzf8V1OcwZHpHBbvuqazWSz5/pHN
        onnTKxaLOdf6mC22rWtntji26SmTA5vH4j0vmTz6tqxi9Pi8SS6AOYrLJiU1J7MstUjfLoEr
        43PrJZaCo8oVC47vZm9g3CLdxcjJISFgIvFn9UamLkYuDiGB3YwSv84cZuxi5ODgFRCU+LtD
        GKRGWMBLYuGRDnYQW0hATmLx1LVsICXCApoSNzemgITZBNQlfj3cwQJiiwjoSey4s5MRZCSz
        wEtGicZ1h9khdvFKzGh/ygJhS0tsX76VEcTmFHCX2PLvOjNEXFTi5uq37DD2+2PzGSFsEYnW
        e2ehagQlHvzczQgzZ+uCp8wgyyQEuhklXu9YzwThTGGU+HjxLRNElbnE/+63YB28Ar4SZ+8c
        BbuCRUBV4tP0a6wQNS4S/bsOgdUzC8hLbH87hxnkS2agL9fv0ocokZWYemodVAmfRO/vJ0ww
        j+2YB2MrSWy9Ph9qpIRE3+ZdUHEPia8ndrFAAno+i0RHXzP7BEaFWYiwnoVk8yyEzQsYmVcx
        SqYWFOempxabFhjlpZbrFSfmFpfmpesl5+duYgQnEy2vHYzLzvkcYhTgYFTi4X1wtTFOiDWx
        rLgy9xCjBAezkggvm39DnBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeSaxXY4QE0hNLUrNTUwtS
        i2CyTBycUg2MXjVJScuudoXzWLSaFt5e86AwqFH91AvF5A0VCh3v+1ctMd836evjW9MWGJ64
        LF9+3Gf/LjWLhH8Cvgxcr+YUifdX7z5z69yDoMt/1vw8lXlpV6/jNolTeb/mfmK9dqU0/U8L
        r4aTk+TXiyYbpU/MMuYJ+qKz2LP17sz6BCP9kDNbl59X/LQrX4mlOCPRUIu5qDgRAI7nKtAi
        AwAA
X-CMS-RootMailID: 20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b
References: <f10ab3eeb9691d20544d0a65b08027fe2de3c26a.camel@intel.com>
        <20200327053515epcms5p1cd532ff3b1ac4b97d375a6336e3ded50@epcms5p1>
        <81d243b6c593e1edb6b36be87898fc57e1e5f0f2.camel@intel.com>
        <20200326144743epcms5p401053700dae86ae93749df5fc77a2807@epcms5p4>
        <20200304153920epcms5p47e26659f715177b0244f18c71e4b5fed@epcms5p4>
        <20200326145252epcms5p2b9b6bded2e2a5d9c68e680e9de403662@epcms5p2>
        <20200327134742epcms5p46a971a1f5653956a287898e01a296dee@epcms5p4>
        <CGME20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p5>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

>--------- Original Message ---------
>Sender : Stotland, Inga <inga.stotland@intel.com>
>Date : 2020-03-30 11:35 (GMT+5:30)
>Title : Re: RE: Re: Mesh Key Refreshment procedure from Config client
> 
>Hi Anupam,
> 
>On Fri, 2020-03-27 at 19:17 +0530, Anupam Roy wrote:
>>  
>> Hi Inga,
>> 
>> > --------- Original Message ---------
>> > Sender : Anupam Roy <
>> > anupam.r@samsung.com
>> > > Staff Engineer/Application S/W Group /SRI-Delhi/Samsung
>> > Electronics
>> > Date : 2020-03-27 11:07 (GMT+5:30)
>> > Title : RE: Re: Mesh Key Refreshment procedure from Config client
>> > 
>> > Hi Inga,
>> > 
>> > > Hi Anupam,
>> > > 
>> > > On Thu, 2020-03-26 at 20:22 +0530, Anupam Roy wrote:
>> > > > Hi ,
>> > > >  Presently, I am trying to check *Key Refreshment Procedure*
>> > > > from Mesh Config client.
>> > > > 
>> > > > For checking the operation, I did following steps
>> > > >  - Create Subnet in Config client at Net index 1
>> > > >  - Add SubNetKey to Local Node at Net Index 1
>> > > >  - Add SubNetKey to Remote Node at Net Index 1
>> > > > 
>> > > 
>> > > Please try to add two steps more here:
>> > >   - Update Subnet 1 (subnet-update command in main menu)
>> > 
>> > I missed mentioning above step in my email. Actually, before
>> > updating netkey to remote, I did update local subnet.
>> > But yes, I missed out below step (Updating netkey to local node).
>> > Will give it a try now. Much thanks!
>> > 
>> 
>> After updating the Netkey to the local node(config client) and then
>> to the remote node, I monitored the beaconing key used by local
>> config client.
>> Please note that since, only two netkeys are at presently configured
>> in both the nodes, therefore, the key ID's are 1 (for primary netkey
>> at index 0), 2(For Netkey at index 1) & 3(For new NetKey at index 1).
>> 
>> After NetKey update, The KR phase in both sides are set to 1, but it
>> seems, the new key id (which is 3 in this case) is still *NOT used
>> for beaconing, by the 'Config Client node'
>> Config Client still keeps on beaconing with key ID 1 & 2. Sharing a
>> bit of logs for your reference.
>> 
>> During NetKey Update-
>> mesh/cfgmod-server.c:cfg_srv_pkt() CONFIG-SRV-opcode 0x8045 size 18
>> idx 000
>> key refresh phase 1: Key ID 3
>> 
>> Beacon Keys after NetKey update on remote Node -
>> mesh/net-keys.c:snb_timeout() beacon 2 for 1 nodes, period 30, obs 2,
>> exp 3
>> mesh/net-keys.c:snb_timeout() beacon 1 for 1 nodes, period 20, obs 2,
>> exp 2
>> 
>> Please share your opinion to check the issue further. Thank You
> 
>Indeed, there's a missing functionality in mesh-cfgclient tool: key
>refresh phase commands.
>The patch set  that I posted today should address the issue:
>[PATCH BlueZ 1/2] tools/mesh-cfgclient: Save subnet key refresh phase
>[PATCH BlueZ 2/2] tools/mesh-cfgclient: Add commands for Key Refresh
>Phase
> 
>The beaconing will start  updated network key once the Key Refresh
>procedure advances to phase 2:
>1. "subnet-set_phase <net_index> 2" from the main menu
>2. "kr_phase_set <net_index> 2" from  the config menu (sent to either
>local or remote node or both).
>     The transition to phase 2 can happen either as a result of a
>directly setting a phase on a node or by
>     detecting a beacon with KR bit set (which, of course assumes that
>at least one node got it's phase set
>    directly and that that node has beaconing enabled) .
> 
>Similar steps to finish Key Refresh procedure: set phase 3 for subnet
>and send phase command to node(s)
> 
Sure, will try this. Thanks for the update & detailed response.

> 
>>  
>> > >   - Update NetKey 1 for a local node (switch to config menu)
>> > > 
>> > > >  - Update Netkey to remote Node in Net index 1
>> > > > 
>> > > > After updating the Netkey, I believe, config client has to
>> > > > either send out SNB with KeyRefreshment(KR) Flag=1 & secured
>> > > > with updated NetKey (i.e by subnet->net_key_upd id)
>> > > > or send out "Config Key Refresh Phase Set" with transition
>> > > > parameter, set to 2. I could not find the later provision in
>> > > > cfgclient menu.
>> > > > However, Config Client seems to be not sending out Secure
>> > > > Network Beacon as well. So KR procedure seems to be not
>> > > > progressing at my setup at present.
>> > > > 
>> > > > Any hint of what could be missing will be really helpful! Thank
>> > > > You.
>> > > > 
>> > > 
>> > > Best Regards,
>> > > Inga
>> 
>> BR,
>> -Anupam Roy
 
