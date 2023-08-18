Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A880C678DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Aug 2023 00:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356720AbjHRAgV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 20:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356698AbjHRAf5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 20:35:57 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5961A2D5F
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 17:35:56 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a76cbd4bbfso237484b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 17:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692318955; x=1692923755;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BU5BcQJvibb2uMkmikrRHAku6nVgwZFfk7tkjMtkwWs=;
        b=sGO8dSSo4sywqqRj/K7R3vc6NarcZCoXvbD9yOro5tTZaqeNo4er2GKO2yvP7Gffx4
         iBXeR927xWO3Zoe0nol4h0EpKCH9fyXJwaCC9c3iPHrM22fH4NyLK7Pg2kIXpKHjcifg
         6mBBVrjgFno2NUPSHgilkO3NgqJy6D15p/68x15psitzk7e4tTdUlM06UaJzc4r+pZP8
         iJ8TteWpeN7kho9Yb7pDcnkd7ITPNwUfEDG/lNVxSZJUgQPq95rL1oVMSgmFZUFSZLyX
         pXlliCtor0rcAQP4v2d6WcF/woDGLx5J/R2ecgh9GGOwbEvUrVQijdHu7GW4HS92jMlR
         c2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692318955; x=1692923755;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BU5BcQJvibb2uMkmikrRHAku6nVgwZFfk7tkjMtkwWs=;
        b=LaJnEGD0+zVQKFkSM/BLvbPnAd9U5dg1nrC719W1EB40tL/q2ONmvgUPTAy3LkQA2j
         MCQrjpAWonfedX0Xa5PfpFiRr6tH3ICyYKa4uALwQhntNUM1h9OyhaMMEK/7zn4QG05G
         CmsB1t7gcCHQv/IurBNTtenMwtlF5pqw2K+e6lX6e/Fm3BNKFFG1gn8jct9XWpNxWV8v
         hRoeg6I94PACk0/EyBO6Dazv6ZA0JtIq/+W2fgVpwfMd1Yp9n5sEnvfHaCNj8fsHvLAV
         Z1nkXtgT8iay5zElD0cWK9UoA6Yx2Mg6j0CBjQiBbzBRJEMVSuRbh/aeamsesIun7THN
         nJiA==
X-Gm-Message-State: AOJu0YwGor8sRwyXkEoh3nj+H+TTF01L6zBJDUTS/ejKcD7fCLv2Nbyb
        TgM+eVVMbR72EFYNZyNsK7WwwTLi5Gc=
X-Google-Smtp-Source: AGHT+IEfK+zruB0mhhrimanYe8+sztJxsICetWYQt8FssdeVaypHq5FXk2/gQ1MczsllbOj7b2uIQg==
X-Received: by 2002:a05:6808:2018:b0:3a7:6532:75f3 with SMTP id q24-20020a056808201800b003a7653275f3mr1483564oiw.46.1692318955492;
        Thu, 17 Aug 2023 17:35:55 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.136.33])
        by smtp.gmail.com with ESMTPSA id bj38-20020a05680819a600b003a74933a1e2sm384762oib.46.2023.08.17.17.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 17:35:55 -0700 (PDT)
Message-ID: <64debceb.050a0220.76394.2a0a@mx.google.com>
Date:   Thu, 17 Aug 2023 17:35:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8140197710184001640=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] device: Don't attempt to set auto_connect for devices using RPAs
In-Reply-To: <20230817224103.3042055-1-luiz.dentz@gmail.com>
References: <20230817224103.3042055-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8140197710184001640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=777197

---Test result---

Test Summary:
CheckPatch                    PASS      0.95 seconds
GitLint                       PASS      0.63 seconds
BuildEll                      PASS      32.45 seconds
BluezMake                     PASS      1002.94 seconds
MakeCheck                     PASS      13.71 seconds
MakeDistcheck                 PASS      186.14 seconds
CheckValgrind                 PASS      305.56 seconds
CheckSmatch                   PASS      405.99 seconds
bluezmakeextell               PASS      123.37 seconds
IncrementalBuild              PASS      1634.12 seconds
ScanBuild                     PASS      1250.37 seconds



---
Regards,
Linux Bluetooth


--===============8140197710184001640==--
