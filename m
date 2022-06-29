Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3C3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jun 2022 22:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiF2WRG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jun 2022 18:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiF2WRF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jun 2022 18:17:05 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74EC36B6A
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 15:17:00 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i17so11184147ils.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 15:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ty1dutQWll7caz/do7lUh2Yq3BaAXzKZTMcnqgfOBKU=;
        b=YbceC03Biz33YpLVMra/ZVQVops4yXyNYdH5UtKayEQQ1aihPkdHue/xH+KNuhx6A/
         0e1NsCq9TqAB7JV55M+YyaVKtAMenFkpIUV5LcAbR+lOT4+88WF6ljLUCqlpDLy//9aD
         wJHFDQWn1ideq6GAUnPWRKo2EmHMG7fHEToBqacF0rLL9zCwD+hdb12pokVUc4SMovTl
         hesOMZLqNtOZQuh6aNVmFxQJTCFSl2xI0pU4SehCVv+nPDqk0KJihFtAL6JBdCb77bFY
         GsTPVWeMG85a+QE59pgTRZnY4KhBYXoOb9PV63Fien4O3hJYO38Y/+gn492vgEHugLUQ
         9VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ty1dutQWll7caz/do7lUh2Yq3BaAXzKZTMcnqgfOBKU=;
        b=dGntYXgOH7m1eQcHf6Ngrjn57zPqa/osLqgS7jR6Vb8/HG6xW6cCpQBQ+DuKfb8gCR
         UJFh7xJtT0NsJrwQ1wDLi9bYS45P3i1gkb0Tkh3/VZHED7uom0ZzbJh7JtxENcccq4X/
         mPZV6tpSrJVJunCKt6zASCy6KHEzKZM4MdGSZmgwPz65FnM8gs5xMcL4AUPCobXkkVMn
         98U3EAZeM+vOJ++Tym3pBh+qkH0u3itP2H3S54taFN/68E+Ih7eI+10MdT5pDeHKWm1p
         y03ElkHJdnX+Gym0QXXRJW6PdaK2/C7CvF8pudcu2gOaQqPS/4E/2eigXCAjDZR08mI5
         NMpg==
X-Gm-Message-State: AJIora+HaC8sP0lorq6g0puh5NBUvDz0RdGz4IXf5vq7hpOrboHPMwpa
        I+R/6y6XN5m3Kf1hp+uG3/rhBkwsrho=
X-Google-Smtp-Source: AGRyM1sq/KhjRKjW+o9jnPQ56mXEqA/vNS20RuE2jH+OWP2l5FIkl16x/JkjooE7zTVrrRPXebaDTA==
X-Received: by 2002:a05:6e02:1c89:b0:2da:9746:c0f3 with SMTP id w9-20020a056e021c8900b002da9746c0f3mr3160221ill.298.1656541019852;
        Wed, 29 Jun 2022 15:16:59 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.173.235])
        by smtp.gmail.com with ESMTPSA id p31-20020a02781f000000b00339cb5b604dsm7821114jac.36.2022.06.29.15.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 15:16:59 -0700 (PDT)
Message-ID: <62bccf5b.1c69fb81.cd612.a403@mx.google.com>
Date:   Wed, 29 Jun 2022 15:16:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1237651889221985962=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,v2] mesh: Fix snprintf return values not being checked
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220629210237.63236-1-brian.gix@intel.com>
References: <20220629210237.63236-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1237651889221985962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=655171

---Test result---

Test Summary:
CheckPatch                    PASS      1.16 seconds
GitLint                       PASS      0.70 seconds
Prep - Setup ELL              PASS      37.84 seconds
Build - Prep                  PASS      0.54 seconds
Build - Configure             PASS      7.33 seconds
Build - Make                  PASS      1211.51 seconds
Make Check                    PASS      11.45 seconds
Make Check w/Valgrind         PASS      397.20 seconds
Make Distcheck                PASS      210.38 seconds
Build w/ext ELL - Configure   PASS      7.50 seconds
Build w/ext ELL - Make        PASS      1182.57 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1237651889221985962==--
