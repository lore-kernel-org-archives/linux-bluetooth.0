Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1469C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 13:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D76D6134F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 13:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhEKNrQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 09:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhEKNrQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 09:47:16 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD3FC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 06:46:10 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id a22so18146359qkl.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 06:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5wJ/D0PSpYy5PeOXQkMhJb31ZtdORVo67NydgTJUnLc=;
        b=MFSOklqNqc7pNTlaV2dw0sY/fAKnYVg/r0XPqrKHWpFoxpKlIEDlhoorJ2vI/QYUyh
         A9qmD2WFcR5PoQcWQpCsiF1le/AmZUfBY8Nvi2grzlXIThIAEL+kKFIWUNFqLlxBs8hv
         Z4AFiA0IeL/Y+jNVK7XBaWvM9YYZseWSZwrnpjMArAQRcXXAgYuFuTpkxs9I1eEyPOZU
         I2L6upY4FnF5+tyIalfqwaKTOcAhCQfM9FHaKc0m2Jho66jPW+k1KPFM6zEyiofngj6P
         szyj2Oq48q5M5JI1m0AxsUVyzAcpd1LUtkL9q9tFS3SG1bAjWBRH/QUPc+vm7DdxmUN0
         TdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5wJ/D0PSpYy5PeOXQkMhJb31ZtdORVo67NydgTJUnLc=;
        b=qY94L20RA5HCUif6orwh2ZCR3fC3lySkyWqQppHlkX/rQpGpDcbwcIqC2OUevqg9Oo
         C/66Fzd019Jw5OLKbX8eEuOfb1175B+GwZ1AjJYxt+qUdj5KtQ7HeHPoUux0SqiWk2C+
         Y1pV+chSCz4N+VIpQaejggonWlQ3posvAIuDndjuY7Ru4+nX7h5RO8dbJYRGe4OJRkV4
         2vPvhAqPZ4oF5+JECZwQIItAvCyF3FH1SMbGcT4fdElAj8YNUuxrQccl4mR2Itk2FS1R
         X+DcxarZShiNJ/SiEAQIBCIBq6RCSvDHZtLzSYHGH+cSOtGDIQUDBaCN5EYgRXl+mH3Q
         /j5g==
X-Gm-Message-State: AOAM531WBOmhPOknj+pBUo/0tNjt8yUejUBwL494qa67XH6Z3wEO1iRh
        nfSyabimXz64tDVtcM5KglkIARrzso368g==
X-Google-Smtp-Source: ABdhPJx9M/8AJGMPO+xLKbroNmoJqZdGlv3U7a56oRoiieKgbnBhT0UlXzJyIkChkcCj9VLR0ABubg==
X-Received: by 2002:a05:620a:2097:: with SMTP id e23mr28762902qka.98.1620740769039;
        Tue, 11 May 2021 06:46:09 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.110.214])
        by smtp.gmail.com with ESMTPSA id d10sm11135739qtq.55.2021.05.11.06.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 06:46:08 -0700 (PDT)
Message-ID: <609a8aa0.1c69fb81.f42f4.fe63@mx.google.com>
Date:   Tue, 11 May 2021 06:46:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0203310872720174313=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, thomas@t-8ch.de
Subject: RE: [BlueZ] tools/mpris-proxy: Ship systemd unit file
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210511132213.150076-1-thomas@t-8ch.de>
References: <20210511132213.150076-1-thomas@t-8ch.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0203310872720174313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=480411

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       FAIL      0.13 seconds
Prep - Setup ELL              PASS      45.42 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      8.03 seconds
Build - Make                  PASS      197.02 seconds
Make Check                    PASS      8.78 seconds
Make Dist                     PASS      11.48 seconds
Make Dist - Configure         PASS      4.92 seconds
Make Dist - Make              PASS      79.31 seconds
Build w/ext ELL - Configure   PASS      8.09 seconds
Build w/ext ELL - Make        PASS      185.67 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
tools/mpris-proxy: Ship systemd unit file
3: B6 Body message is missing


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


--===============0203310872720174313==--
