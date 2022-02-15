Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13DFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 23:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244832AbiBOXjR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 18:39:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiBOXjQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 18:39:16 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658B19A4FB
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 15:39:06 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 132so531870pga.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 15:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VLajr11PTQSzoPBQt2bW7VgPYmFkTOA8XIKfbF4d/ow=;
        b=T5cb3vLPiFknjSwhupOcM5sstY9HrUyNk7o2fJEKlRWR7pfa08wQU6f/mvhz8pOfjX
         dYx1WbzNSU/mJ1OxQHR5q2diWaNHTwPj4kmefiz4vchEaUJujjts6Bx5mxbuqxgVzN6H
         xOCxlI9+fXkWOB14Urdz7HQ6c79BDN1N9DksDUsdpWh0GupeZqnTv0GTWwIA7cZzZLGh
         hw5y/eoCv3gYDpkpf2hiV/2QkrsR8RALSRYSovCTQNgqhsWL7iplxHkp5N5gew+z6mOl
         YVt4ZVcGGAPpwzt7SX4z8NPV7tt/Pvxkq4wgdBgopDmQ8t96IdaF75w0USWD9e3lsHaX
         lDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VLajr11PTQSzoPBQt2bW7VgPYmFkTOA8XIKfbF4d/ow=;
        b=IiPZvASu+Tq9iBj9ioU5ElC9/o3s7O/enrDZyYodI4TXofygvvXKdMIjNnhYv0USDB
         qEIg8nDkd8lXKhssVDrOeHGB84JATusufe4zHcGAQaj0JnXQLLf7h/AFHgI2OTplFhJC
         ICE6DjZTHppIKzuarMiBldBntx/UZedXy1Q7rG3JxuLdnfaDfEhY1xpqlx3aGzh975Ey
         1sGYXuurijdGGs/8rSb/D4yqBadIscwqeTabzRqnJgL5rHJfmZbeJmif3Vqd5uxJDnLb
         dGBCTmem/JsfWOFRCjapTmjK4Ajww2bBI+1nXZnkzPf3YtezmUmaqLarLw/MknIQcl95
         bnCQ==
X-Gm-Message-State: AOAM532GIFy+DPyYXbEdySDMyNLNTj9a5IeXFTJJKeM4LnmDzTxEbiv/
        8n3QSUT+kwT6SqvvbKqRrALunB5SCTU=
X-Google-Smtp-Source: ABdhPJyOb8jY8k0u0KfTIts+U4aYVLyKfCd5XIDzexOywP5WvvDnDiGiZ8N+x7QlHvQm9GXqPcQW0A==
X-Received: by 2002:a63:4b17:: with SMTP id y23mr1016430pga.489.1644968344251;
        Tue, 15 Feb 2022 15:39:04 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830::b99a])
        by smtp.gmail.com with ESMTPSA id w4sm3405335pgs.28.2022.02.15.15.39.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 15:39:03 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] [DO NOT MERGER] Test Patches
Date:   Tue, 15 Feb 2022 15:39:02 -0800
Message-Id: <20220215233902.3090-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

to run CI
---
 README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README b/README
index 3dc226ff1..2b8123d75 100644
--- a/README
+++ b/README
@@ -1,3 +1,5 @@
+Trigger CI
+
 BlueZ - Bluetooth protocol stack for Linux
 ******************************************
 
-- 
2.25.1

