Return-Path: <SRS0=WaXy=Z7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C83C43603
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Dec 2019 15:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C970A20726
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Dec 2019 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575905872;
	bh=s2bEYWf197utEz/SWsvPqfz1Q0KP1wD9/JS+5YS9CYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JIzAvsLu/QG6uLKPjdcgitiJWu5ZTpofcW0xeFllYPgOKA1Xzis1KsKgsxG2hiuGA
	 N7N12MtIWlJq0fpcVNBwlAxZxyvrtb+h/gMmIjmigsG/CcetcNDHAnkG71f1qWmlDh
	 4l2IWdbAHUnBCWNKnnEcfPh+J+zcB+G7xfx431F8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfLIPhr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:37:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfLIPhr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Dec 2019 10:37:47 -0500
Received: from localhost (unknown [89.205.132.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71CAA20726;
        Mon,  9 Dec 2019 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575905867;
        bh=s2bEYWf197utEz/SWsvPqfz1Q0KP1wD9/JS+5YS9CYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9+sU8EvFsTmpzSetgEcKgYYK66YVsUDReVMz1qiS69wSltGYaDf60DLq8wNbun/6
         DAUNwFkEgg1rq1gTfG9AaCbW8t/Ob/+8xwJDUcKPYNnYxyC+UCpDVIcMg1lZTnBPOD
         gy/OygZek5VMfY3cWArKhoqDIGt8es0lTw4/1fq8=
Date:   Mon, 9 Dec 2019 16:37:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     devel@driverdev.osuosl.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        isdn4linux@listserv.isdn4linux.de,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/2] staging: remove isdn capi drivers
Message-ID: <20191209153743.GA1284708@kroah.com>
References: <20191209151114.2410762-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209151114.2410762-1-arnd@arndb.de>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Dec 09, 2019 at 04:11:13PM +0100, Arnd Bergmann wrote:
> As described in drivers/staging/isdn/TODO, the drivers are all
> assumed to be unmaintained and unused now, with gigaset being the
> last one to stop being maintained after Paul Bolle lost access
> to an ISDN network.
> 
> The CAPI subsystem remains for now, as it is still required by
> bluetooth/cmtp.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Nice!  You beat me to it :)

I'll go queue this up soon.

David, any objection for me taking patch 2/2 here as well?

thanks,

greg k-h
