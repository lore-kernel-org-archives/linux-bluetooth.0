Return-Path: <SRS0=bfEF=6B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E76C2D0EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 17:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F7A2078E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 17:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVhpBpp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgDQRQu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:16:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30118 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729687AbgDQRQu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Apr 2020 13:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587143808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CGv2fgPNnWkB6F6rrs/oOKVeGJrIM+/McUrhS/YxLMo=;
        b=VVhpBpp8cJuAs12CVTYPZttmS/4ElHYAsEqw3FIVR2td552hQxL8GsEYTn1b90y8jycfyM
        297phkZpSv8xvVOdlxVwUPOc5rOHogUinCOMvfwkiEsY2bCpJoLTvDYm3FEtTNofIxmWPL
        KUCE6ta4pcbDDUIJB9ymT6XNQaUxbAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-jYFzj31_MdiSZ7idJWqFKg-1; Fri, 17 Apr 2020 13:15:45 -0400
X-MC-Unique: jYFzj31_MdiSZ7idJWqFKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2781518CA242;
        Fri, 17 Apr 2020 17:15:44 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FB0760BE0;
        Fri, 17 Apr 2020 17:15:43 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] Bluetooth: btbcm: Add 2 missing models to subver tables
Date:   Fri, 17 Apr 2020 19:15:32 +0200
Message-Id: <20200417171532.448053-8-hdegoede@redhat.com>
In-Reply-To: <20200417171532.448053-1-hdegoede@redhat.com>
References: <20200417171532.448053-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently the bcm_uart_subver_ and bcm_usb_subver_table-s lack entries
for the BCM4324B5 and BCM20703A1 chipsets. This makes the code use just
"BCM" as prefix for the filename to pass to request-firmware, making it
harder for users to figure out which firmware they need. This especially
is problematic with the UART attached BCM4324B5 where this leads to the
filename being just "BCM.hcd".

Add the 2 missing devices to subver tables. This has been tested on:

1. A Dell XPS15 9550 where this makes btbcm.c try to load
"BCM20703A1-0a5c-6410.hcd" before it tries to load "BCM-0a5c-6410.hcd".

2. A Thinkpad 8 where this makes btbcm.c try to load
"BCM4324B5.hcd" before it tries to load "BCM.hcd"

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btbcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 739ba1200f5d..df7a8a22e53c 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -392,6 +392,7 @@ static const struct bcm_subver_table bcm_uart_subver_=
table[] =3D {
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
 	{ 0x4204, "BCM2076B1"	},	/* 002.002.004 */
 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
+	{ 0x4606, "BCM4324B5"	},	/* 002.006.006 */
 	{ 0x6109, "BCM4335C0"	},	/* 003.001.009 */
 	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
 	{ 0x2122, "BCM4343A0"	},	/* 001.001.034 */
@@ -407,6 +408,7 @@ static const struct bcm_subver_table bcm_uart_subver_=
table[] =3D {
 };
=20
 static const struct bcm_subver_table bcm_usb_subver_table[] =3D {
+	{ 0x2105, "BCM20703A1"	},	/* 001.001.005 */
 	{ 0x210b, "BCM43142A0"	},	/* 001.001.011 */
 	{ 0x2112, "BCM4314A0"	},	/* 001.001.018 */
 	{ 0x2118, "BCM20702A0"	},	/* 001.001.024 */
--=20
2.26.0

