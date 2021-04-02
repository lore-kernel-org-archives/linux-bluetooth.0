Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C291FC433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 18:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D994610FC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 18:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhDBSyT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Apr 2021 14:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhDBSyS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Apr 2021 14:54:18 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BE3C0613E6
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Apr 2021 11:54:17 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id x16so2892115qvk.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Apr 2021 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=VVeasP7LIdoS91rh/1xlGKkQuZZNu6HRF34/9mf7KnQ=;
        b=MyPupDNGvRCyaaen63T0NfuWiaLaIw5cB4BTNXk7El0ntU5sY9ypteJQeDqI0MGy71
         +TALDHE/9pIdlAHGQJ/ZPbhvHID64ZaNrbufVk5PvdvWePnBtt/hK66u+rfZ5LCNYJUW
         klIvcuO/gx3krXqzGntXjfFhmrpWRwat/b1hYRv8Qb9CUOWfYPGJgCoXa+zV3WAPP1Yw
         AOYLqz3KHUg6Z5jh7IgiWD+seNg+NtWXMzxl3HNpmiEK2zMsAIJD++6XDVj05D0TyiNU
         WO/YVRV/EnTIX0EhD1jKQ66M/mWoOMcKdZqtV1t84vuSwe4WtFqgZBvT/YlfVbIkndIR
         4Ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=VVeasP7LIdoS91rh/1xlGKkQuZZNu6HRF34/9mf7KnQ=;
        b=rmR7GrNJRkc4mHyKppz70h5N6i4m1hUbvRAec0W8z73wgEF9Km/ncd2fY7oDSj6HQS
         Fyy0CHT1AaqYNZr88VBhDKjxER9GuT2wT3yO6ocCNrFc0YmiW0hoC1nMFiZR08GYUjPP
         ya4kRx/HIeHaxs8tcrIHBDmlNAd5I6bUNEjD75h6+0kJEod7n7br29MJinbx85E/pQ/4
         nEC/h6bGf3iaTUdQhgAMd6ECFCL6F4uV5NJQ32Alk3+kVAVY7KYRh+IAMN0yxxwuO24E
         wVl4Dhk3oO5eZh5uJu1OlEompNcT+kDo2d0lNnAh5OVUh7R16HMuHud3Ka44eTZXhs9D
         ZUeA==
X-Gm-Message-State: AOAM531zXtbMql20+vzDFS1yi6hZYz8CmZ5GDbJvwhn3Njkt+uirbp+G
        3cf+0oADjSVAvJxmsT7FK+jeY0NeC3ssDQ==
X-Google-Smtp-Source: ABdhPJy8CvsJDUozj4FPmQiwcF/0xjbCsZYHL93GKDSUECK4PfLmz+B86DG+czltfO1KyAqAesa4Nw==
X-Received: by 2002:ad4:4f28:: with SMTP id fc8mr14251727qvb.10.1617389656523;
        Fri, 02 Apr 2021 11:54:16 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.157.244])
        by smtp.gmail.com with ESMTPSA id n77sm8186043qkn.128.2021.04.02.11.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 11:54:16 -0700 (PDT)
Message-ID: <60676858.1c69fb81.d8cc3.d6d1@mx.google.com>
Date:   Fri, 02 Apr 2021 11:54:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8398327330288312587=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yudiliu@google.com
Subject: RE: [v1] doc/mgmt-api - Return connection direction in Device Connected Event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210402110008.v1.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
References: <20210402110008.v1.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8398327330288312587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=460347

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


--===============8398327330288312587==--
