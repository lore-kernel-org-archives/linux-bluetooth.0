Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E58C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 16:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D347360F22
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 16:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhG2Qn3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 12:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhG2Qn2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 12:43:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6DDC0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 09:43:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y125-20020a2532830000b029058328f1b02eso6995329yby.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+vXJXnWw4i/uZjkWX5JtWCOlsWNzjAsTCHJJYSUJPqg=;
        b=DeXGHwZ26J/RmPqe0tvmGC10hTSpp6xifoGBlog/q3hsEyb6x7Aue+LUMEk5Q33fIj
         d56RbbxHoMmyF2vKZ5LiBtVD6fceN9t1dTf7PglIOLZERUg/kQcZ9cWNz5ONZB/KItVc
         gNy5N1kgv1vxgfU/BmFGuszHkW7dDnOG94NX/oVezluQmQm6UXRmG8Qv1GKjw+PlJVQk
         uzWbeeYQ1aPK/snNzAvndpWlhAjrXvpBlG0kN48w3ZnnYInNH1lDUn6Bx2bnkjd611HR
         ngjlyFL1P/cYF163wu5ai+SB6xVzRXg5YT/GH26xMLaq4CLDUlfYh3Mk/bAfUTxJ0Dfx
         lTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+vXJXnWw4i/uZjkWX5JtWCOlsWNzjAsTCHJJYSUJPqg=;
        b=T6Yt02wg1pj/7OwHpY1tgGKSEYQWUG4mzLPxjNWJneP7WudL9Pl4wavDH2TmargHxy
         57Svi05kC9rSFBJ5AO1Um7NRM8uk/bH43WX9i5F+r8RxrA32Lckd49R73G2B4g3D8QmN
         OXs78l72oV3EmA4ipu1s2KDFPM+tdOnyOi9uScJ82TD6uwAIt8K/g4kEhRwUVul8xVWd
         yagn3lay8s1dTmEy7UPskpw8CkbYZG4YDvAwZPuHd27JymWUb0LSsCbrT2kDfDPizUfe
         ipF3sU1giC9qhyc6XcLiSJHUACKzijQ+9yPUEiD1dcjCreDJO6ksJ1HY6ylARQSkrz2e
         jhEQ==
X-Gm-Message-State: AOAM533WL7KU4eRbo7N8NJqy3E/2eXwTHSA/S+Osh0tNIbCVap5RU+yz
        FiVoVGHmE2v7wy+a8bLYYg19YWDzXLMCtPW1YSGP36rZFo81TXcq+J0e3gNP6mX21L1yLZnMVB1
        BbD1RACm9niF8mWuWAjZGg0wOq6eVLnUDJNeD1ubP7vGHROE6bkvGALgaFsqV61ZNtbf6eJgTlI
        zwoQYwKpwyl1k=
X-Google-Smtp-Source: ABdhPJwVXBQAWZwfhc/BekQ1qtupMFZFls7enotw/WCy2nXFNP8xBlx4nkU04KIBWiQ0qwvcHW/q34tI22ot2MdnZQ==
X-Received: from michaelfsun.mtv.corp.google.com ([2620:15c:202:201:9678:c075:a4e7:f144])
 (user=michaelfsun job=sendgmr) by 2002:a25:b3c9:: with SMTP id
 x9mr7360564ybf.514.1627577004790; Thu, 29 Jul 2021 09:43:24 -0700 (PDT)
Date:   Thu, 29 Jul 2021 09:43:21 -0700
Message-Id: <20210729094319.1.Ib7a90fea41e56da34bab6811c2ecf6b255a14f51@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH] Bluetooth: btusb: Enable MSFT extension for Intel next
 generation controllers
From:   Michael Sun <michaelfsun@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Michael Sun <michaelfsun@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

The Intel TyphoonPeak, GarfieldPeak Bluetooth controllers
support the Microsoft vendor extension and they are using
0xFC1E for VsMsftOpCode.

Verified on a GarfieldPeak device through bluetoothctl show

Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Michael Sun <michaelfsun@google.com>
---

 drivers/bluetooth/btusb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1876a960b3dc..23cf6e98173b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3031,6 +3031,17 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	btintel_version_info_tlv(hdev, &version);
 
 finish:
+	/* All Intel new genration controllers support the Microsoft vendor
+	 * extension are using 0xFC1E for VsMsftOpCode.
+	 */
+	switch (INTEL_HW_VARIANT(version.cnvi_bt)) {
+	case 0x17:
+	case 0x18:
+	case 0x19:
+		hci_set_msft_opcode(hdev, 0xFC1E);
+		break;
+	}
+
 	/* Set the event mask for Intel specific vendor events. This enables
 	 * a few extra events that are useful during general operation. It
 	 * does not enable any debugging related events.
-- 
2.32.0.432.gabb21c7263-goog

