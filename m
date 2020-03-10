Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3369EC10F25
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 02:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3662253D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 02:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BwPzyy9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgCJCgD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Mar 2020 22:36:03 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:43030 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgCJCgD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Mar 2020 22:36:03 -0400
Received: by mail-ua1-f45.google.com with SMTP id o42so4113853uad.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Mar 2020 19:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6IdBxYCIYqV3HQIJkWlJWsdSuE1kyl5MLjvSqtdIbQg=;
        b=BwPzyy9hDQE5icXIe9swdaALl1B/nUfV97b2Bz8Y0r5N1L/xt30fD71Qu+SvBv02m8
         bPQaYU0I2RjzAF9kVx+YLsDpWQW4N9GZL0K0LC9NPyN4GdQ320JR8BuLcNioaSwzZjZC
         hcWilGn7rljaMv7bhh7LCXCntGYOYjed11CS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6IdBxYCIYqV3HQIJkWlJWsdSuE1kyl5MLjvSqtdIbQg=;
        b=s5OC9B5NiwhYoYZ9tgiVluO+oAkiHwrGLyylL+coGM+QRS/yybgqoVmGXKfQj4SVOu
         zGZZ82YbMU3OuYytmXXJy2VFc9+GnXHwiCPC+U5KfyMaVzYSsd4a4XZWI0HAWRTcO8CA
         ZAjrNl5wx5AWpaI8OXHdseNEv5DZimi9hrkXIwLcd118xOHYboBQBiXHYrNmFGjWeXPl
         UP1622s+3BdKs2ZjGmUksZiKRnAghSTVtWws99t8cOrqcCzy1ve3lctsZ3sa/QzcTN+b
         ziPpMBGFH2zIxtasBMyWm0NcIXh6twvl6CIyU/hYb/kcoYtZtKyVXIO0Ja7m09EwXFGq
         j6gQ==
X-Gm-Message-State: ANhLgQ1fbpbik8tGMmIl2OTkQfkaTsUjFHN+vvQObb7py+ADxJBAQNyZ
        xtoPKua3v8/jJp115sWIzTYPy6ZTX4Y=
X-Google-Smtp-Source: ADFU+vvkODMEe3WnkyAMtvnP8YkrUJXX8ogUa92xzjQRo/Vt6QTDBq6MoG/37EL3/1vDppGHwnzi+g==
X-Received: by 2002:ab0:26cd:: with SMTP id b13mr10539813uap.24.1583807761792;
        Mon, 09 Mar 2020 19:36:01 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id p24sm2767024uao.4.2020.03.09.19.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 19:36:01 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH 1/2] HOGP must only accept data from bonded devices.
Date:   Tue, 10 Mar 2020 02:35:16 +0000
Message-Id: <20200310023516.209146-2-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200310023516.209146-1-alainm@chromium.org>
References: <20200310023516.209146-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

HOGP 1.0 Section 6.1 establishes that the HOGP must require bonding.

Reference:
https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00352.htm
---

 profiles/input/hog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 83c017dcb..dfac68921 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -186,6 +186,10 @@ static int hog_accept(struct btd_service *service)
 			return -EINVAL;
 	}
 
+	/* HOGP 1.0 Section 6.1 requires bonding */
+	if (!device_is_bonded(device, btd_device_get_bdaddr_type(device)))
+		return -ECONNREFUSED;
+
 	/* TODO: Replace GAttrib with bt_gatt_client */
 	bt_hog_attach(dev->hog, attrib);
 
-- 
2.25.1.481.gfbce0eb801-goog

