Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09C3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 19:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC386136F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 19:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhJSTFK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 15:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234361AbhJSTFK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 15:05:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AEDA61038;
        Tue, 19 Oct 2021 19:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634670177;
        bh=RsQAfgGZ7HHYxOQV3sBT14CqZ0djO4xM9ugRdS1ySWg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tjuEXB22RWY7Gfrh7dw/Ekh/faALlzeG8KhISyrbnc0b3IMtvpon0L74/htIOHLrX
         cnuDSr7y3dItAKdWpvA3baNQWu9vVxli97Kfpn3Apdr6YcoJwgxDQCVY7mn7f52nKQ
         xrLni5DXKZjwvVDzc9iAq0BgGDFkhWDO4iVmj+zOg5ah8kUnAwoS5Aw2EP3j7MbXJO
         Ow0Dq1nvn8ePZZVV+B7R97RqVV601iL5Pg2uJdqpZx9nqOo+KAvgQvK7aSZTtMt0z3
         al/Y6zGEdo5B+VJBE753Osv+kQY99kfXZb5wnFcCRTmI46hDYo3MBudpiHHV11IOQB
         ++qH6uG67RCPQ==
Date:   Tue, 19 Oct 2021 12:02:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     bluez.test.bot@gmail.com,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [1/2] bluetooth: use eth_hw_addr_set()
Message-ID: <20211019120256.0ba89955@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <90247148-9F5A-4D25-9700-27070659C4C5@holtmann.org>
References: <20211019163346.1384785-1-kuba@kernel.org>
        <616f0064.1c69fb81.3a2d8.9416@mx.google.com>
        <20211019110533.5665cc90@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <90247148-9F5A-4D25-9700-27070659C4C5@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 19 Oct 2021 20:26:39 +0200 Marcel Holtmann wrote:
> >> Thank you for submitting the patches to the linux bluetooth mailing list.
> >> This is a CI test results with your patch series:
> >> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=566505  
> > 
> > Eish, sorry, you need 40af35fdf79c ("netdevice: demote the type of some
> > dev_addr_set() helpers") from net-next for this change to build cleanly.
> > 
> > What are your plans on sending a PR for net-next? Probably easiest if I
> > resend this after such PR? Or apply directly to net-next.  
> 
> we have one more pull request for you in the works, but I was not planning
> to rebase bluetooth-next if not needed. So just go ahead and take the patch
> directly into net-next.
> 
> Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Will do, thanks!
