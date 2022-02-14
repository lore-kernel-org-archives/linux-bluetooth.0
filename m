Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21D0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 16:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355829AbiBNQzj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 11:55:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346583AbiBNQzj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 11:55:39 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448A765153
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 08:55:30 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id v10so15291045qvk.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 08:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=81qSY2dRfOFGi8V+1wM1G9DskCyK8AoG2Rb9MwU/EUs=;
        b=YvqCB2EKUxS2VF/azgTPRCULQwmSoQc8ErrfH88Lltnt6PKmAygPpOy9uUPtr5k9LH
         V1c7zxaMrhEu3fz9qKyOyxJBqcN7UciKwEE2Q4bLmpUe1saIDTj/24NBsEdL1CmDeodG
         8MEH+0xIwkVl9/VAh5R8+qD7MNK5TOyjfPSEjclavb+26E4v0cw1EyNQR4SUpM/WinHM
         LD6gGjDaYjIfO52n/Hs2QdoSC7fGghSakijWe4+H6Hee9+ImsoSD+oyRmtsAlb5haOqE
         ATGUaMJB+yIr1VGsKXzuZG/AFhphzNIyq/+4uMGhpqA65VugQ3LtcEiEirf3aU+5KIpA
         Wekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=81qSY2dRfOFGi8V+1wM1G9DskCyK8AoG2Rb9MwU/EUs=;
        b=N+GDgTPqiz8i/ULdlF68R01Vcu5YVRDpUKGslOo8lOw34Pdrzg5LPwsJsu/QJ15T9+
         6ySEkAMml3jprg9icl1pILaxWcno1m4SxgjaU2hVZ+R+Pt6Zy5iNBBh+IMEUziDXWdkS
         rXdYeupR7g5ndy8xR3GeTOPEjZV2wG5jH1CypBGiSmxMBqUfW4mR/OfDpC8wxmCccVVU
         N3jQZYB+ND3WV45FjmwVbYJUJSCi3pbHTf1YW43rvLQby38Yhn8ivUdH1ZnFqNrUFf7y
         UgweaEEY8z60tTYaS0bZiU03XeAoj/OtOpoVEVSEyv8UNXjRZMaVz+RvgrIP04wwGIP2
         PimA==
X-Gm-Message-State: AOAM5309tCcLZnk4r5yPS2Evpx2EDMLltvDUNFRo/gXmMRO/oaFY+OgU
        L+rqf+PoA7ywgEW41Z5WQga5bBtHHIAgmQ==
X-Google-Smtp-Source: ABdhPJx2M44Our7QY78QeoOu7nP4d69pRANyeIuXlwIUgvM21pF/IcCz/aKAhv0CYYb86LW//VlGxA==
X-Received: by 2002:a05:6214:2686:: with SMTP id gm6mr380630qvb.35.1644857729221;
        Mon, 14 Feb 2022 08:55:29 -0800 (PST)
Received: from [172.17.0.2] ([52.167.127.31])
        by smtp.gmail.com with ESMTPSA id o13sm18501197qtx.22.2022.02.14.08.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 08:55:28 -0800 (PST)
Message-ID: <620a8980.1c69fb81.241c.2dd3@mx.google.com>
Date:   Mon, 14 Feb 2022 08:55:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4952634583177928345=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, fontaine.fabrice@gmail.com
Subject: RE: [BlueZ,v2] fix build with glibc < 2.25
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220214153105.2862331-1-fontaine.fabrice@gmail.com>
References: <20220214153105.2862331-1-fontaine.fabrice@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4952634583177928345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614152

---Test result---

Test Summary:
CheckPatch                    FAIL      1.54 seconds
GitLint                       FAIL      1.04 seconds
Prep - Setup ELL              PASS      52.96 seconds
Build - Prep                  PASS      0.79 seconds
Build - Configure             PASS      10.63 seconds
Build - Make                  PASS      1495.14 seconds
Make Check                    PASS      12.90 seconds
Make Check w/Valgrind         PASS      534.49 seconds
Make Distcheck                PASS      282.19 seconds
Build w/ext ELL - Configure   PASS      10.76 seconds
Build w/ext ELL - Make        PASS      1470.34 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v2] fix build with glibc < 2.25
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#81: 
https://www.gnu.org/software/gnulib/manual/html_node/sys_002frandom_002eh.html

/github/workspace/src/12745735.patch total: 0 errors, 1 warnings, 161 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12745735.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,v2] fix build with glibc < 2.25
14: B1 Line exceeds max length (83>80): "https://gitlab.freedesktop.org/pipewire/pipewire/-/blob/master/src/pipewire/utils.c"
17: B1 Line exceeds max length (82>80): " - http://autobuild.buildroot.org/results/6b8870d12e0804d6154230a7322c49416c1dc0e2"




---
Regards,
Linux Bluetooth


--===============4952634583177928345==--
