Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787C7C4361B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Dec 2020 01:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC7723B1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Dec 2020 01:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbgLJBVE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Dec 2020 20:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731943AbgLJBVE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Dec 2020 20:21:04 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFB7C0613CF;
        Wed,  9 Dec 2020 17:20:24 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id x12so1453421plr.10;
        Wed, 09 Dec 2020 17:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnX3YC7/PBJ67zZPtWlNRRmtdbF2hw55/iK7zw29u2k=;
        b=TD5SIHwzSQLGB7lAF6oefAYoP+OjXSSz3BPbsADRIAQE5tA2T5NRH1b5bcPivQTM1L
         uBnrwPsw+Xqh2JVdZu9UUvyOh5P1QfxYga1Z8DF7lp+Y0fPksBj9gfx2llBnKYBpolV/
         sfoRRvgO/pv0N/G5+10WZYGuEqeD+QekMJBsgeysWqGzpkIRuDI5RMuhhinP5+SLFBY8
         5Y8tJuilUgaVOLEenUWIf1vNzD4VSc2cZ2EC49E9tJnLyzmCtOGkEOSyrHb092MpPWb0
         y+ob186mvmvwJtp7SQhEbEHDKWY0XM39YusyZq8Gyfgsx2UEdDTO3/lyWZ9zHiubmkKw
         02pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnX3YC7/PBJ67zZPtWlNRRmtdbF2hw55/iK7zw29u2k=;
        b=LafmFtBPCH3ljsKiq4haK4YeB2AxIViCg5x6/s06DE2ukjdA+qc7M1SMrfDSmRh9DR
         eUuUhTCSmYYNQxxjUY5Fw8evHpHFQw2bIPbNwCminzdA4VEvitIzRdd1G1bIYv+don0f
         J+kdW/5jqMU9JsHvg5d2ngP+4xifALe5R5XV+lFPIt4kVBN0M4uZ+DiCNu7Pfbfe+zHG
         aZo+t12fOl9UoiTsviGasJmETWYhY3Z5xYy2QunYTU6N4dYm2cfDq6OCoXR9yPutRBsS
         G8UkXQ7GkF0E8CtpPhpTCBfjpwtRfR/BMebtSjIywR7kje4N64LRoK+cUR1Wd9wc0JF4
         4tIQ==
X-Gm-Message-State: AOAM533pcFEFLvD6n/mD2F/uJsfq76APZvdHOWc9fc6mZ6wQdwEjmCSH
        Eolw67K+ePvfXpiRqiKTmEi+Qmq6EZ+qyv7x
X-Google-Smtp-Source: ABdhPJwwoTXnpLyWpnVPwDtbP/gj+3zMTxqPgMhRyppERxMeuSE1mXICo6iae5qDwp7Q7Ew/ooxaqg==
X-Received: by 2002:a17:902:bd8d:b029:da:fcd1:664 with SMTP id q13-20020a170902bd8db02900dafcd10664mr4626692pls.30.1607563223347;
        Wed, 09 Dec 2020 17:20:23 -0800 (PST)
Received: from zen.local ([71.212.189.78])
        by smtp.gmail.com with ESMTPSA id i123sm4138118pfb.28.2020.12.09.17.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 17:20:22 -0800 (PST)
From:   Trent Piepho <tpiepho@gmail.com>
To:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hilda Wu <hildawu@realtek.com>,
        Sathish Narasimman <sathish.narasimman@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Hsin-Yu Chao <hychao@chromium.org>,
        Amit K Bag <amit.k.bag@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Trent Piepho <tpiepho@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Always fallback to alt 1 for WBS
Date:   Wed,  9 Dec 2020 17:20:03 -0800
Message-Id: <20201210012003.133000-1-tpiepho@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When alt mode 6 is not available, fallback to the kernel <= 5.7 behavior
of always using alt mode 1.

Prior to kernel 5.8, btusb would always use alt mode 1 for WBS (Wide
Band Speech aka mSBC aka transparent SCO).  In commit baac6276c0a9
("Bluetooth: btusb: handle mSBC audio over USB Endpoints") this
was changed to use alt mode 6, which is the recommended mode in the
Bluetooth spec (Specifications of the Bluetooth System, v5.0, Vol 4.B
§2.2.1).  However, many if not most BT USB adapters do not support alt
mode 6.  In fact, I have been unable to find any which do.

In kernel 5.8, this was changed to use alt mode 6, and if not available,
use alt mode 0.  But mode 0 has a zero byte max packet length and can
not possibly work.  It is just there as a zero-bandwidth dummy mode to
work around a USB flaw that would prevent device enumeration if
insufficient bandwidth were available for the lowest isoc mode
supported.

In effect, WBS was broken for all USB-BT adapters that do not support
alt 6, which appears to nearly all of them.

Then in commit 461f95f04f19 ("Bluetooth: btusb: USB alternate setting 1 for
WBS") the 5.7 behavior was restored, but only for Realtek adapters.

I've tested a Broadcom BRCM20702A and CSR 8510 adapter, both work with
the 5.7 behavior and do not with the 5.8.

So get rid of the Realtek specific flag and use the 5.7 behavior for all
adapters as a fallback when alt 6 is not available.  This was the
kernel's behavior prior to 5.8 and I can find no adapters for which it
is not correct.  And even if there is an adapter for which this does not
work, the current behavior would be to fall back to alt 0, which can not
possibly work either, and so is no better.

Signed-off-by: Trent Piepho <tpiepho@gmail.com>
---
 drivers/bluetooth/btusb.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 03b83aa91277..1b690164ab5b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -506,7 +506,6 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 #define BTUSB_HW_RESET_ACTIVE	12
 #define BTUSB_TX_WAIT_VND_EVT	13
 #define BTUSB_WAKEUP_DISABLE	14
-#define BTUSB_USE_ALT1_FOR_WBS	15
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -1736,15 +1735,12 @@ static void btusb_work(struct work_struct *work)
 				new_alts = data->sco_num;
 			}
 		} else if (data->air_mode == HCI_NOTIFY_ENABLE_SCO_TRANSP) {
-			/* Check if Alt 6 is supported for Transparent audio */
-			if (btusb_find_altsetting(data, 6)) {
-				data->usb_alt6_packet_flow = true;
-				new_alts = 6;
-			} else if (test_bit(BTUSB_USE_ALT1_FOR_WBS, &data->flags)) {
-				new_alts = 1;
-			} else {
-				bt_dev_err(hdev, "Device does not support ALT setting 6");
-			}
+			/* Bluetooth USB spec recommends alt 6 (63 bytes), but
+			 * many adapters do not support it.  Alt 1 appears to
+			 * work for all adapters that do not have alt 6, and
+			 * which work with WBS at all.
+			 */
+			new_alts = btusb_find_altsetting(data, 6) ? 6 : 1;
 		}
 
 		if (btusb_switch_alt_setting(hdev, new_alts) < 0)
@@ -4548,10 +4544,6 @@ static int btusb_probe(struct usb_interface *intf,
 		 * (DEVICE_REMOTE_WAKEUP)
 		 */
 		set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
-		if (btusb_find_altsetting(data, 1))
-			set_bit(BTUSB_USE_ALT1_FOR_WBS, &data->flags);
-		else
-			bt_dev_err(hdev, "Device does not support ALT setting 1");
 	}
 
 	if (!reset)
-- 
2.26.2

