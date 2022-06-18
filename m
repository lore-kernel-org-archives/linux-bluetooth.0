Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C8BC43334
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jun 2022 03:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiFRDsz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 23:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiFRDsy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 23:48:54 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724C654F81
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 20:48:52 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id o43so9042588qvo.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 20:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=qSRdepBQ320jeGAdk3QX6vnX22cGUJSO7gFyTqj/Jzo=;
        b=bf/OJwbxSX8BeQUX6GegJVhI1ain+dAmE+rPNbTtZbVBJt0DND9MqMK0ebk8swLrdQ
         7hslUddV5nzgWra0Ytc0zp5UiZENO7Z6qcNRC7S3S1e7GsWvEt9xBhKFaUGItvgR8mhT
         k6qG+TAU81hVRvOY5WgT+vj/IO0PAnV1a0ojgHyfEHJt46ebdw/H5REKlKfaFV70ICCU
         PQeOHVt57Oi8E81KrHogVDaCSNmRCUPOmMvu9EBciLwgi5AE0iUXoD2TgAvkJz9SySdU
         aVdvyvfvWj+YXLg7HFB/stt/L+RkedC3N3neakyp5cF8L7ggw04sbpZOpLcdDM5w/zKy
         j5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=qSRdepBQ320jeGAdk3QX6vnX22cGUJSO7gFyTqj/Jzo=;
        b=8OPDbpWNCIwvcei+Mi32hkiteVlkQv5XYzX4Hjx5Z5bOkYFBsheBDsJ8MeG9FQjeu7
         ZUXz19jevCHAZaZBthQIl0u/dZwnzSqNagc+ZJG+hNByN2JrMOzxq5pyG8SFbyQaJufd
         GTbXOuIPAuyS7V1yf3m0RaJSzJNmaouyXLrxerDn0agahc13WcoWCXE4CwpOjArjdLvG
         yXNQnfgWjdQXEc3X1lIWxLo/+xZctYYqm8MBzYEQ/E7Td+QgZ5pZET3aon4vZRUAjcsT
         m+HfB9ZqFrRmgYSTy4psvWd84Y+Iw3s6bRcbsyEUG5Da3Rk+3jVEBJ8DwdXsQv0Tr6Ep
         2UxA==
X-Gm-Message-State: AJIora897XB1aVBrkcSQEoF56TNRT8Y/JKo3QBjpaWCSZpSURceUO4MZ
        2rYK2Eg/cxaQU8yDsbnAy1sdlPUqfZzNpQ==
X-Google-Smtp-Source: AGRyM1tFIivni0qx3wrS8RzzCDoIp60y0yRBx2Mkz3z1K9HqgRtrkqkE0/M2TZ4gcZmy0u6Cyhaksg==
X-Received: by 2002:a05:622a:10:b0:305:1a43:7a97 with SMTP id x16-20020a05622a001000b003051a437a97mr11371317qtw.411.1655524131424;
        Fri, 17 Jun 2022 20:48:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.242.24.99])
        by smtp.gmail.com with ESMTPSA id b24-20020ac84f18000000b00304de7561a8sm5486700qte.27.2022.06.17.20.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 20:48:50 -0700 (PDT)
Message-ID: <62ad4b22.1c69fb81.565e.b7c7@mx.google.com>
Date:   Fri, 17 Jun 2022 20:48:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4294815326323961283=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v6,1/8] lib: Add definitions for ISO socket
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220617222119.1413958-1-luiz.dentz@gmail.com>
References: <20220617222119.1413958-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4294815326323961283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=651579

---Test result---

Test Summary:
CheckPatch                    FAIL      15.85 seconds
GitLint                       PASS      8.46 seconds
Prep - Setup ELL              PASS      54.02 seconds
Build - Prep                  PASS      0.89 seconds
Build - Configure             PASS      10.59 seconds
Build - Make                  PASS      1819.04 seconds
Make Check                    PASS      12.78 seconds
Make Check w/Valgrind         PASS      557.04 seconds
Make Distcheck                PASS      294.41 seconds
Build w/ext ELL - Configure   PASS      10.74 seconds
Build w/ext ELL - Make        PASS      1814.82 seconds
Incremental Build with patchesPASS      14733.34 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v6,7/8] tools: Add isotest tool
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1222: FILE: tools/isotest.c:1106:
+		/* fall through */

/github/workspace/src/12886070.patch total: 0 errors, 1 warnings, 1219 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12886070.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4294815326323961283==--
