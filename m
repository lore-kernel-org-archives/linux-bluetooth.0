Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08CCC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 18:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC0661103
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 18:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhDBSDy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Apr 2021 14:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbhDBSDx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Apr 2021 14:03:53 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A893C0613E6
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Apr 2021 11:03:51 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c3so5946941qkc.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Apr 2021 11:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=nFdINN26PaNHm5ZL7Z5HdrhHrRQuhtPflYYCuhXr6Ds=;
        b=bwBLPTlHlqz3DiTQysyNxtNo7TUBEyp2i2Aq+CZjcHJ7q7tbirr6+W1D0bZ2jNMPfN
         HZ0ephURQFdihULrUvpsJ8xUDsOs4c6Qb1au8tUSlnMQjzkF9BdmPU40nOKp06mcnBYl
         QaUqkk/tZhKRs7xp4TdPYRRssesKSrfYGT8hRhQUPHh6iC1RQlS9mI8Pni3bVEQaz/Y5
         qUMhXcLJBTn/aVSDubQjMw67eJIOaGiy+RQCMhiekt9XthbfCV8Gi/Ka/RAz5WvZ23of
         0OAbNHjdvptyH1pMcwpcAVsps+KAuv/3+Nj+JWDtq6rmel7K9bME/OkZ7LrwnWBDBjPH
         VbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=nFdINN26PaNHm5ZL7Z5HdrhHrRQuhtPflYYCuhXr6Ds=;
        b=Q4jsv7CAsmb30Ps9XsREHFq9lYdqFotqUinaSQOzyxusVLfw9iI723Nj+6JJkYxGlG
         nHRihqWDkImWY+SRWN+QJIAQ99TIdNch+37PCOI4an6rKCSiJvBmonhvfkhEItJD69xz
         FNOpa4rG6hRulTRgqbXeLvHFNqvyoBmg9CBljejfXJoMFqTGyxI5nO6tmgVnR2nOI5Bf
         cYYfZQBKiQwHnYJ0+/Eoe+frHmv3xvUNCDhCI3ZRxAYRzOTSyUdgWElA6FTD9VaA24GW
         yAywUsdBE7pADOGpTy1F/TTfjN2GgziVF1LBM8ulqO6Dv2Ab1H6ETZY9ALiay0OTnMJG
         R1Nw==
X-Gm-Message-State: AOAM533sukssstXc4/gHHYJAL+xndZOTwwAvi3xNmKIRTo5mcKVpTpTm
        qCFLWQVuphIC8WIJlFX4sspIKcUieDX5ag==
X-Google-Smtp-Source: ABdhPJzkkBaDE++/GuMC6FCMctszUGBpN4MAHyHjfvk71o7j2CslyvJnkliLuWpnoQvemBiIX04ZdQ==
X-Received: by 2002:a05:620a:699:: with SMTP id f25mr14494946qkh.249.1617386630225;
        Fri, 02 Apr 2021 11:03:50 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.19.167])
        by smtp.gmail.com with ESMTPSA id o26sm4496940qko.83.2021.04.02.11.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 11:03:49 -0700 (PDT)
Message-ID: <60675c85.1c69fb81.6dc89.57fc@mx.google.com>
Date:   Fri, 02 Apr 2021 11:03:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5809798350827233181=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yudiliu@google.com
Subject: RE: [RFC,v4] doc/mgmt-api - Return connection direction in Device Connected Event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210402100124.RFC.v4.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
References: <20210402100124.RFC.v4.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5809798350827233181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=460317

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


--===============5809798350827233181==--
