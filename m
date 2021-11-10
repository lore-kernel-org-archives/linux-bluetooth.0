Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197A7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 09:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC3961105
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 09:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhKJJvW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Nov 2021 04:51:22 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:37276 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJJvV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Nov 2021 04:51:21 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id 47750CED38;
        Wed, 10 Nov 2021 10:48:33 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v2 1/2] Bluetooth: Ignore HCI_ERROR_CANCELLED_BY_HOST on
 adv set terminated event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJQfnxEXnoz3q750ZPN=32bS-fDg8pRRp2RqL3txMks-1DLsoQ@mail.gmail.com>
Date:   Wed, 10 Nov 2021 10:48:32 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <CC006C8F-26D7-44DB-BDAE-93960C474472@holtmann.org>
References: <20211103133225.v2.1.I3ba1a76d72da5a813cf6e6f219838c9ef28c5eaa@changeid>
 <CAJQfnxEXnoz3q750ZPN=32bS-fDg8pRRp2RqL3txMks-1DLsoQ@mail.gmail.com>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> Could you take a look at this patch?
> 

patch is fine, I am just waiting for the resolution of our pull request before applying new patches.

Regards

Marcel

