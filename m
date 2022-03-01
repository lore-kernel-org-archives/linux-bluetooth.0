Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EAFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 16:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbiCAQCR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 11:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiCAQCQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 11:02:16 -0500
Received: from nmtao202.oxsus-vadesecure.net (mta-202a.oxsus-vadesecure.net [51.81.232.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E9EAB477
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 08:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; bh=p0Z4Z39zfJ23LPgxcdCw1G1/6VeC8QLa90ih2H
 JXN2Q=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1646150493;
 x=1646755293; b=lwBJxK6+OCKhSJuDXorYRAVtBoMUGTCTZo7bhwI+K7pVxCZ19OIgo+W
 1IfG9PN3sYVO3qh6UBZI/LnCl9f7FCIu4U9pD5MAMCbB5G9HsQ7NL2o41inPS+KMQniWcZS
 T4E1maDxhvnsG69XMDBEAnKQN7o+NYMo6VJqILVvL8bfjBHhhXOyKqBWGXnzr+/ZX5F8IUU
 qzdAqmigaHEZoyoMZmKX4fNQ1P92360ErbM3AMYCkZ827SPt5uTjnqiEE3ugpbM895J2LNI
 r/+zp+1xqGEd8Knjtj3/N7Hmb9JYo3nzE11wplNWmuclPIzMYGRE0RZ61PrYjuIFkqx3IFk
 t+g==
Received: from [192.168.1.152] ([104.185.76.86])
 by smtp.oxsus-vadesecure.net ESMTP oxsus2nmtao02p with ngmta
 id 3bb4fc7f-16d84d26f0ac2de5; Tue, 01 Mar 2022 16:01:33 +0000
Message-ID: <307e7ee7-b973-4d15-03fd-31cc6087163b@mindspring.com>
Date:   Tue, 1 Mar 2022 11:01:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Battery1 vs. GATT reporting
Content-Language: en-US
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
References: <f46af838-8b28-79e6-5298-4458b44664ca@mindspring.com>
 <CAO271m=RNShfq+zRQjX=yK8NkUDwknr0mekJsCg_Rny3s0gUgA@mail.gmail.com>
 <72122fe6-8c8b-d26e-9c1d-75462052b503@mindspring.com>
 <CAO271m=-nxu238MKCtM-Kc1T88UOO4V2qyon0zF3ifVcThBsPA@mail.gmail.com>
From:   Ed Beroset <beroset@mindspring.com>
In-Reply-To: <CAO271m=-nxu238MKCtM-Kc1T88UOO4V2qyon0zF3ifVcThBsPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 3/1/22 10:43, Sonny Sasaka wrote:
> Hi Ed,
> 
> What I do is call `gatt.select-attribute` on the characteristic called
> "Battery Level", but it is not shown in your case. So maybe this is
> the bug that you are encountering. What is the exact version of your
> BlueZ (commit sha if possible)? Could you also try tip of tree to see
> if this is already fixed?

Hi Sonny,

I'm sorry, I should have noted that this is with the tip of tree, commit 
bf09e1f048.  Thanks for your help with this!

Ed
