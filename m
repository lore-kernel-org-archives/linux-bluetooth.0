Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C0AC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 12:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2F02086D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 12:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547813974;
	bh=TW1hvzIk+ZtPQzsZvG7jLbYnOs9X0NMHQIquCauPGTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i4IBkNFY711fUpKblnrmJkemxweSfIBU7ATBa16SWJhkJyJWQpGgbE9huxb72O+Wi
	 fDABtzmg9L2ZHkZrzaL58sJXhvVVO80Z+JgAauj1F0dt02bDQCv9gaF1QcbQogzQOl
	 UaIyczu4b5aBSSLR/JjJVjD4OtWcIMqrgwwMWUEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfARMTe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:19:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbfARMTe (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 07:19:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04FB820652;
        Fri, 18 Jan 2019 12:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547813973;
        bh=TW1hvzIk+ZtPQzsZvG7jLbYnOs9X0NMHQIquCauPGTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vBY+B0MDUs8oYwD3MbfZ/ullLvv96CNX58XJEV0ctVRVb8EG4fA7NNMdnYfp1iUK5
         0LsSad1WmalVGNIFtm5JuEFbECe+Gnl7HFZJbGgVRsmHR4FnDBOY/DPH/Lj9wwTXrh
         LbvoHn8Bek0pSuJF2L9DEqFzld2UR06H+dU4mBRU=
Date:   Fri, 18 Jan 2019 13:19:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Check L2CAP option sizes returned from
 l2cap_get_conf_opt
Message-ID: <20190118121931.GA4793@kroah.com>
References: <20190118115620.7562-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118115620.7562-1-marcel@holtmann.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jan 18, 2019 at 12:56:20PM +0100, Marcel Holtmann wrote:
> When doing option parsing for standard type values of 1, 2 or 4 octets,
> the value is converted directly into a variable instead of a pointer. To
> avoid being tricked into being a pointer, check that for these option
> types that sizes actually match. In L2CAP every option is fixed size and
> thus it is prudent anyway to ensure that the remote side sends us the
> right option size along with option paramters.
> 
> If the option size is not matching the option type, then that option is
> silently ignored. It is a protocol violation and instead of trying to
> give the remote attacker any further hints just pretend that option is
> not present and proceed with the default values. Implementation
> following the specification and its qualification procedures will always
> use the correct size and thus not being impacted here.
> 
> To keep the code readable and consistent accross all options, a few
> cosmetic changes were also required.

Ah, that's a much nicer patch than mine, I like it.  As long as the code
for handling things when an option is not set properly works ok (which
I'm guessing it is as that would have been found out long ago), this
makes everything much simpler.

> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

