Return-Path: <SRS0=Kz1L=YT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB195CA9EB9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Oct 2019 05:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B7221D7F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Oct 2019 05:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfJZFcU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Oct 2019 01:32:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36665 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfJZFcU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Oct 2019 01:32:20 -0400
Received: from [172.20.19.11] (unknown [213.61.67.157])
        by mail.holtmann.org (Postfix) with ESMTPSA id AE3D8CED0D;
        Sat, 26 Oct 2019 07:41:19 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] Bluetooth: Always set scannable for Adv instance 0
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJzH+bqLK1aohAE3f5-4Xfhz1Gq05URFgZf9yFPAeBF2ekfmQw@mail.gmail.com>
Date:   Sat, 26 Oct 2019 07:32:18 +0200
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <368BD38D-6FFB-412D-A6A9-364B3B5374F0@holtmann.org>
References: <1571913139-6477-1-git-send-email-jaganath.kanakkassery@intel.com>
 <585F2A10-B16E-46BD-8EF6-4FD904A485AC@holtmann.org>
 <CAJzH+bqLK1aohAE3f5-4Xfhz1Gq05URFgZf9yFPAeBF2ekfmQw@mail.gmail.com>
To:     Jaganath K <jaganath.k.os@gmail.com>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jaganath,

>>> By default for instance 0, local name will be added for scan rsp
>>> data, but currently the property is set as non scannable and hence
>>> Set Adv parameter fails with Invalid parameter.
>> 
>> can you be a bit more specific why this is the correct behavior. We must have documented in mgmt-api.txt somewhere, right? Or is this something that used to be correct, but we broke it with adding extended advertising?
> 
> It seems to be functionally broken in legacy adv as well as we set scan rsp
> for instance 0 always but Adv Properties is set to non connectable (if
> connectable
> is not set). Even we need to fix mgmt-api.txt as well as you pointed out.
> 
> But in legacy case commands do not fail as  scan rsp can be set even before
> Set Adv Param where as in extended case Adv param for an Adv set has to be set
> first before sending Scan rsp and other commands for that particular Adv set.

how does this intersect with the patches that Luiz was sending earlier?

Regards

Marcel

