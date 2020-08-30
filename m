Return-Path: <SRS0=5eoE=CI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5EBC433E6
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Aug 2020 11:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2D120BED
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Aug 2020 11:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m24aCiC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgH3L74 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Aug 2020 07:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgH3L7y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Aug 2020 07:59:54 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8507BC061573
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2020 04:59:54 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i13so1661509pjv.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2020 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zqFNKSuFAmeQvdRzqWYjl+KPxRmwQ0ADbz/kuXgPe7o=;
        b=m24aCiC4946C7cIh19AoGt0JPJM3gXIO3huwpkzE9Igc+6l2d1XgHNBGkin6AiiaWW
         xHDf/7tBIShgou0kSBJSDzcm6mef9h6hLavpPmgmu5EK3t/gUfPsbHeiwxFVGxwZLxS8
         whs85+qqSDhiPsSFF7iTqxJr97682WyWrsAZ02YTyXcjVv7w7TrjTyBFedKJ/hqZ44LD
         iq9vD/lLOcoHvi2pbSx9hVBtebppeHWzyP4ul/qF4U9R7oPKv3av2Yig8H/4v1tI3ozM
         RXjo15bc1HtwnaFh1fGt6fmeTxUvZeqVXsas2p+xaSOnHSszjD0Uxv837xbEY+IWTAz2
         sEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zqFNKSuFAmeQvdRzqWYjl+KPxRmwQ0ADbz/kuXgPe7o=;
        b=mK4IIVrphcH4sNlpBhoCdGKtfeJfgyEoIHrDogKTNoHB3u1UH4DtIpB07kCQIuGE6/
         8CNOJJ+l5cUOuS4H8xyRPRvf5TIIsRIOJZNIwDkiCBGAYOaABJNbnL1hEKUmrtIISWTD
         6Hx4mpcHBfKstfae4crcPyT2BpH5PFWLwrskYOggRHVYkJQdXjJqeHfBYqUd/Gc5C3Zz
         KluIokSH5vTXGiWJ9rpwWeXr2o0QVjJRUwM5vsFzvkXU7EXG3cXu39edAMUnRfRK5YbW
         NihHdHIueLNSgK2Y6UtP48sOG0tZ1v1y9Fq7R1rvYlhd4oafxd9H35OSP13zg7joB2Se
         F1dQ==
X-Gm-Message-State: AOAM532iH8bUIotHqjqV75cw5h8QyzX3QbmH5Thus3XL/Rph59WLRcGi
        Ocu1KkEZR5P2HDwK1n2RKiM1sQtKUIRfUbe2
X-Google-Smtp-Source: ABdhPJw4e4jRTE21odtj5BNqGsk51pV/ZO9MCzVABWtgbOtUrEF049pKCZoArVTYh4Hn6lf4XebT9A==
X-Received: by 2002:a17:90b:4b89:: with SMTP id lr9mr6756783pjb.190.1598788793750;
        Sun, 30 Aug 2020 04:59:53 -0700 (PDT)
Received: from ubuntu (210-65-47-79.HINET-IP.hinet.net. [210.65.47.79])
        by smtp.gmail.com with ESMTPSA id q5sm5028986pfu.16.2020.08.30.04.59.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Aug 2020 04:59:52 -0700 (PDT)
Date:   Sun, 30 Aug 2020 04:59:48 -0700
From:   zefang han <hanzefang@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] hcidump: fix a crash in le_meta_ev_dump() 
Message-ID: <20200830115948.GA9519@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/parser/hci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index 41f6fe087..e969d198c 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -3668,7 +3668,12 @@ static inline void le_meta_ev_dump(int level, struct frame *frm)
 	frm->len -= EVT_LE_META_EVENT_SIZE;
 
 	p_indent(level, frm);
-	printf("%s\n", ev_le_meta_str[subevent]);
+
+	if(subevent > LE_EV_NUM){
+		printf("Unknown\n");
+	}else{
+		printf("%s\n", ev_le_meta_str[subevent]);
+	}
 
 	switch (mevt->subevent) {
 	case EVT_LE_CONN_COMPLETE:
-- 
2.17.1

