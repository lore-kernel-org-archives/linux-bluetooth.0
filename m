Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ADBC3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 13:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAB62073B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 13:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="2OemFCBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgCENOd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:14:33 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44001 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCENOd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 08:14:33 -0500
Received: by mail-lf1-f66.google.com with SMTP id s23so4570435lfs.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2020 05:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IlnU7KsjO6Oq1Dyh0wkqzUdwM1VDs47X9s4G63xFlxA=;
        b=2OemFCBIOCeggWREWZDuMl0uoeznlGI2dci+VQkTN70zKe6xURJB6p6wZNgRuybRUu
         srHlL0xdH2nvkR/WzWaToV6V0eYst0rxgAY4Cb3BDJa4sWnDgQf0PVw1HF8G4zlPU6hS
         6CGJ7Wck5tcXdECYcigDTtq6Ir5jBSgtiS6V1C+f1kQOAOVivUjQiB2n7+mUWIC1o3MB
         tz1yc3An4oI1X0zqVNkMmb2s6y0GwqlqUoAp3fPwVVIh9v0ynJ7xfaJR+888HE+SOF4n
         YNEoTxjrCU9D9NavTc6g26bSsNRgx990Sal6klpXww+cmjU17zKRM/EQLneeZnoV2f6g
         PptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IlnU7KsjO6Oq1Dyh0wkqzUdwM1VDs47X9s4G63xFlxA=;
        b=MRGz/cTwkdoNi/WsdNLJ62sh77c/vtN8ciWnFAybPUAQttD/2Zt0fsbm2gZStudSXf
         kH6zQ4hWz+K/g7c+4MUBvhfrrXZAfLIRh7vFSX4+8PqMrcs3siPH1YJvpDlgsoIlOs5F
         V13tlbQkofYnsfEbixwh659CWklaIeuM75M6D58rbXFVM4HT8Fr7Qq4adkI7k6iy7OuJ
         3Fn60BQblz0O3W4JrvKVTcuZtw9fRFQ7R5u4R562hVANmMyGQ4kY10haR/cJqH7pkO8E
         ifRzpwLgOBYBI/pvPEyQ8duPuF1XUPXOiybfMXkOv21Wp+ttZeWWvN7Gq6RnbvLF4mdP
         FXNg==
X-Gm-Message-State: ANhLgQ05/ri5gPAqfGgwVf0L0FPlVGjr+FB4dCRwHcAIyUNgAiC1TicK
        +0ExazFh90P0A0K8ESBoSKnnx4FSo9M=
X-Google-Smtp-Source: ADFU+vviklyqK/6Xb6ZE/QNYSFMiAlnKaSUBHmjBfFd5megHggODvT91B+4a4FX4DZIioNf8SMZP6w==
X-Received: by 2002:a05:6512:203c:: with SMTP id s28mr5596661lfs.117.1583414070776;
        Thu, 05 Mar 2020 05:14:30 -0800 (PST)
Received: from ix.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id o4sm9626817lfl.62.2020.03.05.05.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 05:14:30 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] Bluetooth: Make spurious error message debug
Date:   Thu,  5 Mar 2020 14:14:24 +0100
Message-Id: <20200305131424.381031-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Even with rate limited reporting this is very spammy and since
it is remote device that is providing bogus data there is no
need to report this as error.

[72454.143336] bt_err_ratelimited: 10 callbacks suppressed
[72454.143337] Bluetooth: hci0: advertising data len corrected
[72454.296314] Bluetooth: hci0: advertising data len corrected
[72454.892329] Bluetooth: hci0: advertising data len corrected
[72455.051319] Bluetooth: hci0: advertising data len corrected
[72455.357326] Bluetooth: hci0: advertising data len corrected
[72455.663295] Bluetooth: hci0: advertising data len corrected
[72455.787278] Bluetooth: hci0: advertising data len corrected
[72455.942278] Bluetooth: hci0: advertising data len corrected
[72456.094276] Bluetooth: hci0: advertising data len corrected
[72456.249137] Bluetooth: hci0: advertising data len corrected
[72459.416333] bt_err_ratelimited: 13 callbacks suppressed
[72459.416334] Bluetooth: hci0: advertising data len corrected
[72459.721334] Bluetooth: hci0: advertising data len corrected
[72460.011317] Bluetooth: hci0: advertising data len corrected
[72460.327171] Bluetooth: hci0: advertising data len corrected
[72460.638294] Bluetooth: hci0: advertising data len corrected
[72460.946350] Bluetooth: hci0: advertising data len corrected
[72461.225320] Bluetooth: hci0: advertising data len corrected
[72461.690322] Bluetooth: hci0: advertising data len corrected
[72462.118318] Bluetooth: hci0: advertising data len corrected
[72462.427319] Bluetooth: hci0: advertising data len corrected
[72464.546319] bt_err_ratelimited: 7 callbacks suppressed
[72464.546319] Bluetooth: hci0: advertising data len corrected
[72464.857318] Bluetooth: hci0: advertising data len corrected
[72465.163332] Bluetooth: hci0: advertising data len corrected
[72465.278331] Bluetooth: hci0: advertising data len corrected
[72465.432323] Bluetooth: hci0: advertising data len corrected
[72465.891334] Bluetooth: hci0: advertising data len corrected
[72466.045334] Bluetooth: hci0: advertising data len corrected
[72466.197321] Bluetooth: hci0: advertising data len corrected
[72466.340318] Bluetooth: hci0: advertising data len corrected
[72466.498335] Bluetooth: hci0: advertising data len corrected
[72469.803299] bt_err_ratelimited: 10 callbacks suppressed

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 net/bluetooth/hci_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a40ed31f6eb8..c69267f1951e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5277,7 +5277,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 
 	/* Adjust for actual length */
 	if (len != real_len) {
-		bt_dev_err_ratelimited(hdev, "advertising data len corrected");
+		BT_DBG("%s: advertising data len corrected (%u->%u)",
+		       hdev->name, len, real_len);
 		len = real_len;
 	}
 
-- 
2.24.1

