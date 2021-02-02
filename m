Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B43C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 16:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F133564E3F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 16:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbhBBQvz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:51:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236793AbhBBQty (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Feb 2021 11:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612284506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WAxy8HPIZPNXxjH2vYFDCyRbLRDQFHQGmTFGhczWMVw=;
        b=DmwwFPQ80B6xk/nR+W4Xd8/9xbTV7GTQp2CX+j8ocpxC4BykiP51zj9Z6jiZjK14YwVoRZ
        vLvtyCgYsm563ZCAp/UdEt5NNFAmeHdxOB5Ee5OFU9fkqRGaQyxABD2/RV+GqJiqXq9NHH
        AqxM4Xzu2ixRhdr4qxRS5V2z6jaMEfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-wpH8bqqMMa-nUNvpD903Yw-1; Tue, 02 Feb 2021 11:48:24 -0500
X-MC-Unique: wpH8bqqMMa-nUNvpD903Yw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCF9D107ACE4;
        Tue,  2 Feb 2021 16:48:23 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4C9B2BFC7;
        Tue,  2 Feb 2021 16:48:23 +0000 (UTC)
Received: from zmail20.collab.prod.int.phx2.redhat.com (zmail20.collab.prod.int.phx2.redhat.com [10.5.83.23])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id A89094BB7B;
        Tue,  2 Feb 2021 16:48:23 +0000 (UTC)
Date:   Tue, 2 Feb 2021 11:48:23 -0500 (EST)
From:   Gopal Tiwari <gtiwari@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>
Message-ID: <26183197.29138771.1612284503316.JavaMail.zimbra@redhat.com>
In-Reply-To: <868E89B9-CC86-469A-8C43-22F314EFB038@holtmann.org>
References: <20210202094230.13659-1-gtiwari@redhat.com> <868E89B9-CC86-469A-8C43-22F314EFB038@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Fix null pointer dereference in
 amp_read_loc_assoc_final_data
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.64.242.181, 10.4.195.2]
Thread-Topic: Bluetooth: Fix null pointer dereference in amp_read_loc_assoc_final_data
Thread-Index: C+/u+hDYthAVamREg+wF5OTAtBUM0g==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Marcel.

Regards,
Gopal 

----- Original Message -----
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "Gopal Tiwari" <gtiwari@redhat.com>
Cc: "Bluetooth Kernel Mailing List" <linux-bluetooth@vger.kernel.org>, "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>, "Johan Hedberg" <johan.hedberg@gmail.com>
Sent: Tuesday, February 2, 2021 9:53:57 PM
Subject: Re: [PATCH] Bluetooth: Fix null pointer dereference in amp_read_loc_assoc_final_data

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

