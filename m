Return-Path: <SRS0=LhHL=ZR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94976C432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 12:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5A52082F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 12:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="wDI+tJyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfKYMby (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:31:54 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:35223 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKYMby (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Nov 2019 07:31:54 -0500
Received: by mail-wr1-f53.google.com with SMTP id s5so17794818wrw.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2019 04:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bjJ5ta9IKA8jR2kaX9oA0422T0wdQ3ejzbVi0mmy3gY=;
        b=wDI+tJyo9rSsgBBM+YWrskkY/QhkrZRReCDdTOvYiYwrKVQ6kPoFETOdjuuIsI6mem
         Bi5xovwBSowmypLTurB+CkbRx9qh3WxPgcPNvr5so7kFdSd2vvcMUCeVn97ASmWNrChQ
         cSwfOaTzXle0/RqTaCuQ0w0Q1DKKMopuI40NNLqReWWbq18xOadLa+vmgkWhJrRh2FKw
         v8eoh4r0Y8nvo6/A69xV511tx43LDX7zLvhyfV+i2GxwSMJpRAxnk7pADefA3E0ebiJu
         0yVXy7Y94pnkY/5XdCjbQxluUxHp85ywrUaT33UI1ApLksA/TgyUt/fkdWKTR++iy3vd
         rSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjJ5ta9IKA8jR2kaX9oA0422T0wdQ3ejzbVi0mmy3gY=;
        b=ZUzZD09+fluHtU2wAIWFJNHTRdeN3GtM9OOQs+R2cnylTdtoEi4q6ElxeMDJdEtQez
         rPOH749nAlZayXPGIRp/DPURHFL34jOPJHd3UoMkWAYcigLSm98XDDiikqOz9DbfiPxz
         tbw4ZslDm28djzAg7+hHlRZUBze/opiF/LWSbKwxSQi8zEBL3rDn7NjbbKd3P18GUPX7
         Px0ML8mwmBMijqDw6Jt4rTJS7PeN4Vmnyw0kwxJo2HmS4ROQnhEap7R/lc4D8k/Jrf7M
         OJZK4vpQeTnP8/rm+R+fztz5uxreR0uPSTP2vVGh/Y47/9xqWKec15drOMGJX5//8uXS
         pI+w==
X-Gm-Message-State: APjAAAVL6j8pNGHa0V5wlkbLSRHVmY9YgkAsInyS1A51ECQ57TiZ9n/2
        3ohOR0W0uqp+rKWehdzSocPsefuk0ItMtw==
X-Google-Smtp-Source: APXvYqykWCZemR36Iw4gbTc3bX1fIgkthgNZDqnKBRtnioIvv/pr/QlSqFOd4RRGVS20efl4nuQnBg==
X-Received: by 2002:a05:6000:1181:: with SMTP id g1mr12719998wrx.131.1574685111706;
        Mon, 25 Nov 2019 04:31:51 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id w4sm10257553wrs.1.2019.11.25.04.31.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 04:31:51 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] mesh: Fix test-join to include mandatory VendorModels property
Date:   Mon, 25 Nov 2019 13:31:40 +0100
Message-Id: <20191125123142.25599-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191125123142.25599-1-michal.lowas-rzechonek@silvair.com>
References: <20191125123142.25599-1-michal.lowas-rzechonek@silvair.com>
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

