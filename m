Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C72BEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Jul 2023 19:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjGBTeZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Jul 2023 15:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjGBTeZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Jul 2023 15:34:25 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DE4E6A
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jul 2023 12:34:23 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QvK4Y5ZlDz49Q7F;
        Sun,  2 Jul 2023 22:34:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1688326461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ry3Gs3ypdQxJSRFrm44H6LVyp9adVRUWAhuPQORacI=;
        b=S7l+lekHTFbvPsAsnA4C/xD3gYQtkg5yc3LwXRSMRBtdf1OeweqOz9ahD+sgvfT0BQMNXg
        vbhdNTD/HS5G6U2a7FmTBt2kZkpHXs2Hyv42Opp585chFR4943kzRwiajuQuptoqMXwNkV
        UmCGNJ8p5kjaVs0U+YpRHG9kA1h+Np/5nSAQ0EKu++hguPNFRlHvQcLah8qd0wgBaufa3c
        ol8TAHhW0M1A+Q7qNrXVydH7Qb5T+V6ePxT4g1hfva4onn0FU/fHmdEJ7a6unJMpSZ5cDk
        NZtSlSBK+FEcsCbCDQ8UZqmU9ZcAVbPQw2A2iVO8pf3u+/5+O+SdSqMRruNNgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1688326461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ry3Gs3ypdQxJSRFrm44H6LVyp9adVRUWAhuPQORacI=;
        b=goI5+1uljPvZAmRlZVjWKkq6VtgqDZoGUjlmHldchL2oKigr1AL+srDvluocHxVnV0fn7l
        /aT5/0qiyGUdeKVvgzaM6Q9y9nheqeXczEz/pYsQgbmA+OVuwgFnpirbGPZVQpencQ7vdZ
        Bhv8D+c56eMvJBWwYUHnP8xo85l+UcUQzQlCjn6icf2XFUkIDuqVi09gDm21AFKu1r2UQw
        kD97Y9I6iY5xJJ+z7SNlbQrZhAkKzf74pN0Tf0U0yjJuT/BuVfV5+3cwZN9vV0PBwnUsxI
        InzdBb2XXPRcmRF6FURd+aPkHmsEAtZ36pbT/icVG2uLkADSaxw5pwev2siYgg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1688326461; a=rsa-sha256;
        cv=none;
        b=jsUhJ+QE+NOqkwIXZW9eXjUbRpVmCE35al1g5Q+LifncO1AbLrRwxP64Z/zivslpcCUDny
        bOg+zx+dwyrJtwwz3wy5ARRwMAeTPsO+iSInDy2FsLLYq/o2gx4u5rC/3A4FOF1nw5WQ9t
        9EzN+Cc8bj2IKeIVa0AMBQirKNwaP57/Iq31ckaI042E/YdRd7Y7UWb8hiq8Kj+Xi2iCCU
        YExt0j+EV5TMeo7XdCc16OSzHAksA+Oyw6G1+oVRKJT7i2UFIo5R3gZ/goyI9L/Sr2l0Z0
        LFU4FtcHLt8cwcLwXK4u6AWkl+BhjoxNCdz7CmAi9KZvMbY3QlXxl+MAg9J3xQ==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] shared/bap: use only nonzero req->id
Date:   Sun,  2 Jul 2023 22:34:19 +0300
Message-ID: <7e5753e471757d50569802ddb19546768dea07f5.1688326228.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <8af1dd5097cc4411ff2681ed39c49c232f817ebe.1688326228.git.pav@iki.fi>
References: <8af1dd5097cc4411ff2681ed39c49c232f817ebe.1688326228.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In bap_req_new, use same pattern as elsewhere to not use zero as
a valid id.
---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 13c76afe6..72ce67c08 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4303,7 +4303,7 @@ static struct bt_bap_req *bap_req_new(struct bt_bap_stream *stream,
 	static unsigned int id;
 
 	req = new0(struct bt_bap_req, 1);
-	req->id = ++id;
+	req->id = ++id ? id : ++id;
 	req->stream = stream;
 	req->op = op;
 	req->iov = util_iov_dup(iov, len);
-- 
2.41.0

