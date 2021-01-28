Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0980DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 12:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B904B64DD8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 12:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhA1MCQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jan 2021 07:02:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229569AbhA1MBj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jan 2021 07:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611835212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xDkyZvkL5/FV8/3DNW7wgIsPXPOvVBPwOXxWUlvHiK4=;
        b=BasTmll2WJhC+awjGcutrC4szqElEzmCpZ2SXoGx++Y7+f+LzgEoV5Wq0ev6TTLwyux0om
        Riw0fyVisKpKltsh1YDS8Wuh51+0S4gCjMl1EDCokzkGbD8MFqBYxAVPCx4OKeIV2n5Wz7
        eiSBAUo1S+oz8gnEqoxP9b1yYDvqNwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-36QffA_yO72GoH1AIJI50w-1; Thu, 28 Jan 2021 07:00:10 -0500
X-MC-Unique: 36QffA_yO72GoH1AIJI50w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD5598144E2;
        Thu, 28 Jan 2021 12:00:09 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-250.ams2.redhat.com [10.36.114.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60D0B60C13;
        Thu, 28 Jan 2021 12:00:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: Recent(ish) bluetooth hci_suspend_notifier() changes
Date:   Thu, 28 Jan 2021 13:00:07 +0100
Message-Id: <20210128120007.5676-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi All,

While debugging an rtl8723bs bluetooth issue I noticed that last year
the bluetooth core has grown a new hci_suspend_notifier() mechanism and
I noticed a number of possible issues / improvements with that mechanism
which I noticed:

1. HCI_OP_WRITE_SCAN_ENABLE gets send to the HCI in some places without
   a hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) check

2. HCI_OP_SET_EVENT_FLT gets end to the HCI in some places without
   a hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) check

3. hci_req_set_event_filter sends the following requests:
   1 HCI_OP_SET_EVENT_FLT
   2 HCI_OP_WRITE_SCAN_ENABLE (if the scan parameters have changed only)
   3 HCI_OP_SET_EVENT_FLT (if their are relevant whitelist entries_
   4 HCI_OP_WRITE_SCAN_ENABLE unconditionally

   It seems to me that 2. is unnecessary since it will immediately be
   followed by 4. and 4. misses the check to see if the scan parameters
   need updating which 2 does (this check is done in __hci_req_update_scan()


4. There is another unconditional, possibly unnecessary  HCI_OP_WRITE_SCAN_ENABLE
   in the if (next == BT_SUSPEND_DISCONNECT) {} block of hci_req_prepare_suspend()
   Note if this is made conditional then the:
    set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
   should also be made conditional since then req might not contain any requests
   in which case suspend_req_complete() will not run.

Regards,

Hans

