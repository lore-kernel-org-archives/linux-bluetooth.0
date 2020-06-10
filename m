Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F7EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E612070B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 17:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgFJR7Y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:59:24 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52235 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgFJR7Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 13:59:24 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id BE013CECE9;
        Wed, 10 Jun 2020 20:09:12 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] doc: Add commands and event for handling device flags
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANFp7mUdL2eB8pWf1sfL_zC0zqTvc7QQuv8xR-pBSDds-Mg5Qw@mail.gmail.com>
Date:   Wed, 10 Jun 2020 19:59:22 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <1750110E-C32C-41F8-AD8B-0A318E61AD11@holtmann.org>
References: <20200406180331.891822-1-marcel@holtmann.org>
 <CANFp7mXe3QtkKL8+TgTp=jwvpydABhDkiXks=3h4+op20rWhGQ@mail.gmail.com>
 <AC887BAA-95ED-456B-84D2-2D1EF6A8339F@holtmann.org>
 <CANFp7mU2+Z3f1ZqR8RCsOUu6Crc_xng12gcgn0YCwjzfH9Y-nQ@mail.gmail.com>
 <8FE42946-ED27-4F9F-8F30-2744D0AC2AB0@holtmann.org>
 <CANFp7mUdL2eB8pWf1sfL_zC0zqTvc7QQuv8xR-pBSDds-Mg5Qw@mail.gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

> Do you want to handle the implementation in the kernel or shall I send
> up a patch?

if you can adopt one of your earlier patches, that would be great. I am currently busy with a few other patches. So it would be bottom of my queue.

Regards

Marcel

