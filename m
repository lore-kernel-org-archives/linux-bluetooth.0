Return-Path: <SRS0=Ssic=SK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A73C282CE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Apr 2019 09:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EF320870
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Apr 2019 09:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtOjfRHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfDHJng (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:43:36 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:38076 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDHJng (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Apr 2019 05:43:36 -0400
Received: by mail-ed1-f48.google.com with SMTP id d13so1033634edr.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2019 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GETewLcyRzYhqEsFo1MIGBR5W46jXFVLN5JLuZr9IUo=;
        b=CtOjfRHXjSDGXpRaWalFZVmyTbITFDuUyoQit40inzshN9q+Z/zRPEXx0jpS7v5gvr
         ClTeqs2JPS+AcwMh3N5d8CB1NWC1OMHrKkbIaRiUxYOq7lgoBgnnUFJxzhKqPOoznDjG
         8JqZrSKIbspU41VdHRmH2B6mYD/Te+8Eg1vaGhRkLSthY8iUxHthEnGGJHdh1845qVNq
         9H0YihY0JsQAflqcmq8BmNR72cz9jczkBpkTqNt5XVSspm1BzY8ZIMb7Q7ykaCQWofj0
         U/yOkHPIu97kF4BA4LyRa/ocgFdQx1lASS+v58F83LwSRrZTmerTJ9uXiWfer4ryO3db
         hXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GETewLcyRzYhqEsFo1MIGBR5W46jXFVLN5JLuZr9IUo=;
        b=TRHzuDEt0+IRUei+k9Yq10CB4+IacLpQkTUONHrUdpKEXBOOD6o78Cf5lEJETTMMwR
         Hpy1G0q8nMf6ZsGs9Df626OiiWfEh9JtTz8FnL3rd1MtHpHDTm3PhPGEGb63RGgJxz+d
         Zs5aNVgyLp6aUNhJSrjZKw6jmFTNJlES2anTXyzQhvbHzGeLO3rjQfbM9APhpRoJIlve
         1gv9lUxG7uWPrqbIosWNPHP20Ypv3qmxLNeELdN2tVmISkxmzB+S8bb9dr3GODDQ015x
         uMUG0lVhA04QuRU9UZKYOSH2yOPxm3uvO54bDZyNH1TGWOk4XA2YktRBHIZPDBzPmDIj
         +59g==
X-Gm-Message-State: APjAAAWMOrOjfQqXLLODXRPtMDIUXQPSZVUkcV+tqsrUvo4ZsLsjR2Xi
        KszqkqyxnsEXHq8zTGMdpbhlTMQdej0=
X-Google-Smtp-Source: APXvYqz7gIW+cWnlSoWANmYfsKOybXZwTI2J8DYv++L4UGflO9BEUr+6AMItu5ok4VjXDxR4ojqA5A==
X-Received: by 2002:a05:6402:1717:: with SMTP id y23mr3767661edu.1.1554716614429;
        Mon, 08 Apr 2019 02:43:34 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id p4sm2367257edr.55.2019.04.08.02.43.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Apr 2019 02:43:33 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] a2dp: Fix UUID of remote Sinks
Date:   Mon,  8 Apr 2019 12:43:31 +0300
Message-Id: <20190408094331.11683-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Sinks were being reported as Sources.
---
 profiles/audio/a2dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 4001ea0ea..8f141739c 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1686,7 +1686,7 @@ static gboolean get_uuid(const GDBusPropertyTable *property,
 		uuid = A2DP_SOURCE_UUID;
 		break;
 	case AVDTP_SEP_TYPE_SINK:
-		uuid = A2DP_SOURCE_UUID;
+		uuid = A2DP_SINK_UUID;
 		break;
 	default:
 		uuid = "";
-- 
2.20.1

