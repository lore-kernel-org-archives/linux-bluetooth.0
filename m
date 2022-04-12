Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53352C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Apr 2022 02:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242416AbiDLCzN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Apr 2022 22:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiDLCzM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Apr 2022 22:55:12 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9168224941
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 19:52:55 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id ke15so15155833qvb.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 19:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=LSOG5c8bme/05aqH4tFyobL2k4TvIhReIVToxhBf7QI=;
        b=RMkB+lqFzLYpb9jmfq4KtS0+Sa7GopX5mv44PLgzH/NSCC+dhcs7vBkKzhH5DLkfhq
         OIZUAsrLw2tjXvblLV8x75CVN8bCS9uojOSBvV0ZXhMNUQAJTWF+eTVzfPrYHp0IksLP
         +vBAxsxsaGgemHiw2eoA2qEZ8TsaceTBfMtWbsLE/NKgW1pK5YQvwoi7sdBkf28vHPvS
         xIT5yUV3QX04rDFSf0pZGhyMQeM67mhrr7TKPd0nnvkd3xW2K8eBVlXnRG0smsNapzSN
         yeRWzArqRfOwKJsezPwoRFCZ5VDLFi+qQpXTukbmznwQPTmR6BeUQSWSE4Cz+seROeK7
         k2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=LSOG5c8bme/05aqH4tFyobL2k4TvIhReIVToxhBf7QI=;
        b=kbkWdhKs/HLjT0WdqQWq3rlK+pFGpIKufFjQW+/vjN1g/PkdFLrnnMb/nj9YT7RzdR
         uCQxKxYIp5YrOEp8B9Yn9I4NddA8B3VoZHbslcTUTPfRYZ5x+imwjhuLz7xdzVg3FVgU
         0sSVGyNGQ+i5GzOHTDAhFwSF/hrG27o5W1VqqaiASeC3OD7NVKxjau9Al32i7Mpfj+2E
         EaE9GjIccKVFoTmdvnV9W9t/gS3piXHb91iHAji+oYWGAE9w/mI0d3o5Jt2vXef/DBB1
         DQpTkC4lQfE0IbNNOt+cVE7h9WIymelf7OB+0DO9RNSRygUqj/3XA4qby0FDBocelwuJ
         D/Zw==
X-Gm-Message-State: AOAM531Tpt3t5bfpwV8bmgMzU+XzLEleAMOkkg+m+4Ng+eomJsL0gAf6
        rbFgQ8+FGc48oi1OYyhLBNAbmp/CI/5G1g==
X-Google-Smtp-Source: ABdhPJy2sKX3odJ0bQQtF1PQqYMnwag8PbxSzCStRHSpEPpvl46QJPc8s/gHZ0bWTBw8CPZ7SgLlqQ==
X-Received: by 2002:a0c:fd91:0:b0:444:46e9:9556 with SMTP id p17-20020a0cfd91000000b0044446e99556mr1963650qvr.75.1649731974491;
        Mon, 11 Apr 2022 19:52:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.122.82.10])
        by smtp.gmail.com with ESMTPSA id 193-20020a3703ca000000b0069bf950dd20sm5813900qkd.43.2022.04.11.19.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 19:52:54 -0700 (PDT)
Message-ID: <6254e986.1c69fb81.d973.81c4@mx.google.com>
Date:   Mon, 11 Apr 2022 19:52:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7085990622319275461=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] client/player: Add endpoint menu
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220411235804.3776702-2-luiz.dentz@gmail.com>
References: <20220411235804.3776702-2-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7085990622319275461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=631261

---Test result---

Test Summary:
CheckPatch                    FAIL      2.59 seconds
GitLint                       PASS      1.04 seconds
Prep - Setup ELL              PASS      43.20 seconds
Build - Prep                  PASS      0.72 seconds
Build - Configure             PASS      8.65 seconds
Build - Make                  PASS      1291.87 seconds
Make Check                    PASS      11.53 seconds
Make Check w/Valgrind         PASS      448.81 seconds
Make Distcheck                PASS      231.60 seconds
Build w/ext ELL - Configure   PASS      8.76 seconds
Build w/ext ELL - Make        PASS      1265.50 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/2] client/player: Add endpoint menu
ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#150: FILE: client/player.c:70:
+static GList *medias = NULL;

ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#154: FILE: client/player.c:74:
+static GList *endpoints = NULL;

ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#155: FILE: client/player.c:75:
+static GList *local_endpoints = NULL;

WARNING:LINE_SPACING: Missing a blank line after declarations
#256: FILE: client/player.c:1046:
+		GDBusProxy *proxy = l->data;
+		print_endpoint(proxy, NULL);

ERROR:SPACING: space prohibited before that close parenthesis ')'
#367: FILE: client/player.c:1157:
+						{ "properties", "a{sv}" } ),

ERROR:SPACING: space prohibited before that close parenthesis ')'
#370: FILE: client/player.c:1160:
+					GDBUS_ARGS({ "transport", "o" } ),

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#610: FILE: client/player.c:1400:
+	static int index = 0;

/github/workspace/src/12809906.patch total: 6 errors, 1 warnings, 1098 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12809906.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7085990622319275461==--
