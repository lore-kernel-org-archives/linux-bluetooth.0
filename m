Return-Path: <SRS0=msOO=M2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CAFC71122
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Oct 2018 08:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0DA204FD
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Oct 2018 08:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0DA204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeJNQNz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Oct 2018 12:13:55 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43154 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeJNQNy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Oct 2018 12:13:54 -0400
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id A6714CF351;
        Sun, 14 Oct 2018 10:41:00 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v2 1/2] Bluetooth:LE credit based connection result values
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1538731093-30347-1-git-send-email-mallikarjun.phulari@intel.com>
Date:   Sun, 14 Oct 2018 10:33:39 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8B488454-DB15-4DED-B3F9-7AEB16C3CE28@holtmann.org>
References: <1538731093-30347-1-git-send-email-mallikarjun.phulari@intel.com>
To:     Mallikarjun Phulari <mallikarjun.phulari@intel.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mallikarjun,

> Added the result values specific to LE Credit based connection
> And changing the old result values wherever they were used
> 
> Signed-off-by: Mallikarjun Phulari <mallikarjun.phulari@intel.com>
> ---
> include/net/bluetooth/l2cap.h | 17 +++++++++++------
> net/bluetooth/l2cap_core.c    | 26 +++++++++++++-------------
> 2 files changed, 24 insertions(+), 19 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

