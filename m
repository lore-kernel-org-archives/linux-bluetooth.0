Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824DBCDB474
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Oct 2023 01:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjJUBFu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 21:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUBFt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 21:05:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE981D4C
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 18:05:44 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9e95aa02dso11146645ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 18:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697850344; x=1698455144; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3VqSqeBj1PovCFeUp5+PXaTKa1n+qsANgp3rWzv6ZOc=;
        b=asFuiXYKJ3YsK4SjAB71Lea8iI2fyI9ea1ZkEOpFVYodGpG+tXS69pzlc9iy+qTrCy
         JOSTOK/o21xvPcFPoBDZQljmurNUnhPR5hkcyxERLGzUXlyf5UddyHNKxawQw/GgttKi
         wIyBD/EeXaI/8kyggrPfWa+5yu78Tk8z5pmjfvyVztDzWcQYeRGcJ8+aq+ibXZr3uD47
         6JPSdA4pq8RBv3suiwkuoJbIUNNwQaLan5UB97GjpXHC28DtuGYMG9ABT64B2kOWVAha
         fw/eU8mdKPu7mL1dqUdiOln1FQd+nZivjGj3DyDJeqM3NUlmMKwgmjS1DzpXJpFNG+jp
         BWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697850344; x=1698455144;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VqSqeBj1PovCFeUp5+PXaTKa1n+qsANgp3rWzv6ZOc=;
        b=ag7YUvaTN5zsFNU0CpWOBQLooJq/o45JEW91qqBGn3CiwOsREoj9W6DehVKuP/fihg
         I608TsQF1IwoA5j9LohWS9qa7agBXaVGizsfbZIQE4Jd/+icCeEvD8nEwh2Y3D8dzSQf
         mR59xfScKr/JQCY1RnJ87P17P3oo08N0jps9jIFAhRzhlR8kyeXGF8yR6aeUgz3a5ZqZ
         Oamu93Q5GaPA6GwGaT0RqF1aZM9zVv0yTIkVKOlRMMoRmUleqaJg2lOdlFBGLIx7jjPH
         x2VHFcGof6w6VcbZfiLzoVUPVzDS4qf+xkeuUSqUzoVtxJo50/DAQvBW7SvI05AGcNg+
         jFKw==
X-Gm-Message-State: AOJu0Yzyw7LtsQPmldUAUa9GPMl49qpC1t2NK8JEsj1a+y52eI8jxcdx
        X9Xk602YCHAChKM4iNsafjzxzKMkang=
X-Google-Smtp-Source: AGHT+IE8Te+reeJED7ht7rtrqj2YZb2QIl/KYJvFXM8OCJSc42X0UAYP5m5ZUCwBffrVOZukrcXZug==
X-Received: by 2002:a17:902:f542:b0:1bf:193a:70b6 with SMTP id h2-20020a170902f54200b001bf193a70b6mr4404034plf.5.1697850344103;
        Fri, 20 Oct 2023 18:05:44 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.98.116])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b001bb1f0605b2sm2103266plf.214.2023.10.20.18.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 18:05:43 -0700 (PDT)
Message-ID: <653323e7.170a0220.90bcc.7f6f@mx.google.com>
Date:   Fri, 20 Oct 2023 18:05:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1984004278955609975=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] shared/bap: Remove Locations, Support Context and Context defines
In-Reply-To: <20231020230746.3084772-1-luiz.dentz@gmail.com>
References: <20231020230746.3084772-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1984004278955609975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=795284

---Test result---

Test Summary:
CheckPatch                    PASS      0.98 seconds
GitLint                       FAIL      0.79 seconds
BuildEll                      PASS      39.90 seconds
BluezMake                     PASS      1326.81 seconds
MakeCheck                     PASS      14.37 seconds
MakeDistcheck                 PASS      252.67 seconds
CheckValgrind                 PASS      382.01 seconds
CheckSmatch                   PASS      515.82 seconds
bluezmakeextell               PASS      164.13 seconds
IncrementalBuild              PASS      2348.27 seconds
ScanBuild                     PASS      1644.54 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,2/2] client: Add support for setting Locations, SupportedContext and Context

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (86>80): "[BlueZ,v1,2/2] client: Add support for setting Locations, SupportedContext and Context"


---
Regards,
Linux Bluetooth


--===============1984004278955609975==--
