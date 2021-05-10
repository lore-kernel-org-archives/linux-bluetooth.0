Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39647C433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 May 2021 19:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F32D761432
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 May 2021 19:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhEJT45 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 May 2021 15:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhEJT44 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 May 2021 15:56:56 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2D3C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 May 2021 12:55:50 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id y12so12893798qtx.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 May 2021 12:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=v/1jGU1OcoGCBfGaLj8fh2vUSG7K1hr0TSSd9AuLt0U=;
        b=ILJ9INNTLH5KmQ6b5UKGaBqTztAXW1d5BT73MJI9NImOV7WZwoJMJj5JjP2QXZD/0z
         k3wA/U7r/6obypSI4wbfvsfPeMyq3Z+a2EwJpzTlwlTJC01yqtiiY1IvXRVWNcaBEZ1M
         gk6udHryOBLdHfKEwWM0C5liq791WDiqzpBFpESVYY5k13SDRtWED+Ue71zShx8lgG95
         D3Kl9tmsF6ZSLyGs91yY1q1Xd5fUcoXlgrUqDS0eLl1IPkwM65R9yTROwzxqbBInL7SH
         mUJs0KL/akDsQkzgvvkb8WgNFYP3nQe/meA4dk0EpuQGg9y9cZdGCmtiehdkTWxp3Lt6
         vkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=v/1jGU1OcoGCBfGaLj8fh2vUSG7K1hr0TSSd9AuLt0U=;
        b=i2m68HivISAK1snIOt1mBBNWM3cksEBc6YLXQRcM3M/aZ1Nmetm0g4IlU4GKal5b9f
         DTGpHGyohC+ZNiSHECRMAGhmmM4Mnb6uEq7+0KDVlt4sPTUo26GBBzUwr/t7wbufI8ws
         S5fgCFYOx23n0BUcaYhnUI4dIcpQFP1Dbre2mtBnv6hJCo8Va2JJNulJdOyzzu/js9Zi
         ya5bIjr8hIJXv1b9HKmAKjJx5/t5WFZFPpgDiBfWBKxwxV6uE6UugtL7Ezr2jYqpPX3b
         AVPfEli8ivDwZw695aw3uuP5LsdOhP87o8kt+9tynbLtToZasPLcCS0UgBlm0bbnZ7N7
         uVlQ==
X-Gm-Message-State: AOAM531uLu6rmrf0/0Ip5JUYGL97jPkcKQCG7zBTvbE15cyemTjYjfo9
        nJb4Xw4X47h0VlmCB/QoCZxect+uX5M=
X-Google-Smtp-Source: ABdhPJzMd5wH+Mt2edB+XHcSNUA8vq03rbC6TBwx0mc8s0zePscwZkWF5d03qp9wMAOEGdX4uRImUg==
X-Received: by 2002:a05:622a:40f:: with SMTP id n15mr6305771qtx.10.1620676549776;
        Mon, 10 May 2021 12:55:49 -0700 (PDT)
Received: from [172.17.0.2] ([104.46.198.150])
        by smtp.gmail.com with ESMTPSA id s190sm12105754qkc.40.2021.05.10.12.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 12:55:49 -0700 (PDT)
Message-ID: <60998fc5.1c69fb81.acc3d.7fa5@mx.google.com>
Date:   Mon, 10 May 2021 12:55:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5963346798255293218=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] DO NOT MERGE - Test only
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210510193955.1387490-1-hj.tedd.an@gmail.com>
References: <20210510193955.1387490-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5963346798255293218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=479771

---Test result---

Test Summary:
CheckPatch                    PASS      0.27 seconds
GitLint                       PASS      0.13 seconds
Prep - Setup ELL              PASS      46.66 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.23 seconds
Build - Make                  PASS      199.38 seconds
Make Check                    PASS      9.50 seconds
Make Dist                     PASS      12.62 seconds
Make Dist - Configure         PASS      5.19 seconds
Make Dist - Make              PASS      79.89 seconds
Build w/ext ELL - Configure   PASS      8.22 seconds
Build w/ext ELL - Make        PASS      187.29 seconds

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


--===============5963346798255293218==--
