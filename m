Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D60C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 May 2023 15:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbjEZPT7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 May 2023 11:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243725AbjEZPT6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 May 2023 11:19:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28717E7
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 08:19:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B323661278
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 15:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAC8C4339B;
        Fri, 26 May 2023 15:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685114397;
        bh=2/koG5iBtXxHvPqcFmQwiEyZN+OwaDK7OQ8WT55ULmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Om5TFV0pnsghl5yMG23bvhLmSSjm8GpgrlPzXTWC+1RWe721QmB/C81b2/bF/1ha8
         A0c2cl3n1dbKDkLVgv7PCG+3HaUCZM4G2s30BFCiK1+hN3mEnbGiqxP3jOb9r92XEF
         E7ps9k6r+n2dAG/sGbufA3TSQ2dyY74eynOo0cSciaE+s4+GjO69I4iFa7uwA/hBK/
         3szMmZA81ZhAQ0mU2Jw6YYqMoNUKWuq0IuWXgc6i+ceQS2r224B/HX0Z+tMMyu96M7
         EdSPJYsq0U0Q0mTzU7JpDb7XF6NjG89edoSuNfnRwfRDqR+g+ZbicLxiDgJ8/l5hTd
         DuxJUrOOPEpaw==
Date:   Fri, 26 May 2023 17:19:52 +0200
From:   Simon Horman <horms@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: L2CAP: don't check for out-of-bounds value
Message-ID: <ZHDOGNhIu9pjDKVM@kernel.org>
References: <20230526-l2cap-16bit-v1-1-2cfb83dd28ee@kernel.org>
 <fdab8adc-0f61-4664-a2f9-6f532b0c85be@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdab8adc-0f61-4664-a2f9-6f532b0c85be@kili.mountain>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, May 26, 2023 at 05:34:30PM +0300, Dan Carpenter wrote:
> On Fri, May 26, 2023 at 04:16:54PM +0200, Simon Horman wrote:
> > @@ -4161,8 +4161,12 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
> >  
> >  	result = L2CAP_CR_NO_MEM;
> >  
> > -	/* Check for valid dynamic CID range (as per Erratum 3253) */
> > -	if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_DYN_END) {
> > +	/* Check for valid dynamic CID range (as per Erratum 3253).
> > +	 * As scid is an unsigned 16bit variable it's maximum
> > +	 * value is L2CAP_CID_DYN_END (0xffff): there is no need to check
> > +	 * if scid exceeds that value here.
> > +	 */
> > +	if (scid < L2CAP_CID_DYN_START) {
> 
> This is a false positive.  To me the warning looks reasonable.  But one
> way we could silence it would be to keep a list of macros where the
> check is impossible but we still want to have it.

Hi Dan,

I do agree that the existing code is harmless.
Is this why you feel it is a false positive?

> I could create something where we do:
> 
> echo "L2CAP_CID_DYN_END" >> smatch_data/kernel.allowed_impossible_limits
> 
> I'd do the same for unsigned comparisons with zero like:
> 
> 
>         if (dpmcp_dev->obj_desc.ver_major < DPMCP_MIN_VER_MAJOR ||
>             (dpmcp_dev->obj_desc.ver_major == DPMCP_MIN_VER_MAJOR &&
>              dpmcp_dev->obj_desc.ver_minor < DPMCP_MIN_VER_MINOR)) {
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                 dev_err(&dpmcp_dev->dev,
>                         "ERROR: Version %d.%d of DPMCP not supported.\n",
> 
> echo "DPMCP_MIN_VER_MINOR" >> smatch_data/kernel.allowed_impossible_limits

FWIIW, I've noticed problems with comparisons to enums. Which, f.e., may in
practice are unsigned values of a particular width for a given build.
But in theory could be any type.

Perhaps the system you propose above would be useful for silencing
warnings about such problems? They seem to be a subset of the problem
at hand.

> I can do that on Monday if you want.  Other static checkers might
> complain still though.

No rush from my side.
