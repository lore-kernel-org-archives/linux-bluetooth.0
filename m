Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B69C76196
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Apr 2023 04:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjDGEAg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Apr 2023 00:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjDGEAd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Apr 2023 00:00:33 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E75210C1
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Apr 2023 21:00:31 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w13so19064632oik.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Apr 2023 21:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680840031; x=1683432031;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jc/EUO2U9rLvpv//sI5XjDltTYYFEuTWXimzdI2J0eg=;
        b=S2MsuJsKUPl+yBda1KTmLwOxVwpsfyRMMYsdhO7gjLYl+YiccwNmMn5AA6daqJN4OY
         d6LICl8/F1sZ/TJJUj3s3/AlzhR3GSWCOSPHQgK2fiqQQOTuqhd4b1arvRQrWpI9hE31
         EYzANZom2AKPA3x+Ys4teB7nwDlwJKh62+x4gFyqhAObppsVyWWTrx+Z25nRQiS2aUBu
         3kBjPuXQipYmfIvdZOA4g0+O+VDYOgfGWCUxzvGb9kiD9RLmNIbLtOQay8JGtwBij05h
         /YlZa85+1bvB/1wU9cQFUUjJQg8U5Rx7WLlsAha07pjEDAbuDtB9RH+LdSZEA7+XfDwD
         j38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680840031; x=1683432031;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jc/EUO2U9rLvpv//sI5XjDltTYYFEuTWXimzdI2J0eg=;
        b=mkHqKh7RzE+H3IkTgRB67I1s78Kjpw+z4OF4iCiKwiLDXgJ7EoEvMw0wjNJGa+pJ63
         PVsVG6P2W5HCJ099ct21FIv/0i3bmcXHgikklJtgPC8GxqDmANW796OZAjZpbfBPlg4f
         qT7p7KPMAEjGHPcBG2z/tT1Lsahwxv9ocRhvkyYPWQ3+e3CG/vzu0H0fQAJlXfr5HUtk
         E6J6aYAP1LXm4fs3dcYaNhqjyUFkLJWlq8hsTupQawn04aFKIBNJ5fwh3s353ZO86OkS
         DvK0vS9Q0I0UzxhSe4AWK2g6zf51gukm1MziQWr8a87khvtS7g5JhC5OU7l5rAv2tPIv
         Uy2w==
X-Gm-Message-State: AAQBX9fueq7b1UkSbc3iOfYlJ8NYZlDcIEwNKLxGC8+n209voc43hIWq
        8mDo87EuKAmrtYxned6BlKhWbyScMxg=
X-Google-Smtp-Source: AKy350aqtQx6PDxw1r5DcyKOmrdGgNFApeKlBLOFxu39UEDyl/PJp0EuflKYhiHmRG5Tfr6WPjF2/A==
X-Received: by 2002:aca:670b:0:b0:386:8840:5693 with SMTP id z11-20020aca670b000000b0038688405693mr458829oix.50.1680840030798;
        Thu, 06 Apr 2023 21:00:30 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.132.176])
        by smtp.gmail.com with ESMTPSA id k9-20020acaba09000000b00387367989d7sm1384391oif.23.2023.04.06.21.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 21:00:30 -0700 (PDT)
Message-ID: <642f955e.ca0a0220.b6506.673e@mx.google.com>
Date:   Thu, 06 Apr 2023 21:00:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2759729996617514452=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v1] Bluetooth: btusb: Add WCN6855 devcoredump support
In-Reply-To: <20230407032936.14799-1-quic_tjiang@quicinc.com>
References: <20230407032936.14799-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2759729996617514452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=737858

---Test result---

Test Summary:
CheckPatch                    PASS      0.91 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      39.44 seconds
CheckAllWarning               PASS      42.79 seconds
CheckSparse                   PASS      47.64 seconds
CheckSmatch                   PASS      129.10 seconds
BuildKernel32                 PASS      37.10 seconds
TestRunnerSetup               PASS      527.69 seconds
TestRunner_l2cap-tester       PASS      18.06 seconds
TestRunner_iso-tester         PASS      18.64 seconds
TestRunner_bnep-tester        PASS      6.21 seconds
TestRunner_mgmt-tester        FAIL      124.69 seconds
TestRunner_rfcomm-tester      PASS      9.74 seconds
TestRunner_sco-tester         PASS      8.95 seconds
TestRunner_ioctl-tester       PASS      10.31 seconds
TestRunner_mesh-tester        PASS      7.80 seconds
TestRunner_smp-tester         PASS      8.86 seconds
TestRunner_userchan-tester    PASS      6.49 seconds
IncrementalBuild              PASS      34.92 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 494 (99.4%), Failed: 3, Not Run: 0

Failed Test Cases
Get PHY Success                                      Failed       0.141 seconds
Set PHY 1m 2m coded Succcess                         Timed out    1.970 seconds
Start Discovery LE - (Ext Scan Param)                Failed       0.153 seconds


---
Regards,
Linux Bluetooth


--===============2759729996617514452==--
