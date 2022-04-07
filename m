Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846F4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Apr 2022 08:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbiDGIft (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Apr 2022 04:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiDGIfs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Apr 2022 04:35:48 -0400
Received: from mail.pelzflorian.de (pelzflorian.de [5.45.111.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A68123D59D
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Apr 2022 01:33:48 -0700 (PDT)
Received: from pelzflorian.localdomain (unknown [5.45.111.108])
        by mail.pelzflorian.de (Postfix) with ESMTPSA id 32655360631;
        Thu,  7 Apr 2022 10:33:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pelzflorian.de;
        s=mail; t=1649320426;
        bh=IX278aZVBREwnHWCvRbpPIjn+27SgBbStA5WcqC32jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=E0yKfB8vq1qPZetTbNwn1kzA+tsRWhsC937kfdLiTXi/ofUlLYZUedWihEcMky4If
         rYkW0gFLjxKOwQ9L/2Rf30+R7+6NKLMheylrpiD/3YwR5xd1zsU4HlI+4IQmwTgI8j
         82u7KZH0rzJndgNUkxC/azMq1wOSqAB9355VXac8=
Date:   Thu, 7 Apr 2022 10:33:38 +0200
From:   "pelzflorian (Florian Pelz)" <pelzflorian@pelzflorian.de>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [v2] main: Remove unused main.conf option NameResolving
Message-ID: <20220407083338.tcznjaoaayeywnwy@pelzflorian.localdomain>
References: <20220406084357.iai4k6jvg6gnnbyi@pelzflorian.localdomain>
 <624da59d.1c69fb81.2e0bd.0aa2@mx.google.com>
 <20220406160832.y5mw64ey45donzew@pelzflorian.localdomain>
 <CABBYNZK7YtxDkf_SPqYsrnc_xNaSOa0MyhEhKSQ1jOJboDuf=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZK7YtxDkf_SPqYsrnc_xNaSOa0MyhEhKSQ1jOJboDuf=g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Apr 06, 2022 at 04:27:03PM -0700, Luiz Augusto von Dentz wrote:
> Regarding the use of the name resolving afaik we should make use of it
> for legacy devices perhaps that was not taken into account when
> changing the code lately but we should probably use it to make the
> kernel skip asking for the device name.

OK thank you!  The commit that made NameResolving a no-op is ten years old
though; nobody seems to need it.

Regards,
Florian
