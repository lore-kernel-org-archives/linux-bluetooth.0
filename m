Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC28FCDB482
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 16:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346390AbjJSQAm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345951AbjJSQAl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 12:00:41 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443CE112
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 09:00:39 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-457c7177a42so2863664137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697731238; x=1698336038; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9BB2kcz07AFk+j9y7WlDUJnV0XW33cn6RvqwCtR1MOI=;
        b=cyRUb1JaVthat8xkBWBlkYDbAZdqaSl/z2/oE49y9k7FeVRgprdKBpACgtxzNT19bS
         xmKZZ1PkqMWdeKuwyR6klCq/ii2nf8t4ZAAuFJnaHiN92NZI5tA7h976DJJLSwZUbs0i
         SDoVdTtlaQXdO64txd7I4ZDsk1wVsZewwrPHDY5Jn5m7nZtlb3C2N0JKShl0bSR8C1Tf
         kJme8Xg9WaTdplKYHDMkWRqlkiA02D0Sr8vgvgWX0SgyJ70rEpDzUGM+x4n1FfJKQcaR
         j6ovD6bpoKxlwV5ZnwBcI3hP6EThddYLJlZTzIyDqkbaFxtlVTiaAt7vWKxdYXfKkmcL
         tO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697731238; x=1698336038;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BB2kcz07AFk+j9y7WlDUJnV0XW33cn6RvqwCtR1MOI=;
        b=uBOYRRkfBI0JyVqCtXnBW6+hjGE2pyEXkXAoif7TCuA3L+DehZgnP+3wUIblGuL8Dr
         2TpCU3nL+J4pGGVyc29X74sthGIDAsTBuI6dmSl1v3RQv3GhOpsDb2Or7W91zrEDIQJC
         sPSp9+osNLoBzzwQoTI04VyYXpQgGi5hE6Bk7hITkahnQ77tq8oAb+cj5bpaugelgd/T
         p8vBR4tI9ksxkPcsTUB97C5CInvXdxY0KMZLFiU6KpRjg3WIk2J0yk/2JkoRCLvrxK6Z
         OcXtEd7xfZGGDmhHmivciH4icXpo9HcKs5nueHicSFAAB3bJevqv8a5AniuhB9ybZqMj
         dU6w==
X-Gm-Message-State: AOJu0Yzs0wqR/6t/z3hUzk5kfIxgaooSirj8f8h6nKQwylZd9pCfN+KQ
        4ZsEHfPCWeHJP6CnEGI/l1l5e1M3Xj0=
X-Google-Smtp-Source: AGHT+IG99c8uC5ZQK/Qhs5biUEAHmhWEyQjM8KZ+zumzOQqlLCYMKDflEKegU1zBaOGr9SGlmdmxOg==
X-Received: by 2002:a67:e013:0:b0:457:e881:32c6 with SMTP id c19-20020a67e013000000b00457e88132c6mr2149526vsl.11.1697731237963;
        Thu, 19 Oct 2023 09:00:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.61.50])
        by smtp.gmail.com with ESMTPSA id t7-20020ac86a07000000b004197d6d97c4sm819824qtr.24.2023.10.19.09.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 09:00:37 -0700 (PDT)
Message-ID: <653152a5.c80a0220.8e2b2.4b10@mx.google.com>
Date:   Thu, 19 Oct 2023 09:00:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0122289648545836018=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Fix source+sink endpoint registration
In-Reply-To: <20231019135443.3806-2-claudia.rosu@nxp.com>
References: <20231019135443.3806-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0122289648545836018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794752

---Test result---

Test Summary:
CheckPatch                    PASS      1.22 seconds
GitLint                       PASS      0.77 seconds
BuildEll                      PASS      37.73 seconds
BluezMake                     PASS      1274.12 seconds
MakeCheck                     PASS      14.15 seconds
MakeDistcheck                 PASS      238.31 seconds
CheckValgrind                 PASS      358.38 seconds
CheckSmatch                   PASS      495.67 seconds
bluezmakeextell               PASS      158.29 seconds
IncrementalBuild              PASS      2265.49 seconds
ScanBuild                     WARNING   1540.07 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:4753:23: warning: Access to field 'type' results in a dereference of a null pointer (loaded from variable 'lpac')
                if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
                                    ^~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============0122289648545836018==--
