Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AB0C77B6E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Apr 2023 21:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDMVEz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Apr 2023 17:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDMVEz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Apr 2023 17:04:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F6193CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 14:04:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d22-20020a17090a111600b0023d1b009f52so19531656pja.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681419892; x=1684011892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=358+heE2o6OcvH2wEQoFktPRTIdMyWSY6TmCjjXXmt8=;
        b=nsfvu8+juUcZW/v7RwAALnZZ2wKlX9Gg0WMUqALHYCHCLkEXT2kgUZNfHEpUFWmEBx
         qAyCUegILFIjmqtwHoJPf0E9XotuZNPbafoJUs/dN2ryEqeGRSQKChjWTShEEKLqjcLs
         1WNYfi3MMuE4UswoLsMP35SPCC9++04Yjl/o2dObpRofkv7DCdwLP4w0KHL7ZlDVqum0
         o+4HDX+1JO/9Wy6OH7PccF7/TosU0cmfOJr7ndcTVYyFlPE0XvR7VZKY785mVLqjrgWf
         EXOUUq+MG3yAqMIGTZ3E3hgjigUWJ4J9nwOiugcRzBpvqi5D/KCGyFmuMLL5equ1F42m
         tUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681419892; x=1684011892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=358+heE2o6OcvH2wEQoFktPRTIdMyWSY6TmCjjXXmt8=;
        b=jHYlreXFFNQfe8lgEK0XFvVLP096CKJiK1HMbqORN/BNHOqwYwU2sjOPf3LKnjeSZa
         B9+doPavfTKcFfd6cfyNtBDpNyuXe39AvfsuPp8ClzR6Ai65Sm1X2FWXqmoOXAMI2b24
         2xUE+sM6DWacvtbrP2Idadqh0zTnCOqIrodyk0KL6V4o0934SxcBWBR/OiJ9BSdCW/2M
         7BamXGP2me2jp/kJcHq7oRsQQef7neqpkExH5xLhsfQkEyI7bByNFHynQvP8gVcLqOTA
         eIlpnyUtimbbu8/9PnYs51DoxAg/cWpwlSRHbgL7XVvPqXuBvsOpJO4IZPyqbDN/ol31
         NtVw==
X-Gm-Message-State: AAQBX9dUJwKw46b9I8xJcrCMlWiC4UKz5rm1+on2AA18vy/MLU6grssI
        67oWt90A1NKZ0uNpy6i+UC3LuNnGKptjwA==
X-Google-Smtp-Source: AKy350ap/3+3uSAsHPbMOwG5NaPL6LiS0f0s+hDDEF54W/SU2WSPWAMpGDIlSIkZicyInEvI9AGuNQ==
X-Received: by 2002:a17:902:fb0e:b0:19e:8688:86fe with SMTP id le14-20020a170902fb0e00b0019e868886femr277257plb.42.1681419892116;
        Thu, 13 Apr 2023 14:04:52 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id ij8-20020a170902ab4800b001a514d75d16sm1898509plb.13.2023.04.13.14.04.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 14:04:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 1/2] btdev: Fix not setting CIS parameters properly
Date:   Thu, 13 Apr 2023 14:04:49 -0700
Message-Id: <20230413210450.961897-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The code was assuming only index 0 was to be used which doesn't work
when there are multiple CIS being programmed with different parameters.
---
 emulator/btdev.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 549f93645684..a04f34d4bdb3 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5885,6 +5885,7 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 
 	if (!evt.status) {
 		struct btdev *remote = conn->link->dev;
+		int i = conn->handle - ISO_HANDLE;
 
 		/* TODO: Figure out if these values makes sense */
 		memcpy(evt.cig_sync_delay, remote->le_cig.params.c_interval,
@@ -5895,15 +5896,15 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 				sizeof(remote->le_cig.params.c_interval));
 		memcpy(evt.p_latency, &remote->le_cig.params.p_interval,
 				sizeof(remote->le_cig.params.p_interval));
-		evt.c_phy = remote->le_cig.cis[0].c_phy;
-		evt.p_phy = remote->le_cig.cis[0].p_phy;
+		evt.c_phy = remote->le_cig.cis[i].c_phy;
+		evt.p_phy = remote->le_cig.cis[i].p_phy;
 		evt.nse = 0x01;
 		evt.c_bn = 0x01;
 		evt.p_bn = 0x01;
 		evt.c_ft = 0x01;
 		evt.p_ft = 0x01;
-		evt.c_mtu = remote->le_cig.cis[0].c_sdu;
-		evt.p_mtu = remote->le_cig.cis[0].p_sdu;
+		evt.c_mtu = remote->le_cig.cis[i].c_sdu;
+		evt.p_mtu = remote->le_cig.cis[i].p_sdu;
 		evt.interval = remote->le_cig.params.c_latency;
 	}
 
@@ -5948,7 +5949,7 @@ static int cmd_create_cis_complete(struct btdev *dev, const void *data,
 		evt.acl_handle = cpu_to_le16(acl->handle);
 		evt.cis_handle = cpu_to_le16(iso->handle);
 		evt.cig_id = iso->dev->le_cig.params.cig_id;
-		evt.cis_id = iso->dev->le_cig.cis[0].cis_id;
+		evt.cis_id = iso->dev->le_cig.cis[i].cis_id;
 
 		le_meta_event(iso->link->dev, BT_HCI_EVT_LE_CIS_REQ, &evt,
 					sizeof(evt));
-- 
2.39.2

