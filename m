Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EEBC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Dec 2022 23:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiLOXoJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Dec 2022 18:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLOXoH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Dec 2022 18:44:07 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEAEF587
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 15:44:07 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gt4so798932pjb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 15:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LE4roDm4MQ1XOGW1E9kwnugqIma/DkWXvhq4dOia0OY=;
        b=CKRs1AascDnTsHLDPfUtFzfrhS3J5uR56EjBEV1c+NzmEJWbrPzEO3X3u8jgLYF4R4
         QllHpvrGoTdQ0tYGc9cr/c7RJk53nKD/sayLlSaulOoo9hxfzXYTGOiwj3+3twHBUgUS
         OsNA3EIzJGQMDxjda8TIfy5+ILKARcXRoUr2NiQMHK2OK3qANiTN6rW4yTXtJfrpStWk
         3DDLlI+KJPlHiwOZyuDI61MzKBUcujLkWxNxZQ3jJp/Uycdh1+6/XNFXmengllvCMe4M
         hht0cq6gKamqqlAmGA5QpZIJ4LRWKjX849UHh0jKML7Rp/oNQvHLLlv4Gpr/ILQeN0ec
         iP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LE4roDm4MQ1XOGW1E9kwnugqIma/DkWXvhq4dOia0OY=;
        b=1huxfSPFh8JkrmfhSXOGLH50w7D0X7u+KwDJppIHcYkBs73OkDqTV7EpdB6EIj+b+P
         B3HwSt3KkKThuFePzrH4QJGIjjIEgW7HeoNnkybytPlyqgEpRJnmTH5rHdLo1sNyQdr9
         MSNGf7/D4gVCAJMNUZ4cnCskAsf9GwCn4rYTcCB4+TPiVcK6QCq7aL/YMmHR9r1Sk0WS
         NwlLdwY9jSeqvcx7sLZ09msQ2MvZ7u8BZlxvzrT/BDi327sZ9zo4bEtYcBlAa7PNDYsF
         YVn/fN3epwv2EMpi7sBSiNyvapG5YIkA5B2N7udfdJSPsQSjl07Ya7DZ2gYeznExRjYw
         Ia3A==
X-Gm-Message-State: ANoB5pngd0nB0a4Uh21NuFpxaGAr0fn7p2EbVZCJjgAdW2ahFrgldp3r
        95K1+CuENdH9k9vaHXVKe0geM3+YWOwtcvxI
X-Google-Smtp-Source: AA0mqf78QvHIH3Dmkf9D1fmVCp6ityKT4jg52pqzd4JOonKdQzFFfZ2rYHzbdTY0eqbqplNd9YffNA==
X-Received: by 2002:a05:6a21:9186:b0:a7:345a:100f with SMTP id tp6-20020a056a21918600b000a7345a100fmr7472578pzb.10.1671147846364;
        Thu, 15 Dec 2022 15:44:06 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id w37-20020a634765000000b00478fd9bb6c7sm242887pgk.75.2022.12.15.15.44.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 15:44:05 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Fix not marking service as active
Date:   Thu, 15 Dec 2022 15:44:04 -0800
Message-Id: <20221215234404.2735181-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there are no characteristics to discover, or for some reason
bt_gatt_discover_descriptors is skiped, the service should be marked as
active.

Fixes: https://github.com/bluez/bluez/issues/438
---
 src/shared/gatt-client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index cf0d2e2b749d..459a44a6699e 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -725,6 +725,9 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 		goto failed;
 	}
 
+	/* Done with the current service */
+	gatt_db_service_set_active(op->cur_svc, true);
+
 done:
 	free(chrc_data);
 	return true;
-- 
2.37.3

