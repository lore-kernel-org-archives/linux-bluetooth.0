Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B300FC54EBD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Jan 2023 02:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjAJClV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Jan 2023 21:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjAJClS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Jan 2023 21:41:18 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C783695A0
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jan 2023 18:41:16 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id a25so2724667qto.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jan 2023 18:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tTnRrr33xJNB3tSqYYuFfDfK/h3p/XkTzHdGP+1yz+E=;
        b=ZI1lZfLXBlpVucCddfsvREvuc0M4KJUGp6j5z8hJ6RoXT5Jg2g3NV7oh887TWLEvAy
         +plIE1TwUs8CtuGdkFyxCVZT7Vid7yfXfqSBtn20p4HlGgnTYFvpqyslCmM9WqoEO1l6
         be5lmvgyCI/BB/ac639QKt+PqMj/W5+Ig3xiqpN2OMQQQ02UIv1CZh8XEvEHddtxawnH
         aTjxnabr5za7PqDw6pPu+aw0r1QzMx+DQm4TfNObo6ARLLkJUalFm0n0fQhnRuWr/QIE
         k/Fx8OfYD2xpKNRUmmd46EZrP7XZsYh/nAg2q09gVV1fCSK1/d4nGoINtJ52jEKiG/+n
         w1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTnRrr33xJNB3tSqYYuFfDfK/h3p/XkTzHdGP+1yz+E=;
        b=CwJ1GJ18NBsa8X8id3952mHRJZwBlsA31YOqdB0XOwfVed+cJIvOwKU28YC9aimL3q
         Ykfv/YK+6EV0xPhHHjLBY/HYtlFcXNGy83HLoy++raq3GB07PSNnGmX9NFZ0VxgZMzQC
         L9l72qIDuLMVG2tO4Ynl27um1hVII1tNAHpJI10khEDACbJReqGz2uATvxJKdvrik6F0
         VIHEuw/SZvIlykqsLYGZ/0KDsZjF7liIAH/qqkZA17SOLfxZPh0izMKt7w0rz7v+UXRo
         Q0OXHMzs1lIG5q8tr33pFIY1hkEnrfZUlqg3ytfPwUQmOHWChTMXyKcrRoMYXnKUmqXj
         Mmtw==
X-Gm-Message-State: AFqh2kqGK73M7kLum0eRYPamAZac0MrVl+jThXIx1pQVcPrGs80gk5/1
        4VBiQDY73sr3/eM65Am9uwB2kKs7Vq1eCA==
X-Google-Smtp-Source: AMrXdXsHIv1zR7+AfwrNxmayZlaQXGDxtuCnX7DHP4kWvlCusNojsvhxhFhKM5AOimmhOiJuGm+Asg==
X-Received: by 2002:a05:622a:1e18:b0:3a7:e1db:2fd8 with SMTP id br24-20020a05622a1e1800b003a7e1db2fd8mr1674799qtb.50.1673318475824;
        Mon, 09 Jan 2023 18:41:15 -0800 (PST)
Received: from [172.17.0.2] ([172.176.229.19])
        by smtp.gmail.com with ESMTPSA id 7-20020ac85647000000b0039cc82a319asm5447397qtt.76.2023.01.09.18.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 18:41:15 -0800 (PST)
Message-ID: <63bcd04b.c80a0220.9c81a.0ca1@mx.google.com>
Date:   Mon, 09 Jan 2023 18:41:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8373065897262455154=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gustavoars@kernel.org
Subject: RE: [next] Bluetooth: HCI: Replace zero-length arrays with flexible-array members
In-Reply-To: <Y7zBcCkkuIIS4ueP@work>
References: <Y7zBcCkkuIIS4ueP@work>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8373065897262455154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=710341

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       FAIL      0.54 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.38 seconds
CheckAllWarning               PASS      35.39 seconds
CheckSparse                   PASS      40.35 seconds
CheckSmatch                   PASS      110.13 seconds
BuildKernel32                 PASS      30.87 seconds
TestRunnerSetup               PASS      444.99 seconds
TestRunner_l2cap-tester       PASS      15.92 seconds
TestRunner_iso-tester         PASS      16.11 seconds
TestRunner_bnep-tester        PASS      5.51 seconds
TestRunner_mgmt-tester        PASS      105.91 seconds
TestRunner_rfcomm-tester      PASS      8.70 seconds
TestRunner_sco-tester         PASS      7.97 seconds
TestRunner_ioctl-tester       PASS      9.41 seconds
TestRunner_mesh-tester        PASS      6.91 seconds
TestRunner_smp-tester         PASS      7.87 seconds
TestRunner_userchan-tester    PASS      5.96 seconds
IncrementalBuild              PASS      29.63 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[next] Bluetooth: HCI: Replace zero-length arrays with flexible-array members

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B1 Line exceeds max length (107>80): "Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]"


---
Regards,
Linux Bluetooth


--===============8373065897262455154==--
