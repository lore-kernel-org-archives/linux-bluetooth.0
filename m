Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D93C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EFC760F0F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbhG1Nni (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbhG1Nnh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 09:43:37 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2127DC061764
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:43:35 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id a19so1355498qtx.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=qytRVxmaOI35+L8RJAHZ8qyr1GOLg06/5YOKPCkEtdI=;
        b=nzx0YD2iM3w+KtM2+kUoJwiSXkFZratGqs9OtyO7yMMK66IQI790dwibxtUuQh7172
         CXB2r2towMYpkarNQBUNsnGJshoStM3bQLWejzfQXqcj2c/0CgAI9heR289xibHC8sK7
         G+N98XEF291J0rSi4n37I0b7hocUfibFm7S4xiNuUJ/j62qf5+BjYtGrtU9i0VXSyZND
         EQ8xMxkUfyw77RQqPpPrHt6JCaD50P19la7UJFq7VEk7H3mKhN7gOU0SBp4Qs7WiEm2s
         sAuKhhOB6eSEfzfsieOmvedGMVVRGb1NBDwATicKqL+ckQUUUez8x+RH5mHSe9WwI4Dz
         WZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=qytRVxmaOI35+L8RJAHZ8qyr1GOLg06/5YOKPCkEtdI=;
        b=WllW+5zi/5h59lMUOg/aTDrFfK68R9zFSUUBxylqI1ozwslzbZ3mzt8zuoAVJkdQl8
         YiHkNFCbAA3u7UjYnPun2pk6S49bJ3ddcYPVZsWrIY5cA0qh3PNf0Z1/94xEuhBckWqg
         Y7IKcuYto8OWMOMSeKAC1JGCwGw8ALRMzymEQb4SRKd+NBf4CScw4IdTzD3K3OLv0vv/
         KpuDjUTqIrcBwyHEpYvBg4XWcGPUD9nbpSHkolZZarsPw0Yw4Q+rVAJzGvf8fDRFVgFy
         otV6Yn/ifsFnFzFjuqj6/gv8fE9x+SwUh5DeI9xnsMC/4NQSMzA5wGLP2DBT/7DDvbkO
         ytNw==
X-Gm-Message-State: AOAM533F0loTzH54fE04YbiBf0JvAlBPvDjp73C1BBdcDOIebwjUQ78k
        0vo5td2ae9HCcZ02YLBZPx+/9rU34cHfdQ==
X-Google-Smtp-Source: ABdhPJwEgmg86dp1Mabqayv/GWvNOuHfeoMGLYQZYtIQPlmkrPG7TWt+xJEUkc9mk13zArvUj3sckQ==
X-Received: by 2002:ac8:72d6:: with SMTP id o22mr24092784qtp.177.1627479814167;
        Wed, 28 Jul 2021 06:43:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.190.233.242])
        by smtp.gmail.com with ESMTPSA id e10sm23180qkg.18.2021.07.28.06.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 06:43:34 -0700 (PDT)
Message-ID: <61015f06.1c69fb81.1f3ca.029a@mx.google.com>
Date:   Wed, 28 Jul 2021 06:43:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0847100862739923340=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v2] gatt-db: fix service in range check
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210728212259.Bluez.v2.1.I20397b8350f98567b8d52b895442c768250a6ab3@changeid>
References: <20210728212259.Bluez.v2.1.I20397b8350f98567b8d52b895442c768250a6ab3@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0847100862739923340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=522683

---Test result---

Test Summary:
CheckPatch                    PASS      0.29 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      40.81 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.35 seconds
Build - Make                  PASS      176.55 seconds
Make Check                    FAIL      8.72 seconds
Make Distcheck                FAIL      190.86 seconds
Build w/ext ELL - Configure   PASS      7.24 seconds
Build w/ext ELL - Make        PASS      165.61 seconds

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
Test: Make Check - FAIL
Desc: Run 'make check'
Output:
./test-driver: line 107: 28579 Aborted                 (core dumped) "$@" > $log_file 2>&1
make[3]: *** [Makefile:9910: test-suite.log] Error 1
make[2]: *** [Makefile:10018: check-TESTS] Error 2
make[1]: *** [Makefile:10412: check-am] Error 2
make: *** [Makefile:10414: check] Error 2


##############################
Test: Make Distcheck - FAIL
Desc: Run distcheck to check the distribution
Output:
../../test-driver: line 107: 47458 Aborted                 (core dumped) "$@" > $log_file 2>&1
make[4]: *** [Makefile:9910: test-suite.log] Error 1
make[3]: *** [Makefile:10018: check-TESTS] Error 2
make[2]: *** [Makefile:10412: check-am] Error 2
make[1]: *** [Makefile:10414: check] Error 2
make: *** [Makefile:10335: distcheck] Error 1


##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============0847100862739923340==--
