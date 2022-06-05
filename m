Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F55C43334
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Jun 2022 12:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiFEM3l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Jun 2022 08:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiFEM3k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Jun 2022 08:29:40 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D904844A0E
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jun 2022 05:29:39 -0700 (PDT)
Received: from monolith.lan (91-152-121-49.elisa-laajakaista.fi [91.152.121.49])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 3C5162009B;
        Sun,  5 Jun 2022 15:29:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1654432177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QbxEKfLmTpAx89riYevxz97lUEPCfkWBrIsCIjRh+Kg=;
        b=oTevq3awvQaKQbxqg+sX0uDCnzoNsUUmjvbaANz1xArZEy7no6VK2lLdQ8zCCv17rdKwJV
        jevCe9X+fZcu8V1hRd/kiwE09sVR37+g4MnMW0kOG7EXKT0dIm4sse1dLVkEAxKZfyNm7v
        CAqQFK/3k4NKPKpDBqPsY9NXXgtg1OA=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] a2dp: disallow multiple SetConfiguration to same local SEP
Date:   Sun,  5 Jun 2022 15:29:26 +0300
Message-Id: <20220605122927.110627-1-pav@iki.fi>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1654432177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QbxEKfLmTpAx89riYevxz97lUEPCfkWBrIsCIjRh+Kg=;
        b=Qa96YoA0TbJ428THJpuYoUZeBHP7mn7owm5fTCVv7UxZrNmtmVWvWLlyoG496r8okp8CU+
        UVF0VIwU0hfmTsTxTBmOFomdanuAElCH6FKQ7sPWJSjUV+DqLLt85q9I0LmNxk7WG6VP6i
        d6fUUvEmQuU85Qms5fNZ+mqkhr2CUDo=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1654432177; a=rsa-sha256; cv=none;
        b=EM276tBWWfK4s8X8FiwKMvZnZc9PTQHZZ5F8eGBxi0+ojhKDhZw6yYSM8bsfpIbxZ10voL
        2YXjhnfGdQj+FMQnhsbVhlPNtEIHQkXNinXDrc3JMGTpqSQyr/bTrwFOfjoioCJMr90x1F
        j1iA2+NbjstQSLYLjYI0f2XhFunYK98=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Using the remote SEP SetConfiguration DBus API, it's possible to make
multiple remote endpoints use the same local SEP, if they are endpoints
from different connected devices. This is invalid: successful
configuration shall prevent a different device configuring the same SEP
(AVDTP v1.3 Sec. 5.3).  Moreover, this breaks the assumption in the
AVDTP code that each SEP has at most a single stream, and causes
misbehavior later on (subsequent transport acquires fail with EPERM).

Fix this by first checking the SEP is free before proceeding in the DBus
API call.  Also add a sanity check in avdtp_set_configuration, to reject
configuring an already configured SEP similarly as in avdtp_setconf_cmd.
---

Notes:
    E.g. trying to set the same codec for two simultaneously connected
    devices for the same adapter in Pulseaudio, causes the A2DP
    connection of the first device stop working, as its transport
    acquires start failing with EPERM. Disconnecting the first device
    also breaks the second device connection.
    This patch fixes it so that only the invalid SetConfiguration fails.

 profiles/audio/a2dp.c  | 5 +++++
 profiles/audio/avdtp.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 6f5b13711..f3e2cdd9e 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1843,6 +1843,11 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
 	GSList *l;
 	int err;
 
+	/* Check SEP not used by a different session */
+	if (lsep->stream && chan->session &&
+	    !avdtp_has_stream(chan->session, lsep->stream))
+		return -EBUSY;
+
 	setup = a2dp_setup_get(chan->session);
 	if (!setup)
 		return -ENOMEM;
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index da4114e0f..bc7afad81 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3523,6 +3523,9 @@ int avdtp_set_configuration(struct avdtp *session,
 	if (!(lsep && rsep))
 		return -EINVAL;
 
+	if (lsep->stream)
+		return -EBUSY;
+
 	DBG("%p: int_seid=%u, acp_seid=%u", session,
 			lsep->info.seid, rsep->seid);
 
-- 
2.36.1

