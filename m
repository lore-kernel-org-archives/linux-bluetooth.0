Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8ADE7545E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 18:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjJCSm3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 14:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJCSm2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 14:42:28 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA82E83
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 11:42:25 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-692d2e8c003so88464b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Oct 2023 11:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696358544; x=1696963344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GO3ja3uFisK+FzEXEk75vV1dEsOVFg1hwNYC0RSfqq4=;
        b=jobn2hhLwG30cFFBHlJC97cgE0R3PI6RAuxgwEVlpBIwQCuwsLc+Ci4yQEfhiXyYob
         cg38M5ak4/zcBLzsChCYulzW2UbzcFRKAtfiBqAGJkmOppFQ3YiWG5dHSZkGP+0OnXyb
         iyYn4mwKxDFJO1rz1pW8y+I13/oVo7c9OBg+yQCoa2aeJwLWp1Doc14/A0gbr4J8rCgB
         8WNH8fKqEKBoPZleuCSX/HOOLZn4a/637kmixZKoY3VAgQwmK7sQJ+b+SPXtWlrr4Mhr
         KoSKi+jwqqO7GFPKQ+6H+vp5aghsbU1U4zr1HOe9QxQU0B11IGn6avFjakJsn0+AgEFv
         7NWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696358544; x=1696963344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GO3ja3uFisK+FzEXEk75vV1dEsOVFg1hwNYC0RSfqq4=;
        b=p3uwiUvcfSsCFpdpwDhQUL27nCN6ZcU+gpuCfhQwbdtep3Yjk2MtJPs0iC0RIPs4pf
         gnNyuO2w04vIVe/uH4aJAF/Y7RG+7MY5YF9xgJSXuyq1LGPztnk8Pa7rWARsNA6e8yX7
         27dke31qf6sD8vSgcBfOrN6Jm6Kgm69U1P7TW6Xprjc6Ue7JFO+Rqvw3BaENX00BzyDi
         XAaH89d3P3m0ZlStqR4yUT4LUdXIAOxLhaUCTA6FZSlYGQwSM6KdHamNMIpjBiF83URd
         tBvxCq1KRdXSh2ZYLldO2o8gw7O9b00bhrY80oQ4UwPfXxs9zUXMS0q8abSC/zQS818t
         tKlw==
X-Gm-Message-State: AOJu0YyNw5tN1yvU+M+nYlYBETX+VbhTV+pxql9CsSNBcVd+SiuqSQ2H
        00pFOSxlcKw2pgCSuCx+Qz+yff70SBA8GQdc
X-Google-Smtp-Source: AGHT+IEemgtdRpKasfCT67Xqth7HFA2nz1woQ5QTDuNXtBdoneVNbsvo+uRsdvxE+86bwB+yXS1/eg==
X-Received: by 2002:a05:6a20:12d6:b0:13e:90aa:8c8b with SMTP id v22-20020a056a2012d600b0013e90aa8c8bmr193400pzg.4.1696358544391;
        Tue, 03 Oct 2023 11:42:24 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id p18-20020a62ab12000000b006926a2c9eb7sm1696219pff.119.2023.10.03.11.42.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 11:42:23 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/att: Don't keep retrying the same operation
Date:   Tue,  3 Oct 2023 11:42:22 -0700
Message-ID: <20231003184222.3273301-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If an operation has been retried already don't attempt to change the
security again.
---
 src/shared/att.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 85feead77d0f..62c884b65721 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -193,6 +193,7 @@ struct att_send_op {
 	uint8_t opcode;
 	void *pdu;
 	uint16_t len;
+	bool retry;
 	bt_att_response_func_t callback;
 	bt_att_destroy_func_t destroy;
 	void *user_data;
@@ -785,6 +786,12 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
 
 	*opcode = rsp->opcode;
 
+	/* If operation has already been marked as retry don't attempt to change
+	 * the security again.
+	 */
+	if (op->retry)
+		return false;
+
 	/* Attempt to change security */
 	if (!change_security(chan, rsp->ecode))
 		return false;
@@ -798,6 +805,7 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
 	DBG(att, "(chan %p) Retrying operation %p", chan, op);
 
 	chan->pending_req = NULL;
+	op->retry = true;
 
 	/* Push operation back to channel queue */
 	return queue_push_head(chan->queue, op);
-- 
2.41.0

