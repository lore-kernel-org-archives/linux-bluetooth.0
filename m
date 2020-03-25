Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E8BC43331
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 21:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8472082D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 21:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgCYVZK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:25:10 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40174 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVZK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 17:25:10 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0BEE0CECD6;
        Wed, 25 Mar 2020 22:34:40 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [BlueZ PATCH v4 1/5] mgmt: Update docs for Add Device
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200319185000.BlueZ.v4.1.Idb4f0444e40064a861ee73b098264abd30114aaa@changeid>
Date:   Wed, 25 Mar 2020 22:25:07 +0100
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>, alainm@chromium.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E2FD0076-97EC-4CF6-B8D6-D7E4087459F6@holtmann.org>
References: <20200320015023.85896-1-abhishekpandit@chromium.org>
 <20200319185000.BlueZ.v4.1.Idb4f0444e40064a861ee73b098264abd30114aaa@changeid>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

> Update the docs for Add Device with information on flags mask and value.
> Add information on the Wakeable flag that can be set to allow the device
> to wake the system from suspend.
> ---
> 
> Changes in v4:
> * Newly added support in Add Device for flags
> 
> Changes in v3: None
> Changes in v2: None
> 
> doc/mgmt-api.txt | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 27a41f334..e99c23710 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -1997,6 +1997,8 @@ Add Device Command
> 	Command Parameters:	Address (6 Octets)
> 				Address_Type (1 Octet)
> 				Action (1 Octet)
> +				Flags Mask (1 Octet)
> +				Flags Value (1 Octet)

so we can actually not do that. This is not backwards compatible since the current kernel version have a strict size check for the command parameter size of Add Device.

Is there a problem to just introduce action 3 as I mentioned before?

Regards

Marcel

