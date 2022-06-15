Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD602C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jun 2022 11:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347171AbiFOLno (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jun 2022 07:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbiFOLnX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jun 2022 07:43:23 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2009140BF
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 04:43:21 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id i25so2137537oii.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 04:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=LALtNjkEaJPd2760eenBWmoGzFuC708StmUezoFlirI=;
        b=I2zVDdanMNKMafLLv86U7WJr53evq5hcDU8ymWh8vHWNqz3UaKTU+tXOJSwY2L7orz
         zT+gIp45xbCAenPHZYHQCOsWCYk2A1due7Zd3SQeq8NZ8vf6OOgpE0QOVruPuAUzzTKu
         Lgp8zDhnnqWH8vAhlq/s6yUewz4gfTErPW2RStsMeAHWSG/kQ+3/Qw2ZMYY3BB+BprkA
         Z5KQIPsAKa+O5/NeV/fVN3Z4XgEl8STPPodN4acBD9O4dtLrWvlTZjp1+i4v+W/1IY3z
         8tn1umNynLIBrQn33bgpkWjm8jhuGtsDv0/MYs17qQiHEzu2tfg5I6g22aCPng3HxJZ+
         H1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=LALtNjkEaJPd2760eenBWmoGzFuC708StmUezoFlirI=;
        b=dpvhQaFVfkyDkUMf6yAlnDhbdL57/Lbb/n4nmAdFe1J7YM8Oq67f0+CsCzg6AdtSwN
         JroT+J6otpUGsLaGWjUjNCJ2Oy/wj2U9tqXhzeXgP4QOVUQPwBJfxW0+lKQ1Hq5a9cn4
         lucsBu3EEcO5WiFPyMqtp/+AzzFodSiNyLqUJO+azgFR0w9u+r3/OiDNKGo8c4WaO3Zg
         rNE7Vrc4RgDtcI/B5t6BQ9hvC2JktZIdqdvpPj9l/XZczo2hH+7NiRlcubYFT4xwfSZL
         E/uFGv88tYCFUN+slmP95fTFGDPxilHNLBL9wJ8Tm501j09ODa4FHfLwR7k22Eh5LhM1
         8NkQ==
X-Gm-Message-State: AOAM531mDQebDfs3GExHl9z6YtMgTIlonPrhxUlgid4MEGkoQMUuXG0t
        TDVidgrhZeMg28pQByQZVud4HH6lgvDiSw==
X-Google-Smtp-Source: ABdhPJw4L50qSsOQamuYOISTSj4rLgxI2VcfYfEaAr917OjxjWfglG5Bg+YfK3FyQa/evXN2nuxa8w==
X-Received: by 2002:a05:6808:13cc:b0:32c:20b7:373d with SMTP id d12-20020a05680813cc00b0032c20b7373dmr4596459oiw.182.1655293400851;
        Wed, 15 Jun 2022 04:43:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.199.204])
        by smtp.gmail.com with ESMTPSA id y36-20020a056870b4a400b000f32b1982f1sm6983473oap.46.2022.06.15.04.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:43:19 -0700 (PDT)
Message-ID: <62a9c5d7.1c69fb81.92918.1daa@mx.google.com>
Date:   Wed, 15 Jun 2022 04:43:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1854089259663974887=="
MIME-Version: 1.0
Subject: RE: [Bug,215167] Bluetooth: hci0: command 0xfc05 tx timeout
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bugzilla-daemon@kernel.org
In-Reply-To: <bug-215167-62941-EbA60DEyFQ@https.bugzilla.kernel.org/>
References: <bug-215167-62941-EbA60DEyFQ@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1854089259663974887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: drivers/bluetooth/btusb.c:714
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1854089259663974887==--
