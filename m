Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACC4C3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 11:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099CC208C3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 11:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCELKz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:10:55 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:57621 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCELKz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 06:10:55 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id CEBB5CECE9;
        Thu,  5 Mar 2020 12:20:21 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [BlueZ PATCH v2] Adding definitions for Wide Band Speech
 configuration
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200304203152.111935-1-alainm@chromium.org>
Date:   Thu, 5 Mar 2020 12:10:54 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <634EDB16-907F-42B8-A717-826EE334B1D5@holtmann.org>
References: <20200304203152.111935-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change adds the corresponding user space definition for wide band
> speech.
> 
> ---
> 
> lib/mgmt.h | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)

patch has been applied.

However I did change WIDE_BAND to WIDEBAND as mentioned in the other review.

Regards

Marcel

