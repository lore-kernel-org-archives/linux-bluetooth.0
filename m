Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E9AC64EC4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 08:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjCJIMI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 03:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCJILo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 03:11:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285881086A2;
        Fri, 10 Mar 2023 00:11:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3499ACE27AE;
        Fri, 10 Mar 2023 08:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06720C433D2;
        Fri, 10 Mar 2023 08:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678435858;
        bh=l/tbFRJdqLxf/aFRZsC+76ui01Q9QwpZnNKLvNPHWF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oM48fKM18LyvPVaARA7ZtGt7SsIwkBSQCyaTak/3i6rNP7dwiOgryhk7hqf3OpO89
         hNcgT2VKODBLr/uhNovcQe27JaX/a/X/K0xzO9CKr5/qmvCHYJ2CwOpmLCdUvCcLno
         /0tNvUFtDvgDZeFoeQvis/MjMGk6GnnxzOKPf+Ms=
Date:   Fri, 10 Mar 2023 09:10:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     fnkl.kernel@gmail.com
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] bluetooth: btbcm: Fix logic error in forming the
 board name.
Message-ID: <ZArmD064NVhNS96C@kroah.com>
References: <20230224-btbcm-wtf-v1-1-d2dbd7ca7ae4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224-btbcm-wtf-v1-1-d2dbd7ca7ae4@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Mar 10, 2023 at 09:07:33AM +0100, Sasha Finkelstein via B4 Relay wrote:
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
> 
> This patch fixes an incorrect loop exit condition in code that replaces
> '/' symbols in the board name. There might also be a memory corruption
> issue here, but it is unlikely to be a real problem.
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  drivers/bluetooth/btbcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
