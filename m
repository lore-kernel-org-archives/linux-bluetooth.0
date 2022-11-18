Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFC6C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiKRFKC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiKRFKA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:10:00 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50716BDDA
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:09:59 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id l2so2507398qtq.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rQY2UGsJwZrPmopJ8u47YyNZzNFqb9NBTiFW+yBqsYQ=;
        b=Qy1A0PEdaDg+xJo0V5BJqreZ6AnlBtUl5SF/pkKW734ub9HjkhPuuWB9ilAFSw8oiy
         7ePsFqMB1E6VDO/KkUKVISrwAgZFFPVa2mPUYO1azDfWZPipTxJ3buSavISg6LGKetvs
         yDFcJHbwZkGqLOKZyNldmreGZjJe7iZkCHIofr5FtZ4ucT++nhXaGLwrFzDSxm444EXF
         h2qxIDiHqq/82DUvzYXutqyh7rb/uUSBD/mOe2+lG5m32Nx1tKpfDiXRzQcRwyNlomMa
         iGD5GReW52uMQgc+WAoSrC6QWYFPOHw2pl8H9T9MIGibK8oQEonwkiUkUqDQ4Dl1rwnl
         qc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQY2UGsJwZrPmopJ8u47YyNZzNFqb9NBTiFW+yBqsYQ=;
        b=gtKAv9FZWEzdSt8cQ86JEriXQGgzURw/N5xUj2EeXALS44z49hUoVUxdoqlY2CIaIw
         O3TeaWBi5rVHDPuQGHa4lUCiYYWKpJu1DALgk/m+BxjcOHzQPYI1vHG/OaNz6cjGf2IX
         fPNufGHYtxRBcKSwx10dcwMFyiVPtynn64z1n8d5fkWn2gwMf0vjGKFRR40cYc3TcCQj
         5+Wv+4fPUA+3TpEHdy/LZLqqUA3qcpIxQIeyxcjDfn2h5KOz1yqFXmnTPR+TJ8dsHW7C
         NFmH+kS5s8MMvKJukMGR6iKZb9HhdSBOrlcsXaC5uOR/Ox7oKM9Dn+WrR/lytfT5XeTy
         UtjA==
X-Gm-Message-State: ANoB5plW1s3pTuUxfLAeacdUtLtQkHNrJ/BOPKSwiQ7vptHGk+OpLKdb
        CnVGXhZfq4KLr71x0/5zNfhjQTbgbbPHOg==
X-Google-Smtp-Source: AA0mqf7ceeMd9l308Y8mCTB3Aid9uJauPVVsqBPfLki7+Ly+T5ukAmFesXCQbk3m2vcA/7wiwPwT3g==
X-Received: by 2002:ac8:45d8:0:b0:3a5:1dcf:40ff with SMTP id e24-20020ac845d8000000b003a51dcf40ffmr5073186qto.576.1668748198738;
        Thu, 17 Nov 2022 21:09:58 -0800 (PST)
Received: from [172.17.0.2] ([172.173.138.28])
        by smtp.gmail.com with ESMTPSA id y11-20020a37f60b000000b006ce1bfbd603sm1734211qkj.124.2022.11.17.21.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:09:58 -0800 (PST)
Message-ID: <637713a6.370a0220.61d70.8f3e@mx.google.com>
Date:   Thu, 17 Nov 2022 21:09:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4429949756594112324=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor: Decode vendor codecs of BT_HCI_CMD_READ_LOCAL_CODECS_V2
In-Reply-To: <20221116211836.2671441-1-luiz.dentz@gmail.com>
References: <20221116211836.2671441-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4429949756594112324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=696161

---Test result---

Test Summary:
CheckPatch                    FAIL      0.84 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      35.13 seconds
BluezMake                     PASS      1244.96 seconds
MakeCheck                     PASS      13.18 seconds
MakeDistcheck                 PASS      194.74 seconds
CheckValgrind                 PASS      318.07 seconds
bluezmakeextell               PASS      128.24 seconds
IncrementalBuild              PASS      1032.44 seconds
ScanBuild                     PASS      1417.41 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] monitor: Decode vendor codecs of BT_HCI_CMD_READ_LOCAL_CODECS_V2
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#101: FILE: monitor/bt.h:1794:
+} __attribute__ ((packed));

/github/workspace/src/src/13045866.patch total: 0 errors, 1 warnings, 50 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13045866.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4429949756594112324==--
