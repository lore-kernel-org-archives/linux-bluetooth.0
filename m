Return-Path: <SRS0=ATBr=VE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A5BC48BDE
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Jul 2019 17:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B2C2082F
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Jul 2019 17:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="mzFUOWni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfGGR1z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Jul 2019 13:27:55 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:39765 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfGGR1z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Jul 2019 13:27:55 -0400
Received: by mail-lj1-f172.google.com with SMTP id v18so13582997ljh.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jul 2019 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KqIIU72qYwQpWFzXjdRvYK00adq6+LoLiq7JtRvm0ro=;
        b=mzFUOWnilUXUmk1CZkUHDSTyVlzJmU8Ipb7zKzJuJrI75A70xp7TF+I4Ul8Qg8dsw6
         ZgUKPPdyvOXGt7O/vcqBxLJjp0S8OR3R4kP+leJWqEXKcNY+tSJVVoe0VBFzs6RghPmu
         2948Je16Z81jELemFSmnB20pi2ByTWVwXMvjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KqIIU72qYwQpWFzXjdRvYK00adq6+LoLiq7JtRvm0ro=;
        b=c+lh6fnmCVEn+bf0jkXL9r1yPL2hUeIfEUvLuiwUvhq9wQKxKChOmfFtONoGEl8+vT
         dTR7TaGNExrZhMNiJD1bbxykHicSZDxGyuXlUF2L88HIn+IvIwOVo/ej3HYukvjUXRgI
         mcZtCdj1YFHUUAMPAjbPLL453encYXYfLpuEngHOwLCZpJruMsIPbbyAp0yLq+DSGhKD
         jerPC21ivk68HJ6CchpM1GFM8HtoxiuRorA3B1a+AWRBWmOHt0jo3QMLKkUTzkwLzW0Y
         60cYHZzaZBDo17LOVTkOd82FWqcujtZUlSpk6sPyrdGk/o6X2rUpC0TITFWe3S+W293O
         EJuw==
X-Gm-Message-State: APjAAAUeRwF/NLogc+uZ/VFnloxb4S8SW2gMvbOganGeMX5YXb7LQ0gn
        R3ylwM1U6zIIpvkttCxus4CapvGYRKDyOoo2
X-Google-Smtp-Source: APXvYqwbNI0bfzRmmkvE6MQ3epALHV90D3Ng7cYUwlSAFoB5bBKZqjlNK8Chc4VOcWIlnATpU4vhrA==
X-Received: by 2002:a2e:7c15:: with SMTP id x21mr7871859ljc.55.1562520473339;
        Sun, 07 Jul 2019 10:27:53 -0700 (PDT)
Received: from virtualbox.ipredator.se (anon-49-184.vpn.ipredator.se. [46.246.49.184])
        by smtp.gmail.com with ESMTPSA id b68sm1320732ljb.0.2019.07.07.10.27.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 10:27:52 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH BlueZ] obex: client: map: report notification status on incoming message
Date:   Sun,  7 Jul 2019 10:27:46 -0700
Message-Id: <20190707172746.4099-1-matt.ranostay@konsulko.com>
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

