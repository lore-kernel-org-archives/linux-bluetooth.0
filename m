Return-Path: <SRS0=oE9z=ZS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C2BC432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 19:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510F52064B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 19:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VKWLPB8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfKZTIu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:08:50 -0500
Received: from mail-vk1-f170.google.com ([209.85.221.170]:38064 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfKZTIt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Nov 2019 14:08:49 -0500
Received: by mail-vk1-f170.google.com with SMTP id m128so3103573vkb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2019 11:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PTyMLJIFyJmLvUKwEq5cWL5M8bbTv7I4O+/eZtbXQ20=;
        b=VKWLPB8MLgHYUVRV7zf6UU7yT8Use5dK3/t2KstI3u7FkOXJtyWBQpS57bTRQ95iGg
         fy5PXE5ODX//O6XwpDv8HjNWrqtogkXxyNmJVE9/0l5qzHYNM7WY6UTK8pTKk3C/XYH2
         nHI2MUSVpwqRltnp+MlwoPdhfZ/WPyJyYoaz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PTyMLJIFyJmLvUKwEq5cWL5M8bbTv7I4O+/eZtbXQ20=;
        b=JM974hU5ergfScSmKlG8fZfmsS0T317gs04CA7olOhXqjg2u2OEjTTunoBhtiIk56V
         G+Qnh0EuNBJhTINAFy+ioDb5wULlsf9NiRT42ZBKFEa5tskW4zQdPublvA6WQ/xwGKc+
         WeYm9wGAMr01WhPKjBuLRPk1WNngJSjBI1io+JAqsOy0pEhMktYSNKI4vokBjCi93ftn
         LbhL0psORMD/+DZd9g2rJ+oRlBdzX+Ky6MsOFYbVVvkK7coMxTQcH+jpWgmQDZXhwfHe
         WvQTYSWw5t4YVzSrlD8wuDEF2J7It1WZEtoCaSY8H96tp7ac4lqIksbmKFtTcuUavjna
         MMHA==
X-Gm-Message-State: APjAAAVtA0Cs/gDCR9ZHNACthg+3dlLNi8MCnim8sSl0Us7IX2VIil/C
        rsR7/3kD/UJX2JtutJ31auR1LFfxMDc0Og==
X-Google-Smtp-Source: APXvYqy69uHbYfByZMF1PzjF6yZ0NDmk+/WrSc8AC7XFtG4UW1p58NAzIsM8LW/TFvZ8EEyO3PBCKA==
X-Received: by 2002:a1f:5447:: with SMTP id i68mr44756vkb.66.1574795328168;
        Tue, 26 Nov 2019 11:08:48 -0800 (PST)
Received: from alain.us-east1-b.c.cloudtop-prod.google.com.internal (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id j133sm3224429vke.35.2019.11.26.11.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 11:08:47 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH] Adding dependency get command to README
Date:   Tue, 26 Nov 2019 19:08:42 +0000
Message-Id: <20191126190842.22797-1-alainm@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/README b/README
index 1c5c140fb..c7032d02b 100644
--- a/README
+++ b/README
@@ -16,6 +16,10 @@ In order to compile Bluetooth utilities you need following software packages:
 	- udev library (optional)
 	- readline (command line clients)
 
+	On a debian based system, this can be done by running the following command:
+		sudo apt-get build-dep bluez
+		./bootstrap
+
 To configure run:
 	./configure --prefix=/usr --mandir=/usr/share/man \
 				--sysconfdir=/etc --localstatedir=/var
-- 
2.24.0.432.g9d3f5f5b63-goog

