Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8578C48BCD
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Jun 2021 00:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF952610C9
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Jun 2021 00:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhFEAnU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Jun 2021 20:43:20 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:41675 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhFEAnT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Jun 2021 20:43:19 -0400
Received: by mail-qk1-f171.google.com with SMTP id c124so11168116qkd.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jun 2021 17:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=X8faIWxfR92CC0RokC3NZpy3E51gxDHgIqfWbQpMtzU=;
        b=LxdwgouqLA+WZz9hTLnxjwxHwvEz9Vogy3/HUwCkxmWjnV4aAxH6GP65aTWN7oPya7
         q7/54X3YwqHDFe1QfOOXOWZdux/lm8iOQLr3r7YfNGXJ6GvqeacTfqHCrHMhtngfmPM5
         UQV2g5xs5bJsRFJg87lWywPoJS8VhetotkLMHn5VjV4+8Y8HVStE9hDhzsDeEC7jtdEn
         gmlmgsRO2MG+oXM/LpVIDrGx3Yql/4PKTVtxtagfqtwmMx6Jnmc48vhhEIdKayJzfaiB
         4AL82XRJo81j353662RuqsJy5kjNtMozY/miuiWlpcSPpIojT0QimMccTGdXifeN49Pu
         XhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=X8faIWxfR92CC0RokC3NZpy3E51gxDHgIqfWbQpMtzU=;
        b=TvMccLnkA8RQUwQ8zao4cl21WKuHVgltjYcVNd6tzMjWi9HlMSMNsjTj8w0OaQFxtO
         Zlt2hnpsHpAyOJDwcxZTIaGSEIRR/up5PYWRuC/kE85uWx6bHBkvzdKFaVpj1XCUHOQZ
         Axz57utWQXUonhgYhFFGu5kjaE+EnIjXBsbIyYDdbL5aUnqZxp3xJ4oUcNvyIQyOGhu5
         nxoNaOpBGfsGo/qwrVpw5PX08CTzMOiAYDW5Z5IBAsl9AkU34a65daddNN92LaqR+d++
         NHG+X4ptL4ddk8nE5b8qdUpH2PTCbtxdLG9EYxvKlNaN9aQXd2t9+0nqKRzU5cRmEvGK
         3KQQ==
X-Gm-Message-State: AOAM5337Lxy+7ZJjCQXTl7lEwAZAdSVEjI639ZrveGpU0yCi4krGaUb9
        fbYu91f6ObhllySrQBK9v/8RmJkz51+Jrg==
X-Google-Smtp-Source: ABdhPJwBQau8OGYmqe1bhyBRE/yacKDz880R9AN/aMVofNcMwjVVI8wRWD2WlNlxhvdv1sKPMhQZ2g==
X-Received: by 2002:a05:620a:102c:: with SMTP id a12mr6930548qkk.339.1622853631907;
        Fri, 04 Jun 2021 17:40:31 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.51.197])
        by smtp.gmail.com with ESMTPSA id h3sm4978455qkk.82.2021.06.04.17.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 17:40:31 -0700 (PDT)
Message-ID: <60bac7ff.1c69fb81.cfc9d.3cee@mx.google.com>
Date:   Fri, 04 Jun 2021 17:40:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0766322918424749201=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [V2] shared/mgmt: Fix not processing request queue
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210605000200.1938853-1-luiz.dentz@gmail.com>
References: <20210605000200.1938853-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0766322918424749201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=494447

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.13 seconds
Prep - Setup ELL              PASS      45.76 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.90 seconds
Build - Make                  PASS      193.49 seconds
Make Check                    PASS      9.03 seconds
Make Distcheck                PASS      229.13 seconds
Build w/ext ELL - Configure   PASS      8.06 seconds
Build w/ext ELL - Make        PASS      185.19 seconds

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


--===============0766322918424749201==--
