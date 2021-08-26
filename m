Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D00DC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 16:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D767660FC0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 16:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243021AbhHZQs1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:48:27 -0400
Received: from vern.gendns.com ([98.142.107.122]:56290 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhHZQs1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Aug 2021 12:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JrTj3ZaBGeOfLa1monJNJIeXFMDm+vsbTWa5wx/+tTk=; b=JdSaxKru8OUuK7e4c1VKR0YB6N
        boSL7VtmUrNEwy+QXWtVuq9+yAZ1gqW4kYphoaAiq4qpEblAR8NZG1CS4ShOT7NeN3LpXbbuft6eM
        RUgAoSfb2FGTVWWRvneHlEfrsVrJ4BcXLxb5vcv5iOvykMYG7Ll12YEW4oasnXMNlZYdfTec/0fSH
        QBEqDx0KIrALk3B1A650UOk2n2NTwY+9X40nXS+qOZb7bkrmHt9U2je+nq0veEIQ53qoEi/ehI3iS
        V1BYP7hEM9thWGKBe0eUb48EjAElI2bnYUATEB/Hr8qUVyn0nrlU17hGFxddTN/GFskCXdR/ua3D5
        Uq0JXj+g==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:57298 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mJIXH-0008LX-Ah; Thu, 26 Aug 2021 12:47:38 -0400
Subject: Re: AW: [PATCH BlueZ v2 1/2] device: clear eir_uuids list on
 disconnect
To:     Eisenkolb Thomas <Eisenkolb.Thomas@fronius.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20210825165125.2675544-1-david@lechnology.com>
 <20210825165125.2675544-2-david@lechnology.com>
 <CABBYNZJzTmpvcaw5eDa9awvVZYQdJuKW7EQSYfpMOCzhorP8cg@mail.gmail.com>
 <c74ad033ff8240f8a77b00c6f8f678a0@fronius.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <88edfef4-404d-4baf-cf0a-1b1a888399f5@lechnology.com>
Date:   Thu, 26 Aug 2021 11:47:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c74ad033ff8240f8a77b00c6f8f678a0@fronius.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 8/25/21 11:24 PM, Eisenkolb Thomas wrote:
> Hello,
> 
> I have just found the same problem even if [GATT] Cache = no is set in main.conf.
> It is simply the same because the device is held as temporary device.
> 
> Additionally the method "dev_property_get_uuids" in device.c only returns UUIDs of
> the cached (temporary hold) device because dev->le_state.svc_resolved is not turned
> to false on disconnect. So if a disconnected device advertised an new UUID, you never
> get notified about it through dbus.
> 
> Through DBus device node I would expect to get both UUID lists. The cached ones and
> also the advertised ones.
> Actually I just merge the two lists and provide the result to DBus device->UUIDs request.
> 
> Hope you can change this.
> 

This series has already been applied, so it can't be changed.

If you are still having problems after this series, can you share some
logs so that we can see exactly the problem?



