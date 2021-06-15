Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098EAC48BDF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 20:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D97D0613B1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 20:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFOUIE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jun 2021 16:08:04 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47685 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFOUID (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jun 2021 16:08:03 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id AF510CECFB;
        Tue, 15 Jun 2021 22:13:58 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [Bluez PATCH] monitor: Adding missing device found flag in the
 parser
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210615200005.946131-1-alainm@chromium.org>
Date:   Tue, 15 Jun 2021 22:05:57 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Yu Liu <yudiliu@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <DAF1B1B4-9F58-4564-9E74-7D69BF41C53B@holtmann.org>
References: <20210615200005.946131-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> A new flag was added to the kernel implementation of the Device Found
> event, but had not been added to the parser leading to an "Unknown device
> flag" error in btmon.
> 
> Reviewed-by: Yu Liu <yudiliu@google.com>
> ---
> 
> monitor/packet.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 82513a63c..2c3a6cebf 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -12033,6 +12033,7 @@ static const struct bitfield_data mgmt_device_flags_table[] = {
> 	{  0, "Confirm Name"	},
> 	{  1, "Legacy Pairing"	},
> 	{  2, "Not Connectable"	},
> +	{  3, "Connection Locally Initiated"	},
> 	{ }

please fix also the other }, so that they align.

Regards

Marcel

