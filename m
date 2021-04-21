Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36251C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Apr 2021 02:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0657D61414
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Apr 2021 02:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhDUCkj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Apr 2021 22:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbhDUCkg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Apr 2021 22:40:36 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220E3C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Apr 2021 19:40:01 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d6so12006367qtx.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Apr 2021 19:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=joMKJmKEcMgtnwJZ1alTF7fDb5W7jyIEf+O8/oNZOt0=;
        b=jIl3i8LGq7db3oaCcRb1EQg7WlnPZyJramX8ZcLHU75d1szOhlu71FhrrTN2aooWOT
         WqR2Kdt74WbPHHj7Nz00n4UPAd4M04QqVB+46lYXcb9lg10XdeLXr7pbfNyCmlqsyv4M
         X/+zGYD4PyfPnvwfX4lTxN6xprjLAVpUjK5G+R6l4piFjfvswTzuOYl6ap9uf+Lb9ka1
         fvqEV+fv+UFiY5kb7sp9Mt2m+wK9nDJr1OpDYtxkYR0h/CZKptGsw69Qfjf6cWgIsCBN
         3BYlrhiEgZdw0Upx3pRw+29f4FQ1eQk1U5UowaM7reY829Y0m6XsybxHIrtZ4ELHNMiL
         aWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=joMKJmKEcMgtnwJZ1alTF7fDb5W7jyIEf+O8/oNZOt0=;
        b=rqXcdfX5Bw/z2Z3pPsX6AF4qhwXtJDBYOrRsxge1VvnTpSCvMHSR5d+j8C9XQl2x2M
         OCJCvmJVR5QPqT/S3Xn3LMpcYOkeM/W9czBjQlYk+Yb/Zu/vUhZf4A2rSamR6z2OeoG9
         4fubpRgpysr36J4iAzKqSV3+HN9tdB9Q11o/ASYtCwl94F4O8H/nMLrRTweLjWaLsyq5
         jBtB7+1/a/i25xCJrlKBBMi/oK165aJPcutiis0ImJk2Gk+8eSwPfOKesPfVx5orTtiA
         yLxzt6O0YRHiPkTcciNtrpr6CmI/eIazNJrgKyGiVtiBuy11kpPqVi7aZXuI4R8QX/a8
         14eg==
X-Gm-Message-State: AOAM531sxZFOkd7YVDK6R3beuHW3fuqFSeIs6omBT8SUVLH2JJQUMVx+
        gYfsmFhHti0qFGwcIYzIciDTxNVPdKU9sg==
X-Google-Smtp-Source: ABdhPJx+6Ggqkjxi4OmLWBpon7d26XWP2LHhK3fpBK5PporjCFMmT/6O8MdmHMY2VIm9ujl+1e8B4w==
X-Received: by 2002:a05:622a:314:: with SMTP id q20mr19225150qtw.242.1618972800217;
        Tue, 20 Apr 2021 19:40:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.88.124])
        by smtp.gmail.com with ESMTPSA id l16sm926572qkg.91.2021.04.20.19.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 19:39:59 -0700 (PDT)
Message-ID: <607f907f.1c69fb81.f409e.4e7b@mx.google.com>
Date:   Tue, 20 Apr 2021 19:39:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3111956252447889593=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v3] monitor: Fix the incorrect vendor name
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210421000715.756127-1-hj.tedd.an@gmail.com>
References: <20210421000715.756127-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3111956252447889593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=470557

---Test result---

Test Summary:
CheckPatch                    FAIL      0.44 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      47.24 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      8.17 seconds
Build - Make                  PASS      204.14 seconds
Make Check                    PASS      8.95 seconds
Make Dist                     PASS      12.26 seconds
Make Dist - Configure         PASS      4.99 seconds
Make Dist - Make              PASS      84.00 seconds
Build w/ext ELL - Configure   PASS      8.27 seconds
Build w/ext ELL - Make        PASS      195.15 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
monitor: Fix the incorrect vendor name
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#27: FILE: monitor/msft.h:31:
+} __attribute__ ((packed));

WARNING:BRACES: braces {} are not necessary for single statement blocks
#189: FILE: monitor/packet.c:9448:
+	if (size > prefix_len && !memcmp(data, prefix, prefix_len)) {
+		return msft_vendor_evt();
+	}

- total: 0 errors, 2 warnings, 240 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] monitor: Fix the incorrect vendor name" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

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
Test: Make Dist - PASS
Desc: Run 'make dist' and build the distribution tarball

##############################
Test: Make Dist - Configure - PASS
Desc: Configure the source from distribution tarball

##############################
Test: Make Dist - Make - PASS
Desc: Build the source from distribution tarball

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============3111956252447889593==--
