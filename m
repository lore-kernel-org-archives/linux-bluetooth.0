Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1769FC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2722086D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 17:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCYKFkpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfARRCq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:02:46 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40906 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfARRCq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 12:02:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so6607968plq.7;
        Fri, 18 Jan 2019 09:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3GYPwFAfOQ2PBwuTZDsLKhTieI3hmQzYqkGxR2OgQSM=;
        b=jCYKFkpjXqGzDObfujVjSF4j6c6ARgIt8wreJEFYkmR/9xZsRwyxTyO00TYXkd0qza
         DYOgUwlzeUHGBXlgyET6F7DsZpjSphFI3O/88XjoMOxJ/NiLXDLONXJB5evqKMxIYRxh
         KukpdkTAn43/bBzOzGozLnSBakoLfKM4DU3ynL3RrQuSdPLfgPnQbyo/zBYdI7X02mT1
         0eDtpaxD7DwfvC7ETKqHcyEIVCm3cmwr89aIl2JWRK7Ofly6k35jCuD79eWWvoMXAcch
         S99l4Dwg1lk1H5SDQ/+CkSZ5PbH2KhU4AcaXq19BB8MdCvLCW7iEYiaKPCzPSWahnFuW
         Oqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3GYPwFAfOQ2PBwuTZDsLKhTieI3hmQzYqkGxR2OgQSM=;
        b=dxmMUFlnciNq18lJ9rqMFnjCuEi2ZhfSavZcnQiRrKdfidQ5pYCPAMiWwyENIb/Mhk
         3toHHyNc/oAqlRqE4M7BZyNXPaYEMKgz1DfajM2aAlXAyEVvcV86WSlFNueCUUvpXnu9
         yOjZtIHfCmfxsyLvbOcAMVCn3LIQ/LA+XK/rzGTfBqMplYOZhmS/GQVAkJ0+gHXqWaKD
         7+324KhY30yC82HwSZ4BJ2W++tvJWoj1LRYlk1jEVrfVsEg+tfeN7HQB27i5aBCYemdI
         ChMA6FCn6g1xEe9kj0o4ddOfjL+jZW0GclkLM/qAOECTx8n+Agw1pLebzyVvXQho2NgO
         8TAQ==
X-Gm-Message-State: AJcUukf4x2zSGYCxoNlCxAQQAsMV143btJE5y/B8aKudrvtRcWf7ELhO
        d22RyVkSzbeyiF/dKRZWImU=
X-Google-Smtp-Source: ALg8bN5GYqC1evbJwdjXhHBNVtpkDQAi7VzvvBJXjFG03Ue4K5yK643MPMID0mliToQZas5hMgNhXA==
X-Received: by 2002:a17:902:7791:: with SMTP id o17mr19716381pll.60.1547830964956;
        Fri, 18 Jan 2019 09:02:44 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id b4sm5672222pgq.65.2019.01.18.09.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:02:44 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] Bluetooth: Add new quirk for broken local ext features max_page
Date:   Fri, 18 Jan 2019 09:02:25 -0800
Message-Id: <20190118170232.16142-2-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118170232.16142-1-anarsoul@gmail.com>
References: <20190118170232.16142-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some adapters (e.g. RTL8723CS) advertise that they have more than
2 pages for local ext features, but they don't support any features
declared in these pages. RTL8723CS reports max_page = 2 and declares
support for sync train and secure connection, but it responds with
either garbage or with error in status on corresponding commands.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 include/net/bluetooth/hci.h | 7 +++++++
 net/bluetooth/hci_event.c   | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c36dc1e20556..d7849f128d58 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -192,6 +192,13 @@ enum {
 	 *
 	 */
 	HCI_QUIRK_NON_PERSISTENT_SETUP,
+
+	/* When this quirk is set, max_page for local extended features
+	 * is set to 1, even if controller reports higher number. Some
+	 * controllers (e.g. RTL8723CS) report more pages, but they
+	 * don't actually support features declared there.
+	 */
+	HCI_QUIRK_BROKEN_LOCAL_EXT_FTR_MAX_PAGE,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ac2826ce162b..9c59af7de197 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -639,7 +639,9 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 	if (rp->status)
 		return;
 
-	if (hdev->max_page < rp->max_page)
+	if (!test_bit(HCI_QUIRK_BROKEN_LOCAL_EXT_FTR_MAX_PAGE,
+		      &hdev->quirks) &&
+	    hdev->max_page < rp->max_page)
 		hdev->max_page = rp->max_page;
 
 	if (rp->page < HCI_MAX_PAGES)
-- 
2.20.1

