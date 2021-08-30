Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA42C432BE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 14:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5367F60E73
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 14:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbhH3Ot7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:49:59 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55047 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbhH3Ot5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Aug 2021 10:49:57 -0400
Received: from smtpclient.apple (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6F640CED45;
        Mon, 30 Aug 2021 16:49:01 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: sco: Fix lock_sock() blockage by
 memcpy_from_msg()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210828161818.31141-1-tiwai@suse.de>
Date:   Mon, 30 Aug 2021 16:49:01 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <28F3A4FF-A9F0-40DB-8D90-FF04E3445CC5@holtmann.org>
References: <20210828161818.31141-1-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Takashi,

> The sco_send_frame() also takes lock_sock() during memcpy_from_msg()
> call that may be endlessly blocked by a task with userfaultd
> technique, and this will result in a hung task watchdog trigger.
> 
> Just like the similar fix for hci_sock_sendmsg() in commit
> 92c685dc5de0 ("Bluetooth: reorganize functions..."), this patch moves
> the  memcpy_from_msg() out of lock_sock() for addressing the hang.
> 
> This should be the last piece for fixing CVE-2021-3640 after a few
> already queued fixes.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> net/bluetooth/sco.c | 23 +++++++++++++++--------
> 1 file changed, 15 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

