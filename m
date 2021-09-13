Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28D0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 18:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A7C610D2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 18:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhIMSnt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbhIMSnr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Sep 2021 14:43:47 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4B6C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 11:42:31 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w17so8985522qta.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 11:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=iEcOZQDX7tVv0sTgKAJwChCzLyCUcv1C2XavMwxmS2I=;
        b=Xoh2ZqZWvLGXpQDZ0kS6xOZMpYiOSbQ5lrl5S2Ljs37v22hTSLbSY4qL1Mn9rPuUCL
         wK41jBGQ8jbPCFpvVGY9K0F3p5C8oCWYT9mBf1GCZHX4w59OIcJfKOyHeC1jcqQiehNl
         EMfZ+4cTzNIlOikqtT4J8FVhWKS3/+KY0KQWlXK6WN0Pcmg57jHTF5aW/Na0cf3U8CbL
         aF37haqk2GPT7KhSu7XDUbchJmAuva0jRJMraPiQyTjZcS2AuQzHO5BruTKu1F0pIitj
         zEsah3Aws7+43GU4HF4HRtbTW4Rp7rpTD4DZ2PR53Sw5Gwv+nKpX/pkr1aTT6P992B1J
         e/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=iEcOZQDX7tVv0sTgKAJwChCzLyCUcv1C2XavMwxmS2I=;
        b=p0IqKGIleLxYPHwkZUS3KyqxpLJdZBWS5lNPXoch7bHACcBqc/michplH/fe4ct/+5
         uVu50S3T+FVJsVVBJu0ATo1ySbh/V8DvK20kefUsE0p/0gbM49uFLxsBFbvI30Ixmaej
         0OqcUbWv8vYUZinYRjViH91pN0zPA100VrB1BvfDSagYW+fOD4dgD3zh+DmijWEQT1N6
         YqulFlYzRI0iGRj5jleYkQRQHaSF9GpoEUDGC0hXdtQF5XCIJYBKS3YoGBGTuqgb1W2z
         fqla5rWGQ+krnBI+B18h0LBFvjPx/FhqvTrGJIImq9EJga/b3Np/qeRn7lh034GRq5o6
         pdSA==
X-Gm-Message-State: AOAM531HDKYnfrTyJJL34bWRWEw8SN5OkbdCpo5tqkwT8fR2V6a0q3Of
        KlShMUIx/wsdTPOIGtjwUGtM483wzkmURQ==
X-Google-Smtp-Source: ABdhPJwh1PPGHxBU/yay+ybE6B642XzoIXpEDl1KTa90r+ZxD1fe0wznJ1lY72dpyhWdRR8ylxsFQg==
X-Received: by 2002:ac8:59c4:: with SMTP id f4mr967889qtf.334.1631558549994;
        Mon, 13 Sep 2021 11:42:29 -0700 (PDT)
Received: from [172.17.0.2] ([52.149.181.159])
        by smtp.gmail.com with ESMTPSA id x2sm4559588qtr.6.2021.09.13.11.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:42:29 -0700 (PDT)
Message-ID: <613f9b95.1c69fb81.f1777.b933@mx.google.com>
Date:   Mon, 13 Sep 2021 11:42:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0107602462253004042=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] shared/util: Add convertion function for 24 bits
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210913180552.3468107-1-luiz.dentz@gmail.com>
References: <20210913180552.3468107-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0107602462253004042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=546035

---Test result---

Test Summary:
CheckPatch                    FAIL      0.61 seconds
GitLint                       PASS      0.25 seconds
Prep - Setup ELL              PASS      49.40 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.64 seconds
Build - Make                  PASS      214.82 seconds
Make Check                    PASS      9.30 seconds
Make Distcheck                PASS      254.50 seconds
Build w/ext ELL - Configure   PASS      8.93 seconds
Build w/ext ELL - Make        PASS      203.09 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
shared/util: Add convertion function for 24 bits
WARNING:TYPO_SPELLING: 'convertion' may be misspelled - perhaps 'conversion'?
#4: 
Subject: [PATCH] shared/util: Add convertion function for 24 bits
                                  ^^^^^^^^^^

- total: 0 errors, 1 warnings, 38 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] shared/util: Add convertion function for 24 bits" has style problems, please review.

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


--===============0107602462253004042==--
