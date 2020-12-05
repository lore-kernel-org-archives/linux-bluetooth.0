Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671CAC4361A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Dec 2020 18:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306B6229C4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Dec 2020 18:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgLESaf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:30:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727913AbgLESa3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Dec 2020 13:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607192941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zBmQ0q6SyDIoUKz7lblD3IwikHfn8AQIR7fQR0CAKxg=;
        b=iGuUvkg8yz5VRA7Fnu7gR4d3QDyr5CWWV8YFjQP9N3SMSMe/C8aHDDUtT/7UHpE4+/mpNg
        hZU83KyuSpr7CLKMNAqub3RcWxgmkpVrjBGKH/B+jAYXHT8EkUPg4DRqO7d5kFiyc3zS/4
        zJLIq3pVSesIJ9GMT0tIg6Oe0pODaLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-D01sMfbUMTGJe0-4rBfhtA-1; Sat, 05 Dec 2020 10:02:04 -0500
X-MC-Unique: D01sMfbUMTGJe0-4rBfhtA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9761B192D785;
        Sat,  5 Dec 2020 15:02:03 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-32.ams2.redhat.com [10.36.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82FE25D6D5;
        Sat,  5 Dec 2020 15:02:02 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/2] Bluetooth: btusb: Fake CSR dongle fixes
Date:   Sat,  5 Dec 2020 16:01:59 +0100
Message-Id: <20201205150201.5631-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi All,

As requested here are my 2 btusb fake CSR dongle fixes as a series again
because the second patch depends on the first patch.

Regards,

Jans

