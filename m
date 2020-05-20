Return-Path: <SRS0=JpWv=7C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFBFC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 14:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10CB205CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 14:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgETOeL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 May 2020 10:34:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56560 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgETOeL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 May 2020 10:34:11 -0400
Received: from marcel-macbook.fritz.box (p4fefc5a7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id B7B22CED09;
        Wed, 20 May 2020 16:43:54 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/4] Bluetooth: Fix assuming EIR flags can result in SSP
 authentication
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200519202519.219335-2-luiz.dentz@gmail.com>
Date:   Wed, 20 May 2020 16:34:10 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C478BA49-0BBF-4323-AC3A-30442F65D346@holtmann.org>
References: <20200519202519.219335-1-luiz.dentz@gmail.com>
 <20200519202519.219335-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> EIR flags should just hint if SSP may be supported but we shall verify
> this with use of the actual features as the SSP bits may be disabled in
> the lower layers which would result in legacy authentication to be
> used.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_conn.c | 2 --
> 1 file changed, 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

