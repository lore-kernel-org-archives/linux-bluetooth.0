Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4E0EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 22:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjG0WzV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 18:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjG0WzT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 18:55:19 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D132D7B
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 15:55:13 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bb2ce4f9f8so1229990a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 15:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690498513; x=1691103313;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ8LLTEhDCvF4e6RDFkmX6mqk+CWu8EG8zvQIw9K/xA=;
        b=E26i6FoJ0Rr3ztXBTV3c2KWOcF5P8e8ptUcVAJdbfScagxfmq52G/ukcq3N0DuZ9lM
         I8C2Rcht8ZRxUL0jBzaXz9hWqrjDOnsx5EI2tWpAX2WLkCnu9auQfKZcCzDkWhby4d9g
         5QqZgfaosdjxZXmVGYa1Mt+p9/yCXniezQXc+gl4Nic1KVr4cHdeWVZnBavpAEHXYQF4
         gj8tCaXNt9uuks+qVvZj0ICUzUen8OXNFinnyxhm8Dui3ep6PJdNef2/qL1WoDnOZO+6
         jp7C/hrIKODvq4pakozwXsclTIV7eXXkFdhsk4KGUxFaeg/oJvLCfUQ34MioQYgVBPx8
         sKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690498513; x=1691103313;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQ8LLTEhDCvF4e6RDFkmX6mqk+CWu8EG8zvQIw9K/xA=;
        b=iyy7VSP08DPRUlcqBvC0doqcnNJLAWr7w2SMk7y+gGduPzO0n3C0nFBs/nBxAzQEEc
         HD2YeCglW38pCV/dlrHrJFvcpxDsnLzPiajJqtlpb6c8iEW1Z6LdZrib9E9f77LJBGqI
         klu4uCRQRUc2rLv/jivas/ZmYvanx4EJ6iFaqQl2RL6hLS3sHG7Naw0mBAvEbO84Hg7s
         btJFRp01sn4zN5biEp37pRM34LSoiMJLkPVPQDModOOOtpit540qVvbKinvvSOjEKkGh
         eElVD2aXjtTV6xOWS+oFvONRv2psQXivwu0BpYLTBe3Ki4sAMjiLMblCHgnruL5OngRf
         5SVQ==
X-Gm-Message-State: ABy/qLbA0VKFGaKjzhVXfSXDXu1QmHxb4v6zTse72aWiA7F7FsXP4wtk
        ChuOLQLc4p1isSJlKxSWitc4wMpWB5g=
X-Google-Smtp-Source: APBJJlGckLzks2ynyBYoAa2xcTAmmvxYh/2rOsH94XuB1mVvu7GCTTykIQOAguuJ6uaeurW/ilpngw==
X-Received: by 2002:a9d:6f08:0:b0:6b9:f3cb:db4a with SMTP id n8-20020a9d6f08000000b006b9f3cbdb4amr567032otq.22.1690498512837;
        Thu, 27 Jul 2023 15:55:12 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.3.175])
        by smtp.gmail.com with ESMTPSA id q1-20020a63d601000000b0055be951145csm2061187pgg.36.2023.07.27.15.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 15:55:12 -0700 (PDT)
Message-ID: <64c2f5d0.630a0220.11eb0.4271@mx.google.com>
Date:   Thu, 27 Jul 2023 15:55:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2355334137684422192=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3] monitor: Use gnuplot to plot graph of Latency-Packets
In-Reply-To: <20230727211010.1046099-1-luiz.dentz@gmail.com>
References: <20230727211010.1046099-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2355334137684422192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=770289

---Test result---

Test Summary:
CheckPatch                    FAIL      0.70 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      33.67 seconds
BluezMake                     PASS      1173.46 seconds
MakeCheck                     PASS      12.92 seconds
MakeDistcheck                 PASS      195.13 seconds
CheckValgrind                 PASS      314.79 seconds
CheckSmatch                   PASS      438.72 seconds
bluezmakeextell               PASS      130.61 seconds
IncrementalBuild              PASS      971.95 seconds
ScanBuild                     PASS      1402.53 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3] monitor: Use gnuplot to plot graph of Latency-Packets
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#86: 
        Address: XX:XX:XX:XX:XX:XX (Sony Home Entertainment&Sound Products Inc)

/github/workspace/src/src/13330735.patch total: 0 errors, 1 warnings, 156 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13330735.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2355334137684422192==--
