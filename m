Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DB4C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 23:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682F061181
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Apr 2021 23:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhDGXFn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDGXFm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Apr 2021 19:05:42 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CB6C061760
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Apr 2021 16:05:32 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id u8so41623qtq.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Apr 2021 16:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=CPmXK+5uqxrdi96TUEFNPHlgSxgOeHjgWf9thir9wRw=;
        b=iSoQo05+d2x2eKmz2T11AUqqduOWUn5UVIBqXvmLJ0PF3lu2UuMUyugl6kbEVAwO1C
         BSDTw8an5KqBgex9Ht8RGBNoVgD6xvLD89j/wCPalxZ8NDYr4NCgmybeVoFNGQxhhUfq
         aC3eE031oMY4r8TCHu2qmFy+6EFeSsfaVMtcRnW4UOBmDwsCmyf2ee/6zs0nqbe1G8K0
         Y7Lr5v+/vDNv/MsXLo6Y1HYLHTmbGMzhY7m/ItsEesOLcuKwd7vSCBYqHPqSyPBf1hgl
         JuHGJzTcYKTI4XHYjUNt9mKUuUrjyHa8Kwg5wedIP3+jC3T+vr4QI2+D5c8i5Cghqg0L
         26gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=CPmXK+5uqxrdi96TUEFNPHlgSxgOeHjgWf9thir9wRw=;
        b=fNLuY+wu7s0j4ueVm+iBsg30f3VHOlZGXF5+s0REFwi9hxGHaiLz/74CzvBNLEEk/+
         tVdpnc/WKECyCdVdbaSdx05vddaxcVk4DhiQA7O3S1HA31Djgy4BTYb7eYmax9idCUQi
         r5FvVW3q7mkTGy603cXH/1vjny9keQ1qAAgHWQrl91MINtFy9AfxfMkY4zdgc2Ee81pX
         uydrM3UmSXJpv2vMCd9Jld0NJPPjBU/8EsDc18IVXzGYlfSIoCSRSnd0EQ+2xfkiGbo8
         PLABUs1KkaqPqMzAIA/L6sTXN+CStu/W5JVNoeEgNd6lH12xY75IRj/dy6X7hsahRJT6
         EkPg==
X-Gm-Message-State: AOAM533ti3KO9LnmXYuQC8YmTthf9/K5qy4erWQoAWBzEYi9oJpodvtI
        N6R4N8S6LQfQFTweTZr6KYY0LWpA4moR5w==
X-Google-Smtp-Source: ABdhPJxEzHPSQbTuJes53a03YIKBU3bw5qg2UN1QYRdn0imPQ7uS60tWKKIyLr0QrCpraH9s1e9YuA==
X-Received: by 2002:ac8:5e8d:: with SMTP id r13mr5079474qtx.138.1617836731690;
        Wed, 07 Apr 2021 16:05:31 -0700 (PDT)
Received: from [172.17.0.2] ([40.70.128.74])
        by smtp.gmail.com with ESMTPSA id 19sm19329707qkv.95.2021.04.07.16.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 16:05:31 -0700 (PDT)
Message-ID: <606e3abb.1c69fb81.91112.3d37@mx.google.com>
Date:   Wed, 07 Apr 2021 16:05:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2924628012095937732=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] input/hog-lib: do not silently ignore missing connection in read_char()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210407223347.28669-1-sonnysasaka@chromium.org>
References: <20210407223347.28669-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2924628012095937732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=462829

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


--===============2924628012095937732==--
