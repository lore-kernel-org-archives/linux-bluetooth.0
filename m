Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B581C388F9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 11:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAF720724
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 11:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgKWLZo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 06:25:44 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48288 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgKWLZo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 06:25:44 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7C2C4CECCF;
        Mon, 23 Nov 2020 12:32:54 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH] Bluetooth: revert: hci_h5: close serdev device and free
 hu in h5_close
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201122121725.54351-1-hdegoede@redhat.com>
Date:   Mon, 23 Nov 2020 12:25:41 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <05E87980-D73A-48A4-84F4-EFBFE61FBF46@holtmann.org>
References: <20201122121725.54351-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

> There have been multiple revisions of the patch fix the h5->rx_skb
> leak. Accidentally the first revision (which is buggy) and v5 have
> both been merged:
> 
> v1 commit 70f259a3f427 ("Bluetooth: hci_h5: close serdev device and free
> hu in h5_close");
> v5 commit 855af2d74c87 ("Bluetooth: hci_h5: fix memory leak in h5_close")
> 
> The correct v5 makes changes slightly higher up in the h5_close()
> function, which allowed both versions to get merged without conflict.
> 
> The changes from v1 unconditionally frees the h5 data struct, this
> is wrong because in the serdev enumeration case the memory is
> allocated in h5_serdev_probe() like this:
> 
>        h5 = devm_kzalloc(dev, sizeof(*h5), GFP_KERNEL);
> 
> So its lifetime is tied to the lifetime of the driver being bound
> to the serdev and it is automatically freed when the driver gets
> unbound. In the serdev case the same h5 struct is re-used over
> h5_close() and h5_open() calls and thus MUST not be free-ed in
> h5_close().
> 
> The serdev_device_close() added to h5_close() is incorrect in the
> same way, serdev_device_close() is called on driver unbound too and
> also MUST no be called from h5_close().
> 
> This reverts the changes made by merging v1 of the patch, so that
> just the changes of the correct v5 remain.
> 
> Cc: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_h5.c | 8 ++------
> 1 file changed, 2 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

