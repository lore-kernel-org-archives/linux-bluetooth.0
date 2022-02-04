Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94456C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Feb 2022 19:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiBDT00 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Feb 2022 14:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiBDT0V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Feb 2022 14:26:21 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA2BC061741
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Feb 2022 11:26:21 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i17so5888714pfq.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Feb 2022 11:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=itgDGwkngeyrCOlWDFdfpjfq1dKGDLpmmgwN/KPCPhg=;
        b=jXS5cAJ0tuOo+mHJtRQkwlV4jgs0b7zYx8wp6Q69gmo7R3TnKQhVfEzQeYWcGdfBSc
         xqNvaZZZR+szTdvX2w6H4SO/PvrqUXdt2P8tj8KJGvLAQz59VZ+oCJLaKf+Pyk5x4GxI
         KAEZ/y2Ix5TMv1bKXEtDaozhTCn3CQQ9h0pNW+PHnhgoDTVkwrumDTLHF3PfiTte7gNM
         kZRKAwa4j+qZFjP4DlP2Ch0aTq6syAdkYOBD2R1yMKb95f4rsjbL2ovMV7a8MVJJDvRI
         5OfRtC+EevASJSkkp1LTxh9mY5LkjKvMM/xPhtVwA9drWUiJGD8EEzfH2ijTajlx3jNB
         2vMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=itgDGwkngeyrCOlWDFdfpjfq1dKGDLpmmgwN/KPCPhg=;
        b=pLtjXesVVhdaPv4Sp0SlwNrLwqxZrL3+pFzfuZxGAIoPootCFKdThFEgSIV5v2AuzC
         y3xRIfR4mUjiPTq0a9CnKhLKqShJ9XMHDqpp+t8cBjMDhuiBgxK7OqhnxaHBaikbTQaa
         V9MUgnv4aMTaam7C7CIuvWzGcavwjEmfXhWDx4FOIX4gz8udsPtkLKF9xSb0hcSxM+tQ
         HiDQt3rfM8CJAd+PdKjFkMU1vjTuV9Kn1EEJLw3xMBdcjiJ4AauIPDp8bADxmc5M8fuD
         KFhiOK0jNzHmZYU/Oih5Mm9Ifv+VIJDkjIM7qQpjUgtHqR52c1ldmXRNs/4DvqHYNZOF
         OZ+A==
X-Gm-Message-State: AOAM531zIOJZVczedvDcqkXPHBUgHUfoVLaYPHlnYQvPGrOQHDSPusZd
        9YxpUHGgu+CB9HCrcqjBaq2Q2J/segSWhQ==
X-Google-Smtp-Source: ABdhPJw34t/xceVs9zc8AOs0rQerU2Gi7oYlng2q8yR26P57rj1+HhOqc+YJWtA3d5g8Hy+z9EZ5Zg==
X-Received: by 2002:a63:565a:: with SMTP id g26mr445690pgm.48.1644002780301;
        Fri, 04 Feb 2022 11:26:20 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t2sm3184169pfg.207.2022.02.04.11.26.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 11:26:20 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] gdbus: Emit InterfacesAdded of parents objects first
Date:   Fri,  4 Feb 2022 11:26:19 -0800
Message-Id: <20220204192619.2653955-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes InterfacesAdded respect the object hierarchy in case its
parent has pending interfaces to be added.

Fixes: https://github.com/bluez/bluez/issues/272
Fixes: https://github.com/bluez/bluez/issues/284
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1534857
Fixes: https://bugs.archlinux.org/task/57464
---
v2: Fix typo chield/child and add links for previously reports of the same
issue.

 gdbus/object.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index 50a8b4ff1..f7c8c2be5 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -551,6 +551,12 @@ static void emit_interfaces_added(struct generic_data *data)
 	if (root == NULL || data == root)
 		return;
 
+	/* Emit InterfacesAdded on the parent first so it appears first on the
+	 * bus as child objects may point to it.
+	 */
+	if (data->parent && data->parent->added)
+		emit_interfaces_added(data->parent);
+
 	signal = dbus_message_new_signal(root->path,
 					DBUS_INTERFACE_OBJECT_MANAGER,
 					"InterfacesAdded");
-- 
2.34.1

