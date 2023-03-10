Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E125C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 03:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCJDkH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 22:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCJDkF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 22:40:05 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E15900A7
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 19:40:04 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id b12so2245291ilf.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Mar 2023 19:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678419604;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ejr7xVbnNvzmBKk0zLmXx5/edp224mTL/GkNhQ1KQXM=;
        b=BW0eky9DMNcY/rehz5Gbt+CiHR24quYekFSPyz0NRapUMmIR34PokaUr8qaYttQu3o
         3ahwW0BmaATfU8je+G1xcCWCH2hqO8a+Hb+33useVd50aalyLcpNYV35TWqF1Z6fmIgC
         pHbe7CP7jMFq8BfXKmeOzyBz8ZCYNzaTOSRBlyULk3nUccLwukwGW7eoRUYzHvV5QDxF
         XyRSVSaPEpGJAUHiNQ/mvzfWP5VTFIPIJTmmBJwMykzwqiVCPjA/AIIF8olgoSg5sWdP
         JayNpAbYllVl/aiT8Higke8cVdzA32OAT5j/dMp7V+8it0PHQhbRaJjaSr0Jw8Syw9tI
         BADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678419604;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejr7xVbnNvzmBKk0zLmXx5/edp224mTL/GkNhQ1KQXM=;
        b=VGE6yABirwKy5Le3gDhz63NxGc7MEN+Ypym8uHrH/LK43NcWxwFdhBc+Q3HJqWC0wE
         ABebhpdNrKJbjpqCbNgLNohUVeYmym3rDWGtKYgrQXC3sCZWPXNV5SD3+nYBJz5zzciT
         zHzGPAjpnWRShXb+YqRDG5h5WuwGaPfBn/L1GzffQ7/HG6KNXiH4QpLL8BkKYr/Ja8tQ
         4sAVzSrvSzWiQ9m0PUR16yONtRYWMNJ8RXUZg7pm57/YvteCyOC08ZqY5QiRXSAdU8XX
         DfWGVEOBCQxsQ87lhQfKfmGk6R92HG71K9aNkGyaSo6ZKVjm0IVIuuWRFz/nWzXV5SFI
         wKzw==
X-Gm-Message-State: AO0yUKUk4JrdZGGEil4LcywptEskriZIpSScApigMdXdFkvlxXZSksby
        zXWvd8QBDIK9uBgQgezpdThJSPnVLh0=
X-Google-Smtp-Source: AK7set8kpsk+x4esJjfrkLRr+8mc2DXNBDZk5XawI1h6LNOU7pdVNl14kw1hHy1+nFpPNm257o/rxA==
X-Received: by 2002:a92:b30f:0:b0:315:9a7e:fb03 with SMTP id p15-20020a92b30f000000b003159a7efb03mr13966307ilh.29.1678419603789;
        Thu, 09 Mar 2023 19:40:03 -0800 (PST)
Received: from [172.17.0.2] ([13.89.2.161])
        by smtp.gmail.com with ESMTPSA id j7-20020a056e02124700b00313b281ecd2sm300921ilq.70.2023.03.09.19.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 19:40:03 -0800 (PST)
Message-ID: <640aa693.050a0220.4832c.0a56@mx.google.com>
Date:   Thu, 09 Mar 2023 19:40:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8210249914331646171=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] mesh: Fix node when loading from storage
In-Reply-To: <20230310013512.425033-1-inga.stotland@intel.com>
References: <20230310013512.425033-1-inga.stotland@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8210249914331646171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=728452

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      26.16 seconds
BluezMake                     PASS      745.72 seconds
MakeCheck                     PASS      10.96 seconds
MakeDistcheck                 PASS      147.51 seconds
CheckValgrind                 PASS      239.18 seconds
CheckSmatch                   PASS      319.60 seconds
bluezmakeextell               PASS      95.81 seconds
IncrementalBuild              PASS      603.73 seconds
ScanBuild                     PASS      955.19 seconds



---
Regards,
Linux Bluetooth


--===============8210249914331646171==--
