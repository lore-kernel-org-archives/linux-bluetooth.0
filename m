Return-Path: <SRS0=rxlX=4P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E21C35DF9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Feb 2020 18:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E61120726
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Feb 2020 18:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SfbMAknz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgB0Sa0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:30:26 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33733 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbgB0Sa0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Feb 2020 13:30:26 -0500
Received: by mail-vs1-f67.google.com with SMTP id n27so306619vsa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2020 10:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r62C7Q3pTZHe4INsya0MPDYTIKoY5w4JAKY+dBDHNY4=;
        b=SfbMAknz+1zu66KUb3C8bV0eJzoUBSkNnymelKjcPd0nNmPos4CG/K39SPz2Ns7ZTe
         HgvOJDQ14Q7N5Qa/cwYaOBV+FGqGXIqsvo+gZ2MgtgP0gIsqxn7QfSvaSXqEucb6JYeV
         UR6ON7NFtldsXXnAcB7+4dF8SXMxSWT1d7VSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r62C7Q3pTZHe4INsya0MPDYTIKoY5w4JAKY+dBDHNY4=;
        b=ccNRM6dfeHwfZAX2MkFuF0MZ4LQSUEg1m0yQlS4hLPzGp+uYnOhciOw0FT+ggr1lSK
         MmkcbNV30/CIi06FHh33RwfDn2bHNHxSBzw5OVK6Ew7smllEby7nq2dyK8zPsehUBpUl
         l0UukxhT9NKSgJ1W2hV8S2KNpIaB3IxpppNEFVGD1LXz8XJbil8AUfrynz8EaqHTd7bx
         sOSFaM7qmYMyYpCP7X6ZogAXB7t+rH2dB1nmIrLiy0dIu6Wiw1mSS9Qq2utDEMno7Uyu
         ZJvHkhI4nwKUciZo7uCS8BkZS0gWgXydaIn7TiAUHYUEuPJXjCRrjZibdgkCwkp9x0DP
         6IMA==
X-Gm-Message-State: ANhLgQ3Ubkm1szSa+rIDORC3szdklpSjjA2I6zTz0BUqAkJrfus6385a
        x46uQ0leAOWFXS6MpPyuD+qWUQQ+GRSEpw==
X-Google-Smtp-Source: ADFU+vt3BTyKuxV+I9LJ6fnftioqj7i8WGaM8WqlR11kUFGT38s2K8xbhG8JtLu3fUq1YcJ5X+qPbQ==
X-Received: by 2002:a05:6102:308b:: with SMTP id l11mr416843vsb.68.1582828224905;
        Thu, 27 Feb 2020 10:30:24 -0800 (PST)
Received: from alain.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id v21sm2274464vkd.54.2020.02.27.10.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:30:24 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v1 3/3] bluetooth: Enable erroneous data reporting if wbs is supported
Date:   Thu, 27 Feb 2020 18:29:41 +0000
Message-Id: <20200227182938.110670-4-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200227182938.110670-1-alainm@chromium.org>
References: <20200227182938.110670-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change will enable erroneous data reporting if wide band speech is
supported by the controller as indicated by the
HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED quirk.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 include/net/bluetooth/hci.h |  7 +++++++
 net/bluetooth/hci_core.c    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b214c4358d1c..807fd40bb358 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1095,6 +1095,13 @@ struct hci_rp_read_inq_rsp_tx_power {
 	__s8     tx_power;
 } __packed;
 
+#define HCI_OP_WRITE_DEFAULT_ERRONEOUS_DATA_REPORTING	0x0c5b
+	#define ERRONEOUS_DATA_REPORTING_DISABLED	0x00
+	#define ERRONEOUS_DATA_REPORTING_ENABLED	0x01
+struct hci_cp_write_default_erroneous_data_reporting {
+	__u8     erroneous_data_reporting;
+} __packed;
+
 #define HCI_OP_SET_EVENT_MASK_PAGE_2	0x0c63
 
 #define HCI_OP_READ_LOCATION_DATA	0x0c64
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1ca7508b6ca7..19afb85ad399 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1382,6 +1382,29 @@ static void hci_dev_get_bd_addr_from_property(struct hci_dev *hdev)
 	bacpy(&hdev->public_addr, &ba);
 }
 
+static int hci_write_default_erroneous_data_req(struct hci_request *req,
+						unsigned long opt)
+{
+	struct hci_cp_write_default_erroneous_data_reporting cp = {};
+
+	cp.erroneous_data_reporting = (__u8)opt;
+	hci_req_add(req, HCI_OP_WRITE_DEFAULT_ERRONEOUS_DATA_REPORTING,
+		    sizeof(cp), &cp);
+	return 0;
+}
+
+static void hci_write_default_erroneous_data(struct hci_dev *hdev,
+					     __u8 erroneous_data_reporting)
+{
+	int err = __hci_req_sync(hdev,
+				 hci_write_default_erroneous_data_req,
+				 erroneous_data_reporting, HCI_CMD_TIMEOUT,
+				 NULL);
+	if (err) {
+		BT_ERR("HCI_OP_WRITE_DEFAULT_ERRONEOUS_DATA_REPORTING failed");
+	}
+}
+
 static int hci_dev_do_open(struct hci_dev *hdev)
 {
 	int ret = 0;
@@ -1547,6 +1570,16 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		set_bit(HCI_UP, &hdev->flags);
 		hci_sock_dev_event(hdev, HCI_DEV_UP);
 		hci_leds_update_powered(hdev, true);
+
+		/* If the controller supports wide_band_speech, enable erroneous
+		 * data reporting.
+		 */
+		if (test_bit(HCI_QUIRK_WIDE_BAND_SPEECH_SUPPORTED,
+			     &hdev->quirks)) {
+			hci_write_default_erroneous_data(hdev,
+					      ERRONEOUS_DATA_REPORTING_ENABLED);
+		}
+
 		if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
 		    !hci_dev_test_flag(hdev, HCI_CONFIG) &&
 		    !hci_dev_test_flag(hdev, HCI_UNCONFIGURED) &&
-- 
2.25.1.481.gfbce0eb801-goog

