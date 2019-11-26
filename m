Return-Path: <SRS0=oE9z=ZS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13FAC432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 14:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6152068E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 14:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ecqwx7Vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfKZOyN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:54:13 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:38459 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKZOyN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Nov 2019 09:54:13 -0500
Received: by mail-lf1-f52.google.com with SMTP id q28so14342307lfa.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2019 06:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bjJ5ta9IKA8jR2kaX9oA0422T0wdQ3ejzbVi0mmy3gY=;
        b=ecqwx7Vg7xMt2eEEJPn1wGVIGHThvzlxbZNLKaJa9lyA64eJCDVP99/GgItuEqjYDH
         H6mui10mIfRtGv6wit5NdiY0UkM8f4HEOpMYjo6t81CNlO0nYritGR82lYFixUTJcoSt
         vDQL11anQtb5kls7RsgOxP6PHiydTVCoYdhKUmcyelLcCboleedhn3A4cIiHF2CSzDPk
         v6gUVVWkpxz1YuECCZxhbZ7Hfz54ccKLEtIaskl/N2gWnbmhnsLLbzqiXmSJUJjsJA+T
         0EAN0ZbZjCoJ+kpw4uXTsI6DbE35GK6jPDQg/yHk4w2kdzHG8bPHVPZ+ifJn/ZDk8JQ7
         3fkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjJ5ta9IKA8jR2kaX9oA0422T0wdQ3ejzbVi0mmy3gY=;
        b=nBVgJeSI31j0CrzSafsQ/JEcWoL0/T2OcKw68b0FnAzYcrS3QeKqiduDPL7WXqTCkL
         izGDbqPU3lx4DXEE5hQH/oSxBevPssiTVnytNLHe8/pwSU0mIESS+GxTTSLEwcEkhiME
         I4a+kza0+yWVzXkZPb1hwWJsWFw30egOqY25DmcgYIXogvekMJAm5O2ErEpO9IV+0iAe
         evsDxUJsGQ9vjr+qqLvOCBmpqfXE/+GKnEqvxKJA0B6hvtoJ39iRByGO/Es0TKX4ie3X
         SUqx9ujY3WNjE3k7UH5eChUCs+syqWupmk+ufO/w7pxncFJOt9tI18wOX9R4Z5zaBDaL
         mtjw==
X-Gm-Message-State: APjAAAWzF3Yu+LdsMEfKWHD9tnh21K/b2478MKOVm3SNruRRLAOPTG3w
        nX17/FxsrUQbL/hr1PHtcjjAy7LhXu+ZyQ==
X-Google-Smtp-Source: APXvYqzalE/RnDCeuaqwp/tazWqAHCSJv6Amma3cYYhsuGqwIa/tGftdehkDB4PTk9kz/2xhphRNvQ==
X-Received: by 2002:ac2:5b41:: with SMTP id i1mr2449057lfp.82.1574780050514;
        Tue, 26 Nov 2019 06:54:10 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id d26sm6607954ljo.54.2019.11.26.06.54.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 06:54:09 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/3] mesh: Fix test-join to include mandatory VendorModels property
Date:   Tue, 26 Nov 2019 15:53:59 +0100
Message-Id: <20191126145401.25129-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191126145401.25129-1-michal.lowas-rzechonek@silvair.com>
References: <20191126145401.25129-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 test/test-join | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/test/test-join b/test/test-join
index cdf92a2f1..079f71149 100644
--- a/test/test-join
+++ b/test/test-join
@@ -232,11 +232,25 @@ class Element(dbus.service.Object):
 				ids.append(id)
 		return ids
 
+	def _get_v_models(self):
+		ids = []
+		for model in self.models:
+			id = model.get_id()
+			v = model.get_vendor()
+			if v != VENDOR_ID_NONE:
+				vendor_id = (v, id)
+				ids.append(vendor_id)
+		return ids
+
 	def get_properties(self):
+		vendor_models = self._get_v_models()
+		sig_models = self._get_sig_models()
+
 		return {
 			MESH_ELEMENT_IFACE: {
 			'Index': dbus.Byte(self.index),
-			'Models': dbus.Array(self._get_sig_models(), 'q')
+			'Models': dbus.Array(sig_models, 'q'),
+			'VendorModels': dbus.Array(vendor_models, '(qq)'),
 			}
 		}
 
-- 
2.19.1

