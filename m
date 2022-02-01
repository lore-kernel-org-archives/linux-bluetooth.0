Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBA3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Feb 2022 09:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbiBAJc6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Feb 2022 04:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbiBAJcz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Feb 2022 04:32:55 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CBEC061714
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Feb 2022 01:32:54 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id ED4F21BF212;
        Tue,  1 Feb 2022 09:32:52 +0000 (UTC)
Message-ID: <de2e9b1426587214fcb1b28bb3bec265fd8f9044.camel@hadess.net>
Subject: Re: [PATCH 1/4] build: Always define confdir and statedir
From:   Bastien Nocera <hadess@hadess.net>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Tue, 01 Feb 2022 10:32:52 +0100
In-Reply-To: <61d3fea272805d6bfb1a6cf5883404ea7e294e7c.camel@hadess.net>
References: <20220126113638.1706785-1-hadess@hadess.net>
         <78f77f0268ce1b4818c0a0749d3371b825fa1c92.camel@hadess.net>
         <390473B8-2187-4C84-B319-9D4A8FB6ED0A@holtmann.org>
         <61d3fea272805d6bfb1a6cf5883404ea7e294e7c.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 2022-01-26 at 14:45 +0100, Bastien Nocera wrote:
> This change specifically? Check the next patches in the series, and
> you'll see pretty quickly.
> 
> For the rest of the patchset, check this man page for details on each
> of the directives:
> https://www.freedesktop.org/software/systemd/man/systemd.exec.html#Security
> 
> There's a fair amount of other directives we could use on top of
> those
> ones, but we can add them iteratively (and it makes bisecting easier,
> in case we forget about a particular use case).

Did you have any more questions about this patchset?
