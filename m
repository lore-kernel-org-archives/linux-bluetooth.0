Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE87C2D0F3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2713120787
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="fGCFxjcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgCaI2G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:28:06 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:46141 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCaI2G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 04:28:06 -0400
Received: by mail-wr1-f47.google.com with SMTP id j17so24685359wru.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 01:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b63k3DErR/1nXLYBaG+6sS5inCIckcEURx2bMOJ8U6k=;
        b=fGCFxjcgVMEbT3rbb4TM2F6RFSgO5ejvLyPieOe2uuIgTGAnqJr9+xOpB1ea9rT+nV
         MPwAhMd+CUrB6aEg0JKMNoq2MMo4/mvPx2We1HjxZgQHnlkh2dVEr6CyGqjMZO1tx4qH
         bndpf9elwKEPdtIHquF4F0qbK2lqDb/nhKrViamF7XL7owAEJnQAMOedUZTkylaDdW1P
         9+Pvv9KsYvbbKE0iw7RGcN0IsR95zjl7lxufU4lWfyY88tH0yQU3spqvDQr34uDzIzDv
         sIQcfnin7YpRITywx08An8QHRIs4gYyZ72i5DoOo8IVEw70ZrlvMw5AfSenCK5Ds3q/d
         YvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b63k3DErR/1nXLYBaG+6sS5inCIckcEURx2bMOJ8U6k=;
        b=cUKgtYWctUuaj0TB23SqZ6DMImhAddRpZUi1qm+2BAUBMuf5b7BSop9XkcAvEDU93Z
         kozhDK3v7bjE6Sbp1pMZMxajOYcnHonQ5LM1XaiKlVWcLLUI6IBXFxaIqemZAUx2ytfW
         joSncWGlJmzSfqlezYy+g3OopGkl7tPHP7o2HEN+vY8/yOenZGEbaz/uXqRSszYz0Woy
         2bM2avIgZRMKbZs8L03z8Z45d23SC2N6AV51SJXCPOJg3y2FbnYTEjO4JTA8UfpYvD8z
         6puIgD4Mql9wuDF3x0MwAI96OAkw41Yu1CzpuNYpxeljPGLxiASD7wfA4n1B6oOHa/7A
         O+0w==
X-Gm-Message-State: ANhLgQ2XFkEUfyP0IcreF4ACcVgyO18LirGVj6m+Z8c730epzK5plshk
        nZW47DMTpajDNxkY2ofvBdR72YCxBF2p8w==
X-Google-Smtp-Source: ADFU+vuGNlBGE6B6wp8zQ6h2h9OP4b0tTk1GgEJwDUijUbP4YQyO9n2N1BtDG/8GsNdNFK27CWb3eg==
X-Received: by 2002:adf:e744:: with SMTP id c4mr18354949wrn.133.1585643284274;
        Tue, 31 Mar 2020 01:28:04 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x16sm6172296wrn.71.2020.03.31.01.28.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 01:28:03 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] mesh: Remove unused 'server' argument
Date:   Tue, 31 Mar 2020 10:28:06 +0200
Message-Id: <20200331082810.10856-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331082810.10856-1-michal.lowas-rzechonek@silvair.com>
References: <20200331082810.10856-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/manager.c        | 2 +-
 mesh/prov-initiator.c | 1 -
 mesh/provision.h      | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index 0909c7e16..a4c2f2d41 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -256,7 +256,7 @@ static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
 	}
 
 
-	if (!initiator_start(PB_ADV, uuid, 99, 0, 60, add_pending->agent,
+	if (!initiator_start(PB_ADV, uuid, 99, 60, add_pending->agent,
 				add_data_get, add_cmplt, node, add_pending)) {
 		reply = dbus_error(msg, MESH_ERROR_FAILED,
 				"Failed to start provisioning initiator");
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index 7a767cfb3..d5bae114a 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -817,7 +817,6 @@ static void int_prov_ack(void *user_data, uint8_t msg_num)
 bool initiator_start(enum trans_type transport,
 		uint8_t uuid[16],
 		uint16_t max_ele,
-		uint16_t server, /* Only valid for PB-Remote */
 		uint32_t timeout, /* in seconds from mesh.conf */
 		struct mesh_agent *agent,
 		mesh_prov_initiator_data_req_func_t get_prov_data,
diff --git a/mesh/provision.h b/mesh/provision.h
index 755d848a0..d6f6e0ab0 100644
--- a/mesh/provision.h
+++ b/mesh/provision.h
@@ -118,7 +118,6 @@ void acceptor_cancel(void *user_data);
 bool initiator_start(enum trans_type transport,
 		uint8_t uuid[16],
 		uint16_t max_ele,
-		uint16_t server, /* Only valid for PB-Remote */
 		uint32_t timeout, /* in seconds from mesh.conf */
 		struct mesh_agent *agent,
 		mesh_prov_initiator_data_req_func_t get_prov_data,
-- 
2.20.1

