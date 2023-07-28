Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3798EC0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 05:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjG1FZQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 01:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjG1FZO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 01:25:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D5F3585
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 22:25:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e619bcbf9so2181276a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 22:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690521911; x=1691126711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SiZZ/7Etnq+ZDddbtBFt7mv3Et8wZumrq/RWlKglnp4=;
        b=CEEub1hxlhmMY+etazWwOCrT+1ZQHhULlSA4Iw8PR1RBD1Vl7fxaUh9yUl4Dci7NFQ
         XNxRC9HQZ+DmfzxTrO9r4DStGXRzsMhRTQkJKOQyLe6a5WW6xfnrcsJe8L09VaFIIVhq
         XqMqfz11+RA+QHCgj3Q33vkPtFM7VMITyKznQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690521911; x=1691126711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SiZZ/7Etnq+ZDddbtBFt7mv3Et8wZumrq/RWlKglnp4=;
        b=SrsuRmdL2hK4qq7laYxwh5qfiGD2gKW5jVQnb+HHHTT6LeYhkNWk6V7D4nDfw8EC7M
         RY4Ecoh4yfqM6yApOYaOulYz3VuoGdWIDOUQljD6dNhTqnRT0Ui758EmEeinaOdUoTUg
         J5E/khithyG9iD2VluzIN9AmjJGotu/MzhdlY28wo16aswGhvQVD4IiYmDe1jxTTZjXi
         yz9o4jl6QWaKdn4cncKshotLn2dWae86G4KVw9mqzx5bD6Mdz5J11NGkSau6bkqThLMG
         obOxLLq6gqYKBLiGer1LhuETfyvPOtHwsIo2XGgt+UoK1g/zg2L281nTc4K1inCF8KQ3
         ZcOw==
X-Gm-Message-State: ABy/qLaeXjHD4I5ttaAEf1NuIQpaL8IzYZ21QzT0/7L2GRoYXea3F7Wx
        PlSft6MMIdCnVjxf8bWBD/P0pBH+dR6rbYp0ftU=
X-Google-Smtp-Source: APBJJlFoQ+9SaBXEd+nPialnipYyv7u5TPmh4YYxHpVkXn6G3ISOS2Abj/2QLnwNOtrC9Z8kcuDcUw==
X-Received: by 2002:a17:906:142:b0:993:f497:adc2 with SMTP id 2-20020a170906014200b00993f497adc2mr1302504ejh.18.1690521911643;
        Thu, 27 Jul 2023 22:25:11 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:353d:c2fa:e0df:3251])
        by smtp.gmail.com with ESMTPSA id va16-20020a17090711d000b0099bc0daf3d7sm1600545ejb.182.2023.07.27.22.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 22:25:11 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 0/1] Adapter1.ConnectDevice
Date:   Fri, 28 Jul 2023 07:25:05 +0200
Message-Id: <20230728052506.582394-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I added some minor addition to documentation and also I tested calling
function via DBus in parallel to same device.

In both case of BR/EDR both DBus calls will be pending and they will
finish at same time when Page Timeout arrives or connection. I think
this can be considered as correct behaviour.

In case of LE first one will be pending and second one will get
"org.bluez.Error.Failed: Connect failed" immediately. Later first
one will timeout.

Simon Mikuda (1):
  adapter: Be able to use ConnectDevice for discovered devices

 doc/adapter-api.txt | 2 +-
 src/adapter.c       | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

-- 
2.34.1

