Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC75C74A5B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Mar 2023 21:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjC2VJz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Mar 2023 17:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC2VJg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Mar 2023 17:09:36 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0439F
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 14:09:36 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k17so7438124iob.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 14:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680124175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5gAEQBgCAmrDCYhK9Tm1iY+TdGfsp+0qEGPnEFs/eo=;
        b=o9zQ3zbQu2+wfGBoEvpj4OgbeUwLYRa4kIEAW6qrc6KWnZ+bnlepBwJi+KPnD9brW8
         W6HctAa1qNHty+ikphF+DQNf4O5Tbs7ADBrHpySealG1ASGc/AQBK5f071Jentf0Qj0P
         Sjc3Vb6efTdgiHlC8mc3gugxNHrZEZtdUJXdtiuGvuCN+QRWaYwxiWhc9NbZnPQYzrxq
         zbUPG+lwCZl1ErhgZAJwcqEwZLhVGTMbzWmasdfUuAxXOQNjkq8yQ1J7trkpWXOKxYfT
         Yyq3YYvNwva5pLxxQVJmKBJKwGAEdOeg6bv3jnMGATlspbhIXQjkLSTyvYqPc9W+sF8E
         O7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680124175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5gAEQBgCAmrDCYhK9Tm1iY+TdGfsp+0qEGPnEFs/eo=;
        b=sMU2tNsLggunXrA5SLwhyK9TAyI0zBFUSLj93SWPHIJu+Ei74WVU+siwpj4GFFTW5R
         dUoNKzLmI9VUpYAqJJSV9uN+ue2vTgLpUlmI6YJqG+OqyaPmxB16tab0EZjuYgdinLVI
         GI1Pp98z2uUTimXT4VztK3Nq8DHDaXmrcO/YlE7BZr15u5ty7TM4g+Ca46ha6OEuZX2K
         HobnAoT7tBCLCwYNcVviPXLpwglNsToe/u4G123cq9fXZV1J3TpCcRO9ozuEd3kDoYL2
         Ac7KEoMuy9NGNwBAYddZdc8I3Ye9jV6bLFHHsawxR+SSv3sK4q8YzDBWGkDHvVBASnsY
         y0OA==
X-Gm-Message-State: AO0yUKXHuHCaIqz0yM8pwHK87xLQPtW2uyRyibh4hi0Q/CTxnNZYZT0M
        nTZgJsDzE9OFkZtX61vx4qNOpdiIb3hzgA==
X-Google-Smtp-Source: AK7set8gNO9GN5i4rCRUjnzPJUVGnCpJ3CLOe8v7IFXIgxgI2ZYL6CYizlvJhgQCMKgcJgwyYbV1EQ==
X-Received: by 2002:a5d:9e53:0:b0:753:13ec:4ba with SMTP id i19-20020a5d9e53000000b0075313ec04bamr16759715ioi.4.1680124174832;
        Wed, 29 Mar 2023 14:09:34 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id 71-20020a020a4a000000b004040f9898ebsm11009631jaw.148.2023.03.29.14.09.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 14:09:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] bap: Mark devices to auto-connect
Date:   Wed, 29 Mar 2023 14:09:31 -0700
Message-Id: <20230329210932.537019-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes devices with BAP support to auto-connect once they start
advertising.
---
 profiles/audio/bap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index cfe6854663fa..464f365a93bc 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1352,6 +1352,7 @@ static struct btd_profile bap_profile = {
 	.device_remove	= bap_remove,
 	.accept		= bap_accept,
 	.disconnect	= bap_disconnect,
+	.auto_connect	= true,
 };
 
 static unsigned int bap_id = 0;
-- 
2.39.2

