Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD16AC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 May 2023 00:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjEKACD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 May 2023 20:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbjEKACC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 May 2023 20:02:02 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E44A10DA
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 17:02:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64395e2a715so7891742b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 17:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683763320; x=1686355320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rf8eRSKfJPDMFusnZzOI0itkuuwBnCgk1u412CdsNUs=;
        b=jK+juGZOt4vgvnxNo5tcj/LdUEB+c2rlpnJHmz1GYSkiDr0DIbw05+MB/IiJR7/inR
         iUekynMomtYvXcSGIklN4fA0YvIxurE5z6L+bKg/htRw/KhSZYehBTVs+4l162AAVlYR
         /TGPSTEWPIU0qGhFFHAQlsWJhVWA5f2Afi4uV5vTbQzeDicxv78BgdDmxKyrmpq25nyp
         EHOyi2gDF2kx8oTzjffT5AvQ6Guh0HqGEBRDO1kj8JXnnGPC/xtyqEEgzxNO2J3fOc4+
         twcdZEooVu8tkst6qGiF7uXEfU8kNvvmCKpihDlXwc/9TCW9yHKUcVo4C5w7g75+bTWk
         mksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683763320; x=1686355320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rf8eRSKfJPDMFusnZzOI0itkuuwBnCgk1u412CdsNUs=;
        b=fZdl5l/gbYZhtvqXXW7u9+mqCPKXg5K1caQAkjx6GoiRmgJ9YOJgQlThhEweURR5xq
         b7T/EA3bZ/RrQ8mQdiUKX630DMDprxtD5uLdctUZ9PIiqzIuAvX55D6IlpfAdrVnJqdM
         PBCxFSRA8rkiPTzxDFyuC15tdfma7vWDRcMIlTHfVVG3WgMtAihVo1cjj4ns77jqonSP
         Euj9fn+zCiWZsDClJolZRCugamL6L47rzDvhe/NUEb8u25VRVN2MRDSaTmgnyXtVo4PZ
         0tpbF++rplg00cVEpd9HzfIsXfoimqWZLnwh067Gr93ZaY+sLm2+CT9m1FNsfMfe0SGY
         n36Q==
X-Gm-Message-State: AC+VfDy6I6XL5uiBeNmWb78s01zmY3m+D2DGqYL/w+t52Tv35UTHfWtV
        KoUzbIE7EyrL17wtCAx2Qd3kGVtuwi0=
X-Google-Smtp-Source: ACHHUZ6oZQyETYr4UO0aA+a+aJUokiLn/gnTU5wxA9YTcsFY2A5XwvMGiwU3/aDezp8w+iL9Sy1j7g==
X-Received: by 2002:a05:6a21:9996:b0:f5:6530:c7a8 with SMTP id ve22-20020a056a21999600b000f56530c7a8mr24698821pzb.22.1683763320207;
        Wed, 10 May 2023 17:02:00 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id g15-20020a63f40f000000b0053031f7a367sm3761604pgi.85.2023.05.10.17.01.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 17:01:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] shared/bap: Fix not sending ASE Receiver Stop Ready
Date:   Wed, 10 May 2023 17:01:55 -0700
Message-Id: <20230511000155.3721222-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230511000155.3721222-1-luiz.dentz@gmail.com>
References: <20230511000155.3721222-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not sending ASE Receiver Stop Ready if stream is on disabling
state when CIS is disconnected.

Fixes: https://github.com/bluez/bluez/issues/516
---
 src/shared/bap.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6131c312865a..f194f466fde1 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1115,6 +1115,18 @@ static bool match_stream_io(const void *data, const void *user_data)
 	return stream->io == io;
 }
 
+static void stream_stop_disabling(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+
+	if (stream->io || stream->ep->state != BT_ASCS_ASE_STATE_DISABLING)
+		return;
+
+	DBG(stream->bap, "stream %p", stream);
+
+	bt_bap_stream_stop(stream, NULL, NULL);
+}
+
 static bool bap_stream_io_detach(struct bt_bap_stream *stream)
 {
 	struct bt_bap_stream *link;
@@ -1133,6 +1145,9 @@ static bool bap_stream_io_detach(struct bt_bap_stream *stream)
 		/* Detach link if in QoS state */
 		if (link->ep->state == BT_ASCS_ASE_STATE_QOS)
 			bap_stream_io_detach(link);
+	} else {
+		/* Links without IO on disabling state shall be stopped. */
+		queue_foreach(stream->links, stream_stop_disabling, NULL);
 	}
 
 	stream_io_unref(io);
-- 
2.40.0

