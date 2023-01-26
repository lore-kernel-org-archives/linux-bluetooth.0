Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4D1C61DA3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 20:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjAZUMu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 15:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjAZUMs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 15:12:48 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3CA76BB
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 12:12:47 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a18so2907108plm.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 12:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEyfkcYx7LLXIX8X8vph7xamuJaRQUiOEiriStKBkK4=;
        b=EZ1hCukSv5Niwyn6fTYqJJaYaNyUzFnGEWnSfrlbmkl6DdN5/bR4hwjg+FYerlOINt
         uN1tOKQYe1jTKcOPtqZ+mnuIpKcoHn544UsLzEXX4W3RUnwqYYCR8yuEmRszeDVIpi2A
         D0sJk7ArEXThN6PSD+EuzOZauUtTKK1wCo9SzVDeqWw7J4jIkBkyT90yZCrxI75okDGV
         UbiA6oPRqCOXQ3yS6oBm1ALqIts9AZdXe9TmDyu47ixCtzsTX1mKFdA/+9ELVfttgtWN
         myc8+eNjipyhxrkkWWvVF7OML7qiNExN+0bFbwpKWjUtPLHNjN8LlvgydwrulcbXM8mj
         X4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEyfkcYx7LLXIX8X8vph7xamuJaRQUiOEiriStKBkK4=;
        b=D+6dFlYIsF+8m8iP2kfIOunX5RytH1XCnQnUIbeEJlCBv74bR88u8s3/0j87npB16K
         PbThgzh7odEeXFyhru71QrRKmfemhDtHaJx7k4WPBUuHplGK3ds8vYGBZnGtPWOQKSWL
         dsie1cbseWTIbKSVFGi1q17coKPei/pPXBUrOXxR3gmVvXnPAjtWKlh4V38JeHeBxBA1
         7Vyjpxx4bHWtAYpccRiu7TEbfi3Yg+wby9S36KoGUauHIpTaRuws0hHu7UUBclxokZc1
         sQ11AKDDgEurWXMKs4QQHEvUNNsgqyqXNVockGOPfODEBLD5jHHMwOBZ9giELozjLJFF
         LTfg==
X-Gm-Message-State: AFqh2koFvsjPK2NMltDwZCGRoydSe7NT031yt5uqnS1//0VQRM4ZxZNZ
        +ADdCXmBDNnfoXJvYONrLpisV18koBY=
X-Google-Smtp-Source: AMrXdXtdVRodiQ12o5AnrkVA18M4Mmx3xhnbu5V4CJWvNpyFzefOLroJVsFA9cywpsObD7dBNOW+NA==
X-Received: by 2002:a17:902:aa05:b0:190:fbbd:277d with SMTP id be5-20020a170902aa0500b00190fbbd277dmr37063193plb.17.1674763966424;
        Thu, 26 Jan 2023 12:12:46 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902c78100b00194955b7898sm1341045pla.237.2023.01.26.12.12.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 12:12:45 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/5] bap: Fix not removing endpoint if local PAC is unregistered
Date:   Thu, 26 Jan 2023 12:12:40 -0800
Message-Id: <20230126201242.4110305-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230126201242.4110305-1-luiz.dentz@gmail.com>
References: <20230126201242.4110305-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If local PAC is unregistered it would also notify via pac_removed
callback which shall unregister the endpoint D-Bus object.

Fixes: https://github.com/bluez/bluez/issues/457#issuecomment-1402178691
---
 profiles/audio/bap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8f24117681d2..5a50a2cc6105 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1049,12 +1049,12 @@ static void pac_added(struct bt_bap_pac *pac, void *user_data)
 	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_found, service);
 }
 
-static bool ep_match_rpac(const void *data, const void *match_data)
+static bool ep_match_pac(const void *data, const void *match_data)
 {
 	const struct bap_ep *ep = data;
 	const struct bt_bap_pac *pac = match_data;
 
-	return ep->rpac == pac;
+	return ep->rpac == pac || ep->lpac == pac;
 }
 
 static void pac_removed(struct bt_bap_pac *pac, void *user_data)
@@ -1082,7 +1082,7 @@ static void pac_removed(struct bt_bap_pac *pac, void *user_data)
 		return;
 	}
 
-	ep = queue_remove_if(queue, ep_match_rpac, pac);
+	ep = queue_remove_if(queue, ep_match_pac, pac);
 	if (!ep)
 		return;
 
-- 
2.37.3

