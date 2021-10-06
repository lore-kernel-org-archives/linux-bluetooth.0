Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C7EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 17:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22C40610C8
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 17:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhJFRh4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:37:56 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37287 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbhJFRhz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 13:37:55 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 55474CECD1;
        Wed,  6 Oct 2021 19:36:02 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH V2] Bluetooth: mgmt: Fix Experimental Feature Changed
 event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211006163228.154401-1-hj.tedd.an@gmail.com>
Date:   Wed, 6 Oct 2021 19:36:01 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <D7FCA4BD-A3AE-413F-BFC1-E910E55CD906@holtmann.org>
References: <20211006163228.154401-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> This patch fixes the controller index in the Experimental Features
> Changed event for the offload_codec and the quality_report features to
> use the actual hdev index instead of non-controller index(0xffff) so the
> client can receive the event and know which controller the event is for.
> 
> Fixes: 9332efdf02e9 ("Bluetooth: Add offload feature under experimental flag")
> Fixes: 50a75f15531a ("Bluetooth: Support the quality report events")
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> net/bluetooth/mgmt.c | 15 +++++++++------
> 1 file changed, 9 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree, but I had to fix the commit ids.

Regards

Marcel

