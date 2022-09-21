Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF75ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 21:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiIUVrC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 17:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIUVrB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 17:47:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD28857FB
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 14:47:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fv3so7903937pjb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 14:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=5GZxcBiJGKp47n50Mm9YXlGISV8AqMdHecBdqqmUSeY=;
        b=iT/tnWcwTflhlhmc501i+b3k2EJLBZNQOQIPvya9GMVSsD8Hno5J6oK8fM09NumerT
         YqA2eOruVVpK2wpVQz3Y8Dzr3Ygd4ffZC+KZcaJypZPXMebakbcM0l3Xw+uYkJeM6GFy
         p/FDxxI/JNW8kpTL+NcD13bsgwbARFEsykIBYFc+QExDHtf2kRSyW4OiXQnEygvhH7Z5
         HUkn+ncoPJD/ZqapX45U3TpOu6ZmviZVEx8sazav4qbmzoyTPSFNLk4KlXK6T8AesGgP
         okPj/LFUD4M+uhCs/5KWV4uyO156G9qgDlEpOyb4L/z3sgWxJTXFuCNhF5v2330rA6Rw
         zmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5GZxcBiJGKp47n50Mm9YXlGISV8AqMdHecBdqqmUSeY=;
        b=fHZ8nSpUy0E8JEWz3XAc4aYHsw5cGMggTqwJd9eMYEAih2LPvqxqHWw7hm7YxHIvVi
         HOJgw6lLP0+VyKZMA+pVtTu7Htc9hntmHzfLTAm7nXWA7Ty0DnZQtX1ai1P6u11Q2M7+
         eqRT9k0Rqv80FFxNqOlLpXXlpYB6nQb5qDU1eBLGr8g3sLnpnqRjW/ubCLdx0jQElIya
         iYgPQk0CxQvrZ44sOAm21/orRZpWN8GmW+uDyYdBVnMpRxqolmd+VJ2dfAOCHqbvIUdE
         qBDInkjizeG3STvWnXjKeqgqqMKjvz00KzzF4v5kP1ZVGYvrpHBFEWm1wQlmPnhj+83l
         +uYg==
X-Gm-Message-State: ACrzQf2TEwGlmk/57cSNcIIYhLkPushY5xrQNcDsqpeC9RDl9viFJWqZ
        okAIjI5rxfkmaKMbtKr4TCuRjI7nPAM=
X-Google-Smtp-Source: AMsMyM4S3efHiaJSIt9z9KM3om7BT9+50tAdC0uXXkjh9rU3Nf7hgduMgbJwc136DH30JNfv4wj9Fw==
X-Received: by 2002:a17:90a:ac10:b0:202:9880:4cae with SMTP id o16-20020a17090aac1000b0020298804caemr176673pjq.173.1663796819540;
        Wed, 21 Sep 2022 14:46:59 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902e84b00b001782a6fbcacsm2506526plg.101.2022.09.21.14.46.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 14:46:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] gatt-db: Check if permissions are set when adding CCC
Date:   Wed, 21 Sep 2022 14:46:55 -0700
Message-Id: <20220921214656.2241730-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220921214656.2241730-1-luiz.dentz@gmail.com>
References: <20220921214656.2241730-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

CCC shall always have some permission set.
---
 src/shared/gatt-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index d3b5cec1da86..32cbf6cdc38b 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1066,7 +1066,7 @@ gatt_db_service_add_ccc(struct gatt_db_attribute *attrib, uint32_t permissions)
 	struct gatt_db_attribute *value;
 	uint16_t handle = 0;
 
-	if (!attrib)
+	if (!attrib || !permissions)
 		return NULL;
 
 	db = attrib->service->db;
-- 
2.37.3

