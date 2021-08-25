Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8D9C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 17:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D7F610E8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 17:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhHYRpj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Aug 2021 13:45:39 -0400
Received: from vern.gendns.com ([98.142.107.122]:40544 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233405AbhHYRpj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Aug 2021 13:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=huGsUFwIPThK61p3wjNu91TtEXOY29J/+YXbtebsPz0=; b=yEgxNrj/6TLkFQQ7G+4INDvXD7
        9Dwr7mCUucKEGdgR4u4DbIdbDYS7+dyx/QTEZfU90QLcY3sltSvJivCtAtQldnYBgpoPSK5zYlZRh
        FZLnfMEauWwJS/0eFGqB1nVno+WrBnj/Gejv4mTRj4xjBy/FIyLWI1E3zCWlOKenL58tpqCKv1zF2
        vhOGlq3CuO+vnWaoEPJdjhkl+k6NGRrb/SdEAVujLKjpDVLAoeRlfMWacFcW9uBWU9ST2VXtHPvnd
        Q0rIaEaTYO1oHBNIIk2shOjVfIy/Sd4Yz2c3xVX/cnM/0O/7P3rYrilgLUdchklpd14TGgF8UCoUX
        UhoEnLuQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:56538 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mIwx9-0007WS-Mc; Wed, 25 Aug 2021 13:44:52 -0400
Subject: Re: [PATCH BlueZ] device: Remove GATT Attribute when device is
 removed
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20210824225202.826941-1-luiz.dentz@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <0028fab2-5707-8011-d3f6-d14c7337d449@lechnology.com>
Date:   Wed, 25 Aug 2021 12:44:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824225202.826941-1-luiz.dentz@gmail.com>
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

On 8/24/21 5:52 PM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes the GATT Attribute cache to be removed when device is removed
> just like SDP ServiceRecords.
> 
> Fixes: https://github.com/bluez/bluez/issues/191
> ---
Tested-by: David Lechner <david@lechnology.com>

But wouldn't it be better to just delete the file altogether?
This would prevent any future sections from being forgotten to
be removed as well.

I sent an alternative patch that does this: "device: delete
cache file when device is removed"
