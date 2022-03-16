Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DB6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Mar 2022 15:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiCPPga (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbiCPPg2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Mar 2022 11:36:28 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60DA6D1B5
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 08:35:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gb39so5029840ejc.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtjHsmXPT8LE+jJTyR39fP968xbgt2lw05SHk5jQS8s=;
        b=eHvHbfSHwH2Y4jvdtNxz9a+SK1FhxfXDwycbRdAMj4LgGfap4mtJxkfWjzE98qQ9c6
         jbdPb9pFymVu882c3akJUgSKViEUUZAvrC+8PydMEoFKkl3EGZjW92opDXZMnYXPrY3Q
         eSL+G/mJHixR7teLNRvBFtbaOMRgiQNdpyjNcepjI5kBKWvrlKNM1zKel8B0muNcrzUB
         zGa+N3RzSGZDyu8VqgW3P38SR8/at0nQ6zR8j/Rf1QQxa/3gykr7ybee7DEpp0eTRX6y
         KCrsq+HuERRKO3vBFUPDPzL3FE4xMbp7GJs3/p7+4z9jdK9WeUkyAW/FMlB21jJNmQKl
         qlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RtjHsmXPT8LE+jJTyR39fP968xbgt2lw05SHk5jQS8s=;
        b=eok8JgA2hr7DefQjAHaaX2+05fw1Q15vSvA6qvvyMz0aX3RDtb2kefe7h3gomgYSy4
         qrsrkY+47yUgL8maaK0BkVKpv7GBOWnBMfarP0e8nrpExpwL4xoyUU+iO06jIGwnbVnK
         x6G432eh6Ti2VO9iCD+CqRSzLdSVrWpsxGWBc+7UpDddGGXAwDPL5c+dFun+ztz9CFSY
         ytk6tuhuWRjHVXcHDFCF7OJbHNxXL01DSv8Jd2QWhxB7o+N6jsT9sJXIqtX7Z9iFMMtX
         2p5Jdq3VzU2mYbTcCloeIC8748riCrl98AfGxGs/8k7KkE2vq6/2D7Ewi+7eBu1q5RXu
         8svg==
X-Gm-Message-State: AOAM533y0MJFK09Bn6MHlj3GSDJw2a1ompzDtmeXc/L+Vl07UePauhVP
        ZV47Wk8sl6o2NbHcu2m/EF74VjsNqCZolQ==
X-Google-Smtp-Source: ABdhPJyvoZFPzQrcPrxcDFmceXcwbd9GH5QOCjaNsaSzh/Dqo6j8JaMQHUHXUhXGMvkPpvqCttAUXA==
X-Received: by 2002:a17:907:60c8:b0:6da:83f0:9eaa with SMTP id hv8-20020a17090760c800b006da83f09eaamr406832ejc.605.1647444911145;
        Wed, 16 Mar 2022 08:35:11 -0700 (PDT)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id w12-20020a17090649cc00b006d0bee77b9asm1024415ejv.72.2022.03.16.08.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:35:10 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH] Bluetooth: call hci_le_conn_failed with hdev lock in hci_le_conn_failed
Date:   Wed, 16 Mar 2022 16:33:50 +0100
Message-Id: <20220316153350.10047-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hci_le_conn_failed function's documentation says that the caller must
hold hdev->lock. The only callsite that does not hold that lock is
hci_le_conn_failed. The other 3 callsites hold the hdev->lock very
locally. The solution is to hold the lock during the call to
hci_le_conn_failed.

Fixes: 3c857757ef6e ("Bluetooth: Add directed advertising support through connect()")
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 net/bluetooth/hci_conn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 04ebe901e86f..3bb2b3b6a1c9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -669,7 +669,9 @@ static void le_conn_timeout(struct work_struct *work)
 	if (conn->role == HCI_ROLE_SLAVE) {
 		/* Disable LE Advertising */
 		le_disable_advertising(hdev);
+		hci_dev_lock(hdev);
 		hci_le_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
+		hci_dev_unlock(hdev);
 		return;
 	}
 
-- 
2.35.1

