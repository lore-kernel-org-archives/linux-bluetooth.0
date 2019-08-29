Return-Path: <SRS0=q5Cw=WZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02491C3A59F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 19:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C652166E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 19:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="dhMCbcR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfH2Ti3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:38:29 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:43890 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfH2Ti3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Aug 2019 15:38:29 -0400
Received: by mail-ed1-f41.google.com with SMTP id h13so5280679edq.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2019 12:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KqIIU72qYwQpWFzXjdRvYK00adq6+LoLiq7JtRvm0ro=;
        b=dhMCbcR9cdjMOHGueMFaGTjBPODsXfJcuVzD1eSzzCa8bctop5KYptLL5CGRUUd6nN
         4CuTKm9Bh03sVCLspcNfJctBAfKnZiIpVlEgGYmRG4DU2BaaNBr5q9b69PJMxeRv8Spp
         +jXkhZl3cmKnYNqFvGU+V3frJ7v7fvnrNggb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KqIIU72qYwQpWFzXjdRvYK00adq6+LoLiq7JtRvm0ro=;
        b=snanKic378ZLYHak9yZ1379pIdYKfwEgO5PirA0S4pFz7vOwhasdmX9zgrzvaHYlp6
         L5ONmkEbRCUoXlwmLLlIts/v0wnJcDtw6gH1flir3JClZg3a4NNYMeIrRSr3tYIhXQm+
         hjlYttCLBCHovDNqP0y7XOWRZCTDujTylvEzunfsY0IGbxpdfOOnnuFb28w7t8Mj6HWL
         7clYCDXyhwdmAsVcauN/J/0WfWmU6bx07DQFWOu3PCV+S1IKsoJRVupKO1bS8T8te7lZ
         qvZJvIa9U1imVJVCb9OKi9dZxvRJCBDR+/Pkojj0Uk05EvOaQgtCSxi/sJiiUGP25jQM
         fCTg==
X-Gm-Message-State: APjAAAUqek84E+jk3DL7CUHS6ZsIjNjqPFxfCsuO8Nd8KkEXUyfg5NXE
        3SOSyIxIYmHDYqt9n3izOymgr8aMoKDzpzXM
X-Google-Smtp-Source: APXvYqwD9YDp0xmQK2e0Y5Ik0dGZ10fzNmcYBIDqHaJosTGwWaa/dc6b0hjZ9aSvc7GlSmeaSvbeyQ==
X-Received: by 2002:a17:906:cd03:: with SMTP id oz3mr9886946ejb.210.1567107507035;
        Thu, 29 Aug 2019 12:38:27 -0700 (PDT)
Received: from virtualbox.ipredator.se (anon-49-194.vpn.ipredator.se. [46.246.49.194])
        by smtp.gmail.com with ESMTPSA id d3sm494746ejp.77.2019.08.29.12.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 12:38:26 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH RESEND] obex: report notification status on incoming message
Date:   Thu, 29 Aug 2019 12:38:21 -0700
Message-Id: <20190829193821.16057-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To match doc/obex.txt on incoming message notification the respective
Status field should be set.
---
 obexd/client/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 550c5afb4..23be2d6b2 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1914,6 +1914,7 @@ static void map_handle_notification(struct map_event *event, void *user_data)
 	switch (event->type) {
 	case MAP_ET_NEW_MESSAGE:
 		map_handle_new_message(map, event);
+		map_handle_status_changed(map, event, "notification");
 		break;
 	case MAP_ET_DELIVERY_SUCCESS:
 		map_handle_status_changed(map, event, "delivery-success");
-- 
2.20.1

