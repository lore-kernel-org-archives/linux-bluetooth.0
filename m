Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54854C54EAA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 18:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbjA3SjI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237916AbjA3Siv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 13:38:51 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB921E1F4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 10:38:06 -0800 (PST)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id C1BDD1B001E5
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 20:38:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1675103880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wqMUAdn/P0OmOJuwUxgCO3BaZYL9+puHVBdgZa+D0U=;
        b=ocd7vURUPOmpeX5B+IazMEaEk/V9IOlGJYDnc619GFIIba4aA2zZPWgKvgCzktrCoUsCqJ
        G684Tsb8Zhb9PLFTsfYFZtvrp103uP7nQ62hr+cOzeIGo2gaEzBkLaK6W4gsF+qjXCiRRI
        TnhuwhX3GJ4FNZeypgZ/yAhIAJdkG+L3unWmqAMAcrSBwm3tRTo09ELpGai/StXwDnEvdF
        TNnWVNLUfAA7V76Y3iMDYd6LfhW8klJLz73jM1WiJgDDmHrh+fd6X++H1jvl5HaBTu00pQ
        PK1ygL3gUCbqEnagB9aR8KHABPvKWj06CHdB+zJw7wMybgniUwQztqL8ZCBEPw==
Received: from monolith.lan (91-152-121-187.elisa-laajakaista.fi [91.152.121.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id A22AA20231;
        Mon, 30 Jan 2023 20:37:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1675103874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wqMUAdn/P0OmOJuwUxgCO3BaZYL9+puHVBdgZa+D0U=;
        b=ilbiS5aCCqoZR/gn4OHgBOcSI3iswJW1nuRw8MuM0l7+zx0JCXojazztl7OpsMpkAfCguZ
        2mhsSCaruaafOX1UUqiIP5hrlRp42cK3m5YHv9p3IW/3Vg5ryeXBlt3HE44K/TJVJC9MC0
        qFgilssB2MjLzJhDy2FV0YDVcYFABpA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1675103874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wqMUAdn/P0OmOJuwUxgCO3BaZYL9+puHVBdgZa+D0U=;
        b=aUa4PuKUWKk7rBrTNo0TV10FjOu8weCBriGsa+Q9cdYQlMaG9Y+tpz7DhMovM272O+/lD1
        NvCB+3wDcUp8N63mhDA1qwddbIgurNFU+sAahXw1+yvKXEzFTgBsYMcuaux2hp5kEF4JJ1
        WHWZNZcnF0FurB6H2kTWTk5NRvAn7bc=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1675103874; a=rsa-sha256; cv=none;
        b=mir2axofry3CIuZrpXdxApqn7aeiNgs1ACt4kq3L6LVU/9ItJN2APtB5OL+WsfEY+gsC/A
        cB2J2EXhXMDAmmOg0eg+RDV2nSq3dIJ78d79HCFRS1KC/uHVIeoHZqNoSNxQCl6Roln3W9
        U2GhJRJsi87m0An7eHuE9pD+s1wIfoo=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/8] lib: Add defines for MGMT setting bits for CIS feature support
Date:   Mon, 30 Jan 2023 20:37:33 +0200
Message-Id: <7e42fb8018045ac29c3e7a6784dd1a43a755e977.1675103676.git.pav@iki.fi>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
References: <20230127205205.20235-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 lib/mgmt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 796190cd9..efbdfb4b1 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -96,6 +96,8 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
 #define MGMT_SETTING_PHY_CONFIGURATION	0x00010000
 #define MGMT_SETTING_WIDEBAND_SPEECH	0x00020000
+#define MGMT_SETTING_CIS_CENTRAL	0x00040000
+#define MGMT_SETTING_CIS_PERIPHERAL	0x00080000
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
-- 
2.39.1

