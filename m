Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B55C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 01:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiBJB66 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 20:58:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiBJB55 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 20:57:57 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE5D2BB1A
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 17:51:12 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id i62so5606951ioa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 17:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=df435ELITloi7LgF9lW6gYzHw/chX3XoFGS3/P4NXiM=;
        b=fUNddVWBkIHZiMt3LUAtrBkUf0Ab5MclP+GBD19zlIavdpSIoz2LgRuoOqgDX7dbMG
         TDgd49JcKONiTGV0rEbJkBbKDL+HjttVU2mZoMESj0k0ejkRC9r8TtuYx59a1xJJg0yd
         W7UJxOVqC/h66zX4MKmjTU1fyISBeMMa7ica+egdbpbhruXzi7DvT4knieFeHF+bQq/G
         MHIjkJna+68Pw7AWJ6sHhEqZ1sw2JGPH4hDUsM1cBixG+1x+7CgnN9ZoR295Fogs09cl
         ViaL79OHnHSfgvJC7H7kx42VFhf3RhUutLWfZAypJ7KEYEqQN70YgNsbMu31WYjpko7X
         kjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=df435ELITloi7LgF9lW6gYzHw/chX3XoFGS3/P4NXiM=;
        b=PyEUGro87Fj6o2+1wI0vOzUkI8ToOhn6U2RbpFkhyt9TUAgdPHaovhTlRdbBcXEhs/
         LMgETWPFfwHA0DeNvzPYRYtEYJ7JpDJM8/eZE3e/27ZYs5UJWGBl7mFtW0b2jFkjguWk
         RQ1DoGGOgkyjRkyYm2OYi8SqAeRGy4o4RZMXrgvs7fk7G8lhMEPtv5Ve8p0bm6zCCswH
         SUee3oKdlMY3hshpgmgyPM/1OlL/kjXVzfg0TTjRaINnNun37o/Dhsx2rMsZAHsAOT26
         vS2qXhmLo/OVeZZELYNexlRrOkZEM9UPc92n84dL1/3N9FAyBz9uE3D20Ve0nShKLnr/
         f3cg==
X-Gm-Message-State: AOAM531zZFGh5V3CPlryAjJ4P1JvLdI7qbfdlXhIFjQp9tK34Ar1xn8b
        FDK2yYZuaZ8AFdH9HgXi7b5L0qHoe4uxYg==
X-Google-Smtp-Source: ABdhPJyr0Hl/rXSQRljBjJUu/yK8mPFu6rqej2mY95jJwVBw99vFB8bT7KuIzjB9nWMJ/pOWFcvKvw==
X-Received: by 2002:a63:c156:: with SMTP id p22mr3920640pgi.215.1644451745600;
        Wed, 09 Feb 2022 16:09:05 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 13sm20484555pfm.161.2022.02.09.16.09.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 16:09:05 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] uuid: Fix crashing if a NULL string is passed to bt_string_to_uuid
Date:   Wed,  9 Feb 2022 16:09:03 -0800
Message-Id: <20220210000903.162318-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210000903.162318-1-luiz.dentz@gmail.com>
References: <20220210000903.162318-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_string_to_uuid shall chack if the string is valid before attempting
to access its contents.
---
 lib/uuid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index 3d97dc835..1d2e1f732 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -251,6 +251,9 @@ static int bt_string_to_uuid128(bt_uuid_t *uuid, const char *string)
 
 int bt_string_to_uuid(bt_uuid_t *uuid, const char *string)
 {
+	if (!string)
+		return -EINVAL;
+
 	if (is_base_uuid128(string))
 		return bt_string_to_uuid16(uuid, string + 4);
 	else if (is_uuid128(string))
-- 
2.34.1

