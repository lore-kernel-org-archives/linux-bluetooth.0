Return-Path: <SRS0=Nonw=CQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F9EC43461
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Sep 2020 14:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C057D2137B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Sep 2020 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599490717;
	bh=CxyQpGP9n8TbvTWZlcMnPBvQvdoM8Roi6NJr/4wY+3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CIgJh/e6kFx2ohAEBinbPGv4clWYQbPvBk87hP8qInyMMpmtqRUPwLh+4rPC4TXsM
	 k+c3TsqSqgBHsyYUSta3ZL9q4wQdOUtnz3Byk6x10T9rsD5E/yd1KqS5Yy3/nfVQuL
	 qkf0zNIydOhfc6s0W4/2g4mJ61rekkkTKsbFS1F0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgIGO6Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Sep 2020 10:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:32888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730081AbgIGO4a (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Sep 2020 10:56:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 136EF21532;
        Mon,  7 Sep 2020 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599490589;
        bh=CxyQpGP9n8TbvTWZlcMnPBvQvdoM8Roi6NJr/4wY+3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lLzcZLnJRYwJRZpj3pSMH+uuomTwjStzPuS6HLjLIR8uWd1c17Y4ebZXRr69gGDbk
         XzOwh+xBK4S0GODqAZ9+JB/lT9bmvkpwmYARCwsKMtJ5kSbtocsB4b0nmXhOEwQg8b
         HtSakIDPyMr4ieHYrnhthaO4x/1FviU5JovhMFEA=
Date:   Mon, 7 Sep 2020 16:56:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, stern@rowland.harvard.ed,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 03/11] USB: core: message.c: use
 usb_control_msg_send() in a few places
Message-ID: <20200907145644.GA3767938@kroah.com>
References: <20200907145108.3766613-1-gregkh@linuxfoundation.org>
 <20200907145108.3766613-4-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907145108.3766613-4-gregkh@linuxfoundation.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Sep 07, 2020 at 04:51:00PM +0200, Greg Kroah-Hartman wrote:
> There are a few calls to usb_control_msg() that can be converted to use
> usb_control_msg_send() instead, so do that in order to make the error
> checking a bit simpler.
> 
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Oops, Andy, sorry, you gave me a Reviewed-by: Andy Shevchenko
<andriy.shevchenko@linux.intel.com> on the previous version of this,
I'll add it next round, or when it's queued up.

thanks,

greg k-h
