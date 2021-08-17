Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF7EC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 01:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 429EB60EE5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 01:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhHQBXn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 21:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbhHQBXn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 21:23:43 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C19BC061764
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 18:23:11 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id l3so15846720qtk.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 18:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=w3lKFyvAD4lqVJyodU6AeD66/hR0a1WMA73cfDtQOHw=;
        b=k2plAmpC1VMsqNmbdaTqrNk/sn5zF1sDZdKUS9AiH25jVUmguAnZwtaYdeewIwTOAh
         9VaMbcmhwLntDx+YOerIZ2u16LYWwTy8seMLh2bVdc4OnfF0l4tQcHqfe5Hb2iyuUClL
         5pLxevlyv0xjcA01lSFzwRggHANYdGFJqn/NTMIdgny+VOPt3/VDsgzO2F1Xr+AQsv6w
         de0uiWATAvjSSEvHMlgYoOTsR5k19JCxsCQafrzFsEpMJeiNNic1zFpHABFQqlEgzxtd
         5zmoLddsK6EpfYuEvMa1EEXlEaFleB0sy73qcYhmwPzIBxrmd40s602MeJdZw3JcVH1+
         w3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=w3lKFyvAD4lqVJyodU6AeD66/hR0a1WMA73cfDtQOHw=;
        b=EcURqQP2DlmaSOdtnSe3jNqs7n3qNcFA0WC8i1uzHIlQICs66Aicfyd6jMJDkdOfB7
         XJ0clswJHbVZewj1VxiUivhuRs3QIRcW4mLdNadM9iFIdoaYfUxvDT80B8npI/ozbf/o
         pnTzkDQPK2pvbqGxz+Mxw5shD6VCGIQpe8Rt9/wiNNfbkv1UCQfZr2JNJdPcP6aZAkV7
         nIbbfkAMv4eaNOHnS2qclz3p3RJumbZo/t82LDm+BUCLMPq1fNFRTmaXJ0lB5Uu7pTv2
         5JaudXDvwfW0kbHQdHqSIHWmHEvxwKBZgbjtQbmGlrEvfOTF4iz1hUxAJuQiwnSGN7tu
         eSYA==
X-Gm-Message-State: AOAM5323KQFgR+tk5zNIpxGfa4VwMMUPwGOMI68nNEnTAS8/9Gg37dtP
        fZCfn5HZmMIbQbWKHHJd4gubNvYh/Tf1aQ==
X-Google-Smtp-Source: ABdhPJxURqOdnLjwFdDe84CBJpwGzy/U1Ci1KQHuD7vycEX/3eRmfKMOcNibQIAJpjwejCi87TNPLw==
X-Received: by 2002:ac8:7b47:: with SMTP id m7mr838051qtu.178.1629163390308;
        Mon, 16 Aug 2021 18:23:10 -0700 (PDT)
Received: from [172.17.0.2] ([23.102.96.93])
        by smtp.gmail.com with ESMTPSA id v22sm212819qtw.18.2021.08.16.18.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:23:09 -0700 (PDT)
Message-ID: <611b0f7d.1c69fb81.21cfa.14dc@mx.google.com>
Date:   Mon, 16 Aug 2021 18:23:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7092634516382724514=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,1/3] adapter-api: Add Experimental property
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210817010237.1792589-1-luiz.dentz@gmail.com>
References: <20210817010237.1792589-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7092634516382724514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=532387

---Test result---

Test Summary:
CheckPatch                    FAIL      0.94 seconds
GitLint                       FAIL      0.37 seconds
Prep - Setup ELL              PASS      47.58 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.30 seconds
Build - Make                  PASS      206.51 seconds
Make Check                    PASS      9.41 seconds
Make Distcheck                PASS      243.43 seconds
Build w/ext ELL - Configure   PASS      8.36 seconds
Build w/ext ELL - Make        PASS      194.51 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
client: Add support for printing Experimental property
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#10: 
	Experimental: BlueZ Experimental LL p.. (15c0a148-c273-11ea-b3de-0242ac130004)

- total: 0 errors, 1 warnings, 63 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] client: Add support for printing Experimental property" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
client: Add support for printing Experimental property
7: B3 Line contains hard tab characters (\t): "	Experimental: BlueZ Experimental LL p.. (15c0a148-c273-11ea-b3de-0242ac130004)"


##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============7092634516382724514==--
