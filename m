Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F5AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Mar 2022 01:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346608AbiCXBys (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242699AbiCXByr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 21:54:47 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DFF5F4C2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 18:53:16 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id f3so2687420qvz.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 18:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=NBSu7WF8z/xi5d+2tM2HMgcIHOIERtn9ITrqbqBIs8s=;
        b=BAc1lMILr3orZo+SjS0UN4YbDidGw7W09sf555AIYHXSTEiMlJ26207YQt9qmX4z/G
         4TMOSeE+hA7K5oTp98Kf+dO52eUocipnXhqH9GbmdTI5AQHdP9ReC+I4dSX73scUZc8G
         EE5ybyJz7mBPUt1zxa/enf1SEYfnWlqHyX9Oy4BTTKkBzOn7C2luILWNZ80ib47SOAUe
         JwAMFHY0vyMvTyDWUbngsMKiigwFALVxZktkz1KFHrXTiTTt3qnGIUHuJz7ghEO+n4hr
         XREVKVJMvRuzgx0lvWSARjyABleLuZL0XhxsqpjWF/8IaZaBbLGc6LrwvPYo4K0/W4VG
         OaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=NBSu7WF8z/xi5d+2tM2HMgcIHOIERtn9ITrqbqBIs8s=;
        b=vQCCaVcbsr/KF6oAoIyArkUlo6DtD5jbnBitIhpV/gLxEzUvfTSrLFYkaEO7dmujWU
         btc0H8hJnCrTGcnuCPXvE9pWMPeh9u9k/XLQJqsdhdeW6zyZo0TSebTLY+wKwN2e0yix
         aiKaDxljBUX3V7rM55lD7M5e+K1IYY8OZ1hcmyZxJkzLkSPvQZ6jkXVpDGnMykGeH2cs
         BiFqINXbRYDXJcja/sfDGxQLcTAeZ1jUXXPUnYGjn3fypAmTFT0OLSlGcrq9+MzaQk1u
         HoahJ2AotjcEoMqqi4/s5Wj02dXsHr7KAEAiD7/rdPV2bVjg6l2TPIvZrlubFpFtiNYx
         2eig==
X-Gm-Message-State: AOAM533Nv0eNGauQfpdDGiB+tHT87GWq8RY03XshT52CLpZ9paRmUtDb
        F3hv+WndRWhAW27h7Q5xAF8lWVujw/zwHQ==
X-Google-Smtp-Source: ABdhPJzTfLdIEp+zUMZxc1zAj6krzptjZXeokOp1x849obWf8osrxz3qarBAZxM6d1DJlUj0I53ZGw==
X-Received: by 2002:a05:6214:c82:b0:441:1ec7:a225 with SMTP id r2-20020a0562140c8200b004411ec7a225mr2251759qvr.123.1648086794983;
        Wed, 23 Mar 2022 18:53:14 -0700 (PDT)
Received: from [172.17.0.2] ([40.70.17.103])
        by smtp.gmail.com with ESMTPSA id f14-20020ac8068e000000b002dd1bc00eadsm1224278qth.93.2022.03.23.18.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 18:53:14 -0700 (PDT)
Message-ID: <623bcf0a.1c69fb81.6fc66.8e37@mx.google.com>
Date:   Wed, 23 Mar 2022 18:53:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1562168685975305337=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/9] log: Introduce DBG_IS_ENABLED
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220323201341.3596128-2-luiz.dentz@gmail.com>
References: <20220323201341.3596128-2-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1562168685975305337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=625843

---Test result---

Test Summary:
CheckPatch                    FAIL      13.58 seconds
GitLint                       PASS      9.04 seconds
Prep - Setup ELL              PASS      50.00 seconds
Build - Prep                  PASS      0.85 seconds
Build - Configure             PASS      9.97 seconds
Build - Make                  PASS      1675.05 seconds
Make Check                    PASS      12.27 seconds
Make Check w/Valgrind         PASS      485.16 seconds
Make Distcheck                PASS      265.91 seconds
Build w/ext ELL - Configure   PASS      9.87 seconds
Build w/ext ELL - Make        PASS      1641.50 seconds
Incremental Build with patchesPASS      15009.23 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v3,3/9] mgmt: Introduce mgmt_set_verbose
WARNING:REPEATED_WORD: Possible repeated word: 'the'
#83: 
the the likes hexdump of packets, by default it is disabled since in

/github/workspace/src/12790083.patch total: 0 errors, 1 warnings, 61 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12790083.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1562168685975305337==--
