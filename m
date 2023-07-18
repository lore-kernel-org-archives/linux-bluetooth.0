Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE48EEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jul 2023 00:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjGRAO2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Jul 2023 20:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjGRAO1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Jul 2023 20:14:27 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C84BE48
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jul 2023 17:14:26 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b9c9944da8so1914584a34.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jul 2023 17:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689639266; x=1692231266;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fMkGgfdpsm9mrmDPtLdyuLEQmEZw3ZRfx19FyQiXCb8=;
        b=DfanbAZCBSkaCXD/GcX30nTQhZp8FMajyqMiJE/9i6Ih3+0oqhvd7bixm83CntGa2m
         dhwY5EpUhlj+GZ1ZZvJawM9+oXnoGxZDkLOMIkN+DoHrGu0/muqdmlpScnYb2i6n5oE9
         Z0hVCiRzCF8g+5U43tULETiHvsg3lfwndFD+JdLV6+zST39UWigvw6EMRWZRbG+ELBJe
         8l2XH+bj7FKbB6fB0lMtG+ZnjIqmXIcMjHiNVsEMp3kR0CdgPaF8DY5ehpkbZ42rdB24
         rRmdQkTL5XH7OG9pyY51cb8jKCLVRbKQt1gZIoUzwIUnJq/nkiZjbmAGqTMBd56QxTBP
         DmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689639266; x=1692231266;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMkGgfdpsm9mrmDPtLdyuLEQmEZw3ZRfx19FyQiXCb8=;
        b=JUt13+OecFFTk2Y37PX5mTBObPJhbdVd0SW+OJeInSE29A6OArjuqWGd/crlROXAgX
         AbiGYLzs2Db3xZ45Z9RzCF/YNnbO3yhP9dO4oRwE+DyGTZiP8sBspgTMxporZ6YVzTuZ
         gzcFJyjZMu2OBrNKu5XCeDZoq8iuYICJ3Iu2y4DO8rpJBwfihPbEvwctlRVEbVEqy611
         oAGCU//zDPaU93JzwEMcmQuwMIYn1eve/Nd3/uZmP2UfgE3CTL0f8XZWQf7Cwf1gIkFZ
         fd4cNKxeVu3RJGf/9WJGNeQnVPqbD3MqqvBeVSsyuxIlJxCBx75VQ1cbY2aSa2ejuQka
         ypiA==
X-Gm-Message-State: ABy/qLbI0cvK+IqB2FBNeVWMQcBVo74AyvA8XhIjUQcpwIH8WGEyfbUc
        O25IsXFam+I11rbRnmFDkUugASBQKTI=
X-Google-Smtp-Source: APBJJlFHtAqHE8iojcwN8jF9IpK6MlK/IFseeb6Pig+KSCqWul6cN9UE0Z+dOwSfVShqDEn+qAGO3g==
X-Received: by 2002:a05:6830:618:b0:6b9:107b:5978 with SMTP id w24-20020a056830061800b006b9107b5978mr12080684oti.27.1689639265780;
        Mon, 17 Jul 2023 17:14:25 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.189.47])
        by smtp.gmail.com with ESMTPSA id x4-20020a9d6284000000b006b29a73efb5sm424515otk.7.2023.07.17.17.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 17:14:25 -0700 (PDT)
Message-ID: <64b5d961.9d0a0220.c7cc1.3cde@mx.google.com>
Date:   Mon, 17 Jul 2023 17:14:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5310550153026336177=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] btmgmt: Add man page
In-Reply-To: <20230717230445.168998-1-luiz.dentz@gmail.com>
References: <20230717230445.168998-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5310550153026336177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=766724

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      27.46 seconds
BluezMake                     PASS      875.87 seconds
MakeCheck                     PASS      12.01 seconds
MakeDistcheck                 PASS      157.85 seconds
CheckValgrind                 PASS      258.94 seconds
CheckSmatch                   PASS      345.64 seconds
bluezmakeextell               PASS      104.94 seconds
IncrementalBuild              PASS      716.21 seconds
ScanBuild                     PASS      1087.55 seconds



---
Regards,
Linux Bluetooth


--===============5310550153026336177==--
