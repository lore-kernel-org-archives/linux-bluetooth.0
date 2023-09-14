Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D437BEEAA71
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Sep 2023 21:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjINVgf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Sep 2023 17:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjINVge (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Sep 2023 17:36:34 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E652708
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 14:36:30 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-770ef353b8fso95465885a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 14:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694727389; x=1695332189; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=07P4BlMWp9nK1g5GAZ4XeX8YnFPb4ZE8SK3CEqpTj14=;
        b=oDASw0RE2nKBmfbT2Y4zfITDDyTH2fNVC0v3kIMyssllPsHJQghC253FxBvLVJOyWQ
         GfC7gvSEypxt5J72OMoKTWWBHXVt29b4qVdfyRGrl7+criiL8enyUP/0LUyh3S0IFBNx
         sSznUSP6iRYByxG11AFECGdcjjGbQj7LfNWQLqZLT3+O8iKWKV6cv9zcEupDqSzaq/RU
         6/8X7zJWIEOZBrgnZoMDhs08RBrGqBCLo/trQETKTzm2+wkQtKNBrMZM4XTMJ6Cl0tE3
         hw3XmuTbvWsM4UQO/SnM6j7ZS1xHfWdZ0eryYJTrdT1Ugl5B/ttGHVEsy4o2xkfr1Xl6
         CAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694727389; x=1695332189;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07P4BlMWp9nK1g5GAZ4XeX8YnFPb4ZE8SK3CEqpTj14=;
        b=APauPvjPzQ3VUrs3rPRA2cAJhz4FDkg1hDToSM0vrW8pl4DdAa9DfMMScJwodBAdVB
         N7DFwzgONdvj8Hpji01CaU72Bl0Qs0O9LRaJvdr/kdd1J4+LbdpfrD7QIcB4BwCybEe6
         ll/Ekd1cwkURfUWsJekYVhsiDKnijlXpowx/iGig+Huo+HgugfUvLGEFCot7lxVQDTk6
         VvBqpTRjgQnlfhapQfxlDVuAFIEX/ADez22y/gjtJATfoFIwHIDxDdi3vlobAd+fxTOT
         5UUJW+lAIqSkVIb4NJJ31Is9lvSZ6ptpoI0YIIetnh0HQPvIOnMoqGNAMMbM+hXTVT/H
         Flcg==
X-Gm-Message-State: AOJu0YyhAEuP+Bgd3I7siiKh9UbWeWpRmfhw9nrjKqwQP+E408274hVs
        gT7aVLtmnjiF+4/2RkBx+/4bTXWbgt0=
X-Google-Smtp-Source: AGHT+IHrn3JQUO3X9vrpAJGsRpisKzxQy2Ja+W3vC8cSfYn2/f7Ou4WPFysub/HIRJIKWlIRTFU+bQ==
X-Received: by 2002:a05:620a:951:b0:76f:1707:bfe with SMTP id w17-20020a05620a095100b0076f17070bfemr6594780qkw.66.1694727389014;
        Thu, 14 Sep 2023 14:36:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.44.3])
        by smtp.gmail.com with ESMTPSA id v27-20020a05620a123b00b00767cd764ecfsm757971qkj.33.2023.09.14.14.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 14:36:28 -0700 (PDT)
Message-ID: <65037cdc.050a0220.9f8c7.3d4a@mx.google.com>
Date:   Thu, 14 Sep 2023 14:36:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3774313854794600348=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix leaking l2cap_conn objects
In-Reply-To: <20230914210358.3335206-1-luiz.dentz@gmail.com>
References: <20230914210358.3335206-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3774313854794600348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=784341

---Test result---

Test Summary:
CheckPatch                    FAIL      1.43 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      35.73 seconds
CheckAllWarning               PASS      38.72 seconds
CheckSparse                   PASS      44.91 seconds
CheckSmatch                   PASS      117.19 seconds
BuildKernel32                 PASS      34.18 seconds
TestRunnerSetup               PASS      511.69 seconds
TestRunner_l2cap-tester       PASS      27.94 seconds
TestRunner_iso-tester         PASS      54.37 seconds
TestRunner_bnep-tester        PASS      10.71 seconds
TestRunner_mgmt-tester        PASS      222.67 seconds
TestRunner_rfcomm-tester      PASS      16.36 seconds
TestRunner_sco-tester         PASS      19.56 seconds
TestRunner_ioctl-tester       PASS      18.24 seconds
TestRunner_mesh-tester        PASS      13.59 seconds
TestRunner_smp-tester         PASS      14.56 seconds
TestRunner_userchan-tester    PASS      11.23 seconds
IncrementalBuild              PASS      34.88 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: L2CAP: Fix leaking l2cap_conn objects
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#88: 
Reported-by: Olivier L'Heureux <olivier.lheureux@fortrobotics.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

total: 0 errors, 1 warnings, 0 checks, 75 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13386049.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3774313854794600348==--
