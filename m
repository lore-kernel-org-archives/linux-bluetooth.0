Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C94C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Sep 2021 08:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F2BA60E97
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Sep 2021 08:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhIQIPW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Sep 2021 04:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhIQIPW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Sep 2021 04:15:22 -0400
X-Greylist: delayed 520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Sep 2021 01:14:00 PDT
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF01C061767
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Sep 2021 01:14:00 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id E65811FACD;
        Fri, 17 Sep 2021 10:04:37 +0200 (CEST)
Date:   Fri, 17 Sep 2021 10:04:36 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Barry Byford <31baz66@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Sanchayan Maity <sanchayan@asymptotic.io>
Subject: Re: Deprecated Python Libraries
Message-ID: <20210917080436.hjs3fsezznlqcxay@SoMainline.org>
References: <CAAu3APZAJD-uPUO1d4g=7smD34LUzkn87MkQKfdEcTC41FM5Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAu3APZAJD-uPUO1d4g=7smD34LUzkn87MkQKfdEcTC41FM5Vg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Barry,

On 2021-09-17 08:03:36, Barry Byford wrote:
> The Python examples in the test directory have some dependencies that
> have issues:
> [..]
> Would there be any interest in getting patches to change to these
> different libraries?
> Are these test scripts used in any of the automated tests?
> Can I submit a PR via https://github.com/bluez/bluez/pulls?

Perhaps of relevance: Sanchayan (cc'd) imporved some scripts for Python
3 compatibility (Python 2 is already deprecated for the better part of
1.5 years) and proper formatting [1] while working on BT LDAC [2], some
patches made it to the list [3] but were ultimately never merged.
Sanchayan, would you be willing to resubmit these?  Alternatively Barry
can pick them up as part of their quest to improve the scripts for
longevity?

Disclaimer: I'm not a maintainer, merely a passer-by so don't take my
comment as an acknowledgement to go ahead with the changes.  But if you
do I think everyone appreciates improved shebangs and PEP8 style
formatting (I find `black` to perform formatting nicely) along the way
just like Sanchayan's patches.

[1]: https://gitlab.freedesktop.org/SanchayanMaity/bluez/-/commits/python3/
[2]: https://gitlab.freedesktop.org/gstreamer/gst-plugins-bad/-/merge_requests/1621
[3]: https://lore.kernel.org/linux-bluetooth/?q=sanchayan

Thanks!
- Marijn
