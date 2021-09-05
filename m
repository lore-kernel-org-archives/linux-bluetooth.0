Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650AFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Sep 2021 16:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D2960F3A
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Sep 2021 16:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhIEQuR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Sep 2021 12:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhIEQuQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Sep 2021 12:50:16 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA8EC061575
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Sep 2021 09:49:13 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id ay33so4496676qkb.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Sep 2021 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=xH6bQm9fhrUKROdjrDllUbWCnFoa898EolPd/+IXI3M=;
        b=Ua4YgBZtkOWWqyLZo9Aof5JCPg9sVJnSAoeLgcYduIBbB6CHtIVv6GxyM7HldDtnKF
         uuVSivvFAVkvsWPOQki92CVhUPcGgFlu7IEMlW0GZ3PtkOhNSdqfb0hMsHMHP29cY9Nf
         w3TPcAV2iv613lILZyA/ELREQkQVzQ//xe5eH4nhuSKAxonz+ZlXwJqqZ/9hjY2sCHyN
         /Fe6scOrBlDCG2jaaaZmL0v4YvqPegE2siYQRmTx0TUpwqayhKrez5YyksxuBsDOdiD4
         jGk39fXYq97T0F+InmpU/wtzdD0RZ+5O43D25SlEsPSweDj33qySmgYkrTJ87nhUqJU5
         IMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=xH6bQm9fhrUKROdjrDllUbWCnFoa898EolPd/+IXI3M=;
        b=suBzT7U8ywIieflHALsK9P7E5FRraF9FvLsoJ5IjSitOJBeM+P9zLTi/66u6/CRJXP
         9IPbO9HFHLeaKoyNymmKzXVevDNyiUftsruCwH2EyJMXva3AdiQV307HiYbh5Uh1oWro
         s+hXFFtRwJTn9vcK4LT/eKnTAvTk8LR4N/3T3TJ0e3vlLGW7n8Qq5Hw6y2hhu+0wc/Kz
         bLF7fmZlnHjyU3TzKCLTNl4AYfoWnJo2VhZRJndOQWoCjYxsUTkp1ep/K4tPQlYhFkjw
         tRm3aDXy6cgTDhsNktY54cUuh6Big1h9ea+LWFT5FbNtrIfNqfKzbVi/Sj293kzfgKTo
         AqXA==
X-Gm-Message-State: AOAM5320JDUCeG2VrF55GHqZxK3xeKz7KZTTsIYQdV5z6Z+Fk0wEZKXE
        gqUg0MKVXEwBEIaaJ+VL0hLtS/A5K2dvJA==
X-Google-Smtp-Source: ABdhPJyskfzTtbuaMHJn5jUGVzJITODfYnCWOZtrPGmU6gX2wW1EvPazPg4mquo8MGe0bw2eYqrqaQ==
X-Received: by 2002:a37:9401:: with SMTP id w1mr7489255qkd.166.1630860552236;
        Sun, 05 Sep 2021 09:49:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.168.139.179])
        by smtp.gmail.com with ESMTPSA id m68sm4523720qkb.105.2021.09.05.09.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 09:49:11 -0700 (PDT)
Message-ID: <6134f507.1c69fb81.343cf.76d5@mx.google.com>
Date:   Sun, 05 Sep 2021 09:49:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6319380565393356855=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/2] shared/util: use 64-bit bitmap in util_get/clear_uid
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210905154356.8296-1-pav@iki.fi>
References: <20210905154356.8296-1-pav@iki.fi>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6319380565393356855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=542233

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      44.86 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.75 seconds
Build - Make                  PASS      192.81 seconds
Make Check                    PASS      9.37 seconds
Make Distcheck                PASS      229.33 seconds
Build w/ext ELL - Configure   PASS      8.02 seconds
Build w/ext ELL - Make        PASS      181.60 seconds

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


--===============6319380565393356855==--
