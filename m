Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9B7C352A1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Dec 2022 03:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiLGDir (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Dec 2022 22:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLGDiq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Dec 2022 22:38:46 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D34930F4F
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 19:38:44 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id v1so6465316ioe.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Dec 2022 19:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jyoPFHONKuBOMlVMAK+1e2sQuQCZJNve63Uu+S952iY=;
        b=mBIY/kAWKR13VYW2L8MoMMpQRo+WIlw7zDt2OhGK4NfKqt1DMx9veziP01IVW4NeqF
         F90CrFL7SZC50OZfd0Ditgv/OEGn9a37ncEXTpIACfsqstsax1iQbe4Zh4qizrVIb6o0
         Antx19S4654nFsWQpJKOB9rhZhRgijRRTFdPgcBUV/sqWeV21nW3oDdEjgJLbEB7q4wO
         rejMMIA0+mK8xDKUhnDN9pj7TdlkWApHTTGwLGj8mS4V/bXbyj5yGHKXNMQOock5bveM
         eG6NjYCFO8QBbCoGjIBQbjhy7hgnSxcJZUEaei9/jkoMqibEGrwAAmwjKmwrwQd7KnAT
         aLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyoPFHONKuBOMlVMAK+1e2sQuQCZJNve63Uu+S952iY=;
        b=X+0QPEbShPUr+OVAF6MkGkcvP6/HLmgg4EqXLhZgzQKrwDksa4mRNvuzfg8n0yLiDw
         +gIfjbysEgHrtt6jRZHvL0Zu8TDkK/s4f80r0JcDLZi77mfhS1dnHFSZXwVMP1VkLbQu
         YsBvFSoLXjaDsR/2jL0J6JUGdhdLut2YK9ve8fbOEblelVOkDAiBu0WpALr1ppAD6AEM
         E2cI/fG65e+27aNgEOUoIbX/Jqzj2YvXiwxn4F7uJmSXj5Oko0JGCeBQ1hY1z0tGvGCj
         lUf4+8RECuisvyHdsOYm5UWGNbznoAUeEKskG3tbzHyMQpR3mzZHYygopOIC0rrvmsMg
         oZAw==
X-Gm-Message-State: ANoB5pkoKC/d08uvFuDv8xIRwRTVEbndWg//A2DXo6VNnHbkCBDKOCaQ
        5kCMrvGpe10B3B7UkewhjCktE7Sl3UE=
X-Google-Smtp-Source: AA0mqf45E9PS6obINhvKEDNLS00ACCg2VZGt64kExPSXVIYg4AjHBXlK5jew5+TCXOWh85OyH+DmFw==
X-Received: by 2002:a6b:5018:0:b0:6bf:ef78:9b6d with SMTP id e24-20020a6b5018000000b006bfef789b6dmr32927487iob.73.1670384323707;
        Tue, 06 Dec 2022 19:38:43 -0800 (PST)
Received: from [172.17.0.2] ([40.86.103.140])
        by smtp.gmail.com with ESMTPSA id d74-20020a02624d000000b00363e4730a41sm7417073jac.175.2022.12.06.19.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 19:38:43 -0800 (PST)
Message-ID: <63900ac3.020a0220.8a554.d968@mx.google.com>
Date:   Tue, 06 Dec 2022 19:38:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3773273986939517831=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] bthost: Add callback to accept ISO connections
In-Reply-To: <20221207013546.4162481-1-luiz.dentz@gmail.com>
References: <20221207013546.4162481-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3773273986939517831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=702365

---Test result---

Test Summary:
CheckPatch                    FAIL      1.18 seconds
GitLint                       PASS      0.58 seconds
BuildEll                      PASS      26.21 seconds
BluezMake                     PASS      754.78 seconds
MakeCheck                     PASS      11.29 seconds
MakeDistcheck                 PASS      145.20 seconds
CheckValgrind                 PASS      238.68 seconds
bluezmakeextell               PASS      93.16 seconds
IncrementalBuild              PASS      1219.62 seconds
ScanBuild                     PASS      967.01 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/2] iso-tester: Add test when peer rejects CIS
WARNING:ENOSYS: ENOSYS means 'invalid syscall nr' and nothing else
#141: FILE: tools/iso-tester.c:547:
+	.expect_err = -ENOSYS

/github/workspace/src/src/13066515.patch total: 0 errors, 1 warnings, 93 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13066515.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3773273986939517831==--
