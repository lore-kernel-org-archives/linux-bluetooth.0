Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D4AC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 10:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE15206BA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 10:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="oZpcbAYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfKLKnh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:43:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37840 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfKLKnh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 05:43:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id t1so17953840wrv.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2019 02:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48x4P2GiM4N56zU8oLFh/YQjO27VHrZCFfF6NgBHSXw=;
        b=oZpcbAYVZGHNuloFcfxUrWtDWY7ldLbef5hBFdzsAntp2o1Ik76/1gSA0nduXwwiUp
         5Po7w+dNwC1VfToFTwMSD26EKfV0qD9txVzoq58hHYGQ7assElbRoSEddU7mqxqSGoGe
         PE8OmrUxmSXKQkndRT40TpWcPG0BC3i5fSq+4fjWPC5ZZyHCbyjzHhWx9T9smFnP8XED
         dEJm5S/o7YPkPujGumRN9g+o/59pFYfThjYVWElToNNm4v5zatDKnDlD9RfKYwkOl4Qm
         4MVOzwzibi1UZQkYb94Y2L5nzTypvY9pTqlTNpw8ENYNlgidvv1YgrAL+qZ2RWz9gMvM
         SJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48x4P2GiM4N56zU8oLFh/YQjO27VHrZCFfF6NgBHSXw=;
        b=TO4Ws2L321+vSLUs5TLGNFhTuBNwbDz84tu5RF52HnQ322JBZ4BN1xZsztZGkZBini
         sHKfRFSX9xQ1KnyBss/jrzHHCsdaP6s1oWwQ+uqAfMxl0jvDBPlNxiMym3s/eCA8zuKn
         PjImgyFT+I39DIbY0w4mRZkGc47FwqkBhbdRfiDCw17kbUo5z6TK9TwcLylYE/FM28Uw
         e1zr8i1r5fYk0LoiPaRBIW7jsACPyiZ+G7fh+f/TON5y2bGsPLdYnHZ2VYGvZ8LIilO0
         7FLSGrx6wpRxxGm8zxAcqA7uWHKELELdaTcMFvknmalFV8nK/NbKw4nq3lMeSIUArdj7
         b2cg==
X-Gm-Message-State: APjAAAU1CBI2KheBGowYoWcv/GnhfJyaq+/VOxWkE9NZWhUvAxJ68nZK
        ZPfDkklJrD13J6GiDh51q6I8+vXrzN2KLA==
X-Google-Smtp-Source: APXvYqzxIYVvmhiZ4hCUvL/hC4/XHano5/mDsYEMoo9jq5zH0koJcJQmi/WKyRdhIkstEpRRp5qkmA==
X-Received: by 2002:adf:9cc9:: with SMTP id h9mr1958742wre.137.1573555414213;
        Tue, 12 Nov 2019 02:43:34 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id i13sm17786342wrp.12.2019.11.12.02.43.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 02:43:33 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Add missing property interface to node objects
Date:   Tue, 12 Nov 2019 11:43:27 +0100
Message-Id: <20191112104327.13109-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/node.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mesh/node.c b/mesh/node.c
index e23f32dd1..d2dff3a51 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -294,6 +294,10 @@ static void free_node_dbus_resources(struct mesh_node *node)
 
 		l_dbus_object_remove_interface(dbus_get_bus(), node->obj_path,
 						MESH_MANAGEMENT_INTERFACE);
+
+		l_dbus_object_remove_interface(dbus_get_bus(), node->obj_path,
+							L_DBUS_INTERFACE_PROPERTIES);
+
 		l_free(node->obj_path);
 		node->obj_path = NULL;
 	}
@@ -1156,6 +1160,10 @@ static bool register_node_object(struct mesh_node *node)
 					MESH_MANAGEMENT_INTERFACE, node))
 		return false;
 
+	if (!l_dbus_object_add_interface(dbus_get_bus(), node->obj_path,
+					L_DBUS_INTERFACE_PROPERTIES, NULL))
+		return false;
+
 	return true;
 }
 
-- 
2.19.1

