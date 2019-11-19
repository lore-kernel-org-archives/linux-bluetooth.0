Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D05CC43215
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 06:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EC220872
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 06:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqKi0Iyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfKSGCZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:02:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42352 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbfKSGCZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 01:02:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so22289964wrf.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2019 22:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/BlS5+evosPvHmVUYm6S3V3Nm1zq5W5zoFtd5Loxbw=;
        b=iqKi0Iyze7C5Arl7JoZ403vsIWMOV4I38KahjokaPKFSux6z6d4YAu9KjWjmMNSCKK
         HI54AsFnjWD5trXH5/zFMSWGXnhY57YOtHrkPrGDB15KNvAFKylVVpIJNSiFhtJvu8Tt
         yE2B546Vt6D3hkKbtpJtbFiFzXH7c476lYJ9xCqCKS9sJzg4hlnf8UgPbkhqcfAMX9UF
         MAWfqk3mdtrpb5mogCttH7gmttaSZ0OGurZWObxxw2XJ/hin4/TGLKwUxtAFR+31Ceb1
         oMEv1QXExiMKWarIgi8s/Sa07FhFmPc3qde59d+5p9xvR2KmiUfCxTUBcv3DFMe54bdh
         YHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/BlS5+evosPvHmVUYm6S3V3Nm1zq5W5zoFtd5Loxbw=;
        b=A97yw0cjdu7vbiPuwANKqZvy+6b4Yg4baE6cAMdgDVy1oGEC2mEhgpRtyhrRdlnRPN
         IxCoTkgh+HbogL47m6DFqcEK9dhyAGz6b+ch00OiPVVbKaGaQvL4DUxhwoT1rFnsNP8f
         P+3x9nFNf3gFo2ljabh7MNnCu3JF2ZaXHQj/3Eh5wSIK3sTZPEyu/ZoUmc9rYyOETFiu
         hKr67uN5iEDyRINSIrfN23ifFVq+aa/SAxOylPxOohxLHjTZfIwkEvjlyHd1QLMmf809
         CKBbl6mKusSJ2qWgEZxMX6upmtaqXWHwpCbUUmbxLlEGzpuvTzXBHw3/nHjCMPsrIli6
         yiKw==
X-Gm-Message-State: APjAAAVmbOceEZqTVnb04HyxC2C3YuVAfTA8CgGNwsSAt6z8OPr57iKw
        IoIze25Ou2mqDjF+0BbmK1Y=
X-Google-Smtp-Source: APXvYqxcYydXCrYVBqEhFr/ibUYueLvo6f7R+OcQPtZUIs2zXQbwrehFUnLiyVEglTS0ITwZE0n7kQ==
X-Received: by 2002:adf:9786:: with SMTP id s6mr22769200wrb.188.1574143342972;
        Mon, 18 Nov 2019 22:02:22 -0800 (PST)
Received: from mamamia.internal (a89-183-91-150.net-htp.de. [89.183.91.150])
        by smtp.gmail.com with ESMTPSA id w4sm1791482wmi.39.2019.11.18.22.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 22:02:22 -0800 (PST)
From:   Andre Heider <a.heider@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v2] bluetooth: bcm: Use HCI_QUIRK_USE_BDADDR_PROPERTY
Date:   Tue, 19 Nov 2019 07:02:21 +0100
Message-Id: <20191119060221.3297340-1-a.heider@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some devices ship with the controller default address, like the
Orange Pi 3 (BCM4345C5).

Allow the bootloader to set a valid address through the device tree.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 2d2e6d862068..9d16162d01ea 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -439,6 +439,7 @@ int btbcm_finalize(struct hci_dev *hdev)
 	btbcm_check_bdaddr(hdev);
 
 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 
 	return 0;
 }
-- 
2.24.0

