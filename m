Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC411C6FD18
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Apr 2023 18:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDVSaW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Apr 2023 14:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDVSaV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Apr 2023 14:30:21 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7D41726
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Apr 2023 11:30:17 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-74de9ce136cso154235685a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Apr 2023 11:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682188215; x=1684780215;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cV+EueSYRO3LilKf1yhpNiw81pJDdYdfqRSVESUvxO0=;
        b=TZSb5sId3jEFbEuT2Cp3E1B20q4DghUh+dmsi/brlz/hG9xlS9Ym2jMQvjIvyIfCwK
         T1Hu5KXlzeKEKgMkl/uARyHzzpylOzJEid2eZ1BON9bokiyAtFPlfmClcKIGU1EjQbhv
         fpKe+fGt/UWXY0UxcdOyibXcgDGjx3KG3l/QknHeFENV3y8A3wAue1698/YmjiSkJxJZ
         y5BrzSfk4tb4aqyguufABWuaZnk3/FRu56ei25V2O0oUQKAwnVs8DHfhk16PX2/vegHK
         7J3/P+rc1J9gAGuIYWG5jCwSG92Z0njwJpGbMKXZ1tnpgQiHxzoWzJJdnDmW4OGvg78i
         EFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682188215; x=1684780215;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cV+EueSYRO3LilKf1yhpNiw81pJDdYdfqRSVESUvxO0=;
        b=aBJSB21ITIiEz/wzinJEhwj+M1isItf+8THA1yl5jFrhrZwRsO3/gmQSPnAlmMrJZv
         tW6pV9rJKLM97BgK3zzXab4Pr4Vc1ey4S6IOna+NxtVAUFJYlUiusM9hw6q9kATgFDoD
         OGA0Y60QZaNEY8nn83husH7AaX0D4MPngU7UyHbO7SdVUiWIp/1y2sbG9HglKqD30YFt
         uJmIJeCmFuWTpt3TheROW8Nqxgat9ZsbgqIis6vFeu06cujSG/SX8vSOq8u9glKIOkld
         MkwrQpyyuC5Q9gmsYZl3Wjv0QR4EHxdt4O2x8sM3fYOzxRyczsQ0j+T2ioDIm1PBx5BW
         rWgw==
X-Gm-Message-State: AAQBX9esNUjbhZrIC7nbEebaNf9HplIhfjChxKHViqeuwKx5dhlWXCvC
        YJZpoYdYqg1Fa5BX1LyVU70YX8GwlPY=
X-Google-Smtp-Source: AKy350Y1lHlM/b50VQk32MfheivYvV8UYl9RGeemWZ0Wj8wjfMRlHiNhnPc9LUbFHMtKf8W8fllEPQ==
X-Received: by 2002:a05:6214:21cd:b0:5e6:1bf5:1ae0 with SMTP id d13-20020a05621421cd00b005e61bf51ae0mr16823928qvh.18.1682188215685;
        Sat, 22 Apr 2023 11:30:15 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.209.218])
        by smtp.gmail.com with ESMTPSA id b19-20020a05620a089300b0074de92520b1sm2276333qka.83.2023.04.22.11.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 11:30:15 -0700 (PDT)
Message-ID: <644427b7.050a0220.e004e.8c9e@mx.google.com>
Date:   Sat, 22 Apr 2023 11:30:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7265463807797241890=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] shared/bap: add function to get location from PAC
In-Reply-To: <3cc705b0fa000b4cfc5071ae13f4c0fcb31bfc25.1682182441.git.pav@iki.fi>
References: <3cc705b0fa000b4cfc5071ae13f4c0fcb31bfc25.1682182441.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7265463807797241890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=742421

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.69 seconds
BuildEll                      PASS      27.20 seconds
BluezMake                     PASS      988.66 seconds
MakeCheck                     PASS      11.58 seconds
MakeDistcheck                 PASS      152.08 seconds
CheckValgrind                 PASS      248.73 seconds
CheckSmatch                   PASS      336.25 seconds
bluezmakeextell               PASS      99.69 seconds
IncrementalBuild              PASS      1748.36 seconds
ScanBuild                     PASS      1055.93 seconds



---
Regards,
Linux Bluetooth


--===============7265463807797241890==--
