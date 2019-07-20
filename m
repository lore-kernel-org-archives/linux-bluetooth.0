Return-Path: <SRS0=wCWq=VR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DC0C76186
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Jul 2019 16:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04B12085A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Jul 2019 16:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7XQynjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfGTQ0L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Jul 2019 12:26:11 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:38823 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfGTQ0K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Jul 2019 12:26:10 -0400
Received: by mail-qk1-f169.google.com with SMTP id a27so25593817qkk.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jul 2019 09:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3oJ8p4whHQ+WfS1svf8hNrjjvfL/7wlyVMkIgVSAlOs=;
        b=X7XQynjdXbkHQpiGIw25nIgC/7F3Hq2ACVS0mITd/mjNym5ZuXVSoIDEzuiI4fpKwO
         BHQi2jXMQeSX5iyuVB0N0O0nue3PKVD08MPeOpP+/3ni+FQOIl61ODPWCgLeFCHlLsWP
         KG1BGpzJZhaynNCM6f5Gm5VFMwuqQsEUFQtBBzedz77nkk+mcrmtE/GO5LIuj7UEG5wS
         Uy1fj5KDjP4qUyoh1B1xmHh6omxAaqjmaCvCc5W23vs49PVH/8PyJhOQCrHDidqsdy51
         2x0iCl8IwJoahIcgCujvz2eepmtcRzIAiaEM34wcma0abVQ/L5N0OcSJYp065Vc0RFQR
         VR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3oJ8p4whHQ+WfS1svf8hNrjjvfL/7wlyVMkIgVSAlOs=;
        b=sGi7CTtT4ei/sdpJa5P25v+5RyLDY+xTsIr+9FjU209e+IhwGbJDLL3BEaAMmjWJ8E
         VjwoUQlImJ2elb5q4W7B5bZgIfe9iGC72D2X1KYraF67jmt4XP2qf9RvL42p5nGv0JCV
         gVIb5gblc4XlcP0o+Fzp8N51G0NNrAXAgzEuegKxduY0Otfh4Bnd/oFG0A2mvhfYX5Pj
         sM8++ZIp+MxLZrJAombQCruLeB0ypKatkrP2g53ju1ZhcKf1FHYar9/m/mDwCc8gWxaf
         GRpRzo2JdXjgAvMMbo695zq8XrLTvFSMv1PnDql5Pty2w85ebaBU48WJXpxFWYZED5yW
         2/fQ==
X-Gm-Message-State: APjAAAUvYE7EIwamMt4chVEyDZtTF/kWsLUhXEqVpEIqtrEqR/KFSkyt
        Wc+WUpZ9ABuq/zwItNRBKfaj/TwAsvY=
X-Google-Smtp-Source: APXvYqwSWnahxu2c+4aMCIacUAVqivXTMox6eRkLrKSpVIW5FYbqsZ6ya6NHLuYsLraykxCOp4SrkQ==
X-Received: by 2002:a37:6508:: with SMTP id z8mr39090811qkb.492.1563639969653;
        Sat, 20 Jul 2019 09:26:09 -0700 (PDT)
Received: from localhost.localdomain ([2601:199:4300:8b9e:4ad:4bd6:2a5e:649c])
        by smtp.gmail.com with ESMTPSA id g10sm15065150qkk.91.2019.07.20.09.26.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 20 Jul 2019 09:26:09 -0700 (PDT)
From:   Greg Knight <lyngvi@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Greg Knight <lyngvi@gmail.com>
Subject: [PATCH BlueZ] Minor clarifying edit to media-api.txt
Date:   Sat, 20 Jul 2019 12:26:02 -0400
Message-Id: <20190720162602.8819-1-lyngvi@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This changes the documentation on org.bluez.Media1.RegisterEndpoint
to explicitly state that its argument must implement MediaEndpoint1.
---
 doc/media-api.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index bca8c9563..705d14727 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -12,7 +12,8 @@ Object path	[variable prefix]/{hci0,hci1,...}
 Methods		void RegisterEndpoint(object endpoint, dict properties)
 
 			Register a local end point to sender, the sender can
-			register as many end points as it likes.
+			register as many end points as it likes. The endpoint
+			must implement org.bluez.MediaEndpoint1.
 
 			Note: If the sender disconnects the end points are
 			automatically unregistered.
-- 
2.20.1

