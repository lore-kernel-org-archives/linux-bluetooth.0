Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB91C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Nov 2023 18:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377151AbjKBS3Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Nov 2023 14:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377123AbjKBS3W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Nov 2023 14:29:22 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A76136
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Nov 2023 11:29:18 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7789cb322deso70350585a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Nov 2023 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698949758; x=1699554558; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mjtvDncwuSRoLsaZOYEjm52tMRIEYPxiDkU8a9uvXWg=;
        b=EBJ6trUUN1ubiBrVke4dgLPXem4f8ieFLaCGJgMtLKSgHUGzHbaw+G63FtQt72f8YS
         9EHDnc3NEVqqVqNNHr11yKICFL53iVqjoVr1sDBXp87JP9Qs4az0dS81DWwPv9U175Dd
         Q3F8DalHa2IOy63A/OgTp1B8GYIHUEuyt7emieawAsx8fNEBBxXnp1VIiK44yP37pLQb
         AE+IRS6/LqYtpafHqwF2Mz29aZQftJA54WE/HPiYho7KT63WQOBF1qRZQ6pZTNxsYei2
         zi8yYQqHUbiMqHsMJCWLw99MRm+LCMKl44TVGgX2bN+y3v4d2eqB0LcgEVZHfQozMOab
         ncdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698949758; x=1699554558;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjtvDncwuSRoLsaZOYEjm52tMRIEYPxiDkU8a9uvXWg=;
        b=isHJ4p2Z3ZzHp4xXwAn/O7OI3F8lHzxFlGFjXxeVrO243a2lmgq2O1RT1DG4ghGqdi
         0Vmuos3BrqC2Ghkb5WyTSp8GWoJAXzmL7cYis8E5YJQtbemRyT8AqHd4PRx2eEo6shHN
         6VYi8N/RZa2QpkniqRoX1ioTBujhAQbC/cA4JvjhQgzdxyEjOqRAi17rMUu6PZ3OPSAo
         Nh3JpYk1AedlnWDqoEfOnqqXirWoIYtvm79EfrKETAKAfyveV2kqMBvU0ZuFjm7X/mBk
         jeu4lJfrkcY5HiXhOUETMU6ervKPtdLZRWzBhOfP7ss3/zoZGowdxZ2C8ahZeb37Z3Xw
         Ieqg==
X-Gm-Message-State: AOJu0YwcgHzS5dCeGiANHIjOJbI5lWdkWFGBXcfEzspINh3oe13pH8mI
        0uAJcd+VXwoeDel1zNa/JezvQ7buaBRhzQ==
X-Google-Smtp-Source: AGHT+IG+m+//S8X+pljQf12ts4dwSq1uOJQdnz3W8fFzfY/fHGA4GYexmYnq+ZkBwd+pLoQHrpYMdw==
X-Received: by 2002:ac8:5849:0:b0:41e:7686:fa27 with SMTP id h9-20020ac85849000000b0041e7686fa27mr9623310qth.5.1698949757583;
        Thu, 02 Nov 2023 11:29:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.152.212])
        by smtp.gmail.com with ESMTPSA id gx3-20020a05622a27c300b0041e383d527esm153968qtb.66.2023.11.02.11.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:29:17 -0700 (PDT)
Message-ID: <6543ea7d.050a0220.a22c4.1670@mx.google.com>
Date:   Thu, 02 Nov 2023 11:29:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2967720229118260578=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add support for bcast multiple BISes
In-Reply-To: <20231102155827.4219-2-silviu.barbulescu@nxp.com>
References: <20231102155827.4219-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2967720229118260578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=798448

---Test result---

Test Summary:
CheckPatch                    PASS      4.43 seconds
GitLint                       PASS      1.82 seconds
BuildEll                      PASS      34.02 seconds
BluezMake                     PASS      1025.29 seconds
MakeCheck                     PASS      13.80 seconds
MakeDistcheck                 PASS      213.88 seconds
CheckValgrind                 PASS      328.50 seconds
CheckSmatch                   PASS      433.14 seconds
bluezmakeextell               PASS      140.35 seconds
IncrementalBuild              PASS      4345.83 seconds
ScanBuild                     PASS      1313.66 seconds



---
Regards,
Linux Bluetooth


--===============2967720229118260578==--
