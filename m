Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952EEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Oct 2021 01:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769D5611BF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Oct 2021 01:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhJNBaY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 21:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNBaX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 21:30:23 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BE9C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 18:28:19 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id o12so4436892qtq.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 18:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jRQf3s8U3uFW+HlqYH8tvoez5bAWFENs9ATlaJaZLh4=;
        b=qQdB96qe9faWb54/bKBRr/x6KXMatpN6wXBqMhlOL3AQ53MkF1hIopSDkRPEkkuvP7
         Otg5JMAeZPWgJlo33sNes86vNdyQcv4f5q7c/eLOSCqp+FgOTGMK68dJfF/nprQkA2zn
         K7I4X/EcKo+ggXrJG0O/JY89LOfSL3mKa/HrHYeFuP6zoZM9EpZjQMsVmNe0Oys9oX8n
         uqPLOCoDnqR3ZHifBVXmO2a3dOACHI/5bITPSezxs3lAOzsQVxyNQOjZIFskKAC+SweV
         kEWuMJMiTqZRmgFaq0H5S2ctKIj4HXP2i4Rb9ZPlrrZkd5tCUwycKwptMVGIPXjLuugN
         v3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jRQf3s8U3uFW+HlqYH8tvoez5bAWFENs9ATlaJaZLh4=;
        b=imFMiVjTNzSfZ3S7XIMXedYAH8sMNLHgS95osDI0yScGyMCMLPVs0m/S05alcMUR5e
         sijPveQgLcmwowRv9sWHq00TPtY3IhJNEMW1iq13UBZjldKHlVGE2Y7mchTXVeTQf/RC
         I/WH9SpLmn7vvZ4B597btB91QkOF6RDJjtT6Wtaf+lq03q/5VE+VlpYehOjiOaBNaobt
         n10j/fWdNkn8Aw5Vghy2mmUvdvmcV6hcsYilYjke8DHvhJRg2Dzwn4202cSklyFwOcJr
         JOe19t/7l8d+SBuSAnGRhMZMOeB1ne+bj1dI2bJDhGsg2aoKXFbP7gs6l9OaQRz2o/W/
         sNxA==
X-Gm-Message-State: AOAM53079cVHrDFCt+9hfn/SeTV+E7ayXhv9zSX6GUyR+shxPGWasLrU
        RveIAPYCTGbpXVK026R+0B/T+F5OVIDBQA==
X-Google-Smtp-Source: ABdhPJzeCOsOQ49m38AuKELin/K7WcHo8kmxSfsxgvImzk6UeMqlZmcBLe6Z5BxpvxsJ88KoFJ+Cww==
X-Received: by 2002:ac8:5ac4:: with SMTP id d4mr3173952qtd.275.1634174897069;
        Wed, 13 Oct 2021 18:28:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.96.16.82])
        by smtp.gmail.com with ESMTPSA id g27sm801987qtm.1.2021.10.13.18.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 18:28:16 -0700 (PDT)
Message-ID: <616787b0.1c69fb81.1cead.6e74@mx.google.com>
Date:   Wed, 13 Oct 2021 18:28:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3145720261230994186=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] monitor: Add packet definitions for MSFT extension
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211014005713.2857000-1-luiz.dentz@gmail.com>
References: <20211014005713.2857000-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3145720261230994186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=563121

---Test result---

Test Summary:
CheckPatch                    FAIL      2.98 seconds
GitLint                       PASS      1.89 seconds
Prep - Setup ELL              PASS      42.20 seconds
Build - Prep                  PASS      0.46 seconds
Build - Configure             PASS      7.78 seconds
Build - Make                  PASS      178.44 seconds
Make Check                    PASS      9.71 seconds
Make Distcheck                PASS      213.17 seconds
Build w/ext ELL - Configure   PASS      7.92 seconds
Build w/ext ELL - Make        PASS      169.34 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[v2,1/2] monitor: Add packet definitions for MSFT extension
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#102: FILE: monitor/msft.h:31:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#110: FILE: monitor/msft.h:39:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#121: FILE: monitor/msft.h:50:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#126: FILE: monitor/msft.h:55:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#133: FILE: monitor/msft.h:62:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#138: FILE: monitor/msft.h:67:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#147: FILE: monitor/msft.h:76:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#152: FILE: monitor/msft.h:81:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#161: FILE: monitor/msft.h:90:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#165: FILE: monitor/msft.h:94:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#171: FILE: monitor/msft.h:100:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#181: FILE: monitor/msft.h:110:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#187: FILE: monitor/msft.h:116:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#194: FILE: monitor/msft.h:123:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#199: FILE: monitor/msft.h:128:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#206: FILE: monitor/msft.h:135:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#211: FILE: monitor/msft.h:140:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#218: FILE: monitor/msft.h:147:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#225: FILE: monitor/msft.h:154:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#234: FILE: monitor/msft.h:163:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#244: FILE: monitor/msft.h:173:
+} __attribute__((packed));

/github/workspace/src/12557621.patch total: 0 errors, 21 warnings, 154 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12557621.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3145720261230994186==--
