Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E93C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Nov 2021 07:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353010AbhKYHLq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346039AbhKYHJp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Nov 2021 02:09:45 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6580BC0613D7
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Nov 2021 23:06:34 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id bs14-20020a05620a470e00b0046b1e29f53cso4612036qkb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Nov 2021 23:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xJEfcnM1gsdMRr8HvPxnxusNwcyfFwFCIfrv7825c8A=;
        b=b9sIUxSaDzS7aUvUKFlRjzWMx5Mc/pDyLThD08JjxtUok8dOj24husYmtiFKyevewl
         8D22WSrmMjCWLU4v0U/MtHwsALa5uhL8VIXcmKcC058KsYv/IOoyvyVVxX0ujYyntrZs
         s4wf2Mnm0LxSnrZ8huHRVHYD60Z37p/ViaJGx34pKlZxipu2ZWI7ngVXD0oji45Raw5B
         v6CPuj/Y9t7Yp4AFQERY0P9QQfSSBMhlLTNor0nqjAiX7h/WTPwEnoV/rn5CbdBkpEnp
         tnUOtO02L8vldhBbyA2zn9WLVekLoJqcXAmraEkYyGjL/nfYjJsE3SrlQqw/HY/WafyU
         SL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xJEfcnM1gsdMRr8HvPxnxusNwcyfFwFCIfrv7825c8A=;
        b=N9X4tqoNRQF04jSji/DoSHxT9n6Ob81y6koW5GFdAVRrszJZPnv4U/tRAUCXWt1gxj
         E5kSv5eh7Lpsi7SPjn2rtRV6xs8YsWnYUW4wZ4R0KyQT7CA51uJ1A+aIxvpWsnxEZgqZ
         UNvY4jPz3XrxK0NpZgfAs5yXQCNJyA9VCTNerPaoBTXwb3zzFdWwgOSkZZCBSHzqvz+s
         IfFLdsYDOSDbBN/6klfbt2dynxQVo5i8lAHBS4akUx1FUzuI+8XbsPMbVk4Pn5Epr3LK
         ZPvoU1idS0iVV+L7ke++Iw7gNYJyueSel/iXwCDt6ilAQVgFXQyFZ4XlS3akxPW2f7BT
         dIVA==
X-Gm-Message-State: AOAM531Apwh6YWgSmDulL9BYaPrZVdNmNqMBqSE117nDt0hVaWFBgqo/
        sG18lNW3kxxagvz/WGGyYGZZDY7ko06ftcLyHXj1BiPKVTrhE5hcx4CgbLsI7LZf/nbPms0F/Hm
        dWVhvJV6qryQFkrzJQ4Qoi+XmP56uik6dWQEbuhR5rvI8WEeRBjcNC9LIT9isO2ZDb0LA+xHQqe
        DR
X-Google-Smtp-Source: ABdhPJwQzmyhxiG/c3ymbfBSttQQEZwfkazhTphTZYWEnFMm+FBKt6Wh3arvqOV7s4Am0Io47SjU765HIrxP
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:a5d9:6769:9abb:6b2])
 (user=apusaka job=sendgmr) by 2002:a25:ac24:: with SMTP id
 w36mr4178435ybi.118.1637823993535; Wed, 24 Nov 2021 23:06:33 -0800 (PST)
Date:   Thu, 25 Nov 2021 15:06:23 +0800
Message-Id: <20211125150558.Bluez.v4.1.I78857808e0b20c6e4dd934b174d3f1106fe3402d@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [Bluez PATCH v4 1/5] mgmt: Add NAME_REQUEST_FAILED flag for
 device_found event
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Report failure when resolving remote name to userspace. This is useful
so the userspace can make an informed decision when to retry name
resolving procedure.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
Hi maintainers,

This is the patch series for remote name request as was discussed here.
https://patchwork.kernel.org/project/bluetooth/patch/20211028191805.1.I35b7f3a496f834de6b43a32f94b6160cb1467c94@changeid/
Please also review the corresponding kernel space change.

Changes in v4:
* New in this version, separated from the other patch.

 lib/mgmt.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 9f34b7f28b..922a24367f 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -854,9 +854,10 @@ struct mgmt_ev_auth_failed {
 	uint8_t status;
 } __packed;
 
-#define MGMT_DEV_FOUND_CONFIRM_NAME	0x01
-#define MGMT_DEV_FOUND_LEGACY_PAIRING	0x02
-#define MGMT_DEV_FOUND_NOT_CONNECTABLE	0x04
+#define MGMT_DEV_FOUND_CONFIRM_NAME		0x01
+#define MGMT_DEV_FOUND_LEGACY_PAIRING		0x02
+#define MGMT_DEV_FOUND_NOT_CONNECTABLE		0x04
+#define MGMT_DEV_FOUND_NAME_REQUEST_FAILED	0x10
 
 #define MGMT_EV_DEVICE_FOUND		0x0012
 struct mgmt_ev_device_found {
-- 
2.34.0.rc2.393.gf8c9666880-goog

