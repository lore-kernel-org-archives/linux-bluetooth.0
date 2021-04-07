Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98882C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 23:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE046108B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 23:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhDGXEB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDGXEA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Apr 2021 19:04:00 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867D8C061760
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Apr 2021 16:03:50 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id i9so384770qka.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Apr 2021 16:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3jXLHRhpQVBhW1SYHG7RVkhvPndZiY+lQ/qei85tT88=;
        b=HGCOfUhUr6d8dv2h7d6I43+qip0zuBoPgo2MNJJwaTjeBstY7FYGZLPohDHGkUDp0T
         PvlJ1lXk8hXmblKjl3iiT1TpkdiO9dmlruHzR6xUVOkyhkkCIaKa6O2LdKbNk5Zk55/E
         ACJHtimXi6123AvSfS9KrU/giaHfNl9Vi6iEn0Nw2m21Hydzf4qeENybrEVwyehfFcLA
         WWWRX5wDVPbSa4z04Yuvo3u2exjrBdynJsbomgwfKA0gnx/YWloCZ3T+cjRHNfpzqIp2
         7EUjy0NADMBvAS116hsJHg+iIY7RZcfiZakDtzJN94TLIu/3qxZHXwO9rw/f6jSfa8Rc
         TDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3jXLHRhpQVBhW1SYHG7RVkhvPndZiY+lQ/qei85tT88=;
        b=CUjYK49JsL1qsnsP07VDJIv3vh7I4f/4wYivJGoX+Ypgo04+yxbFCMnGskuIVAQWYG
         SLbV0RCfjlQ7zgEugZ39sB3K0rJuxaMS6D5IJRuMaQMT4fxxG/rDstVPP4YwB8Y+BU0C
         hwJASerkaQUxkcCjkuWlMdzni/CKlZQPxwOSwvJcVLrpZKIEomu4XLkIQI2OK7LqjjVm
         +AShOiZBtLlBdcMwKo6LvbnXU2QJxLIiuNtoypECJbhdwzCsAJlbGa5ErKnWVenOtaf8
         CgtbLcO/AwXXxe4Iqwco5s1bqRbi6cNxbGGbBtJJQwM0c3dI7evRqR3xHRFlBnHqUTbn
         +usA==
X-Gm-Message-State: AOAM531RdER9jf0uX/OmYOyeaLuEqkBhSfW3U383M+LrEYhXg2wb2Qko
        ok0gWtRQYfGcPqFzpHm18SoveHgZM+B2ew==
X-Google-Smtp-Source: ABdhPJwGuA9TMVjdvv7AEKlHoMwn0jl/KTW8qaFEi6DnWNnrtWy5qgKnfzbImPlLC583hNGTNzX6Kg==
X-Received: by 2002:a05:620a:244f:: with SMTP id h15mr5395250qkn.235.1617836629642;
        Wed, 07 Apr 2021 16:03:49 -0700 (PDT)
Received: from [172.17.0.2] ([40.70.69.221])
        by smtp.gmail.com with ESMTPSA id a138sm19560853qkg.29.2021.04.07.16.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 16:03:49 -0700 (PDT)
Message-ID: <606e3a55.1c69fb81.bd45e.4483@mx.google.com>
Date:   Wed, 07 Apr 2021 16:03:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0963828333216392452=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] input/hog-lib: avoid scanning characteristics too early
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210407223418.28793-1-sonnysasaka@chromium.org>
References: <20210407223418.28793-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0963828333216392452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=462831

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
input/hog-lib: avoid scanning characteristics too early
6: B3 Line contains hard tab characters (\t): "	bt_hog_new()->"
7: B3 Line contains hard tab characters (\t): "		gatt_db_foreach_service()->"
8: B3 Line contains hard tab characters (\t): "		foreach_hog_service()->"
9: B3 Line contains hard tab characters (\t): "		hog_attach_instance()"


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


--===============0963828333216392452==--
