Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14C6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Apr 2022 02:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiDPCda (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiDPCd3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 22:33:29 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B366482D27
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 19:30:57 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j9so316911qkg.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=tENT+LZh7xQZ6irD/Xb9lV7v5euxZSsNW2+cOFjnM/E=;
        b=igJbF7Sit8AMfm7sTQZH8OM1l25/w9bMuRwQ6da6Lv7Y26357mgQOjrFQaT4pUTO5b
         zftqRJRNev8Qit2AU8hy2eXExgrRMhv3A6+ZJjl0tqHmx2jA5TDNT5jTRH15+SwF1wK3
         8oykt4nvOXQBX5O6kjrmpmMS1oQGTUi3LCeCJqTMyMJV9o+4IBqjZ4W05Wd9pUcqnfn9
         UTe5uSqQfF87euMxc1Un4ojYSStpzgGlHgA6/Ugh60nuZ7D8y1ZouZySsqOxLqI+x4ls
         MeJ+O0PslNRqJSxfak0N5cVk/fKTalP7uTcHKc6UWj08Lo1advf3/65o2pYJaFm5zatz
         lF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=tENT+LZh7xQZ6irD/Xb9lV7v5euxZSsNW2+cOFjnM/E=;
        b=71ZNqSLm/E8WFLkPU7+9TV4oaJYnDv/5Tay91DGHFHhXpVoi+0U3wdabMI/AGvSlJN
         pf1M5BNhZ6MjZufMrtS3q00SBL9D8lO8jRT1UMNhdFlhTmEOQOTHrxGanzXkasxTLIHP
         ay/TcOf5q0lRKz3QF/B1c7Avyhcu5gIsCTTiB8fyxg4IFvTenY5nMkRNPYOyi35damIs
         arU3GCIYZG4UwBeppMP8nn+FqhouSld/j/vHtmadmHsan6Rh4ycjXOAViWLZRLNiIXJc
         QJucyRvYe3OH5669fkrQ5kFkj8A4N3ZZj8/nQq+yVwJDccbdNJVQ6/Kcqp+p6Wj8QHud
         +voQ==
X-Gm-Message-State: AOAM531/9R2Nrhwsip+Llan+BHfhR5rocpWrKpeBGsV993qFruBjr+zZ
        EgUbJ7LWvYCtrE8Ea3XbmdMWw+xj/QCG7Q==
X-Google-Smtp-Source: ABdhPJyu2TsIJCe/MRCret6wN8sPTI/unwXQQ5ATzdtGp9jJtJd2ZkTBr1y/uwog7C5eaweF/hHDQw==
X-Received: by 2002:ae9:ef55:0:b0:69e:7116:8644 with SMTP id d82-20020ae9ef55000000b0069e71168644mr366354qkg.293.1650071455370;
        Fri, 15 Apr 2022 18:10:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.94.67.103])
        by smtp.gmail.com with ESMTPSA id r7-20020ac85c87000000b002e234014a1fsm3825318qta.81.2022.04.15.18.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 18:10:55 -0700 (PDT)
Message-ID: <625a179f.1c69fb81.7f351.677e@mx.google.com>
Date:   Fri, 15 Apr 2022 18:10:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0102991410510379845=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,BlueZ,1/3] storage: Add support for STATE_DIRECTORY environment variable
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220415223049.1155838-1-luiz.dentz@gmail.com>
References: <20220415223049.1155838-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0102991410510379845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=632684

---Test result---

Test Summary:
CheckPatch                    FAIL      4.66 seconds
GitLint                       FAIL      2.95 seconds
Prep - Setup ELL              PASS      42.20 seconds
Build - Prep                  PASS      0.77 seconds
Build - Configure             PASS      8.36 seconds
Build - Make                  PASS      1579.29 seconds
Make Check                    PASS      11.92 seconds
Make Check w/Valgrind         PASS      433.54 seconds
Make Distcheck                PASS      233.76 seconds
Build w/ext ELL - Configure   PASS      8.62 seconds
Build w/ext ELL - Make        PASS      1575.38 seconds
Incremental Build with patchesPASS      4837.45 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[v2,BlueZ,1/3] storage: Add support for STATE_DIRECTORY environment variable
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __printf(3, 4) over __attribute__((format(printf, 3, 4)))
#888: FILE: src/textfile.h:12:
+					__attribute__((format(printf, 3, 4)));

/github/workspace/src/12815484.patch total: 0 errors, 1 warnings, 715 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12815484.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v2,BlueZ,2/3] main: Add support for CONFIGURATION_DIRECTORY environment variable
WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'main', this function's name, in a string
#161: FILE: src/main.c:1222:
+	main_conf = load_config(option_configfile ? : "main.conf");

/github/workspace/src/12815482.patch total: 0 errors, 1 warnings, 67 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12815482.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[v2,BlueZ,2/3] main: Add support for CONFIGURATION_DIRECTORY environment variable
1: T1 Title exceeds max length (81>80): "[v2,BlueZ,2/3] main: Add support for CONFIGURATION_DIRECTORY environment variable"




---
Regards,
Linux Bluetooth


--===============0102991410510379845==--
