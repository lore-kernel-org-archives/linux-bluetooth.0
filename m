Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB11C001E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 21:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjGZVZi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjGZVZf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 17:25:35 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABCE2685
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 14:25:34 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RB6Pd0n89z49QC8;
        Thu, 27 Jul 2023 00:25:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1690406725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDRbDxhcmxM6TQltf1ltJPpCenY7pRNdxtB1Zgs1JwE=;
        b=jWM72t0vUKmsvJxbHzklGFVXRhVIzlnUf868If+/G4NNaHWgFynNtjdFnA0s4vaSbuqNiI
        GZZ2YCcZsggM4Xp406Qm+0da1FWaTvbR3NaEqdyOvo9Vn4iedec9VtDMLL4kFIwQtnI1ug
        e8yU9ej5Xwyj2g2G3ugIOrLMlErOhwXNU62+xaSwMCO+4X4PcgZ3If0AuJgoqRTIgF2U89
        rKKWz+KwcJ4/qJsxEQtkcLi94MrYuOX5XRv/2QasXIfJrOo/52lyBsTTpZjMZjh3Kdf+WS
        5hyDI5Q+/U/d7M/ARi8SBW6vxOCuwaE0KCZMnGBneUR8p4Es6IFXHGIaKTCaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1690406725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDRbDxhcmxM6TQltf1ltJPpCenY7pRNdxtB1Zgs1JwE=;
        b=GzTJPQmHFph8hElQpaocHBgbGYjJ7FfImNA7GLMPCZxs9wDCdI/anQDBS1FZFsmCaxlgR9
        k4Ywd7Vp3MI0LvSPyLQiR2XnqUyvQQ5Zpcm+I2LhIsHAADxWIN24oKxWKTQSdBM7neInQ9
        pvtvQ+I7EaQfUY6p8Tu8NL0uYGq8rtdpVCjQi5SAh/n3ONERlTGn8qh8G/yENOBC/mlz4a
        RbAeSFZux9ZDYSYAvEHvWSUDUI9Dv6YhK2YGk5uOIQQb9lH4Oxa+M86HxNS/N6Ol4HKe8B
        8j+P1faHmsUex4HdclR0fUepyPAWbAWWCtXNhFx1ny/KnumUF+x0x6Ph33TbvA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1690406725; a=rsa-sha256;
        cv=none;
        b=a6jYeC0LLhfx8xTmBXEfCUF77C8mviuKriP5b9kvYSqzr4QJRrrR0zWNiDpWXFVkpwsqzj
        RWUWpF5OBTgJupDxP411q3uSa35/PegbbZ8ukDadQ/BpzmeOAo1UJPqbitL8ls9/e7jK91
        7oM5tZx3wqldH2JTk1d0aF2BfatQTg2OBvyZCWRV+4LZ57WlCLIVMRyT/Yt2NChPGTsAOp
        6zV5NW0gRarImpaWAv52D06ge35a9qwDsH6X7TO9mj+ngcfByNPbTmFoBKOxwpZD/RNr/t
        JqMV3voRJexX345L1nxLJFoQcKwSzV/uLK9PXchZTl8bFiYYHpbxKv5X8/kocA==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 5/5] btdev: fix Command Status command opcodes for Setup Sync Conn
Date:   Thu, 27 Jul 2023 00:25:19 +0300
Message-ID: <0cba38cb79fc6d940af00d599be6d9d72ef86020.1690405564.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690405564.git.pav@iki.fi>
References: <cover.1690405564.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The command opcode should be the CMD, not EVT.
---
 emulator/btdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 0c75e71c0..2483a35c5 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2681,7 +2681,7 @@ static int cmd_enhanced_setup_sync_conn(struct btdev *dev, const void *data,
 	if (cmd->tx_coding_format[0] > 5)
 		status = BT_HCI_ERR_INVALID_PARAMETERS;
 
-	cmd_status(dev, status, BT_HCI_EVT_SYNC_CONN_COMPLETE);
+	cmd_status(dev, status, BT_HCI_CMD_ENHANCED_SETUP_SYNC_CONN);
 
 	return 0;
 }
@@ -2727,7 +2727,7 @@ done:
 
 static int cmd_setup_sync_conn(struct btdev *dev, const void *data, uint8_t len)
 {
-	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_EVT_SYNC_CONN_COMPLETE);
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_SETUP_SYNC_CONN);
 
 	return 0;
 }
-- 
2.41.0

