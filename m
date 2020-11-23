Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE80C6379F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 10:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B216207FF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 10:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLqei2kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgKWKNT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 05:13:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727849AbgKWKNT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 05:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606126398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ro5XjKZmfavY1EaDlA/CRC/wQ8B05kgG9XIRK9Ydaxk=;
        b=GLqei2khRAqquza3GTIbU+zloBbu+su150Z5gk9VcT4aNs1FIyBgODrT3YEzwBwv79DIBh
        znsq/AnwYQXBUhOo75gCaeiyQniqAO9/gRN7/2mOCLwP0NsALuhL6ynqvJWrrBKVNvcLGv
        MYNY889vASCWU6q+bvsRQii4g8tCq4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-H6bfDrB5MkWmmw1Ff-er4A-1; Mon, 23 Nov 2020 05:13:14 -0500
X-MC-Unique: H6bfDrB5MkWmmw1Ff-er4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31DFB107B45F;
        Mon, 23 Nov 2020 10:13:13 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-113-27.ams2.redhat.com [10.36.113.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 453506086F;
        Mon, 23 Nov 2020 10:13:11 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/2] Bluetooth: btusb: 2 fixes for handling of fake CSR USB dongles
Date:   Mon, 23 Nov 2020 11:13:06 +0100
Message-Id: <20201123101308.7291-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi All,

I just realized that after going through the trouble to open the fake
dongle (for which patch 1 restores identifiying it as fake) to read the
chip number, I forgot to actually add the chip number to the commit-msg.

So here is a v2 with the chip number added to the commit-msg for 1/2,
no other changes.

Regards,

Hans

