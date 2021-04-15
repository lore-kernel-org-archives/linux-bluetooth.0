Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7FAC433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 02:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C62C6102A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 02:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhDOCgU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Apr 2021 22:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhDOCgT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Apr 2021 22:36:19 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30958C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Apr 2021 19:35:57 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id i11so5484563qvu.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Apr 2021 19:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=TnuoL+qXFDn65sL+1OTZVMpCmXd0P5szwnUttOEdVjM=;
        b=YYgO3f+CO0bk5CQCNgYTZBGuksTk8Snrv7PDb5iA9YJIopWnHWadA/KhB9dWam02aK
         I7pq17qBdHKRS9xtDieOU0WiMk6WYrSPOqc1tytLjanhQdE5D6IHW8Gdbr9m1CAgg12S
         IvSQD5niAJSsj06wwklmcQnSSCNkwfLlVFF8HBjH/HEgfhUEKiKs7crEPCxV6fxgA3QL
         0ur+02CWU21lKjil+gvGj9KTSeUvb9vGt1l9GZ4RtUxrViEZA3EvEHIhbRF5oQ5Ca9As
         f5syBd8vgKYZkympe8EXJYQcAQg4XseJEv6mzAeENEj7dPDUN99X2CjitF8gTXtYdhyB
         Yf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=TnuoL+qXFDn65sL+1OTZVMpCmXd0P5szwnUttOEdVjM=;
        b=gMZAn01rJ5hgdKGPzCzwIni2QSAqQPVw2TcT6KipQ8GlHL4zlKg5JDR+0TL+72CJcI
         fuRYhSzfVcDmCoOzpVwJ7HuWtLEvF+MkNm1MpOJ4crQqZWtFLSjY3Nc1WMWYqhZo3DWm
         Gh//aRvuvI/wXShu1+gBoRw7xNOocskgHfaXGussHeazjs7Jj+cLY6TaOfMVxiKs8OXj
         0uvD54qBDomKQ8Rc6sxkBHaYMtHfvfPu60NvLkVlROqOmLO3USDnz1ondnmQJh8/mWoY
         m09zJvFZEOheIXg1Y8SPWyIp+Z7c9Psn6gLB7olr/+5qKbADQi3yz/rCjmRn6jsDBvwv
         ORxQ==
X-Gm-Message-State: AOAM533YC3yMfMxDUzCDKyTsVUT+Oe+VvKCFeZe+xKtedITGUW23BxTL
        558kydTPYeZoP8R7Cwz9ahsmD0vq4frRXg==
X-Google-Smtp-Source: ABdhPJwl93V9j2WhnYV8UMrtElYpqR3aOGKE3h/yPWGWv40+Id+xVFFovZhTPJPwTRVF+2ztudQ0Lw==
X-Received: by 2002:ad4:50c7:: with SMTP id e7mr1016524qvq.48.1618454155994;
        Wed, 14 Apr 2021 19:35:55 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.48.89])
        by smtp.gmail.com with ESMTPSA id p186sm1012378qka.66.2021.04.14.19.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 19:35:55 -0700 (PDT)
Message-ID: <6077a68b.1c69fb81.662c6.7446@mx.google.com>
Date:   Wed, 14 Apr 2021 19:35:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3858118616858286977=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [RFC,BlueZ,v2] monitor: Fix the incorrect vendor name
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210415014828.422303-1-hj.tedd.an@gmail.com>
References: <20210415014828.422303-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3858118616858286977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=467397

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      48.80 seconds
Build - Prep                  PASS      0.12 seconds
Build - Configure             PASS      8.55 seconds
Build - Make                  PASS      204.79 seconds
Make Check                    PASS      9.22 seconds
Make Dist                     PASS      12.94 seconds
Make Dist - Configure         PASS      5.25 seconds
Make Dist - Make              PASS      84.41 seconds
Build w/ext ELL - Configure   PASS      8.55 seconds
Build w/ext ELL - Make        PASS      196.08 seconds

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


--===============3858118616858286977==--
