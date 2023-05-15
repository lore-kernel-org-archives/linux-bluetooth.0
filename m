Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C3DC77B75
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 May 2023 23:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245599AbjEOXKW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 May 2023 19:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjEOXKU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 May 2023 19:10:20 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0B83593
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 16:10:19 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-61b71b7803bso64214546d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 16:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684192219; x=1686784219;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IrO3F2a29MhZ6sZfgc9xan+tZeEqdZDzGdu1cbWgEfs=;
        b=bPRV6OjsX2tLJAGBFFEiwHuPPpFNMLrm1/1MkyjMtpgH+bLQ9bTyCwBqMgP+IigSHz
         vAjyuG55DTzX4EbxBzsEJ48tcm2Zw/EW4j0S9FSvVk9mzUHfLPexSqx64CgY09HjNhuq
         7Skmlq0BvUxbw3YEaLNy/IvJh/2252N0uc1najXt2Cuve/3jVxK/hBNXN2Uw4Jl3xzUH
         kclmkwp1Td3U7c/VNy5iNvjCqdPAMOL3CtvChISh/9PonjsfCMOnObsIU1BVLoGzUeWI
         8+XLVtNdSY+P6N6bvnYbpS2maYsDEDDZXsxxf+0+4DPpbbhn20YuNrG0LtSY0H+n5iR/
         vS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684192219; x=1686784219;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrO3F2a29MhZ6sZfgc9xan+tZeEqdZDzGdu1cbWgEfs=;
        b=VTp7A8FpNW5zcOYBaXJjwr98pQhwqby50jek45PdsI9+9NJFbGCFVuxpuUJrINS6MR
         MC6gV7aiJEvNOraHxUQL2BMyt1Giru36Bl7RUpbZ8ll/viwhcy8juRc9tNG2hBK6btpV
         Q8DQOppYeYgi2I5p2sPYi5PkpxjtXYmoT+4k3e5AHp281mtUUXPBMM2l8wL1RmgQGU7i
         So0XbpBmTA2IP3Lew6N9OFVywUP6OPbVkegQlaW5q6IeDTv/qpv2Vq5ZZ7aEO1mXQuWp
         FKVNGSkaIdbfMfIZ7//WRxglWhxOMwbQxt7NaylvDqAGCpeS6oEm/V2KvS/edxf5ICQv
         Ep0w==
X-Gm-Message-State: AC+VfDxJ2zsr9RqD44jbH/Z2hXFQUgLUbgTcI4tB87X4KUGQ7+4OB7rG
        DQMpSTbKXtMjPYqaAzhtplq8baA7Shk=
X-Google-Smtp-Source: ACHHUZ7kBdeAooGdZj57F1XEhis3oA6Cp+SK2fd7+LsCSQE/+7j9aliRISEK0L0HJwwrixb7KvpoXQ==
X-Received: by 2002:a05:6214:d04:b0:61a:d6af:cb00 with SMTP id 4-20020a0562140d0400b0061ad6afcb00mr58042024qvh.9.1684192218833;
        Mon, 15 May 2023 16:10:18 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.163.145])
        by smtp.gmail.com with ESMTPSA id s15-20020a0ce30f000000b00621066bde91sm5249023qvl.52.2023.05.15.16.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 16:10:18 -0700 (PDT)
Message-ID: <6462bbda.0c0a0220.3c4df.b30b@mx.google.com>
Date:   Mon, 15 May 2023 16:10:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7837572837735897101=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/7] profile: Add support for experimental flag
In-Reply-To: <20230515210545.718701-1-luiz.dentz@gmail.com>
References: <20230515210545.718701-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7837572837735897101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=747773

---Test result---

Test Summary:
CheckPatch                    FAIL      3.79 seconds
GitLint                       PASS      2.45 seconds
BuildEll                      PASS      26.23 seconds
BluezMake                     PASS      753.81 seconds
MakeCheck                     PASS      12.07 seconds
MakeDistcheck                 PASS      153.12 seconds
CheckValgrind                 PASS      245.43 seconds
CheckSmatch                   PASS      329.01 seconds
bluezmakeextell               PASS      99.56 seconds
IncrementalBuild              PASS      4446.45 seconds
ScanBuild                     PASS      975.65 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,7/7] plugin: Treat -ENOTSUP as -ENOSYS
WARNING:ENOSYS: ENOSYS means 'invalid syscall nr' and nothing else
#101: FILE: src/plugin.c:189:
+			if (err == -ENOSYS || err == -ENOTSUP)

/github/workspace/src/src/13242265.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13242265.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7837572837735897101==--
