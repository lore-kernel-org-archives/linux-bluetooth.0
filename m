Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40E5C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 05:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIWFMQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 01:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiIWFMO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 01:12:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159EFD692E
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 22:12:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-34546b03773so96324227b3.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 22:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=yXjveCbLOdd0JzGR4qE7Eak16YrtEn9JU/5KgKpycQ4=;
        b=bsyGrP9RDOEf3/jOXC2B30WnREaFxo8TgD8RiysbiY21Zx4pM97GzW8B9LBoLLc3MT
         WkReA5dbfuobZIt2ERF02TM9S2JjuICdzby+kv46P6Re7jKNmbjQjQVklQ3Vs8OlUfOZ
         wJN4tRh9fAuRuf33bwPhhMn+6rgGI9EI6FOOYz/EmATwev07fw0A16LZnyPakmfn9TNF
         3CVnMrq5bYOhYqYV5N72W2AXxMnyUmF8FOAzp2uhN8VtEHlSDFd98AoivDkIWogu9f0I
         DcZoU/HLkTtJIJiNMw8F09gtli9dXgRK7VHcLOHt5pf0OP/o2cIE7+T42K59/rJ9lMrE
         FpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=yXjveCbLOdd0JzGR4qE7Eak16YrtEn9JU/5KgKpycQ4=;
        b=laT4gXe4XGAjhUxXGnXcdIlc47q330lqcFBw8UmsvZtbIhoORp57I5GjTaImceXgaA
         /GGa7T7lyZZqnNCPLu7fefwXaiuwUpy7xX2BirrYfs2n/ZmROupgbmJeNK9qxJlwbP0H
         XOB6RtjOa/cqWzLLs/yvTk/cdM1qmeWr7KXjif1qwT82M+xFzLgy0oCTSeHYp1vrbG+n
         ozUZIpGVybkDU7yP7NdfjMzrzSjo2xx7dug6wv6IB9ty2NngN2+o2B44rcFAyb40RqbG
         N13QYP4bMLRH3mLaATCvTvfDr3b1z6Pm7U6MQRebiYkp24fYVy+FJ9BXmMj9FixwK2TP
         t8wQ==
X-Gm-Message-State: ACrzQf2NDASAlOv47JArk8ch9ueimTZkLg3tOJKcTsInUhriNgs7mi0K
        0fozeohLQtG67QDUNriyboZxCLdBhpgxAg==
X-Google-Smtp-Source: AMsMyM41fR83KD/FqMiNwNghkRfeT+azMYRzEeG2UAk9jdOfX/1Xz19S+AJ8YYD/cOCtqty+IlpSEopBrQrrDg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:5808:dcfb:1968:5125])
 (user=mmandlik job=sendgmr) by 2002:a25:320d:0:b0:6b0:29ba:fc57 with SMTP id
 y13-20020a25320d000000b006b029bafc57mr7625919yby.77.1663909933413; Thu, 22
 Sep 2022 22:12:13 -0700 (PDT)
Date:   Thu, 22 Sep 2022 22:12:04 -0700
In-Reply-To: <20220922221037.v6.1.I44a65858f594107d3688087dfbdf669fac450b52@changeid>
Mime-Version: 1.0
References: <20220922221037.v6.1.I44a65858f594107d3688087dfbdf669fac450b52@changeid>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220922221037.v6.2.Id7ed3b8351837e45025add1d496630f0b9b460cb@changeid>
Subject: [PATCH v6 2/3] Bluetooth: btusb: Add btusb devcoredump support
From:   Manish Mandlik <mmandlik@google.com>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch implements the btusb driver side .coredump() callback to
trigger a devcoredump via sysfs.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v6:
- Remove dev->coredump_disabled check since the sysfs flag related
  change has been abandoned

Changes in v4:
- New patch in the series

 drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 271963805a38..e9052779f4f8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4205,6 +4205,17 @@ static int btusb_resume(struct usb_interface *intf)
 }
 #endif
 
+#ifdef CONFIG_DEV_COREDUMP
+static void btusb_coredump(struct device *dev)
+{
+	struct btusb_data *data = dev_get_drvdata(dev);
+	struct hci_dev *hdev = data->hdev;
+
+	if (hdev->dump.coredump)
+		hdev->dump.coredump(hdev);
+}
+#endif
+
 static struct usb_driver btusb_driver = {
 	.name		= "btusb",
 	.probe		= btusb_probe,
@@ -4216,6 +4227,14 @@ static struct usb_driver btusb_driver = {
 	.id_table	= btusb_table,
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
+
+#ifdef CONFIG_DEV_COREDUMP
+	.drvwrap = {
+		.driver = {
+			.coredump = btusb_coredump,
+		},
+	},
+#endif
 };
 
 module_usb_driver(btusb_driver);
-- 
2.37.3.998.g577e59143f-goog

