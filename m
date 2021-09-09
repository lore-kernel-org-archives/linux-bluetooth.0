Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D34C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 22:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2399361074
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 22:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbhIIWg4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 18:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbhIIWgz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 18:36:55 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB90C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Sep 2021 15:35:45 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id l24so2974143qtj.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Sep 2021 15:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=kDoMeKyoaerm6rzcly/bT9UoYqiUj5tdlOFMDPjqWyM=;
        b=OL6K2REHkh1/O1uiZlFGx8nnXeCNA5y4HFm1SbNeFgku4aqq0cv/E5ZPlVYLDWxjKf
         J/Ffp3OmuGW1AdRQ422Wdf0uEDUHdwx7vZa2CdeBgPV1NE9qlFGuLcyjJ1400nZyDnSR
         kunl1mbOT5VMHYMnZqChlvQPj0RSncOGv3doY9CeaZphN4LYpSsrJZgmM1ZTthV78K0s
         jFhEvmDyZkcPfwFdfLNJgZNpIm4RNMO1sAA9ymhQMErrSBCa1wbviO6rr3zkJKqeCDST
         IsBTEQg09dGJXXppkjtJFYCFc7G08BT0YEotIT2+zUEImGD5+HcYdtXIZgcpfsVSH+zW
         aeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=kDoMeKyoaerm6rzcly/bT9UoYqiUj5tdlOFMDPjqWyM=;
        b=OE9z3OlQQXwqU4lzoEu00Kw9ZgbCGzzlKmsWzi7qfttoTNie2M0IzZUNDXHQwYJpcF
         54sm83l60FFmeYGfBskfj5FBELkumkkwt2iP5si7yu6ZGE//umFlRXOU1FeXSZK30s6z
         vuP7gCfdy1o8UJ4ZGprqnWvuXtddGj/v0v9/yc8/I1MI+c7VG8AjWXw53Zrw+vNQojRR
         CDKpVcr4e0ZkP82mSZ7yc/j38c5IXGMnGdOm2JF9z4kRGQtXfbrM66IeuMADg4Ymm5nH
         QrEYkQz696PqpDYRtWGwCXxTQr7/jV5AXGEtUajJ1gW6FXOKroqWqZY0UPUzKtLaDche
         0IhQ==
X-Gm-Message-State: AOAM530SGWGD93zzDLuSqe4sp/T3+SWsLpAm14tAGIVhmZC11VPKwjEv
        iqILZywJHubMqZR1UP57Ve/x34/QOgT0vw==
X-Google-Smtp-Source: ABdhPJx4axYGkHyLlGlobQBG/7N9ki6s6/gAdFK7hzIQ7xkRNNvxBPIK48kDqL5N+jebGxj43wYjvw==
X-Received: by 2002:aed:204b:: with SMTP id 69mr5197330qta.24.1631226944191;
        Thu, 09 Sep 2021 15:35:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.18.192])
        by smtp.gmail.com with ESMTPSA id w20sm2024781qtj.72.2021.09.09.15.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 15:35:43 -0700 (PDT)
Message-ID: <613a8c3f.1c69fb81.41556.e7dc@mx.google.com>
Date:   Thu, 09 Sep 2021 15:35:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1793464012688511446=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ] mgmt-api: Introduce Test command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210909214750.2683251-1-luiz.dentz@gmail.com>
References: <20210909214750.2683251-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1793464012688511446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=544637

---Test result---

Test Summary:
CheckPatch                    FAIL      0.27 seconds
GitLint                       PASS      0.13 seconds
Prep - Setup ELL              PASS      45.43 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      8.02 seconds
Build - Make                  PASS      194.81 seconds
Make Check                    PASS      8.94 seconds
Make Distcheck                PASS      233.16 seconds
Build w/ext ELL - Configure   PASS      8.10 seconds
Build w/ext ELL - Make        PASS      185.24 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
mgmt-api: Introduce Test command
WARNING:TYPO_SPELLING: 'intented' may be misspelled - perhaps 'intended'?
#7: 
subcommands which are intented to test the behavior of the kernel
                      ^^^^^^^^

- total: 0 errors, 1 warnings, 33 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] mgmt-api: Introduce Test command" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

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


--===============1793464012688511446==--
