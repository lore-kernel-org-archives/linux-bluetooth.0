Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78908C04A6A
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Aug 2023 20:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjHFUU2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Aug 2023 16:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjHFUU0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Aug 2023 16:20:26 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C92F1722
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Aug 2023 13:20:24 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RJrRV3j8Kz49Q8H;
        Sun,  6 Aug 2023 23:20:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691353222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NS2VaQ7geGZzm/jXHh7YZtOLYcCN+so+PWM+FlPyk30=;
        b=PBF5eYAzaU/+N4JtpMytfZaJW7CXbj67LmksYFVeF0GGr/fgoLDrx5FISWHzAcdzYDbZfz
        HDH06xIodUVUjDevLuBXDmYfBEFefgA+cEEeMzYHAq2gITq+Q4fc2+GWyQyRngPFozzrin
        LmaF6XX9/vZoZHfbeSknjmmstsTId+Mdc8HMPVlemTXEf+Eh857Tutdv5V1wIqMt7O2W2i
        5Xf4EwJ4QuVKo/LgDBzxaz20PEZQc0aal7v6kMZ60W2tg1DuqMdgQ5DBPTQuHIdH6tnySd
        SU8dn6QDpUNwx0wtSbNmRuOiyHThPc9PIrg/LMMpkTWPNaY8HboFp8NZbw5oKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691353222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NS2VaQ7geGZzm/jXHh7YZtOLYcCN+so+PWM+FlPyk30=;
        b=avUAPM7q5CYXXRMVAXm68FLLAv1XMljzDys1wO6uTfoa155ayorEcpdiemOceLuOwVxUF+
        CpBCxEtyuOkuTnggn0VCX3WTWqr0LrtM3c5tDgkDIv1FNUZKX6hakE0iPngTU2sa8WnZLY
        PhJfBYsvVf4scNJmga5wsl7E374hWshNZvh0VlwUTKR9W66eTYLH+17yySnpJ2fOlZXfXi
        hDWLYMxs9dooJggWZOlTXQFkAwD4fSrqbZcueCuo0Nk3EoYOLWjPU8j4rFya/coPG0bl8C
        sQpqAhJ1Dcfk9JkpknojhNkkRgXE2uwdlVN2QK6EmkuswpXQq2VxMIgqhzYo2g==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691353222; a=rsa-sha256;
        cv=none;
        b=q8t3U/D003ytyDNNZL+IMo2HXcUbSnIw2AIFWEdkXQU5iN3Zph/zDG5zqluj8y+Zi9jtuQ
        FxCva7RG77N1eqdpoD9y2v1zi5fqhrDzg74Te77mYhp9GXrsmUAxkEaMJkQwxTrSxMxIIL
        RRH2cgtqDYJQ/rGWf0zIVzja2JfyipIwCATerSihScSraLXpdvLJ6WNW3YEqKuHI4CFBJ9
        WsIk74PfCNp49vX6blcl66Dm4kLPnH1DoNg7bXghm/6VPeSVh+Qb1Ie5zAkURzN4U++DSp
        d0VQCvHnG+WfmStD23SZsJGSpWCToEiN+yJExbE/Neu7Jj5+LRv/49zlegGcfQ==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 4/4] Bluetooth: hci_conn: verify connection is to be aborted before doing it
Date:   Sun,  6 Aug 2023 23:18:40 +0300
Message-ID: <8e9dcf715fa1215545c1a01ad44b62d77a4edebe.1691352503.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <b2ed850478c905299c40154c1d6dfc304a93d77a.1691352503.git.pav@iki.fi>
References: <b2ed850478c905299c40154c1d6dfc304a93d77a.1691352503.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When processing connections in abort_conn_sync, also check the
connection handle still refers to a connection that should be aborted.

There is a theoretical race condition where a connection handle is
reused, after hci_abort_conn but before abort_conn_sync is processed in
hci_sync. This change should avoid terminating a wrong connection in
this case.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2: no change

 net/bluetooth/hci_conn.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ae206eb551f7..b65a1e9b178b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2861,7 +2861,7 @@ static int abort_conn_sync(struct hci_dev *hdev, void *data)
 	u16 handle = PTR_ERR(data);
 
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
+	if (!conn || !conn->abort_reason)
 		return 0;
 
 	return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
@@ -2876,6 +2876,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 */
 	if (conn->abort_reason)
 		return 0;
+	if (!reason)
+		return -EINVAL;
 
 	bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, reason);
 
-- 
2.41.0

