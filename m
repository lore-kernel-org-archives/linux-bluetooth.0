Return-Path: <SRS0=PsJ4=5Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5666AC2D0EA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 06:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D5820747
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 06:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgDHGP0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Apr 2020 02:15:26 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60820 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgDHGP0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Apr 2020 02:15:26 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id AC95FCECE0;
        Wed,  8 Apr 2020 08:24:59 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: Update resolving list when updating whitelist
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANFp7mXR+N7syYE6EdNH-+jE9r-uPHHfN8EvAFSUFUT7sbGVCw@mail.gmail.com>
Date:   Wed, 8 Apr 2020 08:15:24 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B424D264-32AB-47CE-BE13-6073887AE23E@holtmann.org>
References: <20200407205611.1002903-1-marcel@holtmann.org>
 <CANFp7mXR+N7syYE6EdNH-+jE9r-uPHHfN8EvAFSUFUT7sbGVCw@mail.gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

> Since the resolv list is tied directly to the whitelist, do we still
> need hdev->le_resolv_list? Maybe we should remove it.

it is really useful for debugging since you can look into debugfs to see what is actually programmed into the controller. I also have the feeling that eventually we might need the resolving list when we have privacy enabled.

Regards

Marcel

