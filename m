Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B204C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Apr 2022 21:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbiD0VbM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbiD0VbK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Apr 2022 17:31:10 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8E5CEB
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 14:27:57 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b189so2292569qkf.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=1LmE7jhsW8ngx0ACvHC9sfyBSR5gbh2It8LIlDdkG1Q=;
        b=RhCUWONBloRmTI+n4060IOYR9KMfR5KfcQkRn3fX6QNO5bAnXeMcq+bkPmxULQoXuK
         9WQOXlCg5gPOgklw4hgvlKMb9l5kzmbF+zu2MTQSVlIxU/7VivW9UVqHKaalpl9T+A/c
         Zq1L/2Ua0qPFL038SyARqSaVw/3zOAXvtI4jnNjwoeTd6gjVcFAPCzP0ExHafM/vULwu
         LGNIeyQrestA4rQqLCv6T5XCrIT44lCxr0Z78GI3cRnu2+aGcdSEzG2agyrNnd0j7wCl
         9kMHvHLraJ8AMzJrjp2nZeE6AKy5SmBi4SdNVr8Ar4flaZywR6n+rzmh5KWdv8oiYvIa
         dtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=1LmE7jhsW8ngx0ACvHC9sfyBSR5gbh2It8LIlDdkG1Q=;
        b=4twD7Pu2lUcN2mjuV2woAT8vIftHoIPVH7R5l2V0awFa+5mENJ2OxN7/Tw88gJfj3A
         Zzk7KWbARjB/Ar3rHQlYsB+DtCHYx1/xCK5zhKTqfEK9gIsF1e17EZPcRPhVf+5Dyt8h
         mXuK+mi0biw8FzuacI8ann1czG8zi1TIXB9gH5j/SDVclsddfqZKF5QipQC92nBw4ONz
         +oFjkO/uL8fJ8V4Mch9mXIST7rtgKIHimdM3XzrZfS03nzRHHi31YqMLcy2wxg0OXM2K
         PCF9XZv037GEipnfJDX9/P+00ZIke2MY65jsJOf8Ij3ftAXydi/KynGpgZjhWAPtpTiy
         ZQ0g==
X-Gm-Message-State: AOAM533Qnemp2P1fGeSFdTYYpWN3cBwlDLecUi/qp0mqcxqfTOJeu6ny
        aevH5+YSoU6sVo+4kbHOtx9DySoeg9MPkw==
X-Google-Smtp-Source: ABdhPJxXz2H0le8QsCR0rZsDE9KRo2xjeEIBGP1SR/CSwPA49azevkfw5+pmbhGNXEq/ZMKeDxQp3A==
X-Received: by 2002:a05:620a:1a96:b0:69f:4352:fdb0 with SMTP id bl22-20020a05620a1a9600b0069f4352fdb0mr12022776qkb.143.1651094875598;
        Wed, 27 Apr 2022 14:27:55 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.70.142])
        by smtp.gmail.com with ESMTPSA id o15-20020a05620a130f00b0069f9d477f15sm448130qkj.113.2022.04.27.14.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 14:27:55 -0700 (PDT)
Message-ID: <6269b55b.1c69fb81.90c3a.347b@mx.google.com>
Date:   Wed, 27 Apr 2022 14:27:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8351802082035384199=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] transport: Fix not being able to initialize volume properly
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220427201957.1004671-1-luiz.dentz@gmail.com>
References: <20220427201957.1004671-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8351802082035384199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=636348

---Test result---

Test Summary:
CheckPatch                    PASS      1.46 seconds
GitLint                       PASS      0.95 seconds
Prep - Setup ELL              PASS      42.40 seconds
Build - Prep                  PASS      0.67 seconds
Build - Configure             PASS      8.41 seconds
Build - Make                  PASS      1343.00 seconds
Make Check                    PASS      11.79 seconds
Make Check w/Valgrind         PASS      439.80 seconds
Make Distcheck                PASS      226.66 seconds
Build w/ext ELL - Configure   PASS      8.55 seconds
Build w/ext ELL - Make        PASS      1336.88 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============8351802082035384199==--
