Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B09DC433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 20:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD06613D8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 20:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhEDUix (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 16:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhEDUix (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 16:38:53 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9820C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 May 2021 13:37:57 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id r13so139967qvm.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 May 2021 13:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+9M2hnhnfRmtnweYpeIRF8KyotJ9XpGC6GsubFvBXwY=;
        b=MT01ENnN1BDu1EOOCgctcTdQrzs6Y6W+26jB5b6n5FB98kExZsdwx6qMNdJggQkG/j
         sJ3jKBx9bqkb3dKOzTCOuDWSZVwUxFTfqEQ4tvrwxCV/pjsNSBZQjigRQWTaapvn5SOc
         sUXT3AF05JYbgUJN9RSD0wIW7Fn8lgz/L5DLZL/RjmoH11TsBJn0WnsapmxodQDZ+nWD
         SlGa6iQXkhuwX9591kEyaWqF4ioDwBoonbd3nP30jpPVQg/2RnfhID7GasBKmQvlkSzF
         DjL4wPfGe7Dd7RrsW6C3c2UZqT2EBZDhnw30Xo5tn1X+tVL2EdmH7RhL2u2gV+Iz3yQI
         Zpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+9M2hnhnfRmtnweYpeIRF8KyotJ9XpGC6GsubFvBXwY=;
        b=QD41eBYOVlQDAYNc6CnQjICmUUojBQ/50+2nvknOdKFHzfbDpMVBcaGoVtG+/HKQyT
         79B0ameq3rl1nAFlGtDwKWypY8Cp+lCJZzfs6m0os+OcqL3dAnmtzIIjoPWg7GiHFTXD
         FFcDln4FzF4uMtWzURmSToHS+1yGWXcwhUlpdDovM29OTa7z2OGOZmxFjOb/nwR7xx0m
         pmVK6P7pnevslE329bZ4uaKuD4wiVAaRlV/6DBMb1l8HSs+oi9XpkmqzZHhwYD5C5qS9
         oKNYb1aJQphb1tFueQApyTMdkSjW0NZ6x3fwXaSSMU8vd95WMePk6uOR5p8lDB1elvjD
         qgEg==
X-Gm-Message-State: AOAM533Gci/Nu++DATid49CWsvwNzA7ljw261we4dVYV64M8hT1dulcM
        JHS1WMp6TuAmvPJdKAnftFSCn5idaug=
X-Google-Smtp-Source: ABdhPJzb+xrvKEMReoTHO9qDeQGNfTif3h1BoagFjDviO2htRje51M2I6C1AtMNk1iVW9iMsmzldcg==
X-Received: by 2002:a0c:a425:: with SMTP id w34mr27586207qvw.2.1620160676934;
        Tue, 04 May 2021 13:37:56 -0700 (PDT)
Received: from [172.17.0.2] ([52.224.48.121])
        by smtp.gmail.com with ESMTPSA id g25sm1333410qtu.93.2021.05.04.13.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 13:37:56 -0700 (PDT)
Message-ID: <6091b0a4.1c69fb81.7e1e8.984a@mx.google.com>
Date:   Tue, 04 May 2021 13:37:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3491033779812102288=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] checkpatch: ignore SPDX license header check
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210504195953.901987-1-hj.tedd.an@gmail.com>
References: <20210504195953.901987-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3491033779812102288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=477013

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      39.89 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.00 seconds
Build - Make                  PASS      171.28 seconds
Make Check                    PASS      8.62 seconds
Make Dist                     PASS      10.72 seconds
Make Dist - Configure         PASS      4.36 seconds
Make Dist - Make              PASS      69.25 seconds
Build w/ext ELL - Configure   PASS      7.00 seconds
Build w/ext ELL - Make        PASS      160.22 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

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


--===============3491033779812102288==--
