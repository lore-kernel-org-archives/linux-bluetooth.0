Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1490C001DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Aug 2023 23:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjHNXpv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Aug 2023 19:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjHNXpu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Aug 2023 19:45:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF491720
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Aug 2023 16:45:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9C68635FC
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Aug 2023 23:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE307C433C7;
        Mon, 14 Aug 2023 23:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692056748;
        bh=7WY5/jjo3v37KPDKPy5xuOgmTghpkqmD80Dxn/A2OIw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iqBcKMhoiRXSftTqrbpadPDKuoYY967yhV/gW5p+mW2BPaJd83NA5C5rMLt80GaJc
         s75ZX6g5WmgznYYQUGCbpiL8kKhASdAZ5B6NTcYSmg7hLtxDk87aqggNr9J8IKQShc
         s5QTnl4uWElfBBKS9YASvt1kXDm5JdPosmIJd1G5ARyZ4lSXcGuZaWK4A7blZuYiKO
         K41Q88FvZXVEb59Wexzho0ilL2nYve9ZRokziuKJZu22uDtSbrJWWK5VitWThimgNn
         1CaOfFPe8h6DjCBgjyQuO1CEWTFI8dAog9LNZqNYXTBKBeMmL/o6pVBYuhzGZRMSTl
         0pfM73+uhHdOg==
Date:   Mon, 14 Aug 2023 16:45:46 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2023-08-11
Message-ID: <20230814164546.71dbc695@kernel.org>
In-Reply-To: <20230811192256.1988031-1-luiz.dentz@gmail.com>
References: <20230811192256.1988031-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, 11 Aug 2023 12:22:56 -0700 Luiz Augusto von Dentz wrote:
> bluetooth-next pull request for net-next:
> 
>  - Add new VID/PID for Mediatek MT7922
>  - Add support multiple BIS/BIG
>  - Add support for Intel Gale Peak
>  - Add support for Qualcomm WCN3988
>  - Add support for BT_PKT_STATUS for ISO sockets
>  - Various fixes for experimental ISO support
>  - Load FW v2 for RTL8852C
>  - Add support for NXP AW693 chipset
>  - Add support for Mediatek MT2925

As indicated by Stephen's complaint about lack of an SoB tag,
it appears that DaveM merged this PR over the weekend :)
