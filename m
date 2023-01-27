Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1219AC54EAA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Jan 2023 21:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjA0VMZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Jan 2023 16:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjA0VMY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Jan 2023 16:12:24 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D05488CCC
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 13:12:24 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id cr11so2453001pfb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jan 2023 13:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=egEViO+5p8KAVXN6+Znxn25TkiMDVyoag6w2xfCdQFU=;
        b=Ed1VqcRmHaQoIrcxAwnUtTjsxPpOMAU07LpzIoz4fNzm88UPAr+yVf4XVLW72qMkqk
         8hQ2f519NtsO0SC/jXcGOM9/9Q3PoBiMrK3b52m6tXDINv9Fs7XAePekCJzwHYYOPbXe
         ATAxGfzAFsKmZ4VyquS34fAq2eN2PsHVpD8vftBu4z8/+lP/G7ApQTNhqh0rWFPJYwjI
         wVDtgU/ZRSwhzq3imJP1+woFrWXSUGO9uF89ftimvxVm8j5Th5h9dYkZltIBXU0XFx7Q
         EYWGJannzjpKGAS7NsFK2TQDUHSngM0hVUnM2GYc9JT4zsgZVst0y/yuz7udHJQVPdj/
         VmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egEViO+5p8KAVXN6+Znxn25TkiMDVyoag6w2xfCdQFU=;
        b=EVta2LHwuP+FZdNA7RtEzMqBHx82MDP0vpRAly/vJWeopJTeO9v59QLKlFvEGOUPR6
         U1jvx6G1Rjt6DznCi4bpt5BP1gz8xnEEoc4JTMX8dRh8JHY7KI8aZKnry2htYpa1A7TI
         OJohuegp0k4WswaqE4IBecMtBAI0RTLhRwMEpdNItNEPJM68YCsaj5O0sLrVlrbzyRQ/
         1/D6tKBBAtUNp6UtzVR/YShWnOYc+OTvKgBcOGOzV91pBRq8tjSzDuyQRog7etAn2KFO
         r19aKHtx84PCLd8/qThzSVtKnUImKMxmV8E4uIXCSP0YsVYEwNb/hUeQG1Ee2HhTtttK
         7LOg==
X-Gm-Message-State: AO0yUKXn5XN5DPSZs7TlPdomQZ3tRowypSWurLW3ou+zNeC0j5d2g3w3
        9uy1K2YOGEyfRVmRpT4o/1uxkSRBE3E=
X-Google-Smtp-Source: AK7set8LLCFfFw7tfCW907HlG31gK0C4l0VR9qK48nbndyodfTbADyXV/qtZHLUpalaD8rOojjn/Aw==
X-Received: by 2002:a05:6a00:2a7:b0:593:b49:16a2 with SMTP id q7-20020a056a0002a700b005930b4916a2mr1804174pfs.12.1674853943487;
        Fri, 27 Jan 2023 13:12:23 -0800 (PST)
Received: from [172.17.0.2] ([4.227.0.129])
        by smtp.gmail.com with ESMTPSA id y7-20020a056a001c8700b00588cb819473sm3044990pfw.39.2023.01.27.13.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 13:12:23 -0800 (PST)
Message-ID: <63d43e37.050a0220.bf078.4f49@mx.google.com>
Date:   Fri, 27 Jan 2023 13:12:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6289366465735261472=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [RFC,BlueZ] bap: check adapter support before enabling BAP
In-Reply-To: <20230127205205.20235-1-pav@iki.fi>
References: <20230127205205.20235-1-pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6289366465735261472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: include/net/bluetooth/mgmt.h: does not exist in index
error: net/bluetooth/mgmt.c: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6289366465735261472==--
