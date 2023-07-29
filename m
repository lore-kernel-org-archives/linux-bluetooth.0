Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039A8C001DF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jul 2023 00:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjG2Ar3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 20:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbjG2Ar0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 20:47:26 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2E44237
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 17:46:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb7589b187so4628528e87.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 17:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20221208.gappssmtp.com; s=20221208; t=1690591556; x=1691196356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQ3cPYEHW9sMNlIQBEkS+SFH6nsiO3HdBnY1xiKKbmM=;
        b=Xv4ygJ8DS0pFSs+kj9sI02zEaoQdEe5rTrhCYIFqN4F8oJrvX0wkrXkSEAAOReoFEe
         5iwTgyfshJqB/DFQLevewku1YX5m5Y0rtGjvDfSKkmxf2k1HbkVtfiYm2HdkusjDePSo
         0J9A+afajfd1H7svAYRNttI4/rW5vM8/qdmx2xbNLFVcpa0BtDSSHLKU6Yz8n45sUfVu
         YCOXUkc0dZogH10KmPrvPDsa0tWDc8oqEfq1GKNc183qJZiXJ9rptineR2RVh4AJccyz
         fOLmnbf8KeChOphTEmneWI2WD3UAQcKsAbSeP+5fCF6tOOuu15s5l5YxgGt7i5D6UmbS
         d2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591556; x=1691196356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQ3cPYEHW9sMNlIQBEkS+SFH6nsiO3HdBnY1xiKKbmM=;
        b=GtpwdUJSGhPiMd7/E09bFtVS1H/gYLonykDts3bhV2zSzfEqJBgr58LohALhrwVsxG
         nq7+4kfcKF4jehydZtZhJiesHs4MqJhktl0MksNOxbozrzhlScC0XoQqPn1nqUTbTQt0
         FTcodxj0iEJRkwnLOGJUk4RcBKyUmbXAOqapzJQyfS8ZNd2Kh3xqow6s6v4Eimctd2nd
         wm7F2C7Az3H6YmyFoAfQtSAminEZniDWq6cdlclUhluzNG90HgmDgh7D+rAwQIXv30QM
         dW2uuFkDv+ESovMihf8GGKHO5m5lxMCJ1V0PAsc26BU7QVw91KiP+TIEpjLAruDqCRO0
         R17g==
X-Gm-Message-State: ABy/qLZVR93VM/WK+kDaQzhmzngYtWaZHmiTYkOaqpjP4fq6nZYj2/35
        OmGHhPF5HOi67idbUjLBtvOHlWKxjYRKwZT7kiA=
X-Google-Smtp-Source: APBJJlF33Gno5QjXtayfXx7qAQ8Tz4hzoqNpsk+wze6LwwQstDYMvg3oyyNHAA+tbvvHxHjdiqlUPg==
X-Received: by 2002:a19:654e:0:b0:4fe:1ac9:fe5a with SMTP id c14-20020a19654e000000b004fe1ac9fe5amr2853356lfj.39.1690591555709;
        Fri, 28 Jul 2023 17:45:55 -0700 (PDT)
Received: from rymek.localdomain (217.96.255.138.ipv4.supernova.orange.pl. [217.96.255.138])
        by smtp.gmail.com with ESMTPSA id r25-20020ac24d19000000b004fe1f1c0ee4sm617746lfi.82.2023.07.28.17.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:45:55 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 1/5] monitor: Fix decoding Command Complete for Remove ISO Data path
Date:   Sat, 29 Jul 2023 02:45:48 +0200
Message-Id: <20230729004552.1422547-2-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230729004552.1422547-1-lukasz.rymanowski@codecoup.pl>
References: <20230729004552.1422547-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Before

< HCI Command: LE Remove Isochronous Data Path (0x08|0x006f) plen 3                                                        #1061 139.246292
        Connection Handle: 96
        Data Path Direction: Output (Controller to Host) (0x01)
> HCI Event: Command Complete (0x0e) plen 6                                                                                #1062 139.246954
      LE Remove Isochronous Data Path (0x08|0x006f) ncmd 1
        invalid packet size
        00 60 00

After patch

< HCI Command: LE Remove Isochronous Data Path (0x08|0x006f) plen 3                                                        #1061 139.246292
        Connection Handle: 96
        Data Path Direction: 0x01
          Input (Host to Controller)
> HCI Event: Command Complete (0x0e) plen 6                                                                                #1062 139.246954
      LE Remove Isochronous Data Path (0x08|0x006f) ncmd 1
        Status: Success (0x00)
        Connection handle: 96
---
 monitor/bt.h     | 5 +++++
 monitor/packet.c | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index b60263fa0..fcc5478bf 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2862,6 +2862,11 @@ struct bt_hci_cmd_le_remove_iso_path {
 	uint8_t  direction;
 } __attribute__ ((packed));
 
+struct bt_hci_rsp_le_remove_iso_path {
+	uint8_t  status;
+	uint16_t handle;
+} __attribute__ ((packed));
+
 #define BT_HCI_CMD_LE_ISO_TX_TEST		0x2070
 #define BT_HCI_BIT_LE_ISO_TX_TEST		BT_HCI_CMD_BIT(43, 5)
 
diff --git a/monitor/packet.c b/monitor/packet.c
index f581a8e72..c7c0308db 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9871,7 +9871,9 @@ static const struct opcode_data opcode_table[] = {
 				"LE Remove Isochronous Data Path",
 				le_remove_iso_path_cmd,
 				sizeof(struct bt_hci_cmd_le_remove_iso_path),
-				true, status_rsp, 1, true },
+				true, status_handle_rsp,
+				sizeof(struct bt_hci_rsp_le_remove_iso_path),
+				true },
 	{ BT_HCI_CMD_LE_ISO_TX_TEST, BT_HCI_BIT_LE_ISO_TX_TEST,
 				"LE Isochronous Transmit Test", NULL, 0,
 				false },
-- 
2.34.1

