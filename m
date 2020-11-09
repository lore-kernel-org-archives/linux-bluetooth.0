Return-Path: <SRS0=/O/j=EP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A7EC56201
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 13:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400CF2067B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 13:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgKINgZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 08:36:25 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41296 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730383AbgKINEp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 08:04:45 -0500
Received: from marcel-macbook.fritz.box (p4fefcf0f.dip0.t-ipconnect.de [79.239.207.15])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2674ECECC6;
        Mon,  9 Nov 2020 14:11:49 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v5] bluetooth: hci_h5: fix memory leak in h5_close
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201016131447.32107-1-anant.thazhemadam@gmail.com>
Date:   Mon, 9 Nov 2020 14:04:40 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <46A02F1A-DABE-4CEE-A43B-F44766D15FFB@holtmann.org>
References: <20201016131447.32107-1-anant.thazhemadam@gmail.com>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Anant,

> When h5_close() is called, h5 is directly freed when !hu->serdev.
> However, h5->rx_skb is not freed, which causes a memory leak.
> 
> Freeing h5->rx_skb and setting it to NULL, fixes this memory leak.
> 
> Fixes: ce945552fde4 ("Bluetooth: hci_h5: Add support for serdev enumerated devices")
> Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
> Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
> Changes in v5:
> 	* Set h5->rx_skb = NULL unconditionally - to improve code
> 	  readability
> 	* Update commit message accordingly
> 
> Changes in v4:
> 	* Free h5->rx_skb even when hu->serdev
> 	(Suggested by Hans de Goede <hdegoede@redhat.com>)
> 	* If hu->serdev, then assign h5->rx_skb = NULL
> 
> Changes in v3:
> 	* Free h5->rx_skb when !hu->serdev, and fix the memory leak
> 	* Do not incorrectly and unnecessarily call serdev_device_close()
> 
> Changes in v2:
> 	* Fixed the Fixes tag
> 
> 
> drivers/bluetooth/hci_h5.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

