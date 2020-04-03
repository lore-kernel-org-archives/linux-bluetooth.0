Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3EBC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 13:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8E7206E9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 13:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GZ7Mwf38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgDCNtK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:49:10 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40975 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390830AbgDCNtK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 09:49:10 -0400
Received: by mail-vs1-f68.google.com with SMTP id a63so4920700vsa.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lD+v0t1r+qpPIIVUOkHbdA6YGLILGl5eyQXlq4U7YA0=;
        b=GZ7Mwf387jL+wdiMgTQcgYBdAw/jDXf76k/mRO5upAEnY6Y7b69kXQQD2HtPOgEUmM
         k6QqfSC9S75/g7LzJQ0ZR4d4jPbSJBSxQGrg3Ze3vsOhaH5AM2zNypENyroenE1QSo7S
         Gb9P0Qfk+8SM6I6GiDE2+ZPyCumKuDtDhO9nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lD+v0t1r+qpPIIVUOkHbdA6YGLILGl5eyQXlq4U7YA0=;
        b=epESqxPKcnGcoZPosinEOh9NeSD47UOn1E7Tv99IZS3vgLqpnIn2KwPhgD6g243ZgS
         hw7kfufOay9Uvlxs3JXEsTVkmKeEkaNsc/IrLaAjzWnvK7NLaYPITLShAaYRnHTF5fuq
         m/Tk6L7h68DzEb9k9ZCUD8/PhmD4xf7hb1d7m7LKVpZNbyo9ZdZiAUKbmtqSEM/o9/HO
         yGrcZNFPSjA28Jg4YL23VnOcecZOpIUJqYx87EPhLxMXJAB1btQKoJsT0IUxFqgc9h3M
         aVQxZLRPlOiqCJsFycQUUbJN1or5X6ksaMRz8kVH0MWz8bnQcnlgA8IgRpmW/axx9It6
         exxQ==
X-Gm-Message-State: AGi0PuaWYq24+4hM2ZZNP/c0lTS8MYfQ/T+cBiSZ4g/mcJbATTpshnGs
        yp7lMZZ1PuRw5kfus9UZHM6r6mW8gZQ=
X-Google-Smtp-Source: APiQypJurnnFoAiuXy8Uo4cWUNaOJGhhmZ0TEnXVzQJZBKwvTWZiFW9yeKYPxJp3zUJCvDpjowoSrg==
X-Received: by 2002:a67:df86:: with SMTP id x6mr6306893vsk.60.1585921748589;
        Fri, 03 Apr 2020 06:49:08 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id k5sm2249037vkk.23.2020.04.03.06.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 06:49:07 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH] bluetooth:fixing minor typo in comment
Date:   Fri,  3 Apr 2020 13:49:05 +0000
Message-Id: <20200403134905.249261-1-alainm@chromium.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This changes a simple typo in hci_event.c

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0a591be8b0ae..ddf77304aa8e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5269,7 +5269,7 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 		case HCI_AUTO_CONN_ALWAYS:
 			/* Devices advertising with ADV_IND or ADV_DIRECT_IND
 			 * are triggering a connection attempt. This means
-			 * that incoming connectioms from slave device are
+			 * that incoming connections from slave device are
 			 * accepted and also outgoing connections to slave
 			 * devices are established when found.
 			 */
-- 
2.26.0.292.g33ef6b2f38-goog

