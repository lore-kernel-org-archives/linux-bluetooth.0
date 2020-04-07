Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACC4C2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 09:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE662078A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 09:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="fI1jUlQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgDGJdF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:33:05 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36645 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgDGJdE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 05:33:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id w145so1838198lff.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 02:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2LfemgK5CTsvPVa3NwS6xtyOoJr2FZifiptp0xCpbQI=;
        b=fI1jUlQy4RXctkM4YhuYnV30K1RoDoewcbUgoqgkMBKd5WGixN81kwezgtJ8dk90FA
         mxhJgpb/z3Ek7i/wXdspR/hLxmovAWrLf4NVLM4LvoTu91GskbJHzza6sCFpypYmLBVg
         4sv99mSGgecC7NfXj5dxWRRBpXVqtYMw4Hm2gApDUNe9oTycr9LAf6Hk4W63CbwRtr/g
         YfpBJQ4kShtijNOtGz9w0e0TO6wOlD/OuB0SxvXmWSHW90y4CUV9nNqk5qjEoH/6CwNW
         /5oZwmSc3lcoGLkGGHqNRd3mF0y6staDkk3/by8xE1phPM7sopK9vKq9T3Bz/yqBRcTc
         d93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2LfemgK5CTsvPVa3NwS6xtyOoJr2FZifiptp0xCpbQI=;
        b=OlvJpTTb7Z3daa1DuDih9nYgqZIljzzqdlhpji/lVv+H0OhFWlMprEK1J3SWjlwa1L
         bSw7Wgio75AS7M9f5IEHctQrePRaJNjSQQD/NFq61Nyk/bwxT0aQESXu0g9R8GKpvQYq
         H8BlK150TXtqvWKoY7mh82zhRa29G9YePccLzNcIgtVFfpO/sQRcmxD+FUnPRMY/U1bq
         +uVGWjnyC5O6DIQbt/lA+aGOA2sfo1wxjTnjcd0zl3dzQn6YpDFa31rfasqjc4FQDsYQ
         ExglECkY/1mgnwwmuXhvUJMzeBQIvIQ3DiM0aOhAxELlpxrJZSjyeX58e+Y5mzpWLU7h
         pCgA==
X-Gm-Message-State: AGi0PubDwYFOTysB5zBwRiK+xxefFrKlzw6asQKBD2pamCOsdBdoLLKs
        6ymZvLiAgael9xeHTcuP6CNn343d90Q=
X-Google-Smtp-Source: APiQypLCNWBLQVrcMK0TzzvEeUslewUFA0VA3iDwwFKL5oiPN3Rz5nItTh60NWmTec1G0z7DJ4g7pA==
X-Received: by 2002:ac2:483a:: with SMTP id 26mr973327lft.5.1586251982669;
        Tue, 07 Apr 2020 02:33:02 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id z23sm11269272ljz.52.2020.04.07.02.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 02:33:02 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Gajda?= <rafal.gajda@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Gajda?= <rafal.gajda@silvair.com>
Subject: [PATCH BlueZ] mesh: Ignore beacons with IVU if IV already updated
Date:   Tue,  7 Apr 2020 11:32:51 +0200
Message-Id: <20200407093251.594-1-rafal.gajda@silvair.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When daemon receives beacon with IV=n+1, IVU=False it will                                          
start sending messages with new IV and set sequence to 0.                                           
However if daemon receives another beacon with IV=n+1, IVU=True it                                  
will go back to sending messages with old IV=n (IVU will be set to                                  
True).                                                                                              
Because sequence number has been reset those messages will be dropped                               
by replay protection and node will lose communication.                                              
                                                                                                    
Once IV is updated daemon should not go back to using the old value.                                
                                                                                                    
This patch adds beacon rejection if IV has already been updated.   

---
 mesh/net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mesh/net.c b/mesh/net.c
index 9a56d2ee8..2f51a5ade 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2717,6 +2717,12 @@ static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 			return;
 		}
 
+		/* Ignore beacons with IVU if IV already updated */
+		if (iv_index == net->iv_index) {
+			l_info("iv already updated");
+			return;
+		}
+
 		if (!net->iv_update) {
 			l_info("iv_upd_state = IV_UPD_UPDATING");
 			net->iv_upd_state = IV_UPD_UPDATING;
-- 
2.22.0

