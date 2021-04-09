Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46C3C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 13:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B760B61165
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 13:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhDIN7L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Apr 2021 09:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231402AbhDIN7I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Apr 2021 09:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617976735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qinJhImnYRgiKMrHQECQTTWa5RpLkTGILOGnEKPMBbM=;
        b=MdYA5E19b0pfBV5LWRHQnHWf3sMYl6xE3Qeq3BVnqBFZe0QWa8ATsHFwnuCfWztD5vjDSD
        wY4kg+2wH9g+TteP+p99/+vm4sinxmIWE7cXgY056S45jxhRTHoyBn/eeuliBqJkdYXxlj
        7uq0rmy//8gHMMNT7iuLgXYITXIEeP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-71ge44tCNt6ZwPd3yK0zNw-1; Fri, 09 Apr 2021 09:58:53 -0400
X-MC-Unique: 71ge44tCNt6ZwPd3yK0zNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CF2518B9ECA;
        Fri,  9 Apr 2021 13:58:52 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-113-60.ams2.redhat.com [10.36.113.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 563895D9E3;
        Fri,  9 Apr 2021 13:58:51 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Hui Wang <hui.wang@canonical.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 5.12 regression fix 0/1] Bluetooth: btusb: Revert Fix the autosuspend enable and disable
Date:   Fri,  9 Apr 2021 15:58:49 +0200
Message-Id: <20210409135850.106730-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Linus,

Since we are already at 5.12-rc6, Marcel Holtmann has asked me to send
this patch to you directly.

It has his Acked-by to indicate that he is ok with the fix (and it also
has an Acked-by of the author of the original patch which this reverts).

Regards,

Hans


Hans de Goede (1):
  Bluetooth: btusb: Revert Fix the autosuspend enable and disable

 drivers/bluetooth/btusb.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.30.2

