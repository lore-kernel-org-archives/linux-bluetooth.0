Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723BDC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 23:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C22061157
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 23:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243392AbhI1X4d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243367AbhI1X43 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 19:56:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4986BC061746
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 16:54:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id s16so438860pfk.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 16:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PcYqL73IZQs/64HOOwv6U7J6k71cKGFY5XBYtlup2ek=;
        b=iXVXDQAMcBen1czXYR1z/OW1K8ykuRfLtHz/GGB8nL+rU+dF/N8RTXFJHam5VpzKLX
         JYPq7meqV9UpDcy6PGBKvOjGourfJJrCajAoRGjjCmKFRXP7QrMcgfYPVX8hl4FOZzad
         9LBMyhRj1+eZIkwATwKxE97wlR2OTNj+9GeIzG3StHUpmPAVUVUhK/xsd3qN+CC57XtV
         SSPVf2vVv76xfCF1UOGzHyGiDRBEOdkxGJ43eK0X1X28KztxuhZdVM78OQpX0RP13q8j
         81eQ4bMgnM7bSb3VvYbsn4chyG+bvvoQppWRdYgU/PCf6wTYtU+Ovy9yjmPOZAUKNoeW
         tkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PcYqL73IZQs/64HOOwv6U7J6k71cKGFY5XBYtlup2ek=;
        b=rwXmCyDSvQlv+9MtqMsgrY/mL9WiZaty6+Z02q4Bcf2/PJHeRTEOGWwynn5cDOqkhZ
         sVJ5iQdDAaMJKNbkCd4LZGxWvWOivz7fHPY6Ywo8IHF03NhJpzEv/FkOiyp0ttpiGWJn
         1rrEBL+DRrhNH2QrC2H5S2bHAXiP/JVq3HLS+1ZlJ6iYtGaJviXT4lEXixBywLnvwNup
         0F9++oVIkgA5e6AaubC3PDUgG5ajdw0lGgvdyilQeNffKcASUh9KlNurDrBkuXwMU4PZ
         bNLMjBZdgPGV5ooC+0EIkJK4Q/ES96qVgJHIRA/cigEmAN8G+FHtlEOj0xLMRIfi1QWN
         t+uQ==
X-Gm-Message-State: AOAM531KNuwDHO9mvIVDqlHiucuGmaUI97Smx3q6puAXQTCjDWtzmPF9
        rP0RnKIC66XzIgolbMumzu4798Mm9hU=
X-Google-Smtp-Source: ABdhPJwd05dD6eGZax3cCMQ87UlYVer4WXnklwcN25SJomKd31By+6LniyDN26RGGLfG4dzz1PgDDw==
X-Received: by 2002:a63:1d5c:: with SMTP id d28mr6927641pgm.143.1632873288420;
        Tue, 28 Sep 2021 16:54:48 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o2sm3553139pja.7.2021.09.28.16.54.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:54:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] gatt-api: Add MTU property to GattCharacteristic1
Date:   Tue, 28 Sep 2021 16:54:43 -0700
Message-Id: <20210928235447.3077055-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds MTU properyt to GattCharacteristic1 which can be used in
order to determine how much data can be read/write using non-long
procedures which sometimes is the only thing the remote device
supports.

Fixes: https://github.com/bluez/bluez/issues/199
---
 doc/gatt-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 04789c6d3..120b23d1a 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -281,6 +281,12 @@ Properties	string UUID [read-only]
 			shall be used which will cause the allocated handle to
 			be set once registered.
 
+		uint16 MTU [read-only]
+
+			Characteristic MTU, this is valid both for ReadValue
+			and WriteValue but either method can use long
+			procedures when supported.
+
 Characteristic Descriptors hierarchy
 ====================================
 
-- 
2.31.1

