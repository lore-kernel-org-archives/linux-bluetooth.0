Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7641C4332D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 21:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881822076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 21:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKu6ResE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCRVv2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:51:28 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:42923 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgCRVv2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 17:51:28 -0400
Received: by mail-pf1-f182.google.com with SMTP id x2so194969pfn.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2020 14:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MPfZ6Ur90/9wCSGmoi9z3v0hkVuFY/fVXq73vDSGlUE=;
        b=tKu6ResEkrxWegWROAp/ZLoohDnRUUNx3g2fdEXjRfwTlr9TTe9hQkYJKJW6F+Ygdh
         GVtZyIHHKgTHasL26gXlRmNeG/zadwwJPiuIuk5jjgYf6E0E2wSbfsImodxXwW/wXS7+
         CtWhx27+oRTBGKLjJwCw2VNHI600NBJxeu7wlRsC/Avqi9fN15SlfQqrzl++PQJWxwkt
         ZO5/jqmX1/60FmU1W3aU9S8jO5PqT7shzzb2Dx61cpv0JWm4x3O9X2JnC5/Rpon3nP5E
         LSIA9S1yM8uAamexU9hAe+z0YEzSLJOYIjIMDxUA+Em3pFooEDEORDPxgrOUbxng+wfY
         qdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MPfZ6Ur90/9wCSGmoi9z3v0hkVuFY/fVXq73vDSGlUE=;
        b=ZN388xwUP4/XmPyKKQqL15VhSfynq6Mp/jECK2xfoxvI7zQ0zKb6191Ee2yt5t85cl
         HM77XswRhRHPisFMOJAxRrqAEPxx/9cUxPfO+tR3/4aPYP4fCr7f++zPaUji6C74MtsR
         wkZAjtXmVdIg586ZJfZU+pFle0fQHi3f/2UdRk5CA3eT1LVIplnP0iT3jpMsGftPsJGA
         YrVQ8dFv/2RbF0RkfomHgFYgbrjGj3RozrKWp+0ylanrHXFYqNI91GsiK1JR6QPjDmmp
         moCxhH3gtos7+QuylZdht4Ycd53Dv0aZplhsaqP+nxjxZ2h+s/OV9Zok4Q6Sy0+Aqx6S
         yiSw==
X-Gm-Message-State: ANhLgQ0XmHDvhfCbZojdudNRxPXPaRX01MdhhtUE5Rk0OzCX1KCIN6Do
        gzhFN85OJwg3D7loLm/LlTFPo1Gs
X-Google-Smtp-Source: ADFU+vtkYY/DwSP3hwTZLiuzC5Nq8nHkBolU2YfyCdL63s5XKP0DEsGf4Ld0SMfx6ozuEVEv+wS6eg==
X-Received: by 2002:a62:15d3:: with SMTP id 202mr386765pfv.231.1584568286123;
        Wed, 18 Mar 2020 14:51:26 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r13sm83709pgf.1.2020.03.18.14.51.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:51:25 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/6] lib: Add definitions for Enhanced Credits Based Mode
Date:   Wed, 18 Mar 2020 14:51:19 -0700
Message-Id: <20200318215124.21880-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 lib/bluetooth.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index d14217eac..121010c63 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -141,6 +141,15 @@ struct bt_voice {
 #define BT_PHY_LE_CODED_TX	0x00002000
 #define BT_PHY_LE_CODED_RX	0x00004000
 
+#define BT_MODE			15
+
+#define BT_MODE_BASIC		0x00
+#define BT_MODE_RETRANS		0x01
+#define BT_MODE_FLOWCTL		0x02
+#define BT_MODE_ERTM		0x03
+#define BT_MODE_STREAMING	0x04
+#define BT_MODE_EXT_FLOWCTL	0x05
+
 /* Connection and socket states */
 enum {
 	BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
-- 
2.21.1

