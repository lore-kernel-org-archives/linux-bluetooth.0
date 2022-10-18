Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42406C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 22:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJRWhV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 18:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJRWhT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 18:37:19 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E6456033
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 15:37:19 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1326637be6eso18548930fac.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 15:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4D+7RJVexvulSWlDgUGqIspE7M9/K1WMePCYTA+o/qw=;
        b=F7my78Fpw1j1Fjyh6VLVvDb+y6Uh8oklCfZ5iNXLwF5L5jjZoW68nC2qzKZ9u8Co4X
         Y7hXrvjjwIJJX9eOYMafD/UcK1zsJWP180TBgntIPsvUmGP78DWefZdEdcRvmtqS7qF8
         ghhz6O4GxmLAslPhwybUSb2tdmb/F5wTNXDUOVvhoy6VC1VbuzOucxmfM/3ul/dnwg9F
         MJJIec4XeNmaTWSDB9fFzWUQTOXNKl7/C67Pygi7N0Mr0XfvsCkGoeYbZkqhVAMRaYOc
         RiNQXSHQHQB1uy6eKUlmi0Q5MVnlTr+FTztJtaWpMy8l9Vv0nYdVIOYWq0zwHkRt6cIS
         a8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4D+7RJVexvulSWlDgUGqIspE7M9/K1WMePCYTA+o/qw=;
        b=vXYncnwHFhrTN0QmYGzGtS4/Cy49G8psKP/hj7G3YwzfDEAk3Zi0ams7RBzyO1euZq
         UyUT6fD3r7k1KSwMc02dqACJ+wpTJbTTtpfX+ytukbUCEQa1SraFXRJQcUyORwyzdbRS
         nMYDkDfNvhVzm7ymz10SEGz6wn4GcwUBBD5J/8uCXnLJpiRv63yMl/v0XayWRdrgO5jv
         w44ramIl39y/AXqWP0Rp937AloGolLaPcf0WwRhdweTCLXOi+cFpBrGEtFbPv2m6D34J
         meDdSplADu1vtW7lH6cD6TdYLYMAyLKg9khtyTWJn3aA/GWwXluXz1ZGKfXIc2EF/Yhs
         alaQ==
X-Gm-Message-State: ACrzQf3/U/W6+AmsNh4oHgvwAcqMGdSr4YYscPkst506d28u+WjSLjtY
        Ff5bF3Tr5PVrtnLkONSabf7t+AZF/9Y=
X-Google-Smtp-Source: AMsMyM6dWXJDSrGpOnclv562MgXAd4gZnm4LdfripIGH9U5/+grxgAhiOjbD2JZ6P7dkRd2Nfu4mKw==
X-Received: by 2002:a05:6870:6111:b0:132:af5e:36c3 with SMTP id s17-20020a056870611100b00132af5e36c3mr3041550oae.68.1666132638348;
        Tue, 18 Oct 2022 15:37:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.115.250])
        by smtp.gmail.com with ESMTPSA id v81-20020aca6154000000b0034fc91dbd7bsm5990503oib.58.2022.10.18.15.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 15:37:17 -0700 (PDT)
Message-ID: <634f2a9d.ca0a0220.3651.71ab@mx.google.com>
Date:   Tue, 18 Oct 2022 15:37:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5552242516796262941=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] settings: Fix scan-build warning
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221018212800.3967256-1-luiz.dentz@gmail.com>
References: <20221018212800.3967256-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5552242516796262941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=686460

---Test result---

Test Summary:
CheckPatch                    PASS      2.22 seconds
GitLint                       PASS      1.56 seconds
Prep - Setup ELL              PASS      32.57 seconds
Build - Prep                  PASS      0.82 seconds
Build - Configure             PASS      10.55 seconds
Build - Make                  PASS      992.64 seconds
Make Check                    PASS      12.63 seconds
Make Check w/Valgrind         PASS      351.85 seconds
Make Distcheck                PASS      293.36 seconds
Build w/ext ELL - Configure   PASS      10.54 seconds
Build w/ext ELL - Make        PASS      103.89 seconds
Incremental Build w/ patches  PASS      248.67 seconds
Scan Build                    PASS      631.14 seconds



---
Regards,
Linux Bluetooth


--===============5552242516796262941==--
