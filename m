Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E153C04A94
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Aug 2023 16:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjHAQiw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 12:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjHAQit (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 12:38:49 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B411FE8
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 09:38:48 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RFgm63rYGz49QBP;
        Tue,  1 Aug 2023 19:38:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1690907926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXGlzG0HOmoIdevnyhrOyZ1aMraEhvkaqTn8FITNBOA=;
        b=jSPKuPgtt6HUdzSeuCTA+h/RU3KmVJkSmU8lhURIYh1qBv4QJYGBhhsZxsSpwpsmhOvvj9
        7SCBzIwhlKW4myPtWuDqdYCSFbkMRsBaMjF5WmGCKPH/14E0JI2ssXCX9ChHX1hm2fEnt/
        uAMyTunzjqZ9IQEpCu7Le3r5T8NV7FLuNEuFG8v7T4B2tZLn5ic4KjkDd5nm0Ga3AI2g1Y
        /NaTYF5DksCKEqYRgRdyEmTCK1+pjjEv8T4pG7MlPAjSAKFmnCD9qQIqa8mYVgDYwGJEvF
        0lNdI0zNusV/sVubpIFfDJeMJugIrRgi+D9RwezcbSNrNYpSI/QuLElpfQ7uug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1690907926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXGlzG0HOmoIdevnyhrOyZ1aMraEhvkaqTn8FITNBOA=;
        b=Iiu1tKzLTjqjHkcTONgmn4OIlE01SfXLzsVvatUi94LSzxDgTmeevIVW+poWrLwKpKugQ6
        JqtBx2MPPnlN2f8is7L85gAqHzfzCONdlw0cHMg54NmunwI0O51P+UkqW6ml8NIqTUJwmz
        eyfl2PaRFLXhPWgtT2CbpADiwFPk38oiWDgGUfUablVJX0I/K39r93jiqzY+WDbJDDojnU
        YAIdxVMylZh6/jeJdWXvpFb0JxCrNz6jkrF0HUdtyf29OR9TSke4fo3rPSQZWQ3oLFuuID
        vaGNJe/BV5aTq+c3owLxkVKgg3eVIkiiZ7vS1C7w3wSR6miLRx3r5hReVR6gmg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1690907926; a=rsa-sha256;
        cv=none;
        b=NpD+RXPu5/blepl2pz+AkUY5bicI/zqecCPaOaQm008bt2DjjFLZAyDmRo8zfoB4TKMyLu
        0KY7cRYOhIMDWeHQMJMdobOqsZNyPc2IOmLdHZ0ex1hQJRPLmfuCrpRBBk90DFF+qBF4Eo
        w7CnWINfSa++rZDQ4z2CwG696+v/CFVk51QWTmfPuMHACNmYbilYrFGvabUCmeZchZ0/86
        ljIQht4ycv1yxwKgtef1tpf9aASDYVnRcc8rlkuu2v6IsklGpY+YKg6uuqxh7Ce8elJR9F
        qgnKZTOE2Ni/vhZb+WByZ7DO+HfYcWOhKGyDjTqO7GL4AFVtzay5joLFSDnyYw==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/5] btdev: fix Command Status command opcodes for Setup Sync Conn
Date:   Tue,  1 Aug 2023 19:38:39 +0300
Message-ID: <87afe28e40f3bade2466073ace781625235850b9.1690907478.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690907478.git.pav@iki.fi>
References: <cover.1690907478.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The command opcode should be the CMD, not EVT.
---

Notes:
    v2: no change

 emulator/btdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 8658b4121..38dcb189e 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2685,7 +2685,7 @@ static int cmd_enhanced_setup_sync_conn(struct btdev *dev, const void *data,
 	if (cmd->tx_coding_format[0] > 5)
 		status = BT_HCI_ERR_INVALID_PARAMETERS;
 
-	cmd_status(dev, status, BT_HCI_EVT_SYNC_CONN_COMPLETE);
+	cmd_status(dev, status, BT_HCI_CMD_ENHANCED_SETUP_SYNC_CONN);
 
 	return 0;
 }
@@ -2731,7 +2731,7 @@ done:
 
 static int cmd_setup_sync_conn(struct btdev *dev, const void *data, uint8_t len)
 {
-	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_EVT_SYNC_CONN_COMPLETE);
+	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_SETUP_SYNC_CONN);
 
 	return 0;
 }
-- 
2.41.0

