Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218D7C77B61
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Apr 2023 18:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjDGSCe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Apr 2023 14:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjDGSC2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Apr 2023 14:02:28 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F7FAF0D
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Apr 2023 11:02:06 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id kq3so40546948plb.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Apr 2023 11:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680890525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vuQCtQA3zzbxQ/51A1Oi1S7Ut8EFYywvcTa4TksyED8=;
        b=UtYZBxlWP851b84Yu7USaZwE510VKaAnuCQ4E+YZ5yOWntS5+e5D41BSGVqbURKklA
         A1BqKRP9XyXZfmk6ZRbMDc8xRH2RtSfC+dD/4aqXXb7b4zmmsdFaBmA1HVM7QNBOHant
         5CLheiilz2jjgmvaohIcTyA2VuGmd+KHRkMm3zyFF2rGip1Iiv7e/YeUzena2fOLg95a
         HYxABECK57qiZEs3VQ30wjUoeWHdeLOFp7qt90qsG7wBXqYjAd1d0sHcKwivtpGq1Req
         aPbiSulHhQQ1KMrkRESqdDmaEb7NrC59++UfMQm3hnRsH1E3pwAGSKriM9cywF9UEUDZ
         zE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680890525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuQCtQA3zzbxQ/51A1Oi1S7Ut8EFYywvcTa4TksyED8=;
        b=o4qLVGDenMBTarazw4h3t6T3ddiVxHt+yYEw2PcsFv22leouixNeWgi4HSHdlLtm3s
         s2NWW/EIzm70ugRWZYiKsxB4Ym9XbP+9x89/RkHq4zHMLp08VHnEgQtRFxzUQvdwqwaA
         R5AgSH0wae3G3v84oCjscWIyqkHPZph70QdEQDJPcIGqAttXgfHSVbOWs0nC7Ez0ddxz
         ytMYVeeh7egfWpV1CL+odg3hhnZM0c8yg8ZQHGMAQyTNtFeiCJBrj/YasMqWRVmSGvD9
         icgZEzJU7yBTgn11cfWE0DpwHeFdFOpd/HHErIRjgSpw89yyHyhKiI7zVxJlOW5eUHly
         Vxsw==
X-Gm-Message-State: AAQBX9fDjLbrw9xY6++TtkBLwevjdTpLn2aIyJzMv8LHgv/L2W0vZ20Y
        2k7sKpDQd81T1YuKPHLAO88NNFi9lWY=
X-Google-Smtp-Source: AKy350aWTLP4kaZOldTIHqYIdjYEQ48X15DzhKf/A6TIRHx865Bl6qU+A2zgVIAYCcKU5ZRcXYbDDA==
X-Received: by 2002:a05:6a20:6d0f:b0:cc:63c6:8d3a with SMTP id fv15-20020a056a206d0f00b000cc63c68d3amr3384089pzb.41.1680890524505;
        Fri, 07 Apr 2023 11:02:04 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id 186-20020a6304c3000000b004fbb4a55b64sm2985993pge.86.2023.04.07.11.02.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 11:02:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix use-after-free in l2cap_disconnect_{req,rsp}
Date:   Fri,  7 Apr 2023 11:02:01 -0700
Message-Id: <20230407180201.3229763-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Similar to commit d0be8347c623 ("Bluetooth: L2CAP: Fix use-after-free
caused by l2cap_chan_put"), just use l2cap_chan_hold_unless_zero to
prevent referencing a channel that is about to be destroyed.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Min Li <lm0963hack@gmail.com>
---
 net/bluetooth/l2cap_core.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8153293b9a45..5cc95fd17f7d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4651,33 +4651,27 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
 
-	mutex_lock(&conn->chan_lock);
-
-	chan = __l2cap_get_chan_by_scid(conn, dcid);
+	chan = l2cap_get_chan_by_scid(conn, dcid);
 	if (!chan) {
-		mutex_unlock(&conn->chan_lock);
 		cmd_reject_invalid_cid(conn, cmd->ident, dcid, scid);
 		return 0;
 	}
 
-	l2cap_chan_hold(chan);
-	l2cap_chan_lock(chan);
-
 	rsp.dcid = cpu_to_le16(chan->scid);
 	rsp.scid = cpu_to_le16(chan->dcid);
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_DISCONN_RSP, sizeof(rsp), &rsp);
 
 	chan->ops->set_shutdown(chan);
 
+	mutex_lock(&conn->chan_lock);
 	l2cap_chan_del(chan, ECONNRESET);
+	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan);
 
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
-	mutex_unlock(&conn->chan_lock);
-
 	return 0;
 }
 
@@ -4697,33 +4691,27 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x", dcid, scid);
 
-	mutex_lock(&conn->chan_lock);
-
-	chan = __l2cap_get_chan_by_scid(conn, scid);
+	chan = l2cap_get_chan_by_scid(conn, scid);
 	if (!chan) {
 		mutex_unlock(&conn->chan_lock);
 		return 0;
 	}
 
-	l2cap_chan_hold(chan);
-	l2cap_chan_lock(chan);
-
 	if (chan->state != BT_DISCONN) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
-		mutex_unlock(&conn->chan_lock);
 		return 0;
 	}
 
+	mutex_lock(&conn->chan_lock);
 	l2cap_chan_del(chan, 0);
+	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan);
 
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
-	mutex_unlock(&conn->chan_lock);
-
 	return 0;
 }
 
-- 
2.39.2

