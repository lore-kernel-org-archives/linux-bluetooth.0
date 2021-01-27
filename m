Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6CFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 11:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462DD2075B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 11:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbhA0Lkn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 06:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbhA0Ljf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 06:39:35 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E790C0613ED
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 03:38:55 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id ew18so876958qvb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 03:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=nx5qVx2gJG8phnjsM2Mvi3xZY9Vq4hHfzs0go71wu5U=;
        b=PVpRGv17g1sQcgB0cBpaGE+dwOzSc+PzH1uw7JgIzaWWRi8WXiszUgEtWte8qBq4Ix
         P8aB8QMl/SAzhGu5LOqof4C0HOAkN1Du54aO8w1suy+V0t/j1xHdTO6QA9RXQeabxSUw
         MlJqhLntnAgIewIOcOE20QgoYVMK1YEtTVmplSgZ/l2Dc+31mSaHIT2nY8LgFMy+1Q1C
         22S+yDCMeIUKnfpELabCuHX4z8Q92aWPpTU29I78iecqy2eY2xiOLFUnrzosMj6H3J/I
         kMCLNhiK6zZQ/lA8OMumHOEmRsy+WkUy5MGDyJ96YYcYALCjqXPRKw1z1pqQRQDlELN7
         nVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=nx5qVx2gJG8phnjsM2Mvi3xZY9Vq4hHfzs0go71wu5U=;
        b=PoraYtT9B7fSJI7gMoLCoOdLFQ/5r31hvfuxRUecOFdl8ze/fGSEZCa21PpNlkg7xV
         n/H/ybQVeChAjpMsngStdPjsdwK8EBc2jIullKJad295aNZn/Pk0r3ACJ71ljsUVEtKV
         b0mpOyG0yChdoP5ekzwFEpEjf/KrSouHoJJp5YWUG84OJT3XzGg+uNLoGLKfKIvlonR4
         i1uiSUA9z8dSfEx0hgI6eq9yAvXPrJThSitaeND+cce4I4E1Y6YXE8T61cUl9UJ6TAMj
         x5/JnKxwxV1VhkWtrBPWpXEMivHBQ9uQIw82LuEoPV2Hx9wd4eit1zIW08MRJQ5i0V1t
         MfdQ==
X-Gm-Message-State: AOAM531jaqRQv1+QalwUvKjb1RoMRmNNVJu+zw9kCjpqx1t75weIMuwf
        3JpEv16SZzimOm+0Jxa30PAcee01qGXKWg==
X-Google-Smtp-Source: ABdhPJwj5IuhxJY0fBiVQKKFLtwAaRtEtvNPwuAqJDNrPU6q+Y645La2Jp4pvBrobr9pn5Rjd/2HCQ==
X-Received: by 2002:a05:6214:1471:: with SMTP id c17mr9875033qvy.44.1611747534431;
        Wed, 27 Jan 2021 03:38:54 -0800 (PST)
Received: from [172.17.0.2] ([40.70.79.169])
        by smtp.gmail.com with ESMTPSA id n21sm1111672qtn.18.2021.01.27.03.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:38:54 -0800 (PST)
Message-ID: <601150ce.1c69fb81.1d7ed.6d49@mx.google.com>
Date:   Wed, 27 Jan 2021 03:38:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5696929462294507960=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: tools/bluemoon: Display FW version of firmware file
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210126054512.76870-1-tedd.an@intel.com>
References: <20210126054512.76870-1-tedd.an@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5696929462294507960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=422833

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


--===============5696929462294507960==--
