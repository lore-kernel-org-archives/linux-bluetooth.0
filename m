Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953B2C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 09:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BFB60184
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 09:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbhHQJjE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 05:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhHQJjD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 05:39:03 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7055BC061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 02:38:30 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id m21so4407896qkm.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 02:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7LzC1O51V6WUOHOzb9zgty5sgjVO0sITVcf2amIqqhM=;
        b=cKVWu2y+Rv5tD8dYD4D/xfDOiEqxhgL1aSWFzqriB11RCx+k3xspdx3U0nixmK+52c
         cTPRX8fuVqAxGnM5f88iMttLQXWE0fyp8SFpJSdJSONC5lffDqdZSh6EywGll6lEWnWC
         sJ5tNvHds5DZqHAD98eKTSyK6dXzhK5fStlLmsRV726Xa2Djf5mL6rPD9LYNJFIgN0ef
         Dgah1orbHT4fkYmhUS9UhyOogHrc0EfsYj+WAYpfhQjpfSwQdxvKjOStc+w1X3AqKkyK
         KD+XOfxu9Qc3dvOqf49UJEfcTNRtJN96g1SzDCKTM5XqqYLEk763uDwLDyLxBEYWsV2N
         9kgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7LzC1O51V6WUOHOzb9zgty5sgjVO0sITVcf2amIqqhM=;
        b=W+BgkB2RtnkI4F6GWgGV65DapVT9q+5679/sHZzCgTwaxGm8g+BQYnIInzDL9oCa3a
         y7QqNY0FrRiq2oxXHbmpRYeUBvUrbCS8nRI/hJQ/h3J+ixotsB9X0av1O9XMUTx2gI1J
         ZmFdvPVpFVvRceakFekQzcGfcpHsDYXYkWI2uJNchRKfX7fXSAV/2BZnXE9ArLQzfw5l
         emuLCXX6Gr3L+bXkE1h7PEIkcbty2LQpWdxaooUVSwVOTyI0yN7A6aw3/+ETei/wvuLV
         RILqgspWXGhVWtqTtRkDzzri2IErJI9AWhXSXs+um3KZm8nTM71HRVnmot9+7ubzVcAb
         KiqQ==
X-Gm-Message-State: AOAM532nr97VAk6FA0h9gANtx3l/QXSIy/Ssrck0xpphlrUzlXUT2hKI
        waU0kDq2cj/uKYDpqDWKv3Spq0I0CGYBFw==
X-Google-Smtp-Source: ABdhPJw/Nr73vn5Mo7KUKndqPN6xvsvJrGsl08Yssv/LS7fzeOx8f3libPkrBnRSKvoz9n7QZ4bP2Q==
X-Received: by 2002:a05:620a:1786:: with SMTP id ay6mr2849428qkb.423.1629193109377;
        Tue, 17 Aug 2021 02:38:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.216.65])
        by smtp.gmail.com with ESMTPSA id r19sm705175qtt.86.2021.08.17.02.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 02:38:28 -0700 (PDT)
Message-ID: <611b8394.1c69fb81.da430.3e1c@mx.google.com>
Date:   Tue, 17 Aug 2021 02:38:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1063664807489885415=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] emulator: Add support enhanced SCO connection
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210817084941.22484-1-kiran.k@intel.com>
References: <20210817084941.22484-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1063664807489885415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=532611

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.13 seconds
Prep - Setup ELL              PASS      47.65 seconds
Build - Prep                  PASS      0.12 seconds
Build - Configure             PASS      8.57 seconds
Build - Make                  PASS      209.92 seconds
Make Check                    PASS      9.81 seconds
Make Distcheck                PASS      246.03 seconds
Build w/ext ELL - Configure   PASS      8.03 seconds
Build w/ext ELL - Make        PASS      192.27 seconds

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


--===============1063664807489885415==--
