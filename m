Return-Path: <SRS0=Rbfz=PS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8058C43444
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 06:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7156206B7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 06:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547101819;
	bh=V/CdG3iG9BRaMncFPjZUdymnKqcm6TC85bGyctHgSJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k2UaLkON74LqCv3NhGZMZrg+9gwM77a13i+dg/b+8KRU60z8xLd2oGLd9oaFvwo4H
	 qasHXYeHDBF5ZhfCA63PqXKHhtqKshwtiR9kuLF6phdDbfwkYe1YYecnEN27yxo/+D
	 KP0ex6SSuHjLVfKXmWGOwWIjSO345JZP1zjyYpEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbfAJGaR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:30:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfAJGaR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jan 2019 01:30:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39145206B7;
        Thu, 10 Jan 2019 06:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547101816;
        bh=V/CdG3iG9BRaMncFPjZUdymnKqcm6TC85bGyctHgSJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1u35AacnN4u7+GdYQvImmTC59wcyWPGIC/o4l8eFPukKVQKzaAsp8chjP8oOEOcho
         Noybc5jDXzfR5GiPoeP3+joyT27fbp9uugBrSShZz9QZTAuSUHxxGEVQpXTEmo77v4
         KHJ8kT20YnHNHGdZc3MdtPPiLet5XEWj75c2eE6o=
Date:   Thu, 10 Jan 2019 07:30:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Ran Menscher <ran.menscher@karambasecurity.com>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: check the buffer size for some messages
 before parsing
Message-ID: <20190110063013.GD15047@kroah.com>
References: <20190110062833.GA15047@kroah.com>
 <20190110062917.GB15047@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110062917.GB15047@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Jan 10, 2019 at 07:29:17AM +0100, Greg Kroah-Hartman wrote:
> The L2CAP_CONF_EFS and L2CAP_CONF_RFC messages can be sent from
> userspace so their structure sizes need to be checked before parsing
> them.
> 
> Based on a patch from Ran Menscher.

Ran, can you verify if these two patches solve the problems you reported
or not?

thanks,

greg k-h
