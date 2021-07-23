Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ADFC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 10:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789D5608FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 10:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhGWJ0h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:26:37 -0400
Received: from meesny.iki.fi ([195.140.195.201]:50138 "EHLO meesny.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhGWJ0g (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 05:26:36 -0400
Received: from [192.168.1.195] (91-152-122-41.elisa-laajakaista.fi [91.152.122.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4219220050;
        Fri, 23 Jul 2021 13:07:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1627034827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uptbWrx95C5QIVUbKOBVRAx/tDvlkqdSapqfCHOWS0=;
        b=U+u24RPvh9CljIlxFC/IKhvjjFZZv2unQdmB+g1nHBQC9SDHxksbUnGbjAmbe4z9Qq+5jF
        CqrBpmNyQGQDXxTms5A8fL6J2Q5beRKWmi5BFpkxEY18FHUuGgR9JVe582MHH1hGeTg3vs
        Q+b5VR+eg/XaY8L7afLbHfJjYkXJjYk=
Message-ID: <b86543908684cc6cd9afaf4de10fac7af1a49665.camel@iki.fi>
Subject: [PATCH v2] Bluetooth: btusb: check conditions before enabling USB
 ALT 3 for WBS
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc:     Joseph Hwang <josephsih@google.com>,
        Hilda Wu <hildawu@realtek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Date:   Fri, 23 Jul 2021 13:07:07 +0300
In-Reply-To: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
References: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1627034827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uptbWrx95C5QIVUbKOBVRAx/tDvlkqdSapqfCHOWS0=;
        b=ed2pjYjLGmUchORHnTE2ja53QQCj3ke/2dadFuWP42LLwiALLRRjPCFBD0DsWrnrWmXIZ6
        5Y8oDSn7q+IC9T3qkef1XgmSqCr5hkJvqihxJgVVd6Ypqh5j6t1ZAywu2Wtgnkueq6YYWO
        KuX2LPKHa3o4DITVqAYfHAW6vjKf49Y=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1627034827; a=rsa-sha256; cv=none;
        b=AjfPLTIEkZadv+tNmDnhUtScjVhjbxsZ4ZRwtr2BlqqRhjBwF5gonYqhjGas5djHUSSTar
        DwTeqUrq01NwTfXUf06SIY/BjAbBETZSI1benYVocGOxuds0rtabvb1P75ZEQ8Jlp4JDf4
        E0x90HBCR+TGNqwb02E1Oye+y/RiI4c=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some USB BT adapters don't satisfy the MTU requirement mentioned in
commit e848dbd364ac ("Bluetooth: btusb: Add support USB ALT 3 for WBS")
and have ALT 3 setting that produces no/garbled audio. Some adapters
with larger MTU were also reported to have problems with ALT 3.

Add a flag and check it and MTU before selecting ALT 3, falling back to
ALT 1. Enable the flag for Realtek, restoring the previous behavior for
non-Realtek devices.

Tested with USB adapters (mtu<72, no/garbled sound with ALT3, ALT1
works) BCM20702A1 0b05:17cb, CSR8510A10 0a12:0001, and (mtu>=72, ALT3
works) RTL8761BU 0bda:8771, Intel AX200 8087:0029 (after disabling
ALT6). Also got reports for (mtu>=72, ALT 3 reported to produce bad
audio) Intel 8087:0a2b.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
Fixes: e848dbd364ac ("Bluetooth: btusb: Add support USB ALT 3 for WBS")
---

Changes in v2:
- Explain magic number 72 in a comment; didn't add the table for them,
  because it's not used elsewhere and we need just one number from it.
- Add flag for ALT3 support, restoring the behavior
  for non-Realtek devices the same as before e848dbd364ac, due to
  the problems reported on an Intel adapter. Don't have the device
  myself.

 drivers/bluetooth/btusb.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6d23308119d1..5cec719f6cba 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -516,6 +516,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 #define BTUSB_HW_RESET_ACTIVE	12
 #define BTUSB_TX_WAIT_VND_EVT	13
 #define BTUSB_WAKEUP_DISABLE	14
+#define BTUSB_ALT3_OK_FOR_WBS	15
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -1748,16 +1749,20 @@ static void btusb_work(struct work_struct *work)
 			/* Bluetooth USB spec recommends alt 6 (63 bytes), but
 			 * many adapters do not support it.  Alt 1 appears to
 			 * work for all adapters that do not have alt 6, and
-			 * which work with WBS at all.
+			 * which work with WBS at all.  Some devices prefer
+			 * alt 3 (HCI payload >= 60 Bytes let air packet
+			 * data satisfy 60 bytes), requiring
+			 * MTU >= 3 (packets) * 25 (size) - 3 (headers) = 72
+			 * see also Core spec 5, vol 4, B 2.1.1 & Table 2.1.
 			 */
-			new_alts = btusb_find_altsetting(data, 6) ? 6 : 1;
-			/* Because mSBC frames do not need to be aligned to the
-			 * SCO packet boundary. If support the Alt 3, use the
-			 * Alt 3 for HCI payload >= 60 Bytes let air packet
-			 * data satisfy 60 bytes.
-			 */
-			if (new_alts == 1 && btusb_find_altsetting(data, 3))
+			if (btusb_find_altsetting(data, 6))
+				new_alts = 6;
+			else if (test_bit(BTUSB_ALT3_OK_FOR_WBS, &data->flags) &&
+				 hdev->sco_mtu >= 72 &&
+				 btusb_find_altsetting(data, 3))
 				new_alts = 3;
+			else
+				new_alts = 1;
 		}
 
 		if (btusb_switch_alt_setting(hdev, new_alts) < 0)
@@ -4733,6 +4738,7 @@ static int btusb_probe(struct usb_interface *intf,
 		 * (DEVICE_REMOTE_WAKEUP)
 		 */
 		set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
+		set_bit(BTUSB_ALT3_OK_FOR_WBS, &data->flags);
 	}
 
 	if (!reset)
-- 
2.31.1



