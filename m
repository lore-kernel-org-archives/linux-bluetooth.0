Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B02C77B7E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jun 2023 06:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjFAGfR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Jun 2023 02:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjFAGfP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Jun 2023 02:35:15 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5146C98
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 May 2023 23:35:14 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QWxFr308BzywY;
        Thu,  1 Jun 2023 09:35:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1685601312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=In2GQ4RChsfsVcMNhxL0tw8WmzJykrxvybWLaHSpMYc=;
        b=jtQzPn/3jxhmDtZ+46cXsAZDStrzyk1+YvmrIQ+32e2VipyQ0cR68TpKiyZwKQQhQ5KA2H
        /YbrJ2iGzBfpGRYXuxJXLChGj8fkjt4X3Nak6rqxKzNmVXsn0iknDVNpz18hl62IFbi4C5
        E4LkA/pMmSB9iEqr1cSaSc71B5lRxtk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1685601312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=In2GQ4RChsfsVcMNhxL0tw8WmzJykrxvybWLaHSpMYc=;
        b=gAGw9YO/Ae/3raOihobEDHUD9shR+4OJMqq2WAJlxIqczn2af0mXtZEwBntCiFOJOaEy5A
        uIO8gcNAACiZiuNoMiuWzjUvtpOIpr00as9BrryEQSt4XizA/T93i9pIV4r9YiIa3XILyz
        1ZSGjxn9VpSv18HVaXZq1dzjyxRgTHQ=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1685601312; a=rsa-sha256; cv=none;
        b=rbUBWu4sCzXXcGifjX0cJtbAS/S5oyglUEhyTlGELyTlDFQnZ/T8sHowhADueQY0FncL3G
        c9K+HT2mgrXGmKfTPOr2oAadpI4vo9Gd5bCAoE/p2guW9exhYrwkTZa57XGIgruqia2hHB
        WHs73UvK5XcqmWgsz++djVIz7wy6Nl4=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 2/4] Bluetooth: ISO: don't try to remove CIG if there are bound CIS left
Date:   Thu,  1 Jun 2023 09:34:44 +0300
Message-Id: <137e16ab38ea84a02241385e6622497de52ce9a3.1685565568.git.pav@iki.fi>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685565568.git.pav@iki.fi>
References: <cover.1685565568.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Consider existing BOUND & CONNECT state CIS to block CIG removal.
Otherwise, under suitable timing conditions we may attempt to remove CIG
while Create CIS is pending, which fails.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2: no changes

 net/bluetooth/hci_conn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f45476deca82..15cba23ade52 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -983,6 +983,8 @@ static void cis_cleanup(struct hci_conn *conn)
 	/* Check if ISO connection is a CIS and remove CIG if there are
 	 * no other connections using it.
 	 */
+	hci_conn_hash_list_state(hdev, find_cis, ISO_LINK, BT_BOUND, &d);
+	hci_conn_hash_list_state(hdev, find_cis, ISO_LINK, BT_CONNECT, &d);
 	hci_conn_hash_list_state(hdev, find_cis, ISO_LINK, BT_CONNECTED, &d);
 	if (d.count)
 		return;
-- 
2.40.1

