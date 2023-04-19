Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CFAC77B75
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 11:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjDSLtU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 07:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjDSLtU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 07:49:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA2D2D40
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 04:49:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a6715ee82fso35379015ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681904958; x=1684496958;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jkVY3fC+U2BKgKHM+dKgM93m8Sp/PCfZi6J89LstS2Y=;
        b=OH1HSr7EUMnDpxYFy3RM/p6PiDVY2aiV0Sktlf6/Vi5UV+Q12jgLKF+SF7sLt70OD9
         wKctE0MXD6yYWAk0b3+SEwIe61edn25nyNswcfKMEnCZr8EdDjB4zpsnFpmH4uOxpcoq
         iN/5uolWXQYGgpA5mrI6+DJomIICmimhzw41X5sD3jqSyRXriagI6fJgFK/pGKiuHjXX
         IsBEn4oczxQy0GyGJPwqJHFwJaRsrj8WQGedbzDWBKwkSKR7rt9hMpEB5POjn526euUz
         U8mYimzp2H29/xgEdKIApivZbKWQDHgOasPT+/4wEuLMK4gz5oQxYGn4TAATvPrUzxgn
         nNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681904958; x=1684496958;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkVY3fC+U2BKgKHM+dKgM93m8Sp/PCfZi6J89LstS2Y=;
        b=GcUUrt7tbFGeeMwQgFH/ZxLT/X6ltHOaX442FWEJdnw5D/dbJogMp1j8ITqwpFo0sN
         U11ERw0Us5cf6Hejxhj3y0f+ESl423OoHA1TbkELAEI7TLiFKZzxVNuKalVGEHk+cr3n
         qp9aGSjAjFcrXOAznLMANoLQYwsez/zJj92/SAgzMWgK+hxYmzfAoJ+MciJ/Em6/AYYZ
         SWgwZTSY5HDodNzFp5gdFB2rK/X3UYlGDQ1ExsUIaehvDts9bxTesCnqwLc5Jh3tvk2u
         8ssnPv5E+eqYrH0N2//akkzp/BTrSWxzABhY+MeSzqiqFepWuLHp6xumUKB8HMz1wC/E
         20BA==
X-Gm-Message-State: AAQBX9dcpEOyH/Ye1UDtFnijIkjcUKCYvuAmeaRJWeros1gj7Cij5ZS4
        Erk6BSPcdSG59N/tvXVjczwmbngotnQ=
X-Google-Smtp-Source: AKy350a2EpS89lHkmeT7CpXS7twL64/LENJjv+4K+ohIAiaf/Di0+Qv45HhFF+SttGITCXPchwNPnw==
X-Received: by 2002:a17:903:847:b0:1a6:91f0:f7fd with SMTP id ks7-20020a170903084700b001a691f0f7fdmr4631409plb.60.1681904957895;
        Wed, 19 Apr 2023 04:49:17 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.161.24])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090282c300b001a1c721f7f8sm11277428plz.267.2023.04.19.04.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:49:17 -0700 (PDT)
Message-ID: <643fd53d.170a0220.fb797.90ee@mx.google.com>
Date:   Wed, 19 Apr 2023 04:49:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6448157400858123204=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, aarongt.shen@gmail.com
Subject: RE: [BlueZ,v3] obexd: support to reply folder name to store file
In-Reply-To: <20230419101954.56002-1-aarongt.shen@gmail.com>
References: <20230419101954.56002-1-aarongt.shen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6448157400858123204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=741292

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      29.01 seconds
BluezMake                     PASS      1118.82 seconds
MakeCheck                     PASS      12.56 seconds
MakeDistcheck                 PASS      169.21 seconds
CheckValgrind                 PASS      270.73 seconds
CheckSmatch                   PASS      384.56 seconds
bluezmakeextell               PASS      116.09 seconds
IncrementalBuild              PASS      945.71 seconds
ScanBuild                     PASS      1236.59 seconds



---
Regards,
Linux Bluetooth


--===============6448157400858123204==--
