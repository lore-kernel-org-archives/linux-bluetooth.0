Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E132C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 06:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbiKRGgM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 01:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241135AbiKRGgK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 01:36:10 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E42A9A5EC
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:36:07 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-12c8312131fso4940227fac.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eMUgRH4Ev5BVRnXekicMhiLPqqj4y7tBSF/1nWfqmjQ=;
        b=MUOHo23arMuix2cE8H7Z1mIEnSa47KPHGSmn9ZGhyHKddhCVZOepOiRfQbg78OV2Ff
         i9Kw1aFdEOXxwl1ta9NGzS03yz01NKiA8Cw7WscLhmagVKS/N+iDNAih7ECOJ8DxCGYd
         acnJASy0nzhBICjdUEYgkLQUlqoaU43rCZ/9CfbZV3cvPFokLW7Esv7v7V4wKBZAb73A
         ME8XBCr4xQoR+B5drinTt4VmYVjSboXF0EmYrImQ0Yxwvl2Tb1tgSq/0ZvGNh2I70u9c
         5h8+SN/t1m3K/2p52uEJh7NDZ3SYbjh6H6PYs9qkux5oe2/WFIn8ssbys6m5Gk5TxNSj
         jIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMUgRH4Ev5BVRnXekicMhiLPqqj4y7tBSF/1nWfqmjQ=;
        b=KNIloAUsp8ubK36cVJZtZOMKPoPaeh/cFfIKvJ1AzOsCTpFVffy0Kjj5orz8xTv0fh
         FYvxpoALedtdLN3gP4yGys+6Hc4jfgOEumxKVnoN4tPcvXTpXM3FqnWrxPWBS937Llxx
         ScOJDV31uWGCLLS/zgbmk89mq1hJPgTN1TsxfH3qDiP7Ye0CIv4ceW/6hHzC8CQXy52D
         9FTcPNK5ZX2z6tkl4pKTky9704bAdG3T8+kKd1xgOQszKl7YYTD9YfweKP9EaZOqVQvM
         HXPSUUrkNEUh+UisMArpolZFnrTPX5ypUw7URv85fgnIQThH7BEFOZi6aX0T5tVQHTYg
         /sIA==
X-Gm-Message-State: ANoB5pkmVXXexfzK6uMwgVfxTbpDc7O/kzCX0VqQAIholx266D+VQZ/p
        q/LzL3m13H6w2nH915iP6XCHTxQocC0=
X-Google-Smtp-Source: AA0mqf5GzMBHEIOh87DSOs3D7l4gEOFRr+iYj8HFH3/N2ObU7XRlpdRY37Qk/oY3HeK7ArUgK4sBqA==
X-Received: by 2002:a05:6870:1eca:b0:13b:7be7:656e with SMTP id pc10-20020a0568701eca00b0013b7be7656emr6420042oab.151.1668753366153;
        Thu, 17 Nov 2022 22:36:06 -0800 (PST)
Received: from [172.17.0.2] ([104.210.131.149])
        by smtp.gmail.com with ESMTPSA id 67-20020a9d0049000000b00661a05691fasm1189967ota.79.2022.11.17.22.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:36:05 -0800 (PST)
Message-ID: <637727d5.9d0a0220.b4718.51fe@mx.google.com>
Date:   Thu, 17 Nov 2022 22:36:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5465830820182593552=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Fix MSFT filter enable
In-Reply-To: <20221102175927.401091-2-brian.gix@intel.com>
References: <20221102175927.401091-2-brian.gix@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5465830820182593552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691340

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      39.61 seconds
BuildKernel32                 PASS      35.33 seconds
TestRunnerSetup               PASS      482.78 seconds
TestRunner_l2cap-tester       PASS      17.44 seconds
TestRunner_iso-tester         PASS      17.25 seconds
TestRunner_bnep-tester        PASS      6.25 seconds
TestRunner_mgmt-tester        PASS      116.15 seconds
TestRunner_rfcomm-tester      PASS      10.53 seconds
TestRunner_sco-tester         PASS      9.85 seconds
TestRunner_ioctl-tester       PASS      11.28 seconds
TestRunner_mesh-tester        PASS      8.07 seconds
TestRunner_smp-tester         PASS      9.79 seconds
TestRunner_userchan-tester    PASS      6.58 seconds
IncrementalBuild              PASS      36.09 seconds



---
Regards,
Linux Bluetooth


--===============5465830820182593552==--
