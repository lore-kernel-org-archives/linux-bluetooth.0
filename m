Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3482EC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Oct 2022 02:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbiJACQZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 22:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiJACQY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 22:16:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ACD16EAB5;
        Fri, 30 Sep 2022 19:16:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A9DCB82B43;
        Sat,  1 Oct 2022 02:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3F9C433C1;
        Sat,  1 Oct 2022 02:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664590580;
        bh=bC6tIllA2OEQjNrS/Pz5nDxnANJu/zOE5RgYEa5ln78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YrInKNs4avgg10+TGzX+OWKxpzDKyZxQTxrF5iUX0+QPsgyqH2xVpZzp6bWF1Yn6l
         TISwvDprTPMyna47fJXMKLFZJ/hzVJblLlWN4HS8Ih2u8dt7P3dQwqEzZ7SEGNfieB
         HNu/V1shlVdQNP3VXithyLhdyDJOGbwX1YPNwAxpbZkI8p8cJ2litqGeG71HTQESNM
         hvLxTK9zVrzO5JOE869Q6iSAZyelq9EjRVRlRUHJzYRxzIOqLFb3OemGPCFaYn1CV+
         +MiPOSuhqjqhMZRXejKboKls+BIWJFLwiyK/pt0c14epg0oi5BHfizkF0LZdgKEk0D
         PBtZ6/agnk/gw==
Date:   Fri, 30 Sep 2022 19:16:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: bluetooth-next 2022-09-30
Message-ID: <20220930191619.39899ce0@kernel.org>
In-Reply-To: <20221001004602.297366-1-luiz.dentz@gmail.com>
References: <20221001004602.297366-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, 30 Sep 2022 17:46:02 -0700 Luiz Augusto von Dentz wrote:
> bluetooth-next pull request for net-next:
> 
>  - Add RTL8761BUV device (Edimax BT-8500)
>  - Add a new PID/VID 13d3/3583 for MT7921
>  - Add Realtek RTL8852C support ID 0x13D3:0x3592
>  - Add VID/PID 0489/e0e0 for MediaTek MT7921
>  - Add a new VID/PID 0e8d/0608 for MT7921
>  - Add a new PID/VID 13d3/3578 for MT7921
>  - Add BT device 0cb8:c549 from RTW8852AE
>  - Add support for Intel Magnetor

Pulled, thanks!
