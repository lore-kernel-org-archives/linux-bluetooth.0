Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED8CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 15:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC7A60E93
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 15:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbhHSPCX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Aug 2021 11:02:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59232 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240676AbhHSPCV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Aug 2021 11:02:21 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 76A76CED16;
        Thu, 19 Aug 2021 17:01:43 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: how to cleanly shutdown an application using HCI_CHANNEL_USER
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <e17b2044-62cb-cbf7-64b8-c647aa7f6ee7@pabigot.com>
Date:   Thu, 19 Aug 2021 17:01:42 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <A6782BCD-0C05-40AD-B567-7A1E163184E0@holtmann.org>
References: <e17b2044-62cb-cbf7-64b8-c647aa7f6ee7@pabigot.com>
To:     "Peter A. Bigot" <pab@pabigot.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Peter,

> I'm using an AF_BLUETOOTH socket bound with HCI_CHANNEL_USER from a
> user-mode application with cap_net_admin=ep.  As expected this
> requires the device be down, and brings the device up automatically.
> 
> When I close that socket and exit the application, the device appears
> to remain up forever.  Which prevents me from re-starting the
> application.
> 
> I tried to issue HCIDEVDOWN before closing, but that produces EBADFD
> because ioctls cannot be performed with HCI_CHANNEL_RAW.
> 
> I can bring the interface down from within the application if, after
> closing the socket, I wait a second or so, then create a new bound
> HCI_CHANNEL_RAW socket and issue HCIDEVDOWN on it.
> 
> Is there some other way to cleanly shut down an application that used
> HCI_CHANNEL_USER so that the device is returned to down state on exit?
> Or is this supposed to happen automatically (I see code that suggests
> it should)?
> 
> Kernel version is 5.11.0-7620-generic (System76), and I'm using go
> 1.16, if that's relevant.

I think you found a regression. Calling close() on the HCI User Channel should bring the device back down. This used to work correctly, can you please bisect which kernel patch broke this.

Back in the days I added tools/userchan-tester, but it seems I never included enough test cases to catch this regression.

Regards

Marcel

