Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043B9C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 06:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjE3GeE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 02:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjE3GeC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 02:34:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A10BF
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 23:34:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30ae141785bso3058531f8f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 23:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685428439; x=1688020439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4OAxSq+jDW1WBhQxxiq1fw9sqlEfd/X+gHC/8nQV2Q8=;
        b=dZARwajkzeFy7RSYrno9jhXUgHyLuu/RuFnjS4XXpgpXSMelswQB+6cuDqXfwm165j
         Xd0lbfarSol9PoyFokMTzYW6GSZ1UTGgmewpv6LGSZpyPoOO4eiwKEhQAc52SeiIAj05
         ZW+2YcAtMRD3i38aFW/ls4cd9urGQuTfdSIj+iNlwubWvnSjljlXxoKd/Ljorsv5myvT
         8+FBjGUMCbjVRb4ri+xnFHCBvPINk2a72J1wxSVdLmM1KbzI+oyVQYopnKUd6bZNhWIL
         ymZy4q7rUQPyLhmtAN1HDeAYlOxrObofEVWWuvr+bQpsOwRKizyEDZ/C9yMxsVJQMPn7
         oNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685428439; x=1688020439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OAxSq+jDW1WBhQxxiq1fw9sqlEfd/X+gHC/8nQV2Q8=;
        b=c2X04N7X90nyo5z801aqGll8SQ6QRQE6vuD1YbbsmOOGzsutaapZKyr7gakf36G/bO
         Hc13cUfff0hk5umrZakgX7luUsu03r72b4a8GquHgEQvGXYsjjX/u7JP4GtQQLydbl5L
         y8HtDzEBIbNijWaIfi9aDZJYiw6AlYOafPpdlGF7qQQoL88qoD4wsETPE/m65jpnyTjz
         ewAVkO6xVQ5KjT+cEeNbOzoSu6UNBn0t8gxleTxQ9kxAQQ/4iyDgIYO/Qn9m9GlcgfYd
         aXpLVic+16i017cJ4IgMyVDvPz1khjH/rz40RmZsM/Cq652xK2fQ3EgCtVuyASeiusvk
         bXzA==
X-Gm-Message-State: AC+VfDwR96w+20OPpE200CBGcYScr9OPxmaFsNRlvFIVydubkzJC69X0
        0B+R42bNJLZLibNQCHwdVf8ElQ==
X-Google-Smtp-Source: ACHHUZ6W8BZBm/qIjRNH2p9MGYVv/PsNQ9y2uoGYHDIsU2X7jekAcnXCTyOUAT4jwY11Q8ZxAdNrIw==
X-Received: by 2002:a5d:6582:0:b0:30a:e5bc:547c with SMTP id q2-20020a5d6582000000b0030ae5bc547cmr781984wru.9.1685428439590;
        Mon, 29 May 2023 23:33:59 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w12-20020a5d544c000000b002fed865c55esm2091935wrv.56.2023.05.29.23.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 23:33:57 -0700 (PDT)
Date:   Tue, 30 May 2023 09:33:53 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: L2CAP: don't check for out-of-bounds value
Message-ID: <e4d89235-6446-4bd4-8ab8-7b53a89d0f19@kili.mountain>
References: <20230526-l2cap-16bit-v1-1-2cfb83dd28ee@kernel.org>
 <fdab8adc-0f61-4664-a2f9-6f532b0c85be@kili.mountain>
 <ZHDOGNhIu9pjDKVM@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHDOGNhIu9pjDKVM@kernel.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, May 26, 2023 at 05:19:52PM +0200, Simon Horman wrote:
> On Fri, May 26, 2023 at 05:34:30PM +0300, Dan Carpenter wrote:
> > On Fri, May 26, 2023 at 04:16:54PM +0200, Simon Horman wrote:
> > > @@ -4161,8 +4161,12 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
> > >  
> > >  	result = L2CAP_CR_NO_MEM;
> > >  
> > > -	/* Check for valid dynamic CID range (as per Erratum 3253) */
> > > -	if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_DYN_END) {
> > > +	/* Check for valid dynamic CID range (as per Erratum 3253).
> > > +	 * As scid is an unsigned 16bit variable it's maximum
> > > +	 * value is L2CAP_CID_DYN_END (0xffff): there is no need to check
> > > +	 * if scid exceeds that value here.
> > > +	 */
> > > +	if (scid < L2CAP_CID_DYN_START) {
> > 
> > This is a false positive.  To me the warning looks reasonable.  But one
> > way we could silence it would be to keep a list of macros where the
> > check is impossible but we still want to have it.
> 
> Hi Dan,
> 
> I do agree that the existing code is harmless.
> Is this why you feel it is a false positive?
> 

Actually I was thinking of something else, but the other reason why this
is harmless is because it's part of a "clamp both upper and lower
bounds" condition.  Linus doesn't like these warnings because it's clear
to a human reader what the intent is. I re-wrote this code last week to
avoid this kind of warning.  I will push that so now it won't warn.  I
still need to tweak the re-written code a bit.

> > I could create something where we do:
> > 
> > echo "L2CAP_CID_DYN_END" >> smatch_data/kernel.allowed_impossible_limits
> > 
> > I'd do the same for unsigned comparisons with zero like:
> > 
> > 
> >         if (dpmcp_dev->obj_desc.ver_major < DPMCP_MIN_VER_MAJOR ||
> >             (dpmcp_dev->obj_desc.ver_major == DPMCP_MIN_VER_MAJOR &&
> >              dpmcp_dev->obj_desc.ver_minor < DPMCP_MIN_VER_MINOR)) {
> >              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >                 dev_err(&dpmcp_dev->dev,
> >                         "ERROR: Version %d.%d of DPMCP not supported.\n",
> > 
> > echo "DPMCP_MIN_VER_MINOR" >> smatch_data/kernel.allowed_impossible_limits
> 
> FWIIW, I've noticed problems with comparisons to enums. Which, f.e., may in
> practice are unsigned values of a particular width for a given build.
> But in theory could be any type.

Enum types are undefined in C but I think Sparse (and thus Smatch)
follow the same rules as GCC basically so they should catch these bugs.

	int x;

	if (x < ENUM_ZERO)  <-- x is negative but type promoted to uint

regards,
dan carpenter

