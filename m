Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA8DC433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 14:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54C6613E9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 14:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhENOMk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 10:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhENOMj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 10:12:39 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEFEC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 07:11:28 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id n184so28507987oia.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Ps/iq8sKP/Pi7+lKVANCPqM7YISStjk7/Wkm6LMqNyY=;
        b=CMXtg+hxqgrLaWADZp0B9UAz7EhpdEcUg+op6SdWgzlThOtuZOS4JqhXCUltMNc4gV
         QjUK//Xe+mJdkGtUPWozLC1ZQ7P+l4KLh6Z8nyiDJk0S0tcWTAkchavVqxX+4vmX0R+S
         byuviGVf9JonwIe2BegZQ3LVFPmo6WisgzmfT8EHylOnKIPlTHThswZlaEudvkPBIrgA
         FNYIf1yJbiUc2j8x+OJSyB2Yfwnh9yfaKrI4LsUg5qnnepE/sabo3N1V4+O/rO9RsBFp
         yub9ZN5MXpfUG/3sMKGSmlCfGX6ZXVY0nn/JstOCGklo9iaC8AZ6ad7tFYkDrX7ixlDf
         maNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Ps/iq8sKP/Pi7+lKVANCPqM7YISStjk7/Wkm6LMqNyY=;
        b=ixws1XC4WGZGEz6C/0iJRaz5tnfMyRMjkkyfFHQDedmFP8Uzs0YgExL2sER6LOVv62
         bf2fhlbfHgNKNeqNyP2dLpNB2j88ZSwSeYGeojIz8bszTaqvV/Js0d0xHAgHRotRyel3
         z9ESoOGzmlkh2ZwFDlCR4tWSEQhX8pQcB1JMRPSiO2DO0Y+a5lfrR1D+SOhdl0UOOsr7
         RLFLsxAqlda2YJntXiK2QrBnJtSfi4122M9yTlc4nG/XoVmINclmgSDFqGkZIHhU3xeJ
         59tAIUQODCZ311u04lLmHldx3t8iN69MhII81lmUBo/8brPHpd/ZTRbgeB+34jmQW5TV
         fzPQ==
X-Gm-Message-State: AOAM531pYKWFbZLn5W78l0LqQRdBJgW9StbgYDk8/T+sslUyispvW67a
        w2FtJLtMbnO0a4GKPlr+Bu50DIU5836Tmw==
X-Google-Smtp-Source: ABdhPJyrcYBCXaduyBkt2Uhq6ebX60ZH4PUxC2+MOWot66wOzuTtDboV6RkvubSbddsZBmQsDRg3hA==
X-Received: by 2002:a05:6808:4c2:: with SMTP id a2mr34354925oie.150.1621001487894;
        Fri, 14 May 2021 07:11:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.31.71])
        by smtp.gmail.com with ESMTPSA id j18sm1334576ota.7.2021.05.14.07.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:11:26 -0700 (PDT)
Message-ID: <609e850e.1c69fb81.a5fdf.a0a2@mx.google.com>
Date:   Fri, 14 May 2021 07:11:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1667644359413040411=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sgrubb@redhat.com
Subject: RE: Fix various memory leaks
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210514095807.62f40ff5@ivy-bridge>
References: <20210514095807.62f40ff5@ivy-bridge>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1667644359413040411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=482521

---Test result---

Test Summary:
CheckPatch                    PASS      1.22 seconds
GitLint                       PASS      0.19 seconds
Prep - Setup ELL              PASS      45.79 seconds
Build - Prep                  PASS      0.13 seconds
Build - Configure             PASS      8.10 seconds
Build - Make                  PASS      194.32 seconds
Make Check                    PASS      8.86 seconds
Make Distcheck                PASS      229.11 seconds
Build w/ext ELL - Configure   PASS      7.75 seconds
Build w/ext ELL - Make        PASS      179.38 seconds

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


--===============1667644359413040411==--
