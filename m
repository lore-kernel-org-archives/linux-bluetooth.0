Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24CBC0015E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Aug 2023 12:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjHEM3P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Aug 2023 08:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjHEM3O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Aug 2023 08:29:14 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6C144BD
        for <linux-bluetooth@vger.kernel.org>; Sat,  5 Aug 2023 05:29:13 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RJ22H0vgfz49QDB;
        Sat,  5 Aug 2023 15:29:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691238551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L2rw73kLroKoM/0YJSlR8IioJr3KPJjTt7OYh30MAjk=;
        b=VXW3nR4N1YUiUjhfHmhl02GPpAUCAORLTPV2mEoYmImrtbhgjD7aIlhVYPp2L+YMqVNKo8
        qpOFV8wyiSu8RnU9lK0VMbxlVzzZCet8ZCBW3JZx3407c9MXVy2aAXfnfbq9yOGBMZ9NEj
        kW/e6gtmFpXCf9LHV3n2ITvRih5r31Aa6q70nmtnQWnTKwQIKAnbl5l2LT6713Xu7oEZsu
        vj8raaG/Ifhi1gqpkS5WAxB/e1Yo3Tl/Zyio4LWofjLfJz2bOaFbDjk8nNHzv3fSqRysZQ
        oQHMfwkdKGE3dS6rzX/ertWVBF+dy16rA/+UzNquJTe6n0bAw0Wzgy578IzQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691238551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L2rw73kLroKoM/0YJSlR8IioJr3KPJjTt7OYh30MAjk=;
        b=reitWZ69k2qjlOMW9kS2El0F3yE34d2cEi5o97100fb8g7PFyQhRC7fHFc0rdXlob0M2Fz
        nps+mxLphrQecNBqnqVKTtSUwXO5XgZTlbn7bGzjLTyNpjLG85x2aAaEzIKJqZdZkCHAud
        lJ/xqtVs0fCn8lb/j2IP/5q7+d8RFN0S8loLapKCVQC+hYRaSLO/nhxNp4+WdqiKh79zch
        qSwLBa/wPMZXwOoCpcyGAQ/8GSHOUoLIp6oeolhqi0o3dAx6msePVa6wVmry493yvyxcfW
        jHNRHY26OxmgS4rqP1m/iJfyB2R+mxS6aqA8pIVXEzIFyQQnkGsjgq7XAZy3yA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691238551; a=rsa-sha256;
        cv=none;
        b=iUzZCz2JgVMvEFqqYmMEL9Qpe20uguU3g9xn7hXxZUkcyOG7ajZm60D38cXPww8l/U85Aj
        vwnhNr9NBt6iMAyWDlGZrd/VOzDt1Q5n0DmIWEzsUqIjNMExgbPn4/8WoYGMXpDK9E+zJr
        npp4PGRJZEw2BHuJ+SjPfblwg+Rux0HCgN1wuvIgcQi0S5dSo4sPhX7umbi2958T2ShCSz
        OE0oHZueg1G606A0tKZuFQXAinu5YFB87uIs1oMuuatT2iHn36KA8yW8tqwSthKl3o+NAl
        oc65tyNoS7FTHDCoSjGXHV2/yOJQaNDbxGkTk0cR6Ot1TBjXvon/g1myR9uFig==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] btdev: fix CIG ID on Set CIG Parameters error response
Date:   Sat,  5 Aug 2023 15:29:06 +0300
Message-ID: <570f7e0427b35925c741118d397eb8bcbcb51efe.1691238245.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set CIG Parameters shall return correct CIG ID in Command_Complete also
when it errors.
---
 emulator/btdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 38dcb189e..58414bd74 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5872,6 +5872,8 @@ static int cmd_set_cig_params(struct btdev *dev, const void *data,
 
 	memset(&rsp, 0, sizeof(rsp));
 
+	rsp.params.cig_id = cmd->cig_id;
+
 	if (cmd->num_cis > ARRAY_SIZE(dev->le_cig[0].cis)) {
 		rsp.params.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
 		goto done;
@@ -5942,7 +5944,6 @@ static int cmd_set_cig_params(struct btdev *dev, const void *data,
 	}
 
 	rsp.params.status = BT_HCI_ERR_SUCCESS;
-	rsp.params.cig_id = cmd->cig_id;
 
 	for (i = 0; i < cmd->num_cis; i++) {
 		rsp.params.num_handles++;
-- 
2.41.0

