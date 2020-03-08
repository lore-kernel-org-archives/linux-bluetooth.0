Return-Path: <SRS0=rf5u=4Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B30C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Mar 2020 09:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634BE2072A
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Mar 2020 09:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgCHJC3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Mar 2020 05:02:29 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51596 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgCHJC3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Mar 2020 05:02:29 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 94DD7CED15;
        Sun,  8 Mar 2020 10:11:56 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v3 4/5] Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED
 connections
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200303005623.18917-4-luiz.dentz@gmail.com>
Date:   Sun, 8 Mar 2020 10:02:27 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0EA19DAC-700B-456F-AA3A-0502B226F6D7@holtmann.org>
References: <20200303005623.18917-1-luiz.dentz@gmail.com>
 <20200303005623.18917-4-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This uses the DEFER_SETUP flag to group channels with
> L2CAP_CREDIT_BASED_CONNECTION_REQ.

I would make clear that this is just for the outgoing connection case. And we might want to have incoming and outgoing working before we apply this patch.

In addition, I think we need an L2CAP socket tester that really exercises this and ensure that it really works perfectly.

Regards

Marcel

