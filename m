Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDAAC433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 09:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B6B21D43
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 09:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600247209;
	bh=Dfwbci88DTkyCRzDTgwvZH7qGaycD4hKjVm1q2R6nDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZG+512nesLGL4/QhD0MAboNrqb1Ejz4wvL3J02XMQPHVlvwU6LGZs5eY0Q6FSmUjr
	 FIYd4Sm3yU8zaAdnLhwFqzObO+PJP9FGgr6ZJCn2YKXGWWM4PcnhW2P06qgCnijMcO
	 VVDLLQdCnQc3F1iYBNN6rN8D1ITZYlJ7Eiyl4Z0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgIPJGe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 05:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgIPJGb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 05:06:31 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B20F921974;
        Wed, 16 Sep 2020 09:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600247190;
        bh=Dfwbci88DTkyCRzDTgwvZH7qGaycD4hKjVm1q2R6nDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bsWQuzvWoVSuUq700Adg7BMCU+7Pad8dakDZORQGKVPwk48j/EqXdFnRrGzLT44TS
         oWbbT033KjoAt97oXXS1a6qmCQwJ9WUqELN0czuU7AO8AfvZBv/JXdcnYCjj9M+5kf
         GQRn/mLUWDrHjqL9HyfVntGTUcmgZZMahsKZZ84w=
Date:   Wed, 16 Sep 2020 11:06:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        stern@rowland.harvard.ed, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 04/11] USB: core: hub.c: use usb_control_msg_send() in
 a few places
Message-ID: <20200916090641.GA710715@kroah.com>
References: <20200914153756.3412156-1-gregkh@linuxfoundation.org>
 <20200914153756.3412156-5-gregkh@linuxfoundation.org>
 <20200914180616.GB972479@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914180616.GB972479@rowland.harvard.edu>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Sep 14, 2020 at 02:06:16PM -0400, Alan Stern wrote:
> On Mon, Sep 14, 2020 at 05:37:49PM +0200, Greg Kroah-Hartman wrote:
> > There are a few calls to usb_control_msg() that can be converted to use
> > usb_control_msg_send() instead, so do that in order to make the error
> > checking a bit simpler and the code smaller.
> > 
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > v3:
> >  - drop change in usb_enable_link_state() as it was not needed now
> >    thanks to review from Alan
> >  - minor changes requested by checkpatch.pl
> > 
> > v2:
> >  - dropped changes to usb_req_set_sel() thanks to review from Alan
> > 
> >  drivers/usb/core/hub.c | 99 +++++++++++++++++-------------------------
> >  1 file changed, 40 insertions(+), 59 deletions(-)
> 
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

Thanks for the review!

greg k-h
