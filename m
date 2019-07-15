Return-Path: <SRS0=pDNe=VM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35240C76191
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 17:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2BA2081C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 17:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbfGOROM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:14:12 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52504 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbfGOROM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jul 2019 13:14:12 -0400
Received: from [192.168.22.163] (unknown [157.25.100.178])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7F3FACEEB9;
        Mon, 15 Jul 2019 19:22:44 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] v3 Fast Advertising Interval
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1563190522-23651-1-git-send-email-spoorthix.k@intel.com>
Date:   Mon, 15 Jul 2019 19:14:08 +0200
Cc:     linux-bluetooth@vger.kernel.org, bharat.b.panda@intel.com
Content-Transfer-Encoding: 7bit
Message-Id: <FBF9BD43-EE1B-4D20-853C-19301B5573A0@holtmann.org>
References: <1563190522-23651-1-git-send-email-spoorthix.k@intel.com>
To:     SpoorthiX K <spoorthix.k@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Spoorthi,

> Changes made to add support for fast advertising interval
> as per core 4.1 specification, section 9.3.11.2.
> 
> A peripheral device entering any of the following GAP modes and
> sending either non-connectable advertising events or scannable
> undirected advertising events should use adv_fast_interval2
> (100ms - 150ms) for adv_fast_period(30s).
> 
>         - Non-Discoverable Mode
>         - Non-Connectable Mode
>         - Limited Discoverable Mode
>         - General Discoverable Mode
> 
> Signed-off-by: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_request.c      | 32 ++++++++++++++++++++++----------
> 2 files changed, 24 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

