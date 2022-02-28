Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F81BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Feb 2022 11:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiB1Ljc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Feb 2022 06:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiB1Lja (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Feb 2022 06:39:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86B9F4E39A
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 03:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646048331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=l2r3HgOJax23se8MP/HD9kQXYd3LPc78oqPLD+RppAE=;
        b=OabyynDhcqtPe85oiGGs9zj1Z7uN+NG0tV68DmgsA5Eb7uY1rdeuAR40GovJHU4DifSvuC
        pIWJzcxxIBTltmn9EDDqWEjCxJ3LOhDFVW7QjCdH2f3oHLqR+vNYuAfSqa7TOtRZdFrlRK
        YqlcXr2KV9f8jKj6LefM4s3iTTqwXnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-L6MPVTyTM1yiq1_mqh0IvQ-1; Mon, 28 Feb 2022 06:38:48 -0500
X-MC-Unique: L6MPVTyTM1yiq1_mqh0IvQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AD03180FD72;
        Mon, 28 Feb 2022 11:38:47 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.193.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EAF983078;
        Mon, 28 Feb 2022 11:38:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH resend 0/1] Bluetooth: hci_bcm: Add the Asus TF103C to the bcm_broken_irq_dmi_table
Date:   Mon, 28 Feb 2022 12:38:40 +0100
Message-Id: <20220228113841.476174-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi All,

This patch seems to have fallen through the cracks, hence this resend.

Regards,

Hans


Hans de Goede (1):
  Bluetooth: hci_bcm: Add the Asus TF103C to the
    bcm_broken_irq_dmi_table

 drivers/bluetooth/hci_bcm.c | 44 ++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 8 deletions(-)

-- 
2.35.1

