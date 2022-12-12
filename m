Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4F4C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Dec 2022 14:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiLLOte convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Dec 2022 09:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiLLOtd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Dec 2022 09:49:33 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8EE13D00
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Dec 2022 06:49:27 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 4053320003;
        Mon, 12 Dec 2022 14:49:25 +0000 (UTC)
Message-ID: <988dc1f9add28a70ba18ce2f3042aac0bea04b5b.camel@hadess.net>
Subject: Re: [PATCH BlueZ 0/1] Expose the disconnect reason over D-Bus
From:   Bastien Nocera <hadess@hadess.net>
To:     Arthur Crepin-Leblond <arthur@marmottus.net>,
        linux-bluetooth@vger.kernel.org
Date:   Mon, 12 Dec 2022 15:49:25 +0100
In-Reply-To: <20221212133235.79657-1-arthur@marmottus.net>
References: <20221212133235.79657-1-arthur@marmottus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 2022-12-12 at 14:32 +0100, Arthur Crepin-Leblond wrote:
> Hello,
> 
> I am trying to expose the device disconnect reason over D-Bus and the
> most elegant way I found was to subscribe to the adapter notify
> callback that gives the reason as an argument.

Any reason why this can't be a signal with the reason as an argument?
