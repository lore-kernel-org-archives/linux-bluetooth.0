Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0279DC433C1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Mar 2021 17:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D5A6193E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Mar 2021 17:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhCZRJD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Mar 2021 13:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhCZRIf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Mar 2021 13:08:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E9FC0613AA
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Mar 2021 10:08:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso4540394pji.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Mar 2021 10:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=NBNFp1XghJsp/OYS6m5qEuqwejVnlT6RAmtsn/mGH+o=;
        b=mW9anM2Q+RxHIM7jW+X5ouQs39cvqedJYNtRyGmNTMutF7iEQfCeLuf+8X5COHce7i
         PzhDWjIG2Roh/laVf/KFEq2d6/6iUZrkwLp8gy+QSb30Ez3PR1EyC9+jJxb35OlZ5Pjw
         KeLXXNAZ9nH5iPI/y/eoI55LKMaR2xdvKZgf8l3N46TteoWR1bUixKWGrLGlDq3whY7n
         FagomB29AzuBXOZ95rwAwdkE2CILu8ZuHG4aAwS98txiW3cKK+qpd/d4GSKMhkI074y+
         5gYL3SGXhnkRpY15BMF1bY1j21+eWqgLSbEkUmUx06z/fSTGzFBYHxvdjlVpdhDqNGaY
         h+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=NBNFp1XghJsp/OYS6m5qEuqwejVnlT6RAmtsn/mGH+o=;
        b=jv2bfpZ2BF3Jnvvvz5PXSovBE70TqLdiJVlD+ekWSFAYDS0FajinuvN29nR+7X5sxs
         XxUcDffE1HwTlaSAWOXfvofcIOOpHeUEyFtMjSNH0Zvn2tbRNB8S8SpuMtfR3ZKHJKm7
         e/pyVSp1TwXBkw7ZvZJLeox9lYkFdSWIsH1sn0kNVLJLgMkVsyN9w4JnW4MmVIDkEd8g
         Vdf9hWO5aX70/6eK3hG9ZyIaMo7g71mHfCKPto1zbYc+cS4nNLL/Uf39BNC+4Lh595fj
         OrKNRv+xfrq4oAZgKw/Tm0ovqUgOAxApYFd/b0QtySeekOMl6guYLuGjjbDGu8cc35/K
         4mZg==
X-Gm-Message-State: AOAM532hl+hFqUbsgQQL2xTMHkRB6nyJTZ6WR0L+hyH6ebuy/JYT9Nj/
        szRnQX++Ohk1XaZnGYnM4qZKqaMgRwQ=
X-Google-Smtp-Source: ABdhPJzLmiZLIyvtckJdSh5MqUgsCtPzdqWeWf7eR1JBIsYzUk496ZkB/tsuOX77eMp1BMxS9orPbw==
X-Received: by 2002:a17:902:7883:b029:e7:32bd:6b97 with SMTP id q3-20020a1709027883b02900e732bd6b97mr3690533pll.0.1616778514034;
        Fri, 26 Mar 2021 10:08:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.191.131.15])
        by smtp.gmail.com with ESMTPSA id e20sm9563930pgm.1.2021.03.26.10.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 10:08:33 -0700 (PDT)
Message-ID: <605e1511.1c69fb81.663c7.7dce@mx.google.com>
Date:   Fri, 26 Mar 2021 10:08:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0231024121487102903=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yudiliu@google.com
Subject: RE: [RFC,v3] doc/mgmt-api - Return connection direction in Device Connected Event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210326094845.RFC.v3.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
References: <20210326094845.RFC.v3.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0231024121487102903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=456343

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild: Setup ELL - PASS

##############################
Test: CheckBuild: Setup - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS

##############################
Test: CheckBuild w/external ell - PASS



---
Regards,
Linux Bluetooth


--===============0231024121487102903==--
