Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435C0CDB474
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 11:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377043AbjJTLPX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 07:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376987AbjJTLPW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 07:15:22 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2F4D51
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 04:15:20 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2df2fb611so502911b6e.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 04:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697800520; x=1698405320; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QRtHDCL6vI5GN5gLvekZj3eafjGOiIUrb3ai81nyCQo=;
        b=bLYK9K7XUiZ59NsqVH0jolE1GfE5d/0Hi/2PpcgoUaPyftBVz+jRknUMVMb/n9yMug
         oRyQJyroabzD/6Yt+x8d7ATAvmRtTvRYs295Ag4qI4Jw5jTs9D2HuBBmxYUfmDkVa11Q
         +pbID5pEoTYT6vCoCbpfS2ZvQV0XBzFrFyT+7qd0BAmo61Mtaw7At+qBfO/jTc3gpZVR
         BoIafDlfA4mJ8kI0upn5wooYlegQL5wRkI2gKxfJ0fOM6icDNMcLhujbdCrjl7aqIvGi
         pLnmXf5CsLT/VKOPUZi1htsyEEsqt2QHq6W+/wNOrxpYoGP3o3BT8zx4LpgkgLUj4Sdh
         ctMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697800520; x=1698405320;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRtHDCL6vI5GN5gLvekZj3eafjGOiIUrb3ai81nyCQo=;
        b=NOqjKSBbe9Jnk1CMXOlhWUSS8JnGfQzLbhvUxxhyFSlGTPqZ9NmQF0K8OgFqhtA97/
         3YAbjA7zD6B5zZn+6dmRWmdLT+GjaDMBPCzu3Ef+fagPBEyJIikPBJhWNIUYohzVZjjE
         P/D8mC49ai/hICnjgeiCI5DQtzu3HuWiVw8ImsBB2aTt0KzDRjfOZLa4snWHiKniJuwq
         e3PSw6ZXzOpasi5qsKkQ4vhiMepfkCQLc7VnCKgm3L2faXCe9JV7Dc98ThNBOU8cVP8I
         kPvNLedYl0LdATGk9q4kFiZOla4fB4ZrAyoLyp8AG0vLg4IdUHdotf+O0QfzW0ltXoWr
         rIng==
X-Gm-Message-State: AOJu0YzBfRr001Xpaox0h/ny6dpxpWjbnXFObKgrtPSv5jhQ4P1S9V8t
        ggQOENW8kEeBsa13RvvSKFKlZMPxL4Q=
X-Google-Smtp-Source: AGHT+IGvA2JoXDgVeQyFANx69LbCwb78u00LyWjPHuApinnw4AuG0vhjf1vEkJH/MPht1E75oNsGaQ==
X-Received: by 2002:a54:4097:0:b0:3a7:5cc1:69b0 with SMTP id i23-20020a544097000000b003a75cc169b0mr1608127oii.7.1697800520021;
        Fri, 20 Oct 2023 04:15:20 -0700 (PDT)
Received: from [172.17.0.2] ([52.226.82.119])
        by smtp.gmail.com with ESMTPSA id c18-20020a0ce7d2000000b00655e2005350sm602129qvo.9.2023.10.20.04.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:15:19 -0700 (PDT)
Message-ID: <65326147.0c0a0220.cdb55.271d@mx.google.com>
Date:   Fri, 20 Oct 2023 04:15:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2502159849714445458=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, purendra.singh@nxp.com
Subject: RE: Increase default obex timeout: 10 sec to 500 sec
In-Reply-To: <20231020093716.9654-2-purendra.singh@nxp.com>
References: <20231020093716.9654-2-purendra.singh@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2502159849714445458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=795037

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       FAIL      0.59 seconds
BuildEll                      PASS      28.17 seconds
BluezMake                     PASS      857.22 seconds
MakeCheck                     PASS      12.30 seconds
MakeDistcheck                 PASS      173.62 seconds
CheckValgrind                 PASS      270.50 seconds
CheckSmatch                   PASS      359.55 seconds
bluezmakeextell               PASS      116.60 seconds
IncrementalBuild              PASS      725.43 seconds
ScanBuild                     PASS      1075.10 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/1] gobex/gobex.c : Increase default obex timeout from 10 sec to 500 sec

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[BlueZ,v2,1/1] gobex/gobex.c : Increase default obex timeout from 10 sec to 500 sec"


---
Regards,
Linux Bluetooth


--===============2502159849714445458==--
