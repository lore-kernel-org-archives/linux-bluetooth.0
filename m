Return-Path: <SRS0=Sobe=CX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FCFC43461
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 18:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A8B214F1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 18:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgINSGW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Sep 2020 14:06:22 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47267 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725957AbgINSGR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Sep 2020 14:06:17 -0400
Received: (qmail 972913 invoked by uid 1000); 14 Sep 2020 14:06:16 -0400
Date:   Mon, 14 Sep 2020 14:06:16 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        stern@rowland.harvard.ed, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 04/11] USB: core: hub.c: use usb_control_msg_send() in
 a few places
Message-ID: <20200914180616.GB972479@rowland.harvard.edu>
References: <20200914153756.3412156-1-gregkh@linuxfoundation.org>
 <20200914153756.3412156-5-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914153756.3412156-5-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Sep 14, 2020 at 05:37:49PM +0200, Greg Kroah-Hartman wrote:
> There are a few calls to usb_control_msg() that can be converted to use
> usb_control_msg_send() instead, so do that in order to make the error
> checking a bit simpler and the code smaller.
> 
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v3:
>  - drop change in usb_enable_link_state() as it was not needed now
>    thanks to review from Alan
>  - minor changes requested by checkpatch.pl
> 
> v2:
>  - dropped changes to usb_req_set_sel() thanks to review from Alan
> 
>  drivers/usb/core/hub.c | 99 +++++++++++++++++-------------------------
>  1 file changed, 40 insertions(+), 59 deletions(-)

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
