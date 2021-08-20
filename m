Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FF4C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 05:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C767B60F92
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 05:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbhHTFhA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Aug 2021 01:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhHTFg7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Aug 2021 01:36:59 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36939C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 22:36:22 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id bk29so4018048qkb.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 22:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=bmIP7UfOB10FFnFwxZ8bnHrrUJh+JKDLfDYD/IzXQ6E=;
        b=YHZmIauyZpWXL/Dvom9027IemihKGev35uF/536Dl1SoAAFDRe4MJP4LUDosPDn9hE
         rr4Zd/gv/7uQ94i0R4s4UG/JQ1LhCxxXZh3pzOl/rU+GdyW9jh3DVrVXXt756ZpqwKIX
         eLE5fNY/dKRz4eoqeYFeH1/67SNDapgkbdjOfYlBEvnNj+16pHbEKUVeq0WNEwhD/WfH
         AJhcSG1zEn+8XtsKxMRSLKqog9heVzqYQGIl6f38hj1pV1B/wlJkOOTZJbsV9xNdjDVT
         fzD3DmTxcfNIVpGRWU9eMK1qZv0qxYkpZ9ZxffTYL4mTXOG3TabXLtoM35k9LAzY0Dmk
         9fXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=bmIP7UfOB10FFnFwxZ8bnHrrUJh+JKDLfDYD/IzXQ6E=;
        b=Hsh7QRP41HtY1+e28CK/av7r7wZ9hUit3HgVUaipEjOvX44kBhA9kNtSPxKM5PBT5U
         ZNtAeWEP/3ODpiWRgzJ82B44Q7OsDaER1R25jrxzyTqzgBk3wULyEFcXZFdKwZ2OuBqS
         zlTBi8PxkYBARruInGi/A9+x5FYgFX6VlpBofyEGhfi+zv3uTSjyE+frjksY5LSjH3Eo
         6jaCho9/9x+J+S4tJmjWZ79YNsdKYRZR/FG0azj6uUz0aTjDHth8Nd9EZVUUPJyn6xHQ
         UdcLDSiF2fAke5ZmPZj0wy7wJnAgcuk+5khEqQ6J5UvtE80clznBsa3KThLUZ2KA6CB3
         b2dA==
X-Gm-Message-State: AOAM532Qag/bBhgb3uMD4ZLH1TjY8FRoMmFNQDi0eVT1DEXpWsbiwksU
        E6uV92j+wbcqthFw4d0dGju4blMyktKfgw==
X-Google-Smtp-Source: ABdhPJwk4Zi0dsSTcit/l/smKGQbYFFpNh9R2zP0eHOPAUOiaUgkFVnqU2wtgKZD3MqA0PfGN1sI6A==
X-Received: by 2002:a37:45c9:: with SMTP id s192mr7414172qka.21.1629437781307;
        Thu, 19 Aug 2021 22:36:21 -0700 (PDT)
Received: from [172.17.0.2] ([52.170.72.103])
        by smtp.gmail.com with ESMTPSA id u6sm2699815qkp.49.2021.08.19.22.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 22:36:21 -0700 (PDT)
Message-ID: <611f3f55.1c69fb81.87ead.3fe5@mx.google.com>
Date:   Thu, 19 Aug 2021 22:36:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1248797390288410040=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] tools: userchan-tester: Add test case for the closing channel
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210820045652.69761-1-hj.tedd.an@gmail.com>
References: <20210820045652.69761-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1248797390288410040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=534641

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.13 seconds
Prep - Setup ELL              PASS      50.36 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      9.09 seconds
Build - Make                  PASS      220.21 seconds
Make Check                    PASS      9.07 seconds
Make Distcheck                PASS      258.98 seconds
Build w/ext ELL - Configure   PASS      8.71 seconds
Build w/ext ELL - Make        PASS      207.69 seconds

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


--===============1248797390288410040==--
