Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4EBC4321E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 00:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiLBAvA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiLBAu7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 19:50:59 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4E2CBA64
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 16:50:58 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id jl24so3243284plb.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 16:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uipxcqFe+9TjstR7zL9pYMpnpbO4FjPsAnDw9doWmUg=;
        b=pnbM42Z0N/Pf/yeXTkXr6AuGVFH6ku6Xl1kLlFI9G7NrdqQiwrF1zC448YTtIxMkcR
         gBnwFv413fxN8/cS5bdVUTVFSuf0o3yXuSezK9z4w31ywrmUY3EVH0+8DcRtpDQHsZBw
         nYDRkys2myeOuYUIPpgI6FoTRwBjEm3ojNAjKim+dIIvKF99Fx0/NGYdglJ+jewaKhod
         G9M2p05AJQsZP/kdy4kmxYhZzjRv7g30mtjB/cljnBZEfDhr2bxB3t4QvrhIaSo6EIjF
         yrSrxHjTHrcEpkgNXsvDv9KqzMMnwwJFR5l0AA3l/2Lhw5CBecmSJhUmK6Aq9jH2BsQc
         afUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uipxcqFe+9TjstR7zL9pYMpnpbO4FjPsAnDw9doWmUg=;
        b=mSzky75w+wynUkjpL43YvWpGb6RGQNc8+LsEWjx8xSdG772jNhNuqLogWBGfkQlQxB
         DoLvW/h5EdwqPF9SXeMGeZ9ZAwQvMJjskKuOS9EAtQMCUXFbgCCeDkuDBe9PYvzBFkgV
         EU2jfj2yfj9pJ/n5PasKmLI+02XPuALV0w+Z3E7ZOsQLcMIKfRuepex17pxfWOEtfDBr
         gQ06dQmVtb+cURiK5Hb5pM3DFQRqdvaHNv4ENWCs+1is8weThvydkoYgqR54aQZRRYvv
         Y3e07DS/N+cElkwObtdIOL8eN9GAFuu/BoirZ4rqs6/Xv+8qrn0BzMQntXtnTHmlbmqh
         b2MA==
X-Gm-Message-State: ANoB5pkowbQJzAYyQgtbzjw9yUA5JP6fTfWXSz+xIGyy+IVUZgRTCcEw
        M5CJKkPn3z5nxa+YnJ13vBdFMpzrJ5SFCw==
X-Google-Smtp-Source: AA0mqf7+GkbuyLWO8u72QtrTblFcbTxYZhfNJfVD+T+MBteRGFvCtMrmMPQMXXOD62bNYKydf32cbw==
X-Received: by 2002:a17:902:b613:b0:188:f570:7bd6 with SMTP id b19-20020a170902b61300b00188f5707bd6mr50209892pls.97.1669942257114;
        Thu, 01 Dec 2022 16:50:57 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b0018971fba556sm4246005pln.139.2022.12.01.16.50.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:50:56 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/8] bap: Fix not able to reconfigure
Date:   Thu,  1 Dec 2022 16:50:47 -0800
Message-Id: <20221202005051.2401504-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221202005051.2401504-1-luiz.dentz@gmail.com>
References: <20221202005051.2401504-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

While attempting to configure QoS setting the request id is not reset
to 0 when a response is received which prevents any the QoS to be
reconfigured.
---
 profiles/audio/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 67aba3bd76d9..9cee9fd030da 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -366,6 +366,8 @@ static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t reason,
 
 	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
 
+	ep->id = 0;
+
 	if (!ep->msg)
 		return;
 
-- 
2.37.3

