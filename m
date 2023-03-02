Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A011CC6FA8E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Mar 2023 22:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCBWbu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCBWbs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 17:31:48 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D018017CEC
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 14:31:46 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id r4so628143ila.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 14:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677796306;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qWec8+omG22ADwskVi1CqhncajkZ14L9VMII2Kv9SoY=;
        b=PfReenjQS/4qa06BqCCZKbPpSso7KNSrxmSM79TlQuxqL7Qkkk1NHc3DZzrIzAp38X
         cVpm3CFsZxd8gSKju8himgGf+dabHAyDwSUM9o1IXO17lkBlPbO0uZUfNbFZpx9ubmP1
         hYYaMV+rTjRqYSrYmlnVeqiqIlZGlphOl2NrLitcAkigGIw30X/51KvSUJPwZPqOddWw
         eJNOURgpeig2u5pul8gEDue1Wqu9pGaMg35WTCpClcGgpiHy1sSeMYLa910WAIB/IrvB
         bUGsuf4sHbGF7uoc8lBqKIMwNKKM3Ow4M1YK3O6I2vEDORAgrwXoaJonJ20UdJ2LwERc
         HquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677796306;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWec8+omG22ADwskVi1CqhncajkZ14L9VMII2Kv9SoY=;
        b=FQlFq2j1P4A+3QyyqPemwyw8iEifICkolIk1amur1n+NijbZcxulsXto43p33+6bxg
         EwDvJ1XM8YMv0reQJMiI6PxIIGVv6mUmAsdgicf9l6jIk7BWPY3DhGAKaCKw1XiemmPg
         jFEQyZXdOOQtJmTBa2tyAPaCsyTNEp+GtvdtFxxCmbjPCqzM9+McNTQq1dcu7KFIk7Va
         MbWqN/eBq1A+OihYakNJuojslizenIg5aXayz82wgZgUVK9Sfk3A5ucjXThlOMum7uHr
         zvsl+Z28pc/hswbFizbs1Kjj85Q55MuH/vZ60Ju+NALLVDrYeh1dxVujw/MXK4SFIsk1
         vh9Q==
X-Gm-Message-State: AO0yUKUC8/Fq/SnLeKBk9W01zz4x0lBQgyYGMrYup+w/skqD7G3DjGme
        h4xZPIFfV8/8gVC6V+e1TG9nBxIWmdk=
X-Google-Smtp-Source: AK7set/Tvwrck3If7d3IUTbi8c2h/kNqKQlkXSNKFK0u7sczfhZSf5xbzMytxjopJTsXKrSttW3ZTQ==
X-Received: by 2002:a05:6e02:1543:b0:315:2eec:4055 with SMTP id j3-20020a056e02154300b003152eec4055mr2498731ilu.11.1677796306037;
        Thu, 02 Mar 2023 14:31:46 -0800 (PST)
Received: from [172.17.0.2] ([40.77.93.32])
        by smtp.gmail.com with ESMTPSA id u19-20020a056e02111300b0031112bb19e9sm138915ilk.54.2023.03.02.14.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:31:45 -0800 (PST)
Message-ID: <640123d1.050a0220.a5ef2.06ed@mx.google.com>
Date:   Thu, 02 Mar 2023 14:31:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1380257696340308724=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] shared/bap: Make use of bt_gatt_client_idle_register
In-Reply-To: <20230302205758.1252736-1-luiz.dentz@gmail.com>
References: <20230302205758.1252736-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1380257696340308724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=726232

---Test result---

Test Summary:
CheckPatch                    FAIL      1.17 seconds
GitLint                       PASS      0.54 seconds
BuildEll                      PASS      27.16 seconds
BluezMake                     PASS      991.34 seconds
MakeCheck                     PASS      12.02 seconds
MakeDistcheck                 PASS      149.60 seconds
CheckValgrind                 PASS      246.65 seconds
CheckSmatch                   PASS      328.80 seconds
bluezmakeextell               PASS      98.79 seconds
IncrementalBuild              PASS      1726.64 seconds
ScanBuild                     PASS      1027.73 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/2] bap: Fix crash on unexpected disconnect
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#103: 
   by 0x495BFAE: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.7200.3)

/github/workspace/src/src/13157900.patch total: 0 errors, 1 warnings, 92 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13157900.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1380257696340308724==--
