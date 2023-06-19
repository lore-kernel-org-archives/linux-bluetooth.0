Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27834EB64DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jun 2023 20:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjFSUap (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jun 2023 16:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjFSUao (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jun 2023 16:30:44 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C626E4A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 13:30:43 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so2465555a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 13:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687206642; x=1689798642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgesgxoUiEnt7JhH7f+sQVTH/hKqR6THmg+oGF3TcV4=;
        b=lAhuWM4fk6unp83MvzpBW17Lnxy/Trv/NNl/GQDWAEDIK6ZOW7EQyT1v4nPUuxTJk3
         107IcfIufe+ZxLO+sfgoaIALj+PwfpDXw89V/BpwMLTGLGrU2z2kitK2bsqBk/rrQrgt
         C4Lbsm7zIi0gk7n/rObRELTCoNJuJdpDYxkSmAAgLx7821NQumpmp9ckg0bFlxsLwLoM
         TSrQS3hx8j5XwRIAAaAyG6rpdDZjo0vagBELEGRXd8mM7pthTG4aCuwjNrboothMGZoA
         jz4+qSI0yMLSJzccjzSZqCmLGxLBMsOvnMNGI/VR+ysNYDA22Bjfv+wiCuyw5smMofOb
         +EOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687206642; x=1689798642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgesgxoUiEnt7JhH7f+sQVTH/hKqR6THmg+oGF3TcV4=;
        b=NZkb6IaVzIrjDBYQYF0AHiBNchcoYXGf0Z0MsI2MiOx9W4mE1ascN3Famskr8AMh3R
         ES1Ic1FrJvKZg0obnsyREaLxGK7FmuUV5J7h1xUKEtuFc1saJui960IsO9CWuOyu9xTn
         LMArgMeniR2GWaNZ6yiJgCwNS57Z+I9kq+Au7Vt7aQ9ByhadO0AM2c+6wzAEp5IYjgK4
         jyUl3n8FZTnpN2g+kx9W9V8RJLMu5YnkG+wKVelvebQD1rYA0YnNgQkHnpROct0qdF1Y
         popOHxjoQrrsHNopH5iE4AwWnMpXVNvYuKLhLr/B5sqXW4YBc1+N0YDVvIhDeF+6xokv
         354Q==
X-Gm-Message-State: AC+VfDxGknnGNxjvPyJpIYEOTcxR5HBhS2q1mziScoE1IpZxotDVEGwy
        QOPcgFurcW/QRI9NrAznXrgAtau24AoQww==
X-Google-Smtp-Source: ACHHUZ7zNqS+Rs8VRPLAtdgeKcocFYJejfUedl96NBQ3t2EoFOTWVk57E39xrrhEkcJfxxaxk49EZg==
X-Received: by 2002:a17:90a:bb09:b0:25e:d6f0:f0a5 with SMTP id u9-20020a17090abb0900b0025ed6f0f0a5mr9231343pjr.19.1687206641711;
        Mon, 19 Jun 2023 13:30:41 -0700 (PDT)
Received: from lvondent-mobl3.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001b045c9ababsm202714plb.264.2023.06.19.13.30.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:30:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] shared/bap: Pass bcode as a reference instead of value
Date:   Mon, 19 Jun 2023 13:30:32 -0700
Message-Id: <20230619203032.6812-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619203032.6812-1-luiz.dentz@gmail.com>
References: <20230619203032.6812-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bcode field a pointer which makes it simpler to detect when
it is set and also fixes the usage of util_iov_free which expects it to
be allocated.
---
 profiles/audio/bap.c | 12 +++++-------
 src/shared/bap.h     |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index f3564c9e8..8e2fc1556 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -427,12 +427,9 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 			dbus_message_iter_get_basic(&value,
 							&qos->bcast.timeout);
 		} else if (!strcasecmp(key, "BroadcastCode")) {
-			struct iovec *iov;
-
 			if (var != DBUS_TYPE_ARRAY)
 				goto fail;
-			iov = &qos->bcast.bcode;
-			parse_array(&value, &iov);
+			parse_array(&value, &qos->bcast.bcode);
 		}
 
 		dbus_message_iter_next(props);
@@ -624,7 +621,7 @@ static void ep_free(void *data)
 	util_iov_free(ep->caps, 1);
 	util_iov_free(ep->metadata, 1);
 	if (bt_bap_stream_get_type(ep->stream) == BT_BAP_STREAM_TYPE_BCAST)
-		util_iov_free(&ep->qos.bcast.bcode, 1);
+		util_iov_free(ep->qos.bcast.bcode, 1);
 	free(ep->path);
 	free(ep);
 }
@@ -1268,7 +1265,8 @@ static void bap_create_bcast_io(struct bap_data *data, struct bap_ep *ep,
 	iso_qos.bcast.packing = ep->qos.bcast.packing;
 	iso_qos.bcast.framing = ep->qos.bcast.framing;
 	iso_qos.bcast.encryption = ep->qos.bcast.encryption;
-	memcpy(iso_qos.bcast.bcode, ep->qos.bcast.bcode.iov_base, 16);
+	if (ep->qos.bcast.bcode)
+		memcpy(iso_qos.bcast.bcode, ep->qos.bcast.bcode->iov_base, 16);
 	iso_qos.bcast.options = ep->qos.bcast.options;
 	iso_qos.bcast.skip = ep->qos.bcast.skip;
 	iso_qos.bcast.sync_timeout = ep->qos.bcast.sync_timeout;
@@ -1811,7 +1809,7 @@ static struct btd_profile bap_profile = {
 	.disconnect	= bap_disconnect,
 	.adapter_probe	= bap_adapter_probe,
 	.adapter_remove	= bap_adapter_remove,
-	.auto_connect	= true,
+	.auto_connect	= false,
 	.experimental	= true,
 };
 
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 8fc41864a..50b567663 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -79,7 +79,7 @@ struct bt_bap_bcast_qos {
 	uint8_t  packing;
 	uint8_t  framing;
 	uint8_t  encryption;
-	struct iovec bcode;
+	struct iovec *bcode;
 	uint8_t  options;
 	uint16_t skip;
 	uint16_t sync_timeout;
-- 
2.40.1

