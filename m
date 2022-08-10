Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDBBC25B07
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Aug 2022 16:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiHJQWu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiHJQWt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 12:22:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EDE760F5;
        Wed, 10 Aug 2022 09:22:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB97CB81D67;
        Wed, 10 Aug 2022 16:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB92C433C1;
        Wed, 10 Aug 2022 16:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660148563;
        bh=IAfv6FZXTpCajsjH9FvUV4bXDF3bq9z6ECzyK3sG5W0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LuUl3a3PGi0+43jPPVmy4Ko9UBFQfKAz6Ypa1n4ALOgqLZVxXh9dVCHBuFMYEy9Zw
         j2MVah/r3K7g0M5TF51hE2SJRDIJTN6eE4BDeY1ik7imnTSlqouAxS+okjQBQhQqC2
         Yv6wuemBXvszG7yheewLEYeuRRDn5NAACjNg3+UE=
Date:   Wed, 10 Aug 2022 18:22:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Arend van Spriel <aspriel@gmail.com>, marcel@holtmann.org,
        luiz.dentz@gmail.com, Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-bluetooth@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Won Chung <wonchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] sysfs: Add attribute info for
 /sys/devices/.../coredump_disabled
Message-ID: <YvPbUDQ3HXmOgfwu@kroah.com>
References: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Aug 10, 2022 at 09:00:34AM -0700, Manish Mandlik wrote:
> +Date:		July 2022

You wrote this patch in August...
