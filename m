Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258ECC2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 20:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0272124655
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 20:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAVUXh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:23:37 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:34325 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUXh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jan 2020 15:23:37 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 051C6CECF6;
        Wed, 22 Jan 2020 21:32:55 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] bluetooth: fix appearance typo in mgmt.c
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200122194744.239645-1-alainm@chromium.org>
Date:   Wed, 22 Jan 2020 21:23:35 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0168AEE4-0CFC-4A29-A446-145242150240@holtmann.org>
References: <20200122194744.239645-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change addresses a typo in the set_appearance handler.
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> net/bluetooth/mgmt.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

