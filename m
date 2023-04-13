Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F42C77B6E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Apr 2023 18:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDMSPe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Apr 2023 14:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMSPd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Apr 2023 14:15:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B624965A0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 11:15:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d22-20020a17090a111600b0023d1b009f52so19057958pja.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 11:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681409730; x=1684001730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=358+heE2o6OcvH2wEQoFktPRTIdMyWSY6TmCjjXXmt8=;
        b=qvTcQpNflbI+YEqIs6Y5OfmX0xpWoz7YH83rfiT4WSGEp2wf6aqdPvB5RF1RCS4Tx9
         9vomEtLEwPqgKS9AIUx1jyDpAAwIns6jYKG924VofxLqMAVkQNdSzxBIOvZCbVZSjT47
         lhwAb0iBGft49SId06Wh0EXF/mTQc8MHD6lzd84NbBNZnqnhQYh4eeIMNQAHmkE+2a+I
         tnajSl9Jbvru1pdi5hjmLRVgqoUXlvFohasfEqUXnULPL6bK9qwjRDq20STOSuP/U8XB
         Xit2QtOt9hzue4TqDALNk0XOwFCPTWkWguVmqm/oU+e9Cq2/uGkQdtCx3rmUz8upiFNd
         HEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681409730; x=1684001730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=358+heE2o6OcvH2wEQoFktPRTIdMyWSY6TmCjjXXmt8=;
        b=Mgw20oQR65OmBhIYti8cme/vA27+Ww22bjA53+p665DogBHWH0BkCsDBHodSQXpUvp
         42KtQoX12qylN0LWMbkophYDlTnJ+DLxx9Y1WCOe+VLG66+PWE+r5jPNR4zcpqWchqXt
         B9+tqAROOGofF6I2G80uQkE+QxX1LiCgdjyYzIYQuPhIuH+smZ+ga+1km/anmWFfqsIj
         SC5nvQ0RsNT2SZQcRp8OHMHBoIvGVgjmNeG4hUc0cMId8E5O5LUFMWrsOwA0wIw3IAHY
         gZ922kxQ+4bvNYEDpqKaCpadAcJCBc//6arFWbuugowYP0hi/eXt8IaevPBj4NwvtRj1
         DZtQ==
X-Gm-Message-State: AAQBX9dkcO2d0mfkBWOVGk3NVaYqHNt+guluRjFgwpS0mGzeQQ//HMu8
        AzpGFPFooYKRKpydgrHnaSLRnitAzeOsMg==
X-Google-Smtp-Source: AKy350aL1EgF7ENgY52R8psH1CriMObw0/xo1YDScHMD93JetDTvP14LKbMYZuqPOXsUileLvixhGQ==
X-Received: by 2002:a17:902:f90e:b0:1a1:b137:4975 with SMTP id kw14-20020a170902f90e00b001a1b1374975mr2628357plb.49.1681409730309;
        Thu, 13 Apr 2023 11:15:30 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id jn15-20020a170903050f00b001a1a9a639c2sm151921plb.134.2023.04.13.11.15.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 11:15:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] btdev: Fix not setting CIS parameters properly
Date:   Thu, 13 Apr 2023 11:15:27 -0700
Message-Id: <20230413181528.860660-1-luiz.dentz@gmail.com>
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

