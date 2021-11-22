Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253B2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Nov 2021 23:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhKVXJo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Nov 2021 18:09:44 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:50297 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhKVXJn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Nov 2021 18:09:43 -0500
Received: (Authenticated sender: hadess@hadess.net)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 41982240003;
        Mon, 22 Nov 2021 23:06:35 +0000 (UTC)
Message-ID: <45caaa82b56528fed03e534103f55f2ebbdc3885.camel@hadess.net>
Subject: Re: [PATCH v2] uhid: Remove local copy of uhid header
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Tue, 23 Nov 2021 00:06:34 +0100
In-Reply-To: <20211122211707.2219208-1-luiz.dentz@gmail.com>
References: <20211122211707.2219208-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 2021-11-22 at 13:17 -0800, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> uhid.h is part of kernel uapi nowadays so it can be included
> directly from linux/uhid.h so this removes the local copy to use it
> instead.

This will cause the same problems that importing those headers into the
repository was supposed to solve. If you remove those headers, then
older distributions will be stuck on old kernel headers, and bluez
compilations will regularly fail when it uses new structs, struct
members, functions, or constants that are in the upstream uapi headers
but not yet propagated to the user's distribution.

Strong NAK on this one and the uinput header change too.
