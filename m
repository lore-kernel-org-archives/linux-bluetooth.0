Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF93C48BD1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 12:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 293B5613B8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 12:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhFKMzE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jun 2021 08:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFKMzD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jun 2021 08:55:03 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2055C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jun 2021 05:52:55 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id p21so2439028qtw.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jun 2021 05:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=9GUqATV6yLZP3CqCfIMdxSQSKCwDAJpcRi5aMJeDDr4=;
        b=qF6UDIupmz9+ZCYkE1LmXQc0J5W8kH9WpKsgA/DnRkDwC5b18OrjltT+GsWjWsuw3k
         IrGpEq80LNE+w7sB1ebazvrPglzMrp9aCBcUhKZK7TLiuLNgYJERUhrHL8QEIbBUJEto
         D0nyuqUCC9SVXrKM7bvr/mmDiQ5ViCDxPMO95IxT36Dh4qkOQOSEuDLH8qcCLL2G5HjV
         MXOBhvyPNDxEFIQSQHi53dnPnc0AkLhaARoWoIE6/5YYTiEDuHWCo6no0cILhNdDQ0IT
         6p33B8cb26r2ubmSdFWS/OHId/RsaO45mbe+Dtd4ctJXSKVGCnYVnKRZC+eFRI1F5ukc
         D2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=9GUqATV6yLZP3CqCfIMdxSQSKCwDAJpcRi5aMJeDDr4=;
        b=pjgj/5I1QYoWhghiix0vMo80sMubxyzr0x+I5921NpnugsJCrZbaw5bKAohnJXjvmM
         sY49xyZfvg5XIK6/hFhXth4TZ5g6Va0jz96YRVEmftcL34HyVN+74OfN77EhzAM/5p8Q
         BN5n1NvgmG4IP3quoc/X6V/NIs3SizMyU9cDYpWl0jFK/rL3LRA+yZnJIUBDc452Z7ht
         6ecQk3CnzzScmzVT4Z/xeRexzB1V020+uKPbuNoWZRBO2UPGwzmqLbCBWgrL1EtRon5l
         +I+onT3A1b/l0oL1hFb/sQ5RLGCkFsmh+uC00dBqA7Eblh9pBZ0nNOsR45utSniy583v
         pJiA==
X-Gm-Message-State: AOAM531ZXpT3KFk8fc/jkDrZWbchtak++eqXeMO1gMp00YfZ/MUhF/Xj
        RsclsazvnW2rfKAqzsfqKjqGSF7edHVGQw==
X-Google-Smtp-Source: ABdhPJyqTOb75WtoUNlRuf6BwqAdzX2UnrILjnllqSvUXJQ8wiZ2bbGclkK+aq+4Gelmksv3CDiV4w==
X-Received: by 2002:ac8:76ca:: with SMTP id q10mr3651691qtr.150.1623415974558;
        Fri, 11 Jun 2021 05:52:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.232.241])
        by smtp.gmail.com with ESMTPSA id g19sm4224379qto.49.2021.06.11.05.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 05:52:54 -0700 (PDT)
Message-ID: <60c35ca6.1c69fb81.c8dcd.ef63@mx.google.com>
Date:   Fri, 11 Jun 2021 05:52:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4511694514561168586=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, surban@surban.net
Subject: RE: [BlueZ] gatt-server: Flush notify multiple buffer when full and fix overflow
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210611122915.21068-1-surban@surban.net>
References: <20210611122915.21068-1-surban@surban.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4511694514561168586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=498857

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.13 seconds
Prep - Setup ELL              PASS      46.67 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.18 seconds
Build - Make                  PASS      202.14 seconds
Make Check                    PASS      9.49 seconds
Make Distcheck                PASS      237.27 seconds
Build w/ext ELL - Configure   PASS      8.12 seconds
Build w/ext ELL - Make        PASS      188.19 seconds

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


--===============4511694514561168586==--
