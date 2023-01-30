Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76401C636D4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 18:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbjA3SjH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238010AbjA3Siw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 13:38:52 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4B6B456
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 10:38:06 -0800 (PST)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id BCED91B001DD
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 20:38:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1675103880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rhKD4XWV5JCe6+A5sUXbz1z48YBw01O7o5UNjhzPVk=;
        b=cPAG8j69Ls22s6GB74y+bM+I256/ojuImEy7fpDpKOlQmAYsaFzGxTOvP1ZoIm9EQzr5/W
        TCkAEv+XHQXN9FEObv+rgR35Jew+RCn4t1+oY7dhL0XdVK58Q4Xkr3im8Re9QfohQBF2Jx
        hzqO95FqNDPwv2yHMPBlj2i0UbXl+exmLqHH7Oe/k8coNFSPLNqZMc2Ql+/tvpQSBkUPC3
        QX0JCCwKp/JBaeEN63hCJht8KhVhZf4jaXOHr2yagnM5rlRRdWlHTEuF2RhLzZrt+kyvyI
        f1qm/XHz0mfqUwyXm4ZWcjKjG3JB4NJRDbPHW4TiolyUQdXtaMmAuVcXvFleGg==
Received: from monolith.lan (91-152-121-187.elisa-laajakaista.fi [91.152.121.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id C95F120327;
        Mon, 30 Jan 2023 20:37:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1675103874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rhKD4XWV5JCe6+A5sUXbz1z48YBw01O7o5UNjhzPVk=;
        b=EBvTqmFeu/xLMA8IZ1vmWcwRYvqiyf+W00LdR3Qa54YlIvNLnJ4ncLLfhfu7wLVgeQ+ojI
        WWJvfottNNgyiToGALwRuaOPboHN+pUdbMRVxX55JShkaqASORotOaXgEC0FGZaaZ/OB1n
        uslrupbDFhHmR+x62ue40Ckk2XPhHjw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1675103874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rhKD4XWV5JCe6+A5sUXbz1z48YBw01O7o5UNjhzPVk=;
        b=MmDVNLSS/w+wI9mYNRtRW1YH1XIUrWKNoU1YleCdGjwCI7NLpKxIGTnZ3BZSQAZvSOKRuw
        JaD6VwlrUksI3YWPBzX2t1Y514VCahTpp9/OtlsRTtHVd0kz9Vol0rt+gYzA51CexbxTOz
        zHZwYQG3u96vq9vqti5E2AZcXMjwSZg=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1675103874; a=rsa-sha256; cv=none;
        b=J+fjHb2QXiCAwoLsXQR3o54DJJ/TtfdhmAa7GblFdMTzizYaOtWkMVVAPeJ+FjITDu6Sp5
        81qLCd9+w7aflzHMnmmX3odr64fYDc3745o7dTB7iy7gVXyTbPxpwAci3Hg4nxH7/0cGNX
        Q958ndKKXhHkzaCOz7FA8UFgLXi08vc=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/8] monitor: add names for MGMT setting bits for CIS feature support
Date:   Mon, 30 Jan 2023 20:37:34 +0200
Message-Id: <6752660792aa222640025a08ba9d95bcf9cf70b6.1675103676.git.pav@iki.fi>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
References: <20230127205205.20235-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 monitor/packet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 44f1941bd..d9e8abf41 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12649,6 +12649,8 @@ static const struct bitfield_data mgmt_settings_table[] = {
 	{ 15, "Static Address"		},
 	{ 16, "PHY Configuration"	},
 	{ 17, "Wideband Speech"		},
+	{ 18, "CIS Central"		},
+	{ 19, "CIS Peripheral"		},
 	{ }
 };
 
-- 
2.39.1

