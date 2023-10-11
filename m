Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE31CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 22:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376363AbjJKWCO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 18:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjJKWCN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 18:02:13 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85A6AF
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 15:02:11 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-65b0c9fb673so1764176d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 15:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697061730; x=1697666530; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=99gQzH4l2gIquk3ARlgZt+SyrIYm/OYfVV54wRqPOBk=;
        b=HEVfJmF7lF+Dfx4SCsiwk0FMzGGxg9B1TUOFGGZqSOzK7o8s7DyQkuT61pnxwbFw40
         nDR/qdZJ5888mDK/wvAcQyNZc1fRN3Df+N2J46SP7wkHF515Hgg6TDSXoRewtqcNEHYr
         juLCYPqsDAjPuJWevmKG/7oSFfUOQnB2zSkv1W7KCUqnJfgBXdtHIh5t30OSRnyQAmTY
         s16m2FsIu+oKQ1zK6Xm47h6IMdfwpt6HVFidmHD784FVIkl/A71XQo1QJVu5Ka57gccY
         oGEVtEKVUwIXGwinBgwJf7/58QyPsYJHJKdMXt8G83b8mWanUGdTVtshMxrSu8Gaypag
         k3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697061730; x=1697666530;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99gQzH4l2gIquk3ARlgZt+SyrIYm/OYfVV54wRqPOBk=;
        b=pL6FQVTwz2sPcvvD7PFEtRXLhTzkQPEORh/dvMkoQK3cCSuE4pfQc/UaGlqQ2Csa1z
         vxBs50cOu3Ni8+J51s4JFoz0+1JbanVcIKFbV8fuJA/GzFmSTFEQ1h7kdnBStuTvFRdN
         f+WoeCOuVnTCJpWCJ9i/M8RMVLV9+xbp1imy+LkbOZNNzPFEGhkGoteUKog/q1ZHl6E/
         8S2HFlZI//7Pd/HcOWAi8l3kf5Vp2ZkUAl1Pm3ZQfeaSO8bTBeL3p80Cj8cLA1M7YH3A
         zOUDi484QHYlMekrBZEhZa6dV+t0UmaG3yRw+Ti0eW+t2PpWRZE03lqdC3ekR24byySr
         5cCA==
X-Gm-Message-State: AOJu0YyEDbAiQy7J12OSYakkJsqaNQM9zcirzq/Kcqvzy1GYmh/rs3Ml
        TfwKkpuHDCbIYac9UrMy7D3lQgCk7NM=
X-Google-Smtp-Source: AGHT+IFtlK38+acQHbIyCkKlgpndxsaq8hqFKwAuZLWcJmffUVIVIKrYwiYsPM5tRWnYTbD6hx1DXQ==
X-Received: by 2002:a0c:aa56:0:b0:66c:f381:bb6b with SMTP id e22-20020a0caa56000000b0066cf381bb6bmr5555594qvb.38.1697061730211;
        Wed, 11 Oct 2023 15:02:10 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.202.148])
        by smtp.gmail.com with ESMTPSA id x8-20020a0ce248000000b0065afbb39b2dsm5967253qvl.47.2023.10.11.15.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:02:10 -0700 (PDT)
Message-ID: <65271b62.0c0a0220.3f82a.c060@mx.google.com>
Date:   Wed, 11 Oct 2023 15:02:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5732173720925294142=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: [kernel,v1] btmtksdio: enable bluetooth wakeup in system suspend
In-Reply-To: <20231011141631.kernel.v1.1.I6dbfc1fedddf0633b55ce7e7a10ef7f3929a9bdc@changeid>
References: <20231011141631.kernel.v1.1.I6dbfc1fedddf0633b55ce7e7a10ef7f3929a9bdc@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5732173720925294142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=792335

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 FAIL      0.39 seconds
BuildKernel                   PASS      34.48 seconds
CheckAllWarning               PASS      37.37 seconds
CheckSparse                   WARNING   43.69 seconds
CheckSmatch                   PASS      115.85 seconds
BuildKernel32                 PASS      34.37 seconds
TestRunnerSetup               PASS      516.49 seconds
TestRunner_l2cap-tester       PASS      30.67 seconds
TestRunner_iso-tester         PASS      50.02 seconds
TestRunner_bnep-tester        PASS      10.27 seconds
TestRunner_mgmt-tester        PASS      220.19 seconds
TestRunner_rfcomm-tester      PASS      16.02 seconds
TestRunner_sco-tester         PASS      19.37 seconds
TestRunner_ioctl-tester       PASS      18.05 seconds
TestRunner_mesh-tester        PASS      13.22 seconds
TestRunner_smp-tester         PASS      14.13 seconds
TestRunner_userchan-tester    PASS      11.01 seconds
IncrementalBuild              PASS      31.52 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btmtksdio.c:558:63: warning: Using plain integer as NULL pointerdrivers/bluetooth/btmtksdio.c:580:55: warning: Using plain integer as NULL pointerdrivers/bluetooth/btmtksdio.c:612:63: warning: Using plain integer as NULL pointerdrivers/bluetooth/btmtksdio.c:631:63: warning: Using plain integer as NULL pointerdrivers/bluetooth/btmtksdio.c:1506:40: warning: symbol 'btmtksdio_pm_ops' was not declared. Should it be static?


---
Regards,
Linux Bluetooth


--===============5732173720925294142==--
