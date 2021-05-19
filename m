Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF72C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 01:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074456135F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 01:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhESBje (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 21:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhESBjd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 21:39:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F51C06175F
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 18:38:13 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id 1so9078362qtb.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 18:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=JAZsrlrzwyew3m4HiGf55Bl/joSaqVKtV1ZTGMXaJgI=;
        b=nzkefkpn5qoZ+Lgf80dloR1ZtgfNgM8wENBdvVp3kLITM6D4ceHUmW7iF2ZQ6BJTYH
         HAwrZ5UDsm/LwCLju9QmOoSPBj3AU5BPXqiQ8YijVXeHkfpKTzVYH63WoVsJLEL1y5nA
         uK+dBG8V2Jry4sxOembfNRdWuqtNua/PZwt3JrBoTKheKTg5xSrdA5JshaHABLmL8zz1
         uM7AJhGO7hLzNICZO9qg64/nY1fZ+63dLQG8lapBTp13M4T4lpJ4mH8iUorX6j+qHuPm
         bFQ2+ZMr02TImtWMRVn4+9sPRoXDWsTMN8swG2ISJKn+Bs67RBGjz4ZLBHaKVD7Y1gNb
         xQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=JAZsrlrzwyew3m4HiGf55Bl/joSaqVKtV1ZTGMXaJgI=;
        b=lo+sbfAf4CqzBaFUs973F9fhyyHkmaOb+xXazpGJga2armPdeIDp9zwVm+xENtFtd5
         pESrIE8qY+yMYH8Zc5dq90jYKLxpKoy+l/PjKUVN5QorMOCRHmpfYaO6OPYdT6VsPWOp
         jtsNisKDJr/Q+ARe7lGa9OKx62oB8wh99aLtz9tASulHKyYifymyPunKg+h1QSPLnTC3
         3XhikhbTGFf85nrtVAjm7jtHGg7faGIHp/8zs9WPxde6wf3zj9hYOSzP7ZXo4yXIi4h1
         k9lr4iV0klXvJHi0z3xXuG5H0PZUFBfwB84CNI1dovOgobm3Tz3jrhiePwmp+SSs/01n
         gOdQ==
X-Gm-Message-State: AOAM533w9bVMItsnldyAoaONCSm4Si0xZwDp8nucfEtmZZ4xqBJuHk3i
        2cUNVlA9gK6YrQw5H4sxjXXql+xjZ1U=
X-Google-Smtp-Source: ABdhPJwfipuVpZa99SBIfmqkr+unBVfJH/kdPFHOCnU2RDlxVAc5yBLEAjcs74bTqJuba0SiJmJ5jQ==
X-Received: by 2002:ac8:4092:: with SMTP id p18mr6553394qtl.388.1621388292723;
        Tue, 18 May 2021 18:38:12 -0700 (PDT)
Received: from [172.17.0.2] ([13.90.139.159])
        by smtp.gmail.com with ESMTPSA id x27sm8428816qkj.133.2021.05.18.18.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 18:38:12 -0700 (PDT)
Message-ID: <60a46c04.1c69fb81.54a63.6f83@mx.google.com>
Date:   Tue, 18 May 2021 18:38:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3499008825671198274=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] core: Enable experimental MGMT when experimental is set
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210519005313.867382-1-luiz.dentz@gmail.com>
References: <20210519005313.867382-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3499008825671198274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=484631

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      43.11 seconds
Build - Prep                  PASS      0.12 seconds
Build - Configure             PASS      7.59 seconds
Build - Make                  PASS      189.85 seconds
Make Check                    PASS      8.41 seconds
Make Distcheck                PASS      229.02 seconds
Build w/ext ELL - Configure   PASS      8.08 seconds
Build w/ext ELL - Make        PASS      184.29 seconds

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


--===============3499008825671198274==--
