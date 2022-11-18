Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAAFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbiKREf0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiKREfT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:35:19 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E867EC89
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:35:00 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id 11so3083862iou.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WjumEJ2hoepNg3w7ykiUSvjGzG9b4IGuEcbo5vEsTIs=;
        b=i6b9MJ+ZWARFg2Sdcw99PSHO3rC3hOgm9gDPai8JEhV/aRrHlkWA+n5WrChFhqI7n7
         DihpCbQ7CeNKfoh10RAc5xfEqjkNrFiy63WykhpRLENXoRvc/nKHVljUd4nwctMsXpAK
         hBzs6Q6jU6vTcyQUt1/NGxYGf8cLojoA6etl5tEq/7xIIb6xq4gCW9JI0bcX8jEfXt4H
         U3tbqvWP6gQouYHu3AtL7Wcs9BCaPaOB1mVPuBXsokLE8bTgnwFbwpptPFb6eDBvRyOJ
         Ffr4llTshofXlTGMitLUMb5Xag6cCE1xed+xwHmga3ofwpWHtsr7tRq0LZPA4piRWfqE
         CguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjumEJ2hoepNg3w7ykiUSvjGzG9b4IGuEcbo5vEsTIs=;
        b=a2zwR/vTlsv+gsj2DwymDMleUeuawmsPOMbj5hlcC1ndueh2WR6Rch6pgjos749N/J
         6RfWq4vZUfdxqRCiJhW8sIKm47NhCvkZwkWG/xMgQX8jBJSNlJCmhdXs7sobQUbeireK
         yuGtAH9c3b9pCio2egzUgAj5xPCuISNSagjvi0Dwy/bAN3PlRG0oKe9/DRCSSPrfY4eZ
         C2lnCQkBlMaqB0rbkT/gKrgsEmyRGvriM12yN0WTE41856PHA0JAN7HZa8jJGBZ2K0bG
         oBZ1iMhkOoN7vZBHcFKUJrzrzUVHZ/vuZsG+6SThKwMTJn4vSrRAgFwXeKNX86O2glQF
         zBpA==
X-Gm-Message-State: ANoB5placMOdfaiQGcFi/vtb0IYO8Lwu/1NKDwW+1xw2OINWfUjXgnIH
        Y1abcRrkyx6yrTJw3PApqd1/3ET2HDE=
X-Google-Smtp-Source: AA0mqf6OXU8cN07lTs7mpb8uIgHLsBJZf1PdNSmtdmIOPCpBNK62B2WuAQbyG7D/ZSFWWZro/Xa2Ag==
X-Received: by 2002:a02:62cc:0:b0:375:49ce:39c9 with SMTP id d195-20020a0262cc000000b0037549ce39c9mr2534992jac.99.1668746099379;
        Thu, 17 Nov 2022 20:34:59 -0800 (PST)
Received: from [172.17.0.2] ([40.122.121.113])
        by smtp.gmail.com with ESMTPSA id y27-20020a056602179b00b006cf3a1c02e6sm1003281iox.15.2022.11.17.20.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:34:59 -0800 (PST)
Message-ID: <63770b73.050a0220.f6d50.2595@mx.google.com>
Date:   Thu, 17 Nov 2022 20:34:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5407798380597237581=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] bluetooth: Remove codec id field in vendor codec definition
In-Reply-To: <20221104071810.22720-1-kiran.k@intel.com>
References: <20221104071810.22720-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5407798380597237581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691972

---Test result---

Test Summary:
CheckPatch                    PASS      1.31 seconds
GitLint                       PASS      0.59 seconds
SubjectPrefix                 FAIL      0.42 seconds
BuildKernel                   PASS      34.75 seconds
BuildKernel32                 PASS      31.17 seconds
TestRunnerSetup               PASS      429.31 seconds
TestRunner_l2cap-tester       PASS      16.13 seconds
TestRunner_iso-tester         PASS      16.14 seconds
TestRunner_bnep-tester        PASS      5.59 seconds
TestRunner_mgmt-tester        PASS      108.52 seconds
TestRunner_rfcomm-tester      PASS      9.57 seconds
TestRunner_sco-tester         PASS      8.94 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        PASS      7.02 seconds
TestRunner_smp-tester         PASS      8.73 seconds
TestRunner_userchan-tester    PASS      5.82 seconds
IncrementalBuild              PASS      38.67 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============5407798380597237581==--
