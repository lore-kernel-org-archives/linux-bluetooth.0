Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E83C64EC7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 01:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCABiu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 20:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCABis (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 20:38:48 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4459172B4
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 17:38:48 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id n5so6970372pfv.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 17:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W04EP7uIcNCXxKLzunaMiIGbxjY2vfSCOWRxtUUUARQ=;
        b=EIMYmanidK916bc+UEDy3mtbFzfZ+Mdu+BSMMFK9Ror4hZxE4asZn6+ZSTzeabPrJD
         +N6pYPMaFIYVCvRXGc5MwC+CG0Y6L3PNyLOWHLylsvOADCF7MLdL4zIsgqJRrsLndaHn
         mk5w6Osu87klrkeoTdZtZwGlP46FDqwk+34V+JaM3EonSSYc+xnMfDvHQEAgyE0+8JN+
         o7LZrpGDMrgZGwcYFUjvF/eJ2EcMLarHQSIXUUJHleWwkOgzCMOFh+EN+SXJyQuedGbn
         /VYSElvyVEP34fSK29+2gA4EbX5pYiJwOZ0Rv97TNYm3XRoEqzPh9GAnETzgrQaMmPoR
         RWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W04EP7uIcNCXxKLzunaMiIGbxjY2vfSCOWRxtUUUARQ=;
        b=UU2uwQIvAclF3YUOQsj5Wc7kKxsF60Eg62QtwqNVfIQEZXWCoP6GL1K+7Z/jjqcys2
         UISnxQ8MwP0fRmOe1WwvulfXs/u6ty1kSgMoJzslK6zGrS5h0GMitdOzM4vv+W5n8azH
         ofPtoNvuUuocdtmwdssU/O/c9fNcsKXAQSRzxxDdgyCn1TA5v9vOztBYf+mAa+EybPzb
         nqfvm7mpXIH72D6NsOieq5xjF5NkHRTuXQrA2dWOeWB6+8bS26Zwe8aJiTcBh6ErqLO5
         tEUR3tKMZjxKnbV8E9ktog+fAhfGpYm60UfP3FovQRi/VSoGk2iU1R9KcfW3MqycaTgs
         oCBQ==
X-Gm-Message-State: AO0yUKWhW2XUaWN/gqm06jHhVaJHD7nnEhW56fM8b8LCwUSMSoV8TtmC
        JuIoN9b75+wdTEAWRiPlKF8Z04ayH4U=
X-Google-Smtp-Source: AK7set85vr7yull9L64dDgntAkFBPPgMg7EPOHrpUO2AdynDDXSVaFEDOyVIQiIJZ13t2XQd3wd4rw==
X-Received: by 2002:a62:8406:0:b0:5f1:468b:c88 with SMTP id k6-20020a628406000000b005f1468b0c88mr5105256pfd.27.1677634727195;
        Tue, 28 Feb 2023 17:38:47 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id c1-20020aa78801000000b005d866d184b5sm6627797pfo.46.2023.02.28.17.38.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 17:38:46 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] shared/bap: Cleanup requests on detach
Date:   Tue, 28 Feb 2023 17:38:40 -0800
Message-Id: <20230301013842.718438-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301013842.718438-1-luiz.dentz@gmail.com>
References: <20230301013842.718438-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If session is being detached any ongoing/queue request shall be
cancelled as well otherwise when the session is attach again they would
be invalid.
---
 src/shared/bap.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f16ba1832aaa..c63612f0da47 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3820,6 +3820,13 @@ static void stream_foreach_detach(void *data, void *user_data)
 	stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
 }
 
+static void bap_req_detach(void *data)
+{
+	struct bt_bap_req *req = data;
+
+	bap_req_complete(req, NULL);
+}
+
 void bt_bap_detach(struct bt_bap *bap)
 {
 	DBG(bap, "%p", bap);
@@ -3827,6 +3834,15 @@ void bt_bap_detach(struct bt_bap *bap)
 	if (!queue_remove(sessions, bap))
 		return;
 
+	/* Cancel ongoing request */
+	if (bap->req) {
+		bap_req_detach(bap->req);
+		bap->req = NULL;
+	}
+
+	/* Cancel queued requests */
+	queue_remove_all(bap->reqs, NULL, NULL, bap_req_detach);
+
 	bt_gatt_client_unref(bap->client);
 	bap->client = NULL;
 
-- 
2.39.2

