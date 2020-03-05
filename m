Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E343C3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 11:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F14C208C3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 11:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgCELHz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:07:55 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43711 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCELHz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 06:07:55 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id AFB7BCECE9;
        Thu,  5 Mar 2020 12:17:21 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: On reporting issues with potential security implications
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAE5jQCeQfyPu7T4mHutYwUjK04P8MyYS8NmTC8pm4sZkHQRRNA@mail.gmail.com>
Date:   Thu, 5 Mar 2020 12:07:53 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <BE6FA083-5826-4A77-8EF3-D5485D421AA9@holtmann.org>
References: <CAE5jQCeQfyPu7T4mHutYwUjK04P8MyYS8NmTC8pm4sZkHQRRNA@mail.gmail.com>
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Anatoly,

> Many projects have some private mail list or some other policies for
> reporting issues with possible security implications. I mean some bugs
> that the reporter cannot qualify for sure as a "safe to publicly
> disclose" (still, they can turn out to be not security-related after
> review).
> 
> BlueZ, on the other hand, has a policy of "never write to them
> [developers] directly" and no easily grep-able guidelines on reporting
> possibly security-related issues. So, what is the preferred way for
> reporting such things?

unless they are high severity issues that are remotely exploitable to gain root access, I personally have no problem if they are reporting directly to the public mailing list.

For example we have test utilities and development utilities that don’t normally run in production systems. We will fix every issue reported, but they are just bugs and not security issues.

Regards

Marcel

