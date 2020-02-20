Return-Path: <SRS0=cA0y=4I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F849C761A1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 07:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC0A24654
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 07:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgBTH2x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:28:53 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:45477 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgBTH2w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Feb 2020 02:28:52 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 401B1CECDC;
        Thu, 20 Feb 2020 08:38:16 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] Bluetooth: RFCOMM: Use MTU auto tune logic
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200220053155.27352-1-luiz.dentz@gmail.com>
Date:   Thu, 20 Feb 2020 08:28:50 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <38B8EE73-B050-4378-93CC-09BD360985CD@holtmann.org>
References: <20200220053155.27352-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This reuse the L2CAP MTU auto logic to select the MTU used for RFCOMM
> channels, this should increase the maximum from 1013 to 1021 when 3-DH5
> is supported.
> 
> Since it does not set an L2CAP MTU we no longer need a debugfs so that
> is removed.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/rfcomm.h |  1 -
> net/bluetooth/rfcomm/core.c    | 10 ++++------
> 2 files changed, 4 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

