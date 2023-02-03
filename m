Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7460EC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Feb 2023 10:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjBCKfY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Feb 2023 05:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjBCKfH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Feb 2023 05:35:07 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F484A2A57
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Feb 2023 02:33:59 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 203so3236947pfx.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Feb 2023 02:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HEx64Uy65ajlXKC+9rb/9gZlPx6GVBln+Z80o1SrC88=;
        b=VVCItLkc/dw3tGMI+dkWCm4CiYQH15nMdyIAambxY/PPYCGQaRATEu4T2M4LadJBcE
         b7JNsdROnjxoRWU1RaFaTtZrLqBUQTNX+vkE+Jy0wayIgM89q4XI16ws5CwqBCXwSV4z
         zjQhJyifj5TTjV7nOxAkpI24LosFUDoekvEF8XBeMJJh0P8DhV7LMhEx8EgBBS1amXAb
         siMEYi7E2gtx+Wi+FgfHzoqYxOHWWDYDsUY/LoDf53Q3bbx0IMBHwBLgmPSbuJJxFKpe
         BMYIjKT3hhkz9OhQeqZj6930JZdhkHR7qQFIDtC8fnrnodJSEDh8oiCZEjBy0WihndI6
         83iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEx64Uy65ajlXKC+9rb/9gZlPx6GVBln+Z80o1SrC88=;
        b=yV9ya9w9I7PHf/XxdR0Ma3locDQBP12SHmDzj2nqU5zICuyc4L+T7tz598hm29evR+
         9Ci8ZuB8RLmAMwJGqZTr816YoIRNRjAL1l3N2F4BxIaMaM/yYK5xt1gPESJI5Z/H5lGO
         fFZRV4bB3Lt8sU4arCDsFPnxXheMzngHtYRRHvK87/BSoDWaSBzQZVf5f+SoluLbXm+u
         y9KAGjaKYaFtZDPuCSGoYibF+xffcnuAYbaAbwLH/9eER5mULMN5d7g/o9lIw5Tjp+jZ
         VTZ7oQP5xc51MXQ0FCoSuulVHmReJ0e9LlBBAdGhAKxyasKgAhmbEZwESyye5/tl4jzL
         YC8g==
X-Gm-Message-State: AO0yUKX3lWCvEvhcm676/8tA2cP8b417NxENTaIZ1Wp/tdQ4avUmoUiH
        FlJ4Y7AGQ76KHpdL0ft32MuHhR4KKPc=
X-Google-Smtp-Source: AK7set+OaS8GorPPN9Pzkf5TqXYuNKaUIAymSL/dp4m/cbOsP6Uy72hW1Rt7w/gDzQQZApbaESxmHQ==
X-Received: by 2002:a62:640e:0:b0:593:b0f7:8734 with SMTP id y14-20020a62640e000000b00593b0f78734mr8094541pfb.20.1675420438813;
        Fri, 03 Feb 2023 02:33:58 -0800 (PST)
Received: from [172.17.0.2] ([20.171.133.128])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79a50000000b00581172f7456sm1364721pfj.56.2023.02.03.02.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 02:33:58 -0800 (PST)
Message-ID: <63dce316.a70a0220.5fbcb.23ad@mx.google.com>
Date:   Fri, 03 Feb 2023 02:33:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7855444780879890013=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Bluetooth: Make sure LE create conn cancel is sent when timeout
In-Reply-To: <20230203173900.1.I9ca803e2f809e339da43c103860118e7381e4871@changeid>
References: <20230203173900.1.I9ca803e2f809e339da43c103860118e7381e4871@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7855444780879890013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=718497

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      31.04 seconds
CheckAllWarning               PASS      34.10 seconds
CheckSparse                   PASS      38.58 seconds
CheckSmatch                   PASS      107.26 seconds
BuildKernel32                 PASS      29.94 seconds
TestRunnerSetup               PASS      432.55 seconds
TestRunner_l2cap-tester       PASS      16.06 seconds
TestRunner_iso-tester         PASS      16.60 seconds
TestRunner_bnep-tester        PASS      5.44 seconds
TestRunner_mgmt-tester        PASS      108.67 seconds
TestRunner_rfcomm-tester      PASS      8.57 seconds
TestRunner_sco-tester         PASS      7.88 seconds
TestRunner_ioctl-tester       PASS      9.43 seconds
TestRunner_mesh-tester        PASS      6.80 seconds
TestRunner_smp-tester         PASS      7.85 seconds
TestRunner_userchan-tester    PASS      5.64 seconds
IncrementalBuild              PASS      28.37 seconds



---
Regards,
Linux Bluetooth


--===============7855444780879890013==--
