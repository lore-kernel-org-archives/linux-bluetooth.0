Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80ADC2BA1E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 14:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971EA23343
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 14:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N2LOnEIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgDFOff (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:35:35 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34163 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgDFOff (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 10:35:35 -0400
Received: by mail-ua1-f66.google.com with SMTP id d23so12773uak.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=esS10M0t6HYIM0hPFUjRMKJ3QLEoksn3yy41vOUmit0=;
        b=N2LOnEIlUUmJLWjr7MsJt1q0w4hOjkoPgrghPUxHNrAu6aEojSj+M30iJ24Dcpv6Vt
         CqGDhsZ9uw0P7bLW9Kpxic/1ArVC/jwkFYwpwY87f2EI/q2tGxRnmlqRKqOSi8A108jI
         vPJLr8PTKQsGN5ozI6eKa5rfBQBB06sNgrop8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=esS10M0t6HYIM0hPFUjRMKJ3QLEoksn3yy41vOUmit0=;
        b=gUWogy8e/Ut4z4exivbwGiWgRZ8CGZQHEQO8ZZKN6ssKx45/oXKAcq1t9eM7NwILoc
         l31lzrzRJKTFqugGozg6nqD2dwPBWl4+OggSEhL5J//Z1gpgFlijKI9bAHE8da+hMFkH
         X430dltrLjN05hl59ahRnB+827KGm+hC/+vwQ36xwd3yWDa7+GPT7edyN6jN0TolViBs
         LXb20SJczWWBpg5qP5G00Z9hmi5E+XpKrBpltEr3YOuvb5dIk19o1Y6RNHNmqEnVxOr1
         DdS7CIPcS1N4sNuFFw7NoV+8VEnET/V150IuoxLmF98FN0CM+YSqOeAD6nLIvAgY9CY2
         d4HQ==
X-Gm-Message-State: AGi0PuZJoKEzTatDL0HQZ80THzAibEWSp1NxhnGTXCV2zRg/ku3/+xG5
        ZKNgNVqY+mRslssQwLr/dGFaR+E+K+c=
X-Google-Smtp-Source: APiQypLcEj3vvKKcpGo2mpz1X86ZR2b11x2Qd9XX/r5LuZaL0KCZxGo3JhFLA6I4NcAGmT8QTQg7vA==
X-Received: by 2002:ab0:4e96:: with SMTP id l22mr3895197uah.67.1586183733117;
        Mon, 06 Apr 2020 07:35:33 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id 106sm4410327uai.0.2020.04.06.07.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:35:32 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v2] bluetooth:Adding driver and quirk defs for multi-role LE
Date:   Mon,  6 Apr 2020 14:35:29 +0000
Message-Id: <20200406143529.209076-1-alainm@chromium.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds the relevant driver and quirk to allow drivers to
report the le_states as being trustworthy.

This has historically been disabled as controllers did not reliably
support this. In particular, this will be used to relax this condition
for controllers that have been well tested and reliable.

	/* Most controller will fail if we try to create new connections
	 * while we have an existing one in slave role.
	 */
	if (hdev->conn_hash.le_num_slave > 0)
		return NULL;

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 drivers/bluetooth/btusb.c   | 2 +-
 include/net/bluetooth/hci.h | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3bdec42c9612..dd27e28d4601 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -58,7 +58,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_CW6622		0x100000
 #define BTUSB_MEDIATEK		0x200000
 #define BTUSB_WIDEBAND_SPEECH	0x400000
-
+#define BTUSB_VALID_LE_STATES   0x800000
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5f60e135aeb6..25c2e5ee81dc 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -214,6 +214,15 @@ enum {
 	 * This quirk must be set before hci_register_dev is called.
 	 */
 	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
+
+	/* When this quirk is set, the controller has validated that
+	 * LE states reported through the HCI_LE_READ_SUPPORTED_STATES are
+	 * valid.  This mechanism is necessary as many controllers have
+	 * been seen has having trouble initiating a connectable
+	 * advertisement despite the state combination being reported as
+	 * supported.
+	 */
+	HCI_QUIRK_VALID_LE_STATES,
 };
 
 /* HCI device flags */
-- 
2.26.0.292.g33ef6b2f38-goog

