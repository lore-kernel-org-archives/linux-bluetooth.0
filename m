Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55103C4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B6260C3F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbhG2MY6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:24:58 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:54412
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231674AbhG2MYz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 08:24:55 -0400
Received: from [192.168.1.18] (unknown [222.129.38.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BC0953F079;
        Thu, 29 Jul 2021 12:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627561490;
        bh=+FXY2wcHq76jBObAXyKLbqyvrnML5nfK/kXk9WmeV+k=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=HwSvs3V5bC+WQ7a8ZWzSd+PslPpPWSroGLKnRIG3gLKc/SB4Itx0x7pnDIn3VuXn/
         tOJXGuqEryoPuS8j8ei5gK1HuIiGsztRDsShM6Y1ucWoRJij5ywNJLVEHpOK/rvI9y
         OuGIzHV92dj2uLW2/qcd03wWmgEE0NF+tTRFSGeRSdrssXKW2KKBfimzTHN9Js7Cyl
         jmqm1z/dzZdxQPkhVVzuKyTa0/tjJWNOaHt14FXiQfL+Teol/5Hcw9dlCIdxl2Am3m
         nOwZ+nMG9ZxH5SMjkCcrWNFIrjkGn6zCJlR+SsG0TGl651m81+SJhJJ7qpKBilxpiN
         Vu/D1RZ7VuF6A==
Subject: Re: [PATCH v2] Bluetooth: btusb: Add support for Foxconn Mediatek
 Chip
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        matthias.bgg@gmail.com,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org
References: <E6EC3615-DAC0-4267-AD9B-3B0604EDAD87@holtmann.org>
 <20210722171718.134034-1-aaron.ma@canonical.com>
 <117CE889-33B8-4D1D-A81F-AC2AC9A0371D@holtmann.org>
From:   Aaron Ma <aaron.ma@canonical.com>
Message-ID: <333d6607-a364-8f3d-be6b-1bb12c64815c@canonical.com>
Date:   Thu, 29 Jul 2021 20:24:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <117CE889-33B8-4D1D-A81F-AC2AC9A0371D@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel:

On 7/29/21 7:48 PM, Marcel Holtmann wrote:
> I can’t apply this cleanly to bluetooth-next tree. Please rebase it.
> 

You have already applied in bluetooth-next branch master.

Aaron

> Regards
> 
> Marcel
> 
