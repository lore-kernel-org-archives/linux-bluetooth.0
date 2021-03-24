Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F33C433C1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 19:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE2C61984
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 19:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhCXTWu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Mar 2021 15:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbhCXTWf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Mar 2021 15:22:35 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E26C0613DE
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Mar 2021 12:22:34 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g24so18421328qts.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Mar 2021 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=2Nma21BncUF5IrlIOQzHJGlwUMpmPmQSzU/TCo/0rKg=;
        b=E66mb1xjgrgjEPIrkrLqq1x64JzejHnpHctpN1JrWrKXiQR+4Wg6ifIC4/xb4pxBm1
         vvvsTsvXEfhKQ1i/g2p1pA92U/c9MXQV6Zv+RYMbWlaCvO2PojITHMlqAFKffCgcwTrw
         zySUJwYwQa7fLHRHu6Qs05G3OFM4Rzi4hHJnqFo2udi19hHJJtTVEWaijO8XDOW8esnZ
         ZTekLy4EaAPYCvbEchXyiUajC/xqtvBKtAKq5gEOnENxrZR7pTjPVtA1eONWHnX3pvWa
         N5zf7muAx0+nocfV3qtBUKsaum0Tzp8x0C6mpeKJdZhxA3hCr3j0G7BsLVqRDglY/lRH
         J2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=2Nma21BncUF5IrlIOQzHJGlwUMpmPmQSzU/TCo/0rKg=;
        b=CPKlwyR3bhKtJA5Yq+Ts/ybApwB9HZTuQSvzjwqzetTmpK59W/Q+qeWkdUSRXOe6Oa
         oQmwyIDLJAnV5LAtzmek4lLjD7HCUDEZHFHzWZFOkue4I7BIyPIQwAKBd7pyabKgSgho
         GymAW24KNpkWaSWcwZcxPn1KxluXoyZ4WbBT20VZyHKr6hDay2zrQNNaed+ExiNojh43
         r1odwVmQ8aGSpdIZ5vctaeBksLgwm0nFlpxsBN1PFetSGWwMPczSsm9RAYA2Ydbkwsja
         S81DZfvn6jvHGv/RggR2FwYSywn1bOtoUvYGd128lzss4RvQbNuZxGqwccxsRhIfT7h6
         7dqA==
X-Gm-Message-State: AOAM533TzBRb67ZCnaO8uoUXHGMtrGfUeBn9sov5l+fNqrHMy5s6ro1d
        fOWFgtlSY4cBh1XHCrUn0YMkLV3tRII+Wg==
X-Google-Smtp-Source: ABdhPJznpDKUQpdMzgPUqOU1pfZdqatoDctXXto43X1EpehaNeioVdor+nUStsCpyea4ZXiWYbjlhg==
X-Received: by 2002:ac8:5847:: with SMTP id h7mr4483198qth.108.1616613753549;
        Wed, 24 Mar 2021 12:22:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.44.71.110])
        by smtp.gmail.com with ESMTPSA id j13sm2043537qth.57.2021.03.24.12.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 12:22:33 -0700 (PDT)
Message-ID: <605b9179.1c69fb81.5fd51.c9c7@mx.google.com>
Date:   Wed, 24 Mar 2021 12:22:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5793801668129913994=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yudiliu@google.com
Subject: RE: [RFC,v2] doc/mgmt-api - Return connection direction in Device Connected Event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210324115840.RFC.v2.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
References: <20210324115840.RFC.v2.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5793801668129913994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=454837

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============5793801668129913994==--
