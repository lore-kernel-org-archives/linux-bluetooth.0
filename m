Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA2CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 02:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbiKRCKu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 21:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiKRCKt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 21:10:49 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0135716F6
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 18:10:48 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id c129so4005922oia.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 18:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d0PD40GLroX0qhHbD6kajN0x8vYQULGNhZh635nu0iQ=;
        b=Piq6LtxeQi2i/v6j5vdXgh1GATsxKnbwmFMjObDAlUYiYt+jaFqF0I0A9IGRdVJd7i
         ko6pkFDF1Jk8lInNZF6B1DZw2DYN/Uxg5diVNFWVrLk6ImxwRK5Gqh7j7LAL9JcrGF2y
         HEb3/HcXpvqYQDHrhMruDb7vyP3jkws1vUAHtXoELLgkJ6Wg0FsJWlFbNoSJ2/nmOylp
         6VdbQJWsdiO9FYoX1Q8mXVzbL5HTzuzGKr/COXv6cPFKb22HZA4Uqoz3f58T2KjWiJhj
         6skHaKi0ic18WWBsBz5L7FPkk6iqhXxpR6K++yfZhyThJYLVHrS2oyjVeHaAfLDsctS3
         PWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0PD40GLroX0qhHbD6kajN0x8vYQULGNhZh635nu0iQ=;
        b=LfuC2wrAd3d56Anu8r1eLaL1NLsuxB0iZHtJFE9R8gfyJMc63roDidnlCfQqUO6Pyq
         0+aYeH8YlbGs8QXM35pdhEebFozTEUSSyMFqePi5GTrZFWRmPFPxSU0X1L3XxEpj5p/N
         vL6y+tQ/UhFs4ABssePqkcJWRjB3Yj4WTTiF0FVEUTw4M9qac5kHbQHYmWhkRv4gmlft
         RETh0YOp/hKE1yVAr2VoBo9BhH8gs1Mp18OJq9EiMnZchZpczl4gJcH0h2YWxdsMqEQN
         m47MYuHbkc/AH+wv75tP/iBOQbe+jq/GSVQHnYfeRDuQ+1Wi6G/DDrx6seSi1gRKR9ka
         lenw==
X-Gm-Message-State: ANoB5pkrQgNUbRLzVl7T2X79aheWlUhJiqbhIJVy1Siso4SvQPZvgQ8U
        fZDcMYEoBsiQMlMlW0iBWlrsROa0Uqo=
X-Google-Smtp-Source: AA0mqf7ERdH1gNaCuLhy58NExYWXSu9sR38TewscimO13wnbIWupXDDg2aO0iom5ojqE4/bjFp+ZEA==
X-Received: by 2002:a05:6808:1703:b0:35a:60a3:77d8 with SMTP id bc3-20020a056808170300b0035a60a377d8mr5344722oib.127.1668737448043;
        Thu, 17 Nov 2022 18:10:48 -0800 (PST)
Received: from [172.17.0.2] ([20.225.227.9])
        by smtp.gmail.com with ESMTPSA id a9-20020a05687073c900b00142169cb977sm1317268oan.7.2022.11.17.18.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 18:10:47 -0800 (PST)
Message-ID: <6376e9a7.050a0220.513cf.6751@mx.google.com>
Date:   Thu, 17 Nov 2022 18:10:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7537348639194292687=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v3] doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052513.57081-1-hj.tedd.an@gmail.com>
References: <20221116052513.57081-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7537348639194292687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695796

---Test result---

Test Summary:
CheckPatch                    PASS      0.35 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      26.19 seconds
BluezMake                     PASS      743.27 seconds
MakeCheck                     PASS      11.69 seconds
MakeDistcheck                 PASS      145.12 seconds
CheckValgrind                 PASS      236.67 seconds
bluezmakeextell               PASS      92.38 seconds
IncrementalBuild              PASS      599.39 seconds
ScanBuild                     PASS      950.04 seconds



---
Regards,
Linux Bluetooth


--===============7537348639194292687==--
