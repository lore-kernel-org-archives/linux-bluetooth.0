Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB31C7619A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 04:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCWExN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 00:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCWEws (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 00:52:48 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D8B2684D
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 21:52:47 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id l18so1709684oic.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 21:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679547166;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4TcWvsD3cyxcAFl37r5tKDBgb8Zuo1ZqMCKIynnqYc4=;
        b=gp0Hic9RU7ETaWomD5EEAKJQZ8OsPBUYmPJM6UgCAH+TL1f3+a/c89Yov1pYouciTq
         oe4+1hXOSvXC4kjYVOFNpfDbrXQBT3Lu9BPSYmigczEaAznXcAtCyk5/tEoHFSHg15gH
         9y0T/c/lSRVZY+uw7UdJ4ybfjI/cXdQAoFSErBiOE+n1VnlCgnx013Ed2GvVCm8KSc4v
         HFOiw4KHPUSbIQTxItZ1/+8nh5sBhbrTXa3tcn84f2V9Se0KxM2ZM0p+sGiCXMXRL2mW
         Fyiyt4+e3FqAkuhh334r29geVvb2avZzAtlkHaDD+M5lu8zPnkaqh67jy5MjNesF3diO
         9lHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679547166;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TcWvsD3cyxcAFl37r5tKDBgb8Zuo1ZqMCKIynnqYc4=;
        b=n/gcrHqhLSsDP7EGpmjKbMHcW6cSDgyikGzIKGRdlLTR1mUkiURBwljSzj0mmg6vy8
         41cdB6bvV/RuhppMFvjQB+zU/g7ZbQpf9Mjq7In3uJpXNTMIsvRELIzvUH0Dvz5km576
         JLunlC7atQYHfaIyuc9wSTq8ishrWeQnNaE7BBCpo2R2964nhsbfEKI6Il+v8pBP6m2w
         EOg0EeAlNH0fk55Yen7/V5KkiKEmSFtpWmhSre458WaIqqQdoU1dFACMVRuKfFk+7ofM
         zdwbAFJSoGBsa/uT8jX5la1JEA8Qn94VZFoRXL32gurOS98emOJOdO9oOKQeN4WobxFC
         5IpQ==
X-Gm-Message-State: AO0yUKVJnt+KsZwoJJ4cSBYk9ijsUboU9Q0osNMY9OuaBMihEujtrsJm
        uheRMUkKpdfAeOP46Renzj9SEjKEkwM=
X-Google-Smtp-Source: AK7set+Cixp8MPQmMglYGdiekRlJu99d45AWVIYJ2YV8atl7rt3FBIEQo/uhx/DC5Oa3xzeem4n+qw==
X-Received: by 2002:a05:6808:7cf:b0:386:c5ad:16ab with SMTP id f15-20020a05680807cf00b00386c5ad16abmr2286981oij.10.1679547166455;
        Wed, 22 Mar 2023 21:52:46 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.132.177])
        by smtp.gmail.com with ESMTPSA id m5-20020a05680806c500b00383ce81c186sm6467521oih.32.2023.03.22.21.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 21:52:46 -0700 (PDT)
Message-ID: <641bdb1e.050a0220.3525b.da2d@mx.google.com>
Date:   Wed, 22 Mar 2023 21:52:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2143426123743364313=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, aarongt.shen@gmail.com
Subject: RE: [BlueZ] obexd: support to reply folder name to store file
In-Reply-To: <20230323032236.17706-1-aarongt.shen@gmail.com>
References: <20230323032236.17706-1-aarongt.shen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2143426123743364313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=732954

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      33.71 seconds
BluezMake                     PASS      1137.01 seconds
MakeCheck                     PASS      13.05 seconds
MakeDistcheck                 PASS      184.67 seconds
CheckValgrind                 PASS      302.31 seconds
CheckSmatch                   PASS      418.70 seconds
bluezmakeextell               PASS      123.20 seconds
IncrementalBuild              PASS      938.93 seconds
ScanBuild                     PASS      1334.36 seconds



---
Regards,
Linux Bluetooth


--===============2143426123743364313==--
