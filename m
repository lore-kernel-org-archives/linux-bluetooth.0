Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8313C00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 22:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiHAWEc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 18:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiHAWEa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 18:04:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F2E3FA25
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 15:04:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id pm17so6317913pjb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Aug 2022 15:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=72KAlD2pQNQ9CZ/2B0QMvYLDQXYGmx3HJ4jf0lt4E24=;
        b=Xv6aBA/l69LLrQV/k9dllQh9ctzX4XdfjqaS+r/Yj7BYDqaRMCx9NmFjtYlwiXb8y+
         tyL1uuxy/oIEcEgGOKfchcmWKNhK3C19N/Eu68eD+pn+G6obE9KOxbSyg8+D0xaFryOl
         pHBVNIkvwlmXhK5ZbXiVojVF7+GKbTKQTuQ+qF8W6Tdd1trPafSpLQmjYVcl7MZFjyyr
         y9bp9aKQ+skkCb9GFx6e3QEZicXEerAtPJkbQ7OOoswAYP+HkprYyQp8PXIKuvKwdCl4
         unmLuS16BWKwIDH5PgAB05koLISkmZe2813v3OdqLW2hYbmoP7Llgxy+VkKUqefRBBY+
         ltBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=72KAlD2pQNQ9CZ/2B0QMvYLDQXYGmx3HJ4jf0lt4E24=;
        b=8Hm3S4DFcO0zJycnOyR9DvMuwJFiNI3nfXdh/ylCiS68DfsZFVjQqzq9Cyx7kVhPBB
         NbF7V3/x+xQ31vPSpZgB9dL0r5gnZyzyj/reux5/M07FaZ8snXLEAFXmDk86Z1WqtyTc
         K3DwbmxPUbbnDsU5jvie/Au+MB629Bb3vmYMlCZG0H58+Xhkfj5silZqN06DUhN8vltz
         UeqaXwK2x60UvMWvbIZuLoad4Byvu5UBPswKrqK8v2aKwffb5xd4RRtrcPyp8TkR8u6J
         3d/rC+xg0LFh3XGsOMc8fNHYwvKiHLTcVt3bT+G3175pX5i5cn/JFN5xWyZ4iNrF1uVJ
         VwMA==
X-Gm-Message-State: ACgBeo3tZF9kxD0htFvxVQtyK4SCe5fcw+lrVsDTYBAJ2CMUPG4woM8X
        tEZC/2jDWTW1GavDskGtXFTUqMkpd80C/g==
X-Google-Smtp-Source: AA6agR6fwP0+3L2a64gNfLJ5DTXwXiDgB+3yVmcHaKIqBDKSYjQ+QIDMto5i6zkAMeBzqnowskLNng==
X-Received: by 2002:a17:90a:14f:b0:1f4:e8d0:e5ab with SMTP id z15-20020a17090a014f00b001f4e8d0e5abmr11399464pje.200.1659391469026;
        Mon, 01 Aug 2022 15:04:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v66-20020a622f45000000b005254535a2cfsm9109288pfv.136.2022.08.01.15.04.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 15:04:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm regression
Date:   Mon,  1 Aug 2022 15:04:26 -0700
Message-Id: <20220801220426.2198967-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The patch d0be8347c623: "Bluetooth: L2CAP: Fix use-after-free caused
by l2cap_chan_put" from Jul 21, 2022, leads to the following Smatch
static checker warning:

        net/bluetooth/l2cap_core.c:1977 l2cap_global_chan_by_psm()
        error: we previously assumed 'c' could be null (see line 1996)

Fixes: d0be8347c623: "Bluetooth: L2CAP: Fix use-after-free caused by l2cap_chan_put"
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 77c0aac14539..cbe0cae73434 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1970,11 +1970,11 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 						   bdaddr_t *dst,
 						   u8 link_type)
 {
-	struct l2cap_chan *c, *c1 = NULL;
+	struct l2cap_chan *c, *tmp, *c1 = NULL;
 
 	read_lock(&chan_list_lock);
 
-	list_for_each_entry(c, &chan_list, global_l) {
+	list_for_each_entry_safe(c, tmp, &chan_list, global_l) {
 		if (state && c->state != state)
 			continue;
 
@@ -1993,11 +1993,10 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 			dst_match = !bacmp(&c->dst, dst);
 			if (src_match && dst_match) {
 				c = l2cap_chan_hold_unless_zero(c);
-				if (!c)
-					continue;
-
-				read_unlock(&chan_list_lock);
-				return c;
+				if (c) {
+					read_unlock(&chan_list_lock);
+					return c;
+				}
 			}
 
 			/* Closest match */
-- 
2.37.1

