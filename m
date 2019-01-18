Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAA0C1B0FD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 22:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB9D2054F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 22:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RJQmUJee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfARWeb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:34:31 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:55118 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbfARWe3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 17:34:29 -0500
Received: by mail-pg1-f201.google.com with SMTP id p4so9574485pgj.21
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jan 2019 14:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MKDiLdJAGVcam6n/C88chFt5Uukxq2JbRfDsgfi2qfs=;
        b=RJQmUJeeVSxDNoQBGPZ/aXIwEaENyWhzVw2Y7x9D46/UGWDjU0UN9Oqr0CinUx/qTQ
         7NkpqkMD+ZSO/5gkC0c1ToZ8zWQjw2fENP1Yp/u/rrW/wqyyHvFruC+AJiZgHYYlLIt/
         rChRudiYfIUxqL5If/sJvySptpuumatRXBBe7glsyfFPbn+bnAxYwnkJK2Qxjb6RBlVt
         QYvZSSneR/n5b6rCfqz3Y5YlfNpJ3HyT0UQH/20jLMpHQYZ06tbkNSMHMfKJdaOTzmBw
         ehnLCOr6e8NmvzINoi71Dav346h5LPgqwCJgn54WGvYwA/AYkGP0JiMBhOS9bWMrraqJ
         jzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MKDiLdJAGVcam6n/C88chFt5Uukxq2JbRfDsgfi2qfs=;
        b=NHM4xUof5ZmS/75dFYBckjBAuBws6fAmM44mJj7X9ax6NcfbDgro0SloJUqM5ycOaf
         XXMq0d6hByLUkwpw28+BcQwfKrLADWL/QQh0+YzeZL4RYf6iwFlw16Oaqwap5RhwJ5F5
         ht5fqFc1gZICm3JDozIWExqkfI0tW50fImrMI4/5JvrR4qMXsCeF2juYcHuQQmvO+eVU
         NgozqyYAdysdHtKYhixAzEBovrClnaLeavxIdjPBlreXR+HCmWD1iteoDWN2eyNamevN
         SCE8IG8Sq14fySPMQxW47RkiLG8S+pzjg5FmCmBHWDsKz7tgkvxZ6a+Nl0NmGPGbZ/IA
         tKBg==
X-Gm-Message-State: AJcUukfbfrf0mu2zBal2+IILCi4yJwHx6rq1C8TJgK+T2UhN+3bW2nap
        8jgDfA8CZN3e+l0wZn/8hyKKWSQrhXEB
X-Google-Smtp-Source: ALg8bN4AN0FpDx7fPsGAHiXRpjkJPj+6LBlnXepeOfGKTGYwV8Lhxmbk8334sqb8W+QRfNpfoVe++kw3vpCi
X-Received: by 2002:a17:902:1e6:: with SMTP id b93mr6878523plb.0.1547850867920;
 Fri, 18 Jan 2019 14:34:27 -0800 (PST)
Date:   Fri, 18 Jan 2019 14:34:06 -0800
In-Reply-To: <20190118223407.64818-1-rajatja@google.com>
Message-Id: <20190118223407.64818-4-rajatja@google.com>
Mime-Version: 1.0
References: <20181117010748.24347-1-rajatja@google.com> <20190118223407.64818-1-rajatja@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v4 4/5] Bluetooth: btusb: Collect the common Intel assignments together
From:   Rajat Jain <rajatja@google.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Alex Hung <alex.hung@canonical.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Cc:     rajatxjain@gmail.com, dtor@google.com, raghuram.hegde@intel.com,
        chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The BTUSB_INTEL and BTUSB_INTEL_NEW have common functions & quirks are
assigned to hdev structure. Lets collect them together instead of
repeating them in different code branches.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v4: same as v1
v3: same as v1
v2: same as v1

 drivers/bluetooth/btusb.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4761499db9ee..59869643cc29 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3075,28 +3075,25 @@ static int btusb_probe(struct usb_interface *intf,
 		data->diag = usb_ifnum_to_if(data->udev, ifnum_base + 2);
 	}
 #endif
+	if (id->driver_info & BTUSB_INTEL ||
+	    id->driver_info & BTUSB_INTEL_NEW) {
 
-	if (id->driver_info & BTUSB_INTEL) {
 		hdev->manufacturer = 2;
-		hdev->setup = btusb_setup_intel;
-		hdev->shutdown = btusb_shutdown_intel;
-		hdev->set_diag = btintel_set_diag_mfg;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
-	}
 
-	if (id->driver_info & BTUSB_INTEL_NEW) {
-		hdev->manufacturer = 2;
-		hdev->send = btusb_send_frame_intel;
-		hdev->setup = btusb_setup_intel_new;
-		hdev->hw_error = btintel_hw_error;
-		hdev->set_diag = btintel_set_diag;
-		hdev->set_bdaddr = btintel_set_bdaddr;
-		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
-		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
-		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
+		if (id->driver_info & BTUSB_INTEL) {
+			hdev->setup = btusb_setup_intel;
+			hdev->shutdown = btusb_shutdown_intel;
+			hdev->set_diag = btintel_set_diag_mfg;
+		} else {
+			hdev->send = btusb_send_frame_intel;
+			hdev->setup = btusb_setup_intel_new;
+			hdev->hw_error = btintel_hw_error;
+			hdev->set_diag = btintel_set_diag;
+		}
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
-- 
2.20.1.321.g9e740568ce-goog

