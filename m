Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B569C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Jun 2022 12:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbiFEM3o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Jun 2022 08:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiFEM3l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Jun 2022 08:29:41 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5922444A0E
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jun 2022 05:29:41 -0700 (PDT)
Received: from monolith.lan (91-152-121-49.elisa-laajakaista.fi [91.152.121.49])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 12FB3202BF;
        Sun,  5 Jun 2022 15:29:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1654432178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lfsi7xGIptgAzbQq42qqEUI1iAKuqmlAYry/tekXUZI=;
        b=ccoorc82MDGuJJv7jS5aR8jxJ7N8xh14WnRomenp4VMZeTYA3kCae1hYs5tZ/CP5fg4pV3
        a8U3fL03yK8LXluMVEY6HQq48grMWFZxI7F+w1SLM+wbSmhZJaGhha0gGPoH2L1Pix1eYN
        i9s9/TzYuZgZMVD2iXL0qVXvd5XiUX8=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] a2dp: error return paths in a2dp_reconfig must free allocated setup
Date:   Sun,  5 Jun 2022 15:29:27 +0300
Message-Id: <20220605122927.110627-2-pav@iki.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220605122927.110627-1-pav@iki.fi>
References: <20220605122927.110627-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1654432178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lfsi7xGIptgAzbQq42qqEUI1iAKuqmlAYry/tekXUZI=;
        b=OcfHPAj63OEpJbe68jFCqcgkIf6KZcZVJ8O+5wP7VximAaFJXPH8rHT3brnLlJq23qSN4T
        Y/fHUKBodmZAlTsNgC+5iUYh2pYPOa1gi2UNr+WvpzyM0iz4U8zwsC9JrbBWvWdAN9Y0U7
        zOsXW7onZpZmdhzSzDhO3T3Tc96DeIs=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1654432178; a=rsa-sha256; cv=none;
        b=a1mAjOWsIMhl+KZjBKU6gWZLBVWNbgovSyzA0TP7qdLM48dgPGTLzFRdRfClKOVd7DZofg
        fq5sJJmVGh7g3HdtuZmSREyA8bhaZs7slw09LKZQIEynk0NcX/g52QN7ViJuCD+aRG/TJk
        RCN4ad19LpxwGlojSV1ruGRNPrLZhdI=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 profiles/audio/a2dp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index f3e2cdd9e..276512208 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1876,8 +1876,10 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
 		if (tmp->stream) {
 			/* Only allow switching sep from the same sender */
 			if (strcmp(sender, tmp->endpoint->get_name(tmp,
-							tmp->user_data)))
-				return -EPERM;
+							tmp->user_data))) {
+				err = -EPERM;
+				goto fail;
+			}
 
 			/* Check if stream is for the channel */
 			if (!avdtp_has_stream(chan->session, tmp->stream))
-- 
2.36.1

