Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0616AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Dec 2021 22:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242407AbhLGW7p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 17:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242400AbhLGW7o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 17:59:44 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A4CC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 14:56:13 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y13so1752310edd.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 14:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yZi0bAN+7dNGL/Dc4WYuqpEaP070jZnR5ZkGoeW86hg=;
        b=k2aj/xZLtIkUDQzYmT6e/7r0ZnfmbSwdbDjj1gIi3cfRluk8Oj6q0RNTsHXzTCzY9w
         GGYQe0/cGK4bQIgJfL5eRJgSB5jkYs7/x97YY06ed/MU4bPVBtGjmEiVJ6DN+pf5u51k
         Nq3ozqfYC3Fz7wnzvL+oBC97SpCZlX4KO3eJuvJcDyragbAElXGm/yTeVFbGTA+qxNDY
         8B0R5ET27YIMZQd5Kga2l0w5dCYjrdmBea8isIaYu09+24vLhjjNO7VocXx3VaGBgoAc
         mkZTwidGXdQssmhTitF3b5RoedovLprARxRjHdSFPW8WU4iH5pvl3rBTTdPmpmBRZvJC
         sF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZi0bAN+7dNGL/Dc4WYuqpEaP070jZnR5ZkGoeW86hg=;
        b=N35Cph5KIS8M8BNvgceiRvUPWw0YmrQExHpiWEY618sPhprWeowvjlLenP9oTCiYHd
         EOIDFm//Xm4QONSbJNv5cN1SS9rBGCtLF2CiTXVKSwwpwQ8EB/xHlPR3imCRp5zRm0KP
         oW+LQHR73G4E0lX+rKTwUzeYuTaOiZoT97B3eK/gaMswfHDqCjYNeqRy0PCbdTgcj4HU
         Q+Y6PJ1c0FQR0ZUEfGODO+SOdqb6Oco+4GR+sm2CR9uUJqaXnT9uD4TZd0U+AjW5g5B2
         eDgj3VWCIUEDT3JEo0EjIwDX5FXTq17x/y9/bXSpk6CxCR7SRiTbl9zCatw2Dk79GW16
         QsmA==
X-Gm-Message-State: AOAM531FkiSvCIyor+tuT7Zdv6NvWzcrKFr3EZNa0T7LkWlMOH4sWwWU
        yLh2e4y4aUFiaI2MH9jzMQQ27G/ynmE=
X-Google-Smtp-Source: ABdhPJy+6chSGzmmO3M95ZzZx0gSSdlxOKF2i4TBVGdQRJCqzaoNxwyBnmFD9TKWzLN6bsgMH6FFmQ==
X-Received: by 2002:a17:906:5501:: with SMTP id r1mr2843823ejp.212.1638917771797;
        Tue, 07 Dec 2021 14:56:11 -0800 (PST)
Received: from aspire.cbl.vpn (net-188-217-49-100.cust.vodafonedsl.it. [188.217.49.100])
        by smtp.gmail.com with ESMTPSA id ho30sm489468ejc.30.2021.12.07.14.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 14:56:11 -0800 (PST)
From:   Daniele Biagetti <dbiagio79@gmail.com>
X-Google-Original-From: Daniele Biagetti <daniele.biagetti@cblelectronics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniele Biagetti <daniele.biagetti@cblelectronics.com>
Subject: [PATCH BlueZ 4/6] tools/mesh-gatt: Add subscription delete message to config client model
Date:   Tue,  7 Dec 2021 23:56:02 +0100
Message-Id: <20211207225604.35156-5-daniele.biagetti@cblelectronics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207225604.35156-1-daniele.biagetti@cblelectronics.com>
References: <20211207225604.35156-1-daniele.biagetti@cblelectronics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/mesh-gatt/config-client.c | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/mesh-gatt/config-client.c b/tools/mesh-gatt/config-client.c
index 7bdd028d2..c61908b4e 100644
--- a/tools/mesh-gatt/config-client.c
+++ b/tools/mesh-gatt/config-client.c
@@ -1037,6 +1037,44 @@ static void cmd_sub_get(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void cmd_sub_del(int argc, char *argv[])
+{
+        uint16_t n;
+        uint8_t msg[32];
+        int parm_cnt;
+
+        if (IS_UNASSIGNED(target)) {
+                bt_shell_printf("Destination not set\n");
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        }
+
+        n = mesh_opcode_set(OP_CONFIG_MODEL_SUB_DELETE, msg);
+
+        parm_cnt = read_input_parameters(argc, argv);
+        if (parm_cnt != 3) {
+                bt_shell_printf("Bad arguments: %s\n", argv[1]);
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        }
+
+        /* Per Mesh Profile 4.3.2.19 */
+        /* Element Address */
+        put_le16(parms[0], msg + n);
+        n += 2;
+        /* Subscription Address */
+        put_le16(parms[1], msg + n);
+        n += 2;
+        /* SIG Model ID */
+        put_le16(parms[2], msg + n);
+        n += 2;
+
+        if (!config_send(msg, n)) {
+                bt_shell_printf("Failed to send \"DELETE SUBSCRIPTION\"\n");
+                return bt_shell_noninteractive_quit(EXIT_FAILURE);
+        }
+
+        return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static void cmd_mod_appidx_get(int argc, char *argv[])
 {
 	uint16_t n;
@@ -1232,6 +1270,8 @@ static const struct bt_shell_menu cfg_menu = {
 				cmd_sub_add,    "Add subscription"},
 	{"sub-get", "<ele_addr> <model id>",
 				cmd_sub_get,    "Get subscription"},
+	{"sub-del", "<ele_addr> <sub_addr> <model id>",
+				cmd_sub_del,    "Delete subscription"},
 	{"node-reset",		NULL,                    cmd_node_reset,
 				"Reset a node and remove it from network"},
 	{} },
-- 
2.25.1

