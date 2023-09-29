Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4651E71D42
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Sep 2023 14:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjI2O1Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Sep 2023 10:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjI2O1O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Sep 2023 10:27:14 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6441E1AE
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 07:27:12 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c364fb8a4cso128135425ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 07:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695997632; x=1696602432; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+N/X8E/VUwxtAvL/X/E2dcRfbcI8FVIfvjuUzevWgQk=;
        b=CBJPkC/vTriAa0goKqV+XLJhQboZjbbySn1n0s+1gpQ9ksWdToc3deOIPqInJqLdnb
         Wr9llLKSGe35XOomnx5LAccC30Dch6DCfC2Q0UNN6VDclKCt6ldfMJcxNh8UJHniSWMN
         DVELq8dbpAylFnOmGU7MONr/4a50LxaTUZzTsuz0JB+iBf5DfRiIhcHlk6km47XH5xFT
         WpIlOn9DVZUuI1daT6TNp9eBUDiDSMdqa84QktEVMX2yi30WQzD9xUN6dPu+eRsiWkmu
         RdT0ec6FgVuEK9glElUYqrBmgZiUPaJNgz+vL0hcZPChw10YEjs6RNjXDPZWhphAVmo5
         uynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997632; x=1696602432;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+N/X8E/VUwxtAvL/X/E2dcRfbcI8FVIfvjuUzevWgQk=;
        b=fYyN2pwctd2ZqwR5VHsUyQG46tPugMpnOL2RRkSVAqrnClu/FZdMTCh8jIEJN93mn6
         2JaYExwraWJOqTmMV9vMhB44a42KqWpwIxM6wdpz643snTUbLoKqKcek8c3iTDot9o9P
         eQGDNgoNSvIEHq+aGmLwjdR8V/adXs3MlkaYWCaF+lWjlt+hywiwHJi5IHYLYmlKt26s
         9WUzYiWU3VR50kLuy3QkYiNKcnuqGUR6h725OQjLJW5p99PwnyxPVk/Gb0qInxcxyAFY
         hzUJHKkcn23SeLTrzJoXGxk/EoXG1LnYoyXeoYoI7ENegmDAVi6RpHO0uBU0wyaihJk3
         xD0Q==
X-Gm-Message-State: AOJu0YwJ6ZScvS3OioPPOaRxR6L/22jBhrnjMyLZtn/hfnDMh83teaam
        REY2QaOtqbjtn0RWUGgVi0lrUxLbHiM=
X-Google-Smtp-Source: AGHT+IHyUvy2q1D2/QwWV17jUY470sQQNndyjOiDINeLTtawGbv2AyTdJ2Sj8wIoDKFcu5GHf08DbQ==
X-Received: by 2002:a17:903:230b:b0:1c3:4565:22f with SMTP id d11-20020a170903230b00b001c34565022fmr5011941plh.21.1695997631568;
        Fri, 29 Sep 2023 07:27:11 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.161.20])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090322cb00b001c322a41188sm13046521plg.117.2023.09.29.07.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:27:11 -0700 (PDT)
Message-ID: <6516debf.170a0220.6c467.e838@mx.google.com>
Date:   Fri, 29 Sep 2023 07:27:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7125695014625790480=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vibhavp@gmail.com
Subject: RE: [BlueZ,v2,1/2] adapter: Add Version and Manufacturer props to org.bluez.Adapter1.
In-Reply-To: <20230929130622.146306-2-vibhavp@gmail.com>
References: <20230929130622.146306-2-vibhavp@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7125695014625790480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=788804

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       FAIL      0.56 seconds
BuildEll                      PASS      30.70 seconds
BluezMake                     PASS      1046.22 seconds
MakeCheck                     PASS      13.88 seconds
MakeDistcheck                 PASS      179.72 seconds
CheckValgrind                 PASS      277.48 seconds
CheckSmatch                   PASS      421.49 seconds
bluezmakeextell               PASS      119.57 seconds
IncrementalBuild              PASS      911.93 seconds
ScanBuild                     PASS      1207.68 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/2] adapter: Add Version and Manufacturer props to org.bluez.Adapter1.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,v2,1/2] adapter: Add Version and Manufacturer props to org.bluez.Adapter1."
1: T3 Title has trailing punctuation (.): "[BlueZ,v2,1/2] adapter: Add Version and Manufacturer props to org.bluez.Adapter1."


---
Regards,
Linux Bluetooth


--===============7125695014625790480==--
