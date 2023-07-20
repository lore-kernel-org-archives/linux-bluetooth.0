Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F607EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 21:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGTVpH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jul 2023 17:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGTVpH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jul 2023 17:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62961270D
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 14:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E61C461C9C
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 21:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D149C433C7;
        Thu, 20 Jul 2023 21:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689889505;
        bh=e1310xhq8DUzL3X6BmVQoKMIBVFp6CTMKurK2dIpPiE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kEIQVSafgL15jTNPmvRTSrZP4uvo1vrUWTTaS/Fyw/gJHPHty3uo5OkjyO48kqxei
         LZqAE4GmOLjYIl65FVRa5czbzzz7DgxlNHBT6SJX+uyIpcAKf21EKJTD7ARVcFLyXQ
         OXmWie2HW+bRIkVpH6hgNOQYe8vAFMXE4AT6pYqh3oW80mVLE9N1xzhKVOSvIAOhig
         FgMhExZWooNnbuxsOPQUq4EPL5fh4mpO2v7Ht9+DSN2rrZBkGUOhE2Zz0zwhpoBSBu
         K9p/aWNOcOxQ+UQBoYXkWi9Nq3YNq4BJWRmWx+Gr+yrWiXpwvcueiH7OtOMwVzeegz
         LyiBNb6yjof2g==
Date:   Thu, 20 Jul 2023 14:45:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: pull-request: bluetooth 2023-07-20
Message-ID: <20230720144504.5f14f58b@kernel.org>
In-Reply-To: <CABBYNZL9puVzX7ELtR7UQGSU1=YFVWfdKWBmcGf4X5m3bRCS3w@mail.gmail.com>
References: <20230720190201.446469-1-luiz.dentz@gmail.com>
        <20230720142552.78f3d477@kernel.org>
        <CABBYNZL9puVzX7ELtR7UQGSU1=YFVWfdKWBmcGf4X5m3bRCS3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 20 Jul 2023 14:30:02 -0700 Luiz Augusto von Dentz wrote:
> > One bad fixes tag here, but good enough.
> > Hopefully the big RCU-ifying patch won't blow up :)  
> 
> Weird, I'd run verify-fixes and it didn't show up anything. 

I think it works by checking the git database. If the commit exists 
in your git it will not complain. So you need a somewhat pristine
repo instance to avoid false negatives.
