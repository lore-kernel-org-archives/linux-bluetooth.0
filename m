Return-Path: <SRS0=Qms+=2J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56856C2D0C1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Dec 2019 19:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C1824676
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Dec 2019 19:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfLSTyj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:54:39 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35113 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfLSTyj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Dec 2019 14:54:39 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id A0333CECE9;
        Thu, 19 Dec 2019 21:03:50 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH V4 01/10] bluetooth: hci_bcm: Fix RTS handling during
 startup
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5bbda434-d0e4-7162-8634-9900a4fa9148@gmx.net>
Date:   Thu, 19 Dec 2019 20:54:37 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        =?utf-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Content-Transfer-Encoding: 7bit
Message-Id: <BFF8D9F0-235C-4907-8F6C-23C230CD5470@holtmann.org>
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
 <1570375708-26965-2-git-send-email-wahrenst@gmx.net>
 <61789264-a4c2-ac85-9d74-d186213ec70a@gmx.net>
 <20191216132509.ofqcdpwxsd7324ql@core.my.home>
 <6f05f4d8-fa84-ae81-ac4f-00ab12fabeea@gmx.net>
 <5bbda434-d0e4-7162-8634-9900a4fa9148@gmx.net>
To:     Stefan Wahren <wahrenst@gmx.net>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Stefan,

>>> Meanwhile i will play with modifications of original patch on the
>>> Raspberry Pi 4 and come back to you.
> 
> could you please test this patch [2] on top of current bluetooth-next?
> 
> This is the solution in case we don't find the cause of this issue. I
> don't prefer this one, because this is next stuff and we need to revert
> the offending patch for Linux 5.5.
> 
> [2] - https://gist.github.com/lategoodbye/3d39e4b07d401f07fa9f9c2f11e1f17d

that patch looks fine to me. Just submit it and we will see how it works out.

Regards

Marcel

