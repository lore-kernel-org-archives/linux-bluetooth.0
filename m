Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6283C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 23:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiBQXpR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 18:45:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiBQXpQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 18:45:16 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60515367002
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 15:44:03 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m7so7115190pjk.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 15:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IbGAC1h6wZ2Rtb7hj4bLmC7vwrTbHvpT1XKOfFl5ukY=;
        b=NT4FT0fwWdl0X3xCe39jhBdaVQqfEDgC3M9V8G+EgP1QRemWXA6X920CDLnviXHqCm
         DxpBvL0xydWQPq9LpTsTEbcau0AO2CAEWltyVCt7aE+xOJYp+aTcL+cXv/KjfKmqvrk/
         uM+SzbZZBUpfJMdPg97k47kgb23DMyHW7oMgzjRk/HAShGBkuBCke3ikjdYXIsDHWCW7
         /4k8k6BruxK6Ls4DCtIQOFgvWdnAa2Uk9vV0WelCicN+RgfXv3THRDusdYynyw5ddbqL
         ahloVcONsOkY3TTDhiKdseE/cFIKRnX36nswN54fdU47ikUZwcyUlhFgFsYpDHuODdEJ
         6rRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IbGAC1h6wZ2Rtb7hj4bLmC7vwrTbHvpT1XKOfFl5ukY=;
        b=lOD9S6DeW0I6stk/98P2KCj5MQd+dGMVUz8URLo1a/E1OM/RE2dymaTCeHBOsOidlt
         A79p4oZT5EKFONd9O2wFqjZ0/RGFNu0H8tqG1IR0RMe2wz1E6W61dlgXL28fqbFncYgm
         6i711hoqYQXC9YmS6SmdaMEndjt11bJ3EiP2w9zvkv73TF28MzQ2x3cJ/uhUcdnjZaMQ
         AIyENJaistqQ4RAMBqSol+8GFd6KhpYCrVBD5RzxrWfBWx8aXzCEQSwLGNjesKv4PiPT
         QeYwGA4bmgScVa/kZt5ygJkm6N54bzxkw0yFYY8h/aV0JNkNlOnv6lQZf2EY57Rwumc5
         499w==
X-Gm-Message-State: AOAM530w9VYdlhqIO1HWPHvq0aL9ddIGAtOTKRDvi9DrXmKMFIB+eTBs
        mrwqzTs3AnCo4IVkLFwikJZekG7Qg6lBRA==
X-Google-Smtp-Source: ABdhPJwElr+MlMtYoJhNQniM1MZCQlRXKMts6cDn4yr8bv6kWafSJvQ2YnQp93O5PnB7HOoVyofIVQ==
X-Received: by 2002:a17:90a:6e47:b0:1b9:1154:6635 with SMTP id s7-20020a17090a6e4700b001b911546635mr9742306pjm.118.1645141143834;
        Thu, 17 Feb 2022 15:39:03 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id lb18sm2840780pjb.42.2022.02.17.15.39.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:39:03 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] adapter: Fix allowing multiple adapters with the same address
Date:   Thu, 17 Feb 2022 15:39:02 -0800
Message-Id: <20220217233902.3093404-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217233902.3093404-1-luiz.dentz@gmail.com>
References: <20220217233902.3093404-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The bdaddr of an adapter is used for its unique storage path so having
multiple adapters with the same address would likely cause problems
with its storage as they would be shared.
---
 src/adapter.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 1551011a8..97ce26f8e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9807,6 +9807,16 @@ static void read_info_complete(uint8_t status, uint16_t length,
 			goto failed;
 		}
 	} else {
+		struct btd_adapter *tmp;
+
+		tmp = adapter_find(&rp->bdaddr);
+		if (tmp) {
+			btd_error(adapter->dev_id,
+				"Bluetooth address for index %u match index %u",
+				adapter->dev_id, tmp->dev_id);
+			goto failed;
+		}
+
 		bacpy(&adapter->bdaddr, &rp->bdaddr);
 		if (!(adapter->supported_settings & MGMT_SETTING_LE))
 			adapter->bdaddr_type = BDADDR_BREDR;
-- 
2.35.1

