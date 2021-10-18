Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E14C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 23:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8B960E09
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 23:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhJRXjW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 19:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhJRXjU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 19:39:20 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626E2C06161C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 16:37:06 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id v2so11202275qve.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 16:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vgWXNiNpL5DrMk7WTds3TGv7VwPxC6g0T+Nf+GK7pOw=;
        b=kTvCyG5wDq4mGRL3i1DwnIfJocHGAkC1znDj4KkVeoc4xmoVHT6Zez53dQNFrvLSYd
         Du2LrQO5hE+Z7z62UGyqixuNeyW6rnrRiElxCULjQk5pEmxbYcOruoJIzUeKnJUfOmV5
         Jql7CogRCiwHmo3y0RI/p6iZeCPuMqP/T7M5gyjgoKY4gRdkjrM5B8jUcINlNC1qsYhb
         fWW+UwQLWRUGirXENWP6LL6P89kdHKSJTXxdsgMo277RxDN2GRDDK/WZhPW/UHXoYY8R
         O2aL1Hj/VnOFaVpFksU2o+H6J5+pKXqTZBGCKaHMcvgWskanktA0M4bEYZn9Fo09446O
         Av1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vgWXNiNpL5DrMk7WTds3TGv7VwPxC6g0T+Nf+GK7pOw=;
        b=1fbtBGGvGdqy+3mtRQQ1NgdAeOhADKUJ4N7aPVtibcXTFylWlmRS3O95e7Cj77K7ps
         iKjSaYhoFLzByV/MECP718jxOK/UQd7/QZYnc6AFSzj3F9lgzw4d7wL0GAAiucQxa//W
         yjQBXYfdUcxnD9QsPqyX0OiXopC3zWPPWZFhXk64TZiCmyrtnodH3iP9I8M24VRgimWU
         Hcd/EG2S4EFbHG8nfZX5uAta+KxycJM/Bq1S9u23+Q8rsQECtlbENjTdrU1iNfEC1rtO
         WPbAESrira7Xcuh7swyHtJZOjuLwjmPx7bDYmZYR6k96PIBRxX6QqcwIo+mqAUb6Shlr
         76iw==
X-Gm-Message-State: AOAM532xJg+vXWMFR3l28ickrV5Eg/n/WBRjGLnnwCshAThsXQxmPseO
        7Ej97olRMFFDq8S/Nja7wFYqdQ9G5A8=
X-Google-Smtp-Source: ABdhPJzLaUpo2BIYjeQ6d9ANdNt4jNhItGg8N+Khpjtto+o6lJewROd3laNXDBDvq4zYfhOtZHledw==
X-Received: by 2002:ad4:46ab:: with SMTP id br11mr28057855qvb.33.1634600224998;
        Mon, 18 Oct 2021 16:37:04 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.251.217])
        by smtp.gmail.com with ESMTPSA id j14sm6803960qtq.36.2021.10.18.16.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 16:37:04 -0700 (PDT)
Message-ID: <616e0520.1c69fb81.41244.f6f6@mx.google.com>
Date:   Mon, 18 Oct 2021 16:37:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5487848175112633714=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [RFC,BlueZ,v12,1/4] emulator: Add support to config the accept and resolve list
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211018230853.134320-1-hj.tedd.an@gmail.com>
References: <20211018230853.134320-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5487848175112633714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=565857

---Test result---

Test Summary:
CheckPatch                    PASS      7.41 seconds
GitLint                       PASS      3.84 seconds
Prep - Setup ELL              PASS      43.22 seconds
Build - Prep                  PASS      0.52 seconds
Build - Configure             PASS      7.90 seconds
Build - Make                  PASS      180.23 seconds
Make Check                    PASS      8.94 seconds
Make Distcheck                PASS      210.80 seconds
Build w/ext ELL - Configure   PASS      7.82 seconds
Build w/ext ELL - Make        PASS      168.45 seconds



---
Regards,
Linux Bluetooth


--===============5487848175112633714==--
