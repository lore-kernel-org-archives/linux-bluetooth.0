Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D8FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 07:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350874AbiDOHHp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 03:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiDOHHo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 03:07:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FC549F11
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 00:05:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso7733062pjj.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 00:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=XV75PbrgV8PxC5KaZKQRQO9Wy903WNtzcUuD/rL1Hgo=;
        b=ATlkFO2YvsPD4e5XHYVUZrk8HCUN6kApwYnOxsjWNnGl+Bzj1mUCPhnSm+sEg7F0vy
         eWAJGEIOhn6xMFFXbi7dIA+L5NdIWK7Bx1MQWUWktXPP2hOiWaqTk8dJUYD0wlcDSgkx
         h23AguJx+P2cRZE3+Gz916BsSQ3CSZ0BfBXmlu3ZqVGpqG4ddHlwg00LdJAsuh2lyn/p
         2TAwiyggvApnansBy1RZBTu/RI6Txs2itPNbOOe6LnwE/zp3uHYE5ADO9hsJCiYj77le
         kDcMD4bsBl8JaSV2THQSoCD5Z1ZuavYX/zwNIwiQZkR7Cg+AThxXBUrr6OCnJ2KKQJrK
         4B9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=XV75PbrgV8PxC5KaZKQRQO9Wy903WNtzcUuD/rL1Hgo=;
        b=lYeqr2cJSZZt68wy/4YgCqLBM5RPMcRXo/BGaIpi1B+Ob3OzdPuEyo4t9oNMnyoi73
         SqpSfSL1oyLvZvuYSzyqvuc1PAzQcYR9lpyyFlCspgetkvg7OXblF6Vz7bg2ugdr+JoZ
         bdbYBkArD2pIAfMCYBT1Fgnyx3vSJ/oiz//aNMFwaGuHlFeYD0o2mPc/KALP49V4RtHx
         xiEBYDdkenNdd84oIeaW8ShCp6vZwwkP/jAR8ISPeLXhM8diJFtjgT8LYCDQUfQwTvH8
         n9FOKXTRbfdnRUHZpOk66ISHk7ac849s6CBo725BJAIcngKA6hBcH01197brKXT6mzjv
         8qdQ==
X-Gm-Message-State: AOAM530fR3Qe7swy0o8UIu7S9WLIEuX3ZkfosRcQuz7+C9+h1BWixiYM
        TyuvJw4zKpTC+RZWMQpDuWGIyfpkbm0=
X-Google-Smtp-Source: ABdhPJym4U+7wyh3jsmuk65DhvrosE6mLQLdhAOIzICxG7qzaIxGCfDR1gwVcu5j8S88LBONUCZ0eg==
X-Received: by 2002:a17:902:6b44:b0:154:4bee:c434 with SMTP id g4-20020a1709026b4400b001544beec434mr50801926plt.43.1650006316222;
        Fri, 15 Apr 2022 00:05:16 -0700 (PDT)
Received: from [172.17.0.2] ([40.112.144.53])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090a784c00b001c6bdafc995sm6634681pjl.3.2022.04.15.00.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 00:05:15 -0700 (PDT)
Message-ID: <6259192b.1c69fb81.bf4ba.d8e9@mx.google.com>
Date:   Fri, 15 Apr 2022 00:05:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7603793001052204614=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,BlueZ,1/2] client/player: Add endpoint menu
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220413211630.171843-1-luiz.dentz@gmail.com>
References: <20220413211630.171843-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7603793001052204614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=632031

---Test result---

Test Summary:
CheckPatch                    FAIL      2.97 seconds
GitLint                       PASS      0.91 seconds
Prep - Setup ELL              PASS      41.43 seconds
Build - Prep                  PASS      0.45 seconds
Build - Configure             PASS      8.12 seconds
Build - Make                  PASS      1247.20 seconds
Make Check                    PASS      11.23 seconds
Make Check w/Valgrind         PASS      435.67 seconds
Make Distcheck                PASS      223.18 seconds
Build w/ext ELL - Configure   PASS      8.22 seconds
Build w/ext ELL - Make        PASS      1229.19 seconds
Incremental Build with patchesPASS      2507.39 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[v2,BlueZ,1/2] client/player: Add endpoint menu
ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#152: FILE: client/player.c:72:
+static GList *medias = NULL;

ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#156: FILE: client/player.c:76:
+static GList *endpoints = NULL;

ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#157: FILE: client/player.c:77:
+static GList *local_endpoints = NULL;

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#251: FILE: client/player.c:1020:
+	static int index = 0;

WARNING:LINE_SPACING: Missing a blank line after declarations
#303: FILE: client/player.c:1072:
+		GDBusProxy *proxy = l->data;
+		print_endpoint(proxy, NULL);

ERROR:SPACING: space prohibited before that close parenthesis ')'
#687: FILE: client/player.c:1456:
+						{ "properties", "a{sv}" } ),

ERROR:SPACING: space prohibited before that close parenthesis ')'
#690: FILE: client/player.c:1459:
+					GDBUS_ARGS({ "caps", "ay" } ),

ERROR:SPACING: space prohibited before that close parenthesis ')'
#693: FILE: client/player.c:1462:
+					GDBUS_ARGS({ "transport", "o" } ),

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#870: FILE: client/player.c:1639:
+	static int index = 0;

/github/workspace/src/12812703.patch total: 8 errors, 1 warnings, 1314 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12812703.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v2,BlueZ,2/2] client/player: Add transport menu
ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#113: FILE: client/player.c:79:
+static GList *transports = NULL;

WARNING:LINE_SPACING: Missing a blank line after declarations
#350: FILE: client/player.c:2462:
+		GDBusProxy *proxy = l->data;
+		print_transport(proxy, NULL);

/github/workspace/src/12812704.patch total: 1 errors, 1 warnings, 448 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12812704.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7603793001052204614==--
