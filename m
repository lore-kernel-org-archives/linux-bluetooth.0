Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E262E71D3F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Sep 2023 14:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjI2OhJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Sep 2023 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjI2OhG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Sep 2023 10:37:06 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C765CC3
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 07:37:04 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-65b08bbd8b1so60785466d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695998223; x=1696603023; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XJ/0HoyPGfchsuc1Ap4MQWIIodUDiAPa/V4ii+YG64o=;
        b=gIYHu6Tplrj7ldhplGSglechxIrkp0qOJNxnOlAvdI9+FfyOUW0k0eGP3gMlwyZQrN
         5sSr9Y9qV/W+OlvAkFPqXtWjmA1DClp6XKyB1Woky6EMzZ2xc9f6H/m3IPilljGNdWDi
         /xL/s52IuJ0eQ6fPIpCNS5ByHg95nS1QkC5lr/nSzKLkDMgt/xqHDeJvmhXAszn2XS+m
         0D7FFng0PjbtupQeZfMbPtk7REj5kVvQeHZmnve9MfoUbOIaWuPFukN8HJn2fYg2o9Zv
         9iitx8VwRwuHJk+yeVgF9PmOjPwPGyXxG91XM3JgRxWTk35H7LAZaKNzCk0SCHpa9DMo
         XIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695998223; x=1696603023;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJ/0HoyPGfchsuc1Ap4MQWIIodUDiAPa/V4ii+YG64o=;
        b=Jb+BP1J2gqGN/+PRUPee1cPY0iSdT99GHX8NMY+ojYNNumDwyB73x49mVa82n6mS9x
         xCkaM0AogOX8jkY5CtWJkU5a+/bry7kGbUY7y08I7SlXtuROAyp7wjta7zyTBtllCyfo
         dM1zJ+GyHoM7E7FlqUeillp8v9uQmA/o1eky07NGnSCcBhHm/uEUD4V5bLLerto1MGF7
         MklzNRJzGBQAFp6FyPJF3ofUxGd0F6HeUTHr7X8tOKgucpG1vzcWVIxxlDIH7xKMoB/b
         90/0O3XY+wPvJdFWxmDnl1E6Xhc4Lc4CG8EXJdayrx27mMGTL/GKmKejJwzKDJAlLvy+
         /2xQ==
X-Gm-Message-State: AOJu0YwlRJEX7l2lOR+dIziCOBSqdDhgx9VIzxsKENq9OrXgMoccyq80
        Dl8hGBTiYl4l77HFrM3EnoakFB3OVcI=
X-Google-Smtp-Source: AGHT+IFPExI+dUgw9HnO+iTwAI4qp2tKppNriWKArHA4C9kiH2uSTvkDeMFJWccBAZqdogg2m4a6pg==
X-Received: by 2002:a0c:e252:0:b0:65b:2008:8a24 with SMTP id x18-20020a0ce252000000b0065b20088a24mr4069383qvl.17.1695998223481;
        Fri, 29 Sep 2023 07:37:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.44.119])
        by smtp.gmail.com with ESMTPSA id l2-20020a0c9782000000b0064f3b0d0143sm5341706qvd.142.2023.09.29.07.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:37:03 -0700 (PDT)
Message-ID: <6516e10f.0c0a0220.cac8.4871@mx.google.com>
Date:   Fri, 29 Sep 2023 07:37:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8474911502218939134=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vibhavp@gmail.com
Subject: RE: [BlueZ,v2,1/2] adapter: Add Version and Manufacturer props to org.bluez.Adapter1.
In-Reply-To: <20230929130742.146571-1-vibhavp@gmail.com>
References: <20230929130742.146571-1-vibhavp@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8474911502218939134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=788805

---Test result---

Test Summary:
CheckPatch                    PASS      1.09 seconds
GitLint                       FAIL      1.72 seconds
BuildEll                      PASS      28.83 seconds
BluezMake                     PASS      1024.19 seconds
MakeCheck                     PASS      13.04 seconds
MakeDistcheck                 PASS      165.71 seconds
CheckValgrind                 PASS      265.79 seconds
CheckSmatch                   PASS      356.05 seconds
bluezmakeextell               PASS      109.50 seconds
IncrementalBuild              PASS      1741.06 seconds
ScanBuild                     PASS      1098.65 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/2] adapter: Add Version and Manufacturer props to org.bluez.Adapter1.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,v2,1/2] adapter: Add Version and Manufacturer props to org.bluez.Adapter1."
1: T3 Title has trailing punctuation (.): "[BlueZ,v2,1/2] adapter: Add Version and Manufacturer props to org.bluez.Adapter1."
[BlueZ,v2,2/2] adapter-api: Add docs for properties Manufacturer and Version.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[BlueZ,v2,2/2] adapter-api: Add docs for properties Manufacturer and Version."


---
Regards,
Linux Bluetooth


--===============8474911502218939134==--
