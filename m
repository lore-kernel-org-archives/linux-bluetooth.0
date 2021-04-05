Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2EEC43460
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 20:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77D1613CD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 20:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbhDEUfu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Apr 2021 16:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236422AbhDEUfs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Apr 2021 16:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617654941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rIZVNXETPK/8WO3+9Mz28aU16QeaaPOBmQvDwOS27m4=;
        b=awQ9DmxUzknrxXJdlsHbW+uAqYsWp0edOwLCk5KV15rrKqHyDHqlQxB8zP7KFpCWuZhW1C
        dYXRdsmuhgwxo0hZklGAoyuvFnMO4qLMe23ofnMBVs5jOVQbeIsFy+P9n+c3qjirxKrj72
        fYPQK6SezOJI+3hXhvXp0r2iSNCxnEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-vRM2meiQMpmyEj5b-W9O3A-1; Mon, 05 Apr 2021 16:35:38 -0400
X-MC-Unique: vRM2meiQMpmyEj5b-W9O3A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48E5C1084C97;
        Mon,  5 Apr 2021 20:35:36 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-31.ams2.redhat.com [10.36.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5B1260C17;
        Mon,  5 Apr 2021 20:35:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 5.12 regression fix resend 0/1] Bluetooth: btusb: Revert Fix the autosuspend enable and disable
Date:   Mon,  5 Apr 2021 22:35:32 +0200
Message-Id: <20210405203533.17091-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

As discussed in the original submission of this patch, the patch this
reverts simply is wrong.

This revert was also Acked by the author of the original patch in the
thread (I've added his ack to this resend).

This fixes a regression where bluetooth autosuspend no longer works OOTB
with 5.12 leading to significantly increased power-consumption.

Can we get this regression fix on its way to Linus for 5.12-rc7 please ?

Regards,

Hans


Hans de Goede (1):
  Bluetooth: btusb: Revert Fix the autosuspend enable and disable

 drivers/bluetooth/btusb.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.30.2

