Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F019AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 03:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbiCNDtM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Mar 2022 23:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiCNDtK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Mar 2022 23:49:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920111AD82
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Mar 2022 20:48:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fs4-20020a17090af28400b001bf5624c0aaso13294449pjb.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Mar 2022 20:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8Fowydw/pZXG6jjGRpsGD+NGptpAlZ3JTkIDfXKLPHc=;
        b=J27dUFnhwurHVd4fRoZMnAPGftgw0zTKxKMDDXWbKJfP8A7zmVV5XXL8KeWjKTABlo
         5VXjx/zRzp6X7f4cGbHF5vw8XWiWxYnK2RKLc2Xh36k3baPeYIk5c8d3BJ96XzXPB7b/
         iQRuG3aqgdQoweLVuf9AARIwEqyZ/bYUrHvcBE2esCXzfndTvuEJIjZgyi3zQ9gZRujr
         NefU30wYSjRCFBst4Mhi0iGOycKCtPu6EiKTcq4cSislE0hy5qInI4q7ESPuU5JENxRh
         1TcMv7SC3azUU9DSMYux5/E2Wb17Burg1pi7Har/4FKlOJzsLPz3E4D/6JSpJJ1Y2JU3
         V/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8Fowydw/pZXG6jjGRpsGD+NGptpAlZ3JTkIDfXKLPHc=;
        b=lbqPPBmeSZGeFIGwVDdKydbzqWlp2CcKK/kadRzlQn7AXZ/vqCLzhfZg6d4UhHBRxH
         R83p0A3oKp7rL27uyDb66moKIAcKJ2mb6WU5wwqgGwPxEcrud5gL2CMeQ1gl3x34Xl6D
         +uZQHFlIXIvudskf/267DXjzXvdvFsrpiJ//q/QJ3e9rAw25LccbL+vAWrItEOzIY109
         lbVQWl0eGyYBW3Mjw+sTJGtjqIxoWtXz4caS+cilFwJaUnoo3rMyvTmFm6gziGU4lMdh
         J/Zg5A+Je7IO+o5y/l32+AKMAKY+6GwJmVRalEsLGJ8sMY2RVogXTDtjuRkRmHSrjsOg
         wSyA==
X-Gm-Message-State: AOAM533BtU1ldKzpo5DqlaoABdm2bPuYGKJB2kcgK+6g5xEtPqNhELc1
        UkOujYjicpO0Q8Y54SxJWYNxxOuR8ug=
X-Google-Smtp-Source: ABdhPJwBuRODxblnGSGeuR6A3lF66wk9SzkckQzqUDOsZpIs74hc4f3P3tZSlkG/Zd3oJwi7E1Zj+w==
X-Received: by 2002:a17:90b:4d82:b0:1c5:d65:9a3a with SMTP id oj2-20020a17090b4d8200b001c50d659a3amr13679836pjb.112.1647229679835;
        Sun, 13 Mar 2022 20:47:59 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.93.37])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a859100b001bc20ddcc67sm19077810pjn.34.2022.03.13.20.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 20:47:59 -0700 (PDT)
Message-ID: <622ebaef.1c69fb81.20dda.1e5e@mx.google.com>
Date:   Sun, 13 Mar 2022 20:47:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6325461999531679373=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jesse12p@gmail.com
Subject: RE: [BlueZ] sixaxis: Fix Sony Navigation Controller pairing
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220314020245.135251-1-jesse12p@gmail.com>
References: <20220314020245.135251-1-jesse12p@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6325461999531679373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=623006

---Test result---

Test Summary:
CheckPatch                    FAIL      0.65 seconds
GitLint                       PASS      0.47 seconds
Prep - Setup ELL              PASS      52.35 seconds
Build - Prep                  PASS      0.69 seconds
Build - Configure             PASS      10.00 seconds
Build - Make                  PASS      1829.82 seconds
Make Check                    PASS      12.18 seconds
Make Check w/Valgrind         PASS      549.94 seconds
Make Distcheck                PASS      283.47 seconds
Build w/ext ELL - Configure   PASS      10.14 seconds
Build w/ext ELL - Make        PASS      1819.22 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] sixaxis: Fix Sony Navigation Controller pairing
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '61745d2bb8b5f534278db49faf8e2cdb7e894529', maybe rebased or not pulled?
#80: 
Commit 61745d2bb8b5f534278db49faf8e2cdb7e894529

/github/workspace/src/12779492.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12779492.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6325461999531679373==--
