Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C85EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 21:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjGTVZ4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jul 2023 17:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjGTVZz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jul 2023 17:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36C626AC
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 14:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 416C861C5B
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 21:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD44C433C8;
        Thu, 20 Jul 2023 21:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689888353;
        bh=NFP685XN668i1Crn2t0Bt62w8dHk0p52c2Ko9JGGOCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cNoDFFqTSXqybZpPEF/mONpPfTyPLW/y5LMo5AgSd2I4Vfxzhi+LsBGmgNcZz5x/e
         YVDXsHhirXMnUrDeeIYriuVXhu9e6crW42PACH93eBHjdGCBEcebe5MjWqq/6gDeWO
         QAgLR4343UdE5+HFczeLt9/qnP9rDoQPqXpD3ebJIJLKCX5lgg72fCEK4AOJOqElHc
         2hZm+3ZygyQL12WsM8obBF0cLKEUarlrBl0y/BfPYaL1olm7BKjFgvfoJHTDdAxtBj
         1F+bDEN+3CB+8Wz+USZ0aQZYetyo3x9FnoKCOsJRvJSgmTYYdDWeugEtM8R4aDnzbe
         HslYCZrg1k7xA==
Date:   Thu, 20 Jul 2023 14:25:52 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: pull-request: bluetooth 2023-07-20
Message-ID: <20230720142552.78f3d477@kernel.org>
In-Reply-To: <20230720190201.446469-1-luiz.dentz@gmail.com>
References: <20230720190201.446469-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 20 Jul 2023 12:02:00 -0700 Luiz Augusto von Dentz wrote:
> bluetooth pull request for net:
> 
>  - Fix building with coredump disabled
>  - Fix use-after-free in hci_remove_adv_monitor
>  - Use RCU for hci_conn_params and iterate safely in hci_sync
>  - Fix locking issues on ISO and SCO
>  - Fix bluetooth on Intel Macbook 2014

One bad fixes tag here, but good enough.
Hopefully the big RCU-ifying patch won't blow up :)
