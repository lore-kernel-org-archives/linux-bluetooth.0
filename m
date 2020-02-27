Return-Path: <SRS0=rxlX=4P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E679CC3F2C2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Feb 2020 22:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93C02469F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Feb 2020 22:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jsEeD9Ra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgB0WA4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:00:56 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42902 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbgB0WA4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Feb 2020 17:00:56 -0500
Received: by mail-vs1-f68.google.com with SMTP id w142so682594vsw.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2020 14:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iYfl/nO4ZnXEHyd+jnu5r5om/coKJt3oLuyUf2gWc98=;
        b=jsEeD9RamC4m2udPQnQ+A01xEvAu0LQxCCCzO69nTi47Oucpc2n7Iln6XfUu1a4mh1
         N6ak+yS0GOUs8hrJQp/4OMBnD0HwfO5y2s6Vldg61zWjDCHeTIsZgI+A7KHTPTaNP6fR
         E2cqR7yTVFJYnNRGcMRekSpsatFqpNLfwv0QA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iYfl/nO4ZnXEHyd+jnu5r5om/coKJt3oLuyUf2gWc98=;
        b=R7fZt76sgyl08TIeQlG3muMCbPTmb56hONUW939Pg575R2poby1ZRM/ywweOzAqtb8
         spD8QlTzwB2E/ZohSG8vQwtP/7DdOIwMU8QSJUXeCcpg2vcK9LS5ZfGE978VXek2aHLH
         nfn9vNo97kB2vxlN7GPqAKD0p3qbQY8iTLDltJVA/p5bbgYtM8cdytNn6fgSgF1vddpV
         gy2nD8LH4k/ZV7egpbPoFUoGVY8EwH7X7BbYim8TJLPUIpRQvX0tOR+sT2c0Jg46LHt0
         +SVwRIz/p4usc/OV87zgXD19Pzodke+n8DSwa7V16VbmEhK6rLIZ5JCujOCDcAvXcVyQ
         bGXA==
X-Gm-Message-State: ANhLgQ1A2CaIzdlJE1MgJPgzNatowaBkiBYDwc3h7Ru4kXjJfqkmvVq/
        EOeJvtPkZdu/vjiyhiB4h/r+4CGC3HQ=
X-Google-Smtp-Source: ADFU+vv2LVQxmzjeNWcFWCK+G8RHQDuWLKmUrok55dav+vKKE6lEzqkhbe2oJ680YJICING5H98kEg==
X-Received: by 2002:a67:b107:: with SMTP id w7mr1003130vsl.128.1582840853552;
        Thu, 27 Feb 2020 14:00:53 -0800 (PST)
Received: from alain.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id m19sm2473973vko.9.2020.02.27.14.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 14:00:53 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH] bluetooth: Fixing a few comment typos in the quirk definitions.
Date:   Thu, 27 Feb 2020 22:00:49 +0000
Message-Id: <20200227220049.148784-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change simply fixes a few typos in the quirk definitions.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 include/net/bluetooth/hci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 6293bdd7d862..3311322f5128 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -115,7 +115,7 @@ enum {
 	 * wrongly configured local features that will require forcing
 	 * them to enable this mode. Getting RSSI information with the
 	 * inquiry responses is preferred since it allows for a better
-	 * user expierence.
+	 * user experience.
 	 *
 	 * This quirk must be set before hci_register_dev is called.
 	 */
@@ -142,7 +142,7 @@ enum {
 
 	/* When this quirk is set, an external configuration step
 	 * is required and will be indicated with the controller
-	 * configuation.
+	 * configuration.
 	 *
 	 * This quirk can be set before hci_register_dev is called or
 	 * during the hdev->setup vendor callback.
-- 
2.25.1.481.gfbce0eb801-goog

