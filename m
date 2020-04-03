Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7BCC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 13:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101402078C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 13:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W0GFzh9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403853AbgDCNVH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:21:07 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:44828 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgDCNVH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 09:21:07 -0400
Received: by mail-vs1-f46.google.com with SMTP id e138so4845971vsc.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u66zw3BS9Frmxrpsxbbi3yFJUMm0r/b33P5UNWAe6Rw=;
        b=W0GFzh9F9ASpfYyx5R6yt6vUYSb6VQz9M2EDfNCA+/ZmAAK2PAFHYTe+CnMgmbs5xA
         sFMIZ+ovQDK/IWAo1Bh5H6ZyoSl4yI/N8qvhKn2n84aS+bZ7R4t9P7+N4JlSv3DbV+pH
         s8wIw3x6D0sJsRNC8kwZP4hS6WZFrGP9kEP5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u66zw3BS9Frmxrpsxbbi3yFJUMm0r/b33P5UNWAe6Rw=;
        b=UT+qOYBl2LpZFlIrKird1raan9zvfUxXQY9e6ZD7g2fLRuNbTFn6AjZUm5JIqR2rm/
         ovgusYDrQqHIAODW765vK7qjQLH7QVBlk32l3yOv5tl+l6zy9MOn04yFCtGeCltNcVju
         3f4plF2hLYqz17/mHy7fxrV+lWH2LLPVTWOSWWGum8PIXXxaiYA5IHINBuSZmXnCWa8o
         Qw/Asf9QklrB6JXZMQcPWkDWTgQu7Zdte5AkZDe0Wul9aK0G8Oj2OhHEh2/TFTqK8gyZ
         I0k+eGRgz6i1PsI0wpvantNqylHohDMBRRiPpOdhsePC1RJEhzmDuR4xxZhJEm26LP5C
         h20A==
X-Gm-Message-State: AGi0PuYhMqZYZ3McyITQfdE8aYbJzpbhCrJtVUAQTOMp10EY1gYCtr2c
        Wgxj86BOfySMXeriZC+aik6L7mADyVk=
X-Google-Smtp-Source: APiQypIynO1KcJVcPA4X1eWa42e6zcfFNMkEO738T6DyRMuIuNBqeFNTAzFk1N6Sh0PYHFCNaKtODw==
X-Received: by 2002:a67:5c7:: with SMTP id 190mr6611082vsf.97.1585920066088;
        Fri, 03 Apr 2020 06:21:06 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id x5sm1920609uad.4.2020.04.03.06.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 06:21:05 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v1] doc:Adding ConcurrentLERoleSupported property
Date:   Fri,  3 Apr 2020 13:21:02 +0000
Message-Id: <20200403132102.186407-1-alainm@chromium.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds a new property to indicate the support for concurrent
LE roles which means that the controller has reported the appropriate
LE_Supported_States (hdev->le_states) and that the controller's driver
has reported correctly handling the various reported states.

---

 doc/adapter-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index acae032d9..fb3a246a7 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -326,3 +326,8 @@ Properties	string Address [readonly]
 
 			Local Device ID information in modalias format
 			used by the kernel and udev.
+
+		boolean ConcurrentLERolesSupported [readonly]
+
+			Indicates if the adapter supports concurrent central
+			and peripheral role at the same time.
-- 
2.26.0.292.g33ef6b2f38-goog

