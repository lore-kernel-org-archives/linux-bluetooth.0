Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1CFC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 18:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC8160F91
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 18:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhGZRXe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jul 2021 13:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbhGZRXZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jul 2021 13:23:25 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07674C061764
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 11:03:52 -0700 (PDT)
Received: from monolith.lan (91-152-122-41.elisa-laajakaista.fi [91.152.122.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id CE0121B002A8;
        Mon, 26 Jul 2021 21:03:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1627322629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZK3goQGr61YMODISmDi3C/51pOmyG9njHeHQ9gezMk=;
        b=Hle2Ztsd1m7xQJVsA7clfJgVk/B42BannmjCexWtc2MGS/WEB22yuZBV7wtUVH8uLlBpYN
        JwodgPNv43Wld7jeOMDkVT7RMNBSkT+a+rOd6Prs4wrmywdri8HTBA2y/ONNbL5Fr/4WX3
        v1fM2Hfu/B9baDmNE9mQ0xR51pymnhXo1/QPkb0I3u01FGVmFpIOg3mnFquZRTGIrxHXZt
        ZYjCmgUKX8Z5Hwr2zZ6C0rnBK7banGu4z8jnvuBCx0NGY91dw/Q+SxTs6zybZehfQG8aV1
        g6jPYiN5u4r0zx0p5qpqRvORbsg4f7URfKUAlz00qduMfWqQLSpF2qJ/f/dSKA==
From:   Pauli Virtanen <pav@iki.fi>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, kernel@kempniu.pl,
        linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, pav@iki.fi,
        hildawu@realtek.com, josephsih@google.com
Subject: [PATCH v3] Bluetooth: btusb: check conditions before enabling USB ALT 3 for WBS
Date:   Mon, 26 Jul 2021 21:02:06 +0300
Message-Id: <20210726180206.49703-1-pav@iki.fi>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
References: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1627322629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZK3goQGr61YMODISmDi3C/51pOmyG9njHeHQ9gezMk=;
        b=buTOnWvkof2RI8RiqEMQzjnCeRLhwAFhcBS/Z97URmENpHl5UCGmnr5M3dn261w2HRkqFP
        ME3UA73d/W7CABn6l8SjXG8Jw9kDqE3xp4ipI9xmpgCylf8XpbggI5ZePJ7sXP9DLBkkFp
        3pFQ+HUg3K4WkFSaLzAtLxRL0OIsKsrxJfiAhOB/QgP2tME6w8r59TJRCN1JdJr8QdRFoh
        jwmhzMC/OonJ4D/ngNmPsC0MikQQ6aBYZBre1uwumJrsaAQiO+LqBlbC3lTOCOeri3VIBu
        BaHfwfW1i6RLEu7ufhqNOF5+U6fmrVrrK5/YE/lpdXwt/yzHSqGMfQmwzTCB+w==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1627322629; a=rsa-sha256;
        cv=none;
        b=G5iNlN9VjgfHnfxZLb/Lff/FIL6xVANsHjNWPIttoVS31IrgMNFzGgPRn6SuNJuC6cMAkE
        YUgEy2qM+WpVu176p5lZ1CjuoAf1ecpUjitSTFigvZF+7A9HAIeaGoTBBT6M8gdQ6Edk7J
        xGcRC1Kgl6snK0H5fzlRZD8m4lBl79NL8VmmW05iOjpNR2CNacLGZ7HGrCyxiaOtRzl8qj
        zTYBEiXCzG0UA5PPtKh1USe/VsnTd/G9ehbO9gOg+v8J27fFj25LK5s2jn8F3PrrpLfM/y
        QeA6NTi8NA0Va6MRpevqfyTKEwLuX5kvDw2KZ1IfR8OIyWnlwJvtGHErYvFjkQ==
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
Tested-by: Michał Kępień <kernel@kempniu.pl>
---

Changes in v3:
- Rename flag to BTUSB_USE_ALT3_FOR_WBS.
- No spaces in indent.
- Added Tested-by: Michał Kępień

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
index 6d23308119d1..e8062d0b7d4d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -516,6 +516,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 #define BTUSB_HW_RESET_ACTIVE	12
 #define BTUSB_TX_WAIT_VND_EVT	13
 #define BTUSB_WAKEUP_DISABLE	14
+#define BTUSB_USE_ALT3_FOR_WBS	15
 
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
+			else if (test_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags) &&
+					hdev->sco_mtu >= 72 &&
+					btusb_find_altsetting(data, 3))
 				new_alts = 3;
+			else
+				new_alts = 1;
 		}
 
 		if (btusb_switch_alt_setting(hdev, new_alts) < 0)
@@ -4733,6 +4738,7 @@ static int btusb_probe(struct usb_interface *intf,
 		 * (DEVICE_REMOTE_WAKEUP)
 		 */
 		set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
+		set_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags);
 	}
 
 	if (!reset)
-- 
2.31.1

