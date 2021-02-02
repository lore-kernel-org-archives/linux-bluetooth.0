Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5167C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 16:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A6C64F74
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 16:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbhBBQ0q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:26:46 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:41924 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbhBBQYo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Feb 2021 11:24:44 -0500
Received: from marcel-macbook.holtmann.net (p4fefcdd8.dip0.t-ipconnect.de [79.239.205.216])
        by mail.holtmann.org (Postfix) with ESMTPSA id 98359CECDF;
        Tue,  2 Feb 2021 17:31:24 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] Bluetooth: Fix null pointer dereference in
 amp_read_loc_assoc_final_data
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210202094230.13659-1-gtiwari@redhat.com>
Date:   Tue, 2 Feb 2021 17:23:57 +0100
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <868E89B9-CC86-469A-8C43-22F314EFB038@holtmann.org>
References: <20210202094230.13659-1-gtiwari@redhat.com>
To:     Gopal Tiwari <gtiwari@redhat.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Gopal,

> kernel panic trace looks like: 
> 
> #5 [ffffb9e08698fc80] do_page_fault at ffffffffb666e0d7
> #6 [ffffb9e08698fcb0] page_fault at ffffffffb70010fe
>    [exception RIP: amp_read_loc_assoc_final_data+63]
>    RIP: ffffffffc06ab54f  RSP: ffffb9e08698fd68  RFLAGS: 00010246
>    RAX: 0000000000000000  RBX: ffff8c8845a5a000  RCX: 0000000000000004
>    RDX: 0000000000000000  RSI: ffff8c8b9153d000  RDI: ffff8c8845a5a000
>    RBP: ffffb9e08698fe40   R8: 00000000000330e0   R9: ffffffffc0675c94
>    R10: ffffb9e08698fe58  R11: 0000000000000001  R12: ffff8c8b9cbf6200
>    R13: 0000000000000000  R14: 0000000000000000  R15: ffff8c8b2026da0b
>    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> #7 [ffffb9e08698fda8] hci_event_packet at ffffffffc0676904 [bluetooth]
> #8 [ffffb9e08698fe50] hci_rx_work at ffffffffc06629ac [bluetooth]
> #9 [ffffb9e08698fe98] process_one_work at ffffffffb66f95e7
> 
> hcon->amp_mgr seems NULL triggered kernel panic in following line inside
> function amp_read_loc_assoc_final_data
> 
>        set_bit(READ_LOC_AMP_ASSOC_FINAL, &mgr->state);
> 
> Fixed by checking NULL for mgr.
> 
> Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
> ---
> net/bluetooth/amp.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

