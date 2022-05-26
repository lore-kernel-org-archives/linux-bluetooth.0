Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40151C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 11:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347069AbiEZLWd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 07:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347081AbiEZLWU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 07:22:20 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E9C112F
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 04:22:02 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h186so1097536pgc.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wRyXjUnbuN8AArPJcHoUjYeWkLPL7LreNSYdLAK0u9k=;
        b=B0xy+3RUGPdeJE34oJ+ShJjF1I809kPfObCH500XadV1bePmTTJKBRbAD2ieBC+ysO
         2DT6QUCgLMqGimKyXkICXmUcppD2Ndob6ILn9uZGQyL1ZIT9blB4p4eiiaosTyo08Wwo
         DFzott6m4wObq8TjrTeBfoL9XLRrNnTPpZg8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wRyXjUnbuN8AArPJcHoUjYeWkLPL7LreNSYdLAK0u9k=;
        b=Iu8QY6jdNDljkhAG+CpiONATO3TwRZTlT1LubvDRu5Fc+EA9jkqxMQPH6SL+NlYEal
         oP8ostmRjTkG9nsbvnOvji139XlE7B/iZL/oYJimNCclEaxkITanvSSgis/y+T5r/gg9
         E1DTuEJNmuMf7yinTPSxwgIxL8HLS06+d3GBrq9EoYBuFzSXdzZvIybfEOIiyUi+8pF6
         yY0w1w0V0bi3RXfe4S7VDBBMmSONkDYREV+hETJy5Vz3mJPBaO5q4Fl5+GSjk0A4vwY3
         zwPm3aK8hod0wvSL0tbDdrwXx69E2IGpqjCu9d23Qnr66wHnTUfNOl2RlQEJoPvcj3PE
         dr8Q==
X-Gm-Message-State: AOAM531oWVpaq/eiJbkVQAwg9Oz8wsOVSNkY8rWf3BTFf/DbPLuCzliH
        s/wNln59pNK+9sv38Gb0blaz0Btq+V7TRA==
X-Google-Smtp-Source: ABdhPJxnxtIlJ7ULQJ8KTu/+loAsvXfALnBvt6eaj1i0FdCDRbJ9YrYd6QHBB+uN6hwoH0xG8m7HKg==
X-Received: by 2002:a63:82c7:0:b0:3f9:e153:6a54 with SMTP id w190-20020a6382c7000000b003f9e1536a54mr23972141pgd.409.1653564121453;
        Thu, 26 May 2022 04:22:01 -0700 (PDT)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id 2-20020a170902e9c200b001614cd997a8sm1230287plk.236.2022.05.26.04.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 04:22:01 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v6 5/5] Bluetooth: let HCI_QUALITY_REPORT persist over adapter power cycle
Date:   Thu, 26 May 2022 19:21:34 +0800
Message-Id: <20220526112135.2486883-3-josephsih@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220526112135.2486883-1-josephsih@chromium.org>
References: <20220526112135.2486883-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The quality report specifications, including AOSP Bluetooth Quality
Report and Intel Telemetry Event, do not define what happen when
the adapter is turned off and then on. To be consistent among
different specifications and vendors, the quality report feature is
turned off when the adapter is powered off and is turned on when
the adapter is powered on if the feature has been on before power
cycle.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

(no changes since v5)

Changes in v5:
- This is a new patch in this series changes version.

 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_sync.c         | 35 +++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9e48d606591e..5788350efa68 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -807,7 +807,6 @@ extern struct mutex hci_cb_list_lock;
 		hci_dev_clear_flag(hdev, HCI_LE_ADV);		\
 		hci_dev_clear_flag(hdev, HCI_LL_RPA_RESOLUTION);\
 		hci_dev_clear_flag(hdev, HCI_PERIODIC_INQ);	\
-		hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);	\
 	} while (0)
 
 #define hci_dev_le_state_simultaneous(hdev) \
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a6ada9dcede5..12a18d046bb6 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3849,6 +3849,31 @@ static const struct {
 			 "advertised, but not supported.")
 };
 
+static void suspend_resume_quality_report(struct hci_dev *hdev, bool enable)
+{
+	int err;
+
+	/* Suspend and resume quality report only when the feature has
+	 * already been enabled. The HCI_QUALITY_REPORT flag, as an indicator
+	 * whether to re-enable the feature after resume, is not changed by
+	 * suspend/resume.
+	 */
+	if (!hci_dev_test_flag(hdev, HCI_QUALITY_REPORT))
+		return;
+
+	if (hdev->set_quality_report)
+		err = hdev->set_quality_report(hdev, enable);
+	else
+		err = aosp_set_quality_report(hdev, enable);
+
+	if (err)
+		bt_dev_err(hdev, "%s quality report error %d",
+			   enable ? "resume" : "suspend", err);
+	else
+		bt_dev_info(hdev, "%s quality report",
+			    enable ? "resume" : "suspend");
+}
+
 int hci_dev_open_sync(struct hci_dev *hdev)
 {
 	int ret = 0;
@@ -4013,6 +4038,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		msft_do_open(hdev);
 		aosp_do_open(hdev);
+		suspend_resume_quality_report(hdev, true);
 	}
 
 	clear_bit(HCI_INIT, &hdev->flags);
@@ -4095,6 +4121,14 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	hci_request_cancel_all(hdev);
 
+	/* Disable quality report and close aosp before shutdown()
+	 * is called. Otherwise, some chips may panic.
+	 */
+	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+		suspend_resume_quality_report(hdev, false);
+		aosp_do_close(hdev);
+	}
+
 	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
 	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
 	    test_bit(HCI_UP, &hdev->flags)) {
@@ -4158,7 +4192,6 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	hci_sock_dev_event(hdev, HCI_DEV_DOWN);
 
 	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
-		aosp_do_close(hdev);
 		msft_do_close(hdev);
 	}
 
-- 
2.36.1.124.g0e6072fb45-goog

