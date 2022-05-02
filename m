Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99248C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 May 2022 23:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiEBXVK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 May 2022 19:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiEBXVJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 May 2022 19:21:09 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F0630F75
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 May 2022 16:17:37 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a22so9446071qkl.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 May 2022 16:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=kMkVCaSThBr4GnpFjffuByqzUcnwE0Aq3ONGp0WM2ag=;
        b=UlTGBf9XsH936zqlbM5HW71n+6/Ykg6k7KAaMD3OhZNbiZTiF+LJ3KK5ueD7I4J0PL
         meB9eeiAykdmeHMAQbHeA3LapdViupkUnw/pSp2T/MRGMmqPLXoGSN+BuoeKZXiTPkUz
         5/LW7byd2u0PWN/NBi2kGdKpl6ABxRfQWaAjkx4Tt62kTjf/gQvz3s8r+LQ5PdslnoZw
         atOXaCsOiOjkuOwgr606FHZUYswHn7KlUfsGNXRWw3GUawoBuNoyZaTdidP9NOoMDH05
         C9xMwKp7Xkq6vNFPtV5dhfRmSVvITiLxj0lYAkvG28riX/VH5X01ygT7lWJjOg7XpssH
         uOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=kMkVCaSThBr4GnpFjffuByqzUcnwE0Aq3ONGp0WM2ag=;
        b=qmuXnrc71sGB9/A9VKovgsWFvGCDMBIgGo2c9TcED8Z3npnzOEPLTGx/ymiZ/0GPtd
         lNiN2GZdPfgZKfjOih/5QcARqK2yadxOzWW1/xsLrnQlFrpMGRriG242xP+p3HtNUVWQ
         7Hxl26uMbuPI/17gqUTL+CIc+ToQ5//Dgx36HbPhgoLedIDo84Bv8emJxkn6Q92ldntj
         eoWjNmAGAXkTXAoDp//KViG1JWGGyB/TwfQt2cogRj1ZueCzT9s6Xh9YuZRO25lAooBi
         NSo9iwndzSuM9LDJPZqIOGBUxmVIzYf3bc9EbfnyYOPGbuHeWb/L21sxLvuJ0DWgvpRz
         T7xw==
X-Gm-Message-State: AOAM532InCbA8kaWcZtnmy/dDw5N+E73liBH8X7C7a3lfD7w0RMDdbUl
        dMxbU02qP1C5+/aqg8izUKFOFZxt/cc=
X-Google-Smtp-Source: ABdhPJxyINCmJHkJzS63AyBHcymNwGzMLAuTFksez8/9TwuglBfZnRX74EMtfusIzjWYUmNvJB/V1Q==
X-Received: by 2002:a05:620a:254f:b0:680:f510:22e4 with SMTP id s15-20020a05620a254f00b00680f51022e4mr10204121qko.554.1651533456207;
        Mon, 02 May 2022 16:17:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.190.237.143])
        by smtp.gmail.com with ESMTPSA id z13-20020ac8710d000000b002f39b99f6a5sm4718553qto.63.2022.05.02.16.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 16:17:35 -0700 (PDT)
Message-ID: <6270668f.1c69fb81.92733.6aa4@mx.google.com>
Date:   Mon, 02 May 2022 16:17:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3382472390126487091=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] btdev: Fix not removing connection and advertising set on reset
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220502210553.2271064-1-luiz.dentz@gmail.com>
References: <20220502210553.2271064-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3382472390126487091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=637722

---Test result---

Test Summary:
CheckPatch                    FAIL      2.98 seconds
GitLint                       PASS      1.95 seconds
Prep - Setup ELL              PASS      50.92 seconds
Build - Prep                  PASS      0.76 seconds
Build - Configure             PASS      10.03 seconds
Build - Make                  PASS      1421.90 seconds
Make Check                    PASS      12.93 seconds
Make Check w/Valgrind         PASS      520.30 seconds
Make Distcheck                PASS      272.81 seconds
Build w/ext ELL - Configure   PASS      10.27 seconds
Build w/ext ELL - Make        PASS      1394.51 seconds
Incremental Build with patchesPASS      2867.14 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,2/2] monitor: Decode LTV fields of Basic Audio Announcements
ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
#151: FILE: monitor/packet.c:3352:
+		print_hex_field(label , v, l);
 		                      ^

ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
#155: FILE: monitor/packet.c:3356:
+		print_hex_field(label , iov.iov_base, iov.iov_len);
 		                      ^

/github/workspace/src/12834736.patch total: 2 errors, 0 warnings, 60 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12834736.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3382472390126487091==--
