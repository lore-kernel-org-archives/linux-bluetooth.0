Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B45C43464
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 03:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D4120678
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 03:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tzX8w74F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgIRDM6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 23:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbgIRDMc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 23:12:32 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66DCC06178C
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 20:12:23 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id w8so841001qvt.18
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 20:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2XmRDQUdgiUCXLjgBSHndxfu/U3AL11i4Ub5lRoe7R0=;
        b=tzX8w74Fl69bkT1fuRekk3Yej9sz1p+sVINXDr737cRNWeMl+XLBVOK2a2H0/gbs18
         Uteg1+HYcXiSdUfhbnQicvFRotx4pj43Yc4fW36tr8Heiz4fRD8sQpYKYSvllygVcd0A
         xkuT05qTA+JmIK5f05enmUZ28D5g3H9MHYFzxpZpBaDdUSpx7BYg+gM4Yw3d88FLJ1ms
         +Vx9hoczHxmCaA1IKAcuAWej+DHGVqZm/4w+QsYhlF6k3BQ5dr8m3Yfy+IR0h4u/6xkd
         dq4v9k/P82oknrNxUTpZMex+uiAB60T391HA8RB0MOdr02Im6N06aKG0sZmsi2N5CYBz
         9SLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2XmRDQUdgiUCXLjgBSHndxfu/U3AL11i4Ub5lRoe7R0=;
        b=J7uD2fOxDga5/o5EjHz+haH4utOtEDszGdd3iUunII1OiuG+VnV+FrmW4MEh0qyOZn
         oyDk+klw2g0xWC49S2I9eReD0LD9yf7O8DaG0m3+DQW2iDLb1Oo+XLCVn+OVjagyluPi
         t+PJg2MI3n1e6H7lAr+Ef7xob6eX46QKekKv65kveeMwRS3hTMTnFYktlQMKO4CI1Lhr
         pZsar832hCI2MeT8Dc9bfpyu3FSg2Arbb+W61F0vPOCcV9Cn/DGzFIGq47p6eHo3yeFe
         3SxaVvUR/0+JDES0YoI0UtQgBmUZE3ovGhNwAdDUglL04/vDL/cSVwEMK/54s22OyEXP
         uAkQ==
X-Gm-Message-State: AOAM530NGBVqChc6c41E3t/ImYjp5IxpfGTMK540pd/PbSyQ6LQAiCGE
        fwDySJndPqrdft5ibcBwSnad7JlViRhKQvTu0jVRpuErX8bLa6Ym/FpV9HR1JVJ+PKuiKScHjDF
        bpvnmEbWZ8GnfXz84mI18NqTNEAd/43msSpiXpA6X5rLkaYbncLeV5CEIylZCvJKlA2FHFzqQfw
        C8tE+cmpogjVc=
X-Google-Smtp-Source: ABdhPJwmWJFJNTTBFBXGPrIZyuSqnx1dWqO6oAbGMDrw5KopjYBA2KwiHRZ355u4CWsVx/4UV2f90s26M6BxkZjhrg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:458f:: with SMTP id
 x15mr15602557qvu.33.1600398742980; Thu, 17 Sep 2020 20:12:22 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:11:49 +0800
In-Reply-To: <20200918111110.v3.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200918111110.v3.2.I8aafface41460f81241717da0498419a533bd165@changeid>
Mime-Version: 1.0
References: <20200918111110.v3.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 2/6] Bluetooth: Set scan parameters for ADV Monitor
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     howardchung@google.com, luiz.dentz@gmail.com, marcel@holtmann.org,
        mcchou@chromium.org, mmandlik@chromium.org, alainm@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set scan parameters when there is at least one Advertisement monitor.

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 net/bluetooth/hci_request.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 413e3a5aabf54..d2b06f5c93804 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1027,6 +1027,9 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	} else if (hci_is_le_conn_scanning(hdev)) {
 		window = hdev->le_scan_window_connect;
 		interval = hdev->le_scan_int_connect;
+	} else if (hci_is_adv_monitoring(hdev)) {
+		window = hdev->le_scan_window_adv_monitor;
+		interval = hdev->le_scan_int_adv_monitor;
 	} else {
 		window = hdev->le_scan_window;
 		interval = hdev->le_scan_interval;
-- 
2.28.0.681.g6f77f65b4e-goog

