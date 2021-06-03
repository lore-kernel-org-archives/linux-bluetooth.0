Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EA1C47083
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 00:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C059E61360
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 00:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhFCAxm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Jun 2021 20:53:42 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:33728 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFCAxm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Jun 2021 20:53:42 -0400
Received: by mail-qt1-f176.google.com with SMTP id a15so3323832qta.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jun 2021 17:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pApOZgznBZMk8Vc6nCL7k00wPK585e6RpsHbPM4eLyI=;
        b=gBO4rmDE8J4p2uiyAEoDpzJ+pigg4z3ehdsD1ekCHq++JlNFQXgfvx70clICjo3Ttl
         wFV9WxSrLXUnSEAC1r3xlR0ZNwe7AUbO3NuKNSw/SgLnNDbav5h7+n70FnXPFfqdi1kz
         xTz35hjiGf7HV+BmkmoY5LDsqVFrmNTks9c/2HskKVW7coMfXNoPo+6TUWYvOL6RMpIe
         OnLb2py1qBMo0eWfqY/KjfdYvWsE4N2jbxK5ro7Z9XzQSy443Tu9Sgd2PkQIZXoY4yp7
         L6YZxXDfN9gtSOmnGKjqCi7cJMNRDRQzN1FU0Ab/naTSXOHuD4wUVVkyTv6Wc0wosfB8
         Mzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pApOZgznBZMk8Vc6nCL7k00wPK585e6RpsHbPM4eLyI=;
        b=eh5uf1dYc9Ksxx4exKiu2VuALrdOIWcROjgDAee+lIxvmGYHuwJOE1S+wiv2tqXzvi
         k6WbMxCgY3dLOXlNIGk8U6aGa2bW99XvhNJrA1Cvfp0IQ0hCTcZnkBpY3zr7peiIpj1q
         2CV7hZwaLjQ9Fky/op+J7H5XJNWaEK9TxoJKd9EUXg71fEPwG9t/2Z5066Hi4IJN0krq
         Ku5nrSeVRUoLNGq+ch9skV6ymhzWFLjUuWHxqYB03hRkmZS0BhBT/I4eI+GreRsJ90yD
         VN7Ahe0wQvuFGnVGRzk72OtWYTlCd4jbBhjvY/Vb93j2StfVIll/PWWXu7fRzTdbz5/9
         4o2Q==
X-Gm-Message-State: AOAM530mjDJ6c7KzH5MuCCAj6Je4aJKDBq3aeP69HCeJdkAafzNotgos
        P5vneCNgcwZ+Z6i/66tLk7xWxUHlyZHipA==
X-Google-Smtp-Source: ABdhPJwf9ZHjS1IqAee4nfggafhDrlU0Aeu8sY7pzTcOJt7q1PTrq/t0VD2AegyRgKfgOGYSStN3DQ==
X-Received: by 2002:ac8:5cd4:: with SMTP id s20mr4676368qta.241.1622681442659;
        Wed, 02 Jun 2021 17:50:42 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.250.50])
        by smtp.gmail.com with ESMTPSA id z186sm955258qkb.116.2021.06.02.17.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 17:50:42 -0700 (PDT)
Message-ID: <60b82762.1c69fb81.ca107.7827@mx.google.com>
Date:   Wed, 02 Jun 2021 17:50:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0276816247321519071=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ,1/2] tools/mgmt-tester: Adjust test setup complete check
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210603000416.171392-1-inga.stotland@intel.com>
References: <20210603000416.171392-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0276816247321519071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=492919

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.21 seconds
Prep - Setup ELL              PASS      41.15 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.19 seconds
Build - Make                  PASS      177.68 seconds
Make Check                    PASS      8.92 seconds
Make Distcheck                PASS      210.21 seconds
Build w/ext ELL - Configure   PASS      7.21 seconds
Build w/ext ELL - Make        PASS      167.43 seconds

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


--===============0276816247321519071==--
