Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EA6C43217
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 17:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiLARNN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 12:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiLARNM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 12:13:12 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9253CA9EB4
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 09:13:11 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id g26so1445964iob.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 09:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BsEvKoM2mCRZ9Plef/VdlPcpZHw6g7tf3ztyr/KG1tE=;
        b=YAvI3djLUs2p2kES08sLojPEuq2DoFlnpFzZUNvT5fntaHJhpH0Z1SLbk5NweyYDY0
         st0iFx5+JXuxKmCsY9b9q6BIIoWtnkfOhNB4/Yj4Gv0Jdtw4+fqmDZNdGYqeP4UYDGFs
         r4/Y7mw6adM0pQJvY+O9li2VOSse0UBEC9izbRW0XeM4m15w7IZCp1w8kWrUeQcZy36l
         RG1lE2tHmxUcZHJktxqDDlAIszJWULenMsW5SYJAesHYVLMI7CfBEv3Dc8VFLapgf3fP
         2hTuu8NQy5+WC4auB0D7RYe40gTraAHCBHN7BjCzGemt5T+qZl6vSefPD8uMUtjFSWHe
         jEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsEvKoM2mCRZ9Plef/VdlPcpZHw6g7tf3ztyr/KG1tE=;
        b=nAVtf+qG2TeQCIJqBqcymPFAl1GuWzWqVmSTQ1LYrJQ6V28WKhm/WlP/SrUc9kn8eq
         MOEwHZ6N5nug92QopWgEq4xRhHFnXOJPCjGeZfhlREqRijMk0GWLR8EzYE72KZS5WMlc
         gDOPtMzqzlxZ8Pt7Ehs1QzoqQm1z/5aYmZB24vM3wbTDqUADsZEMQRG2i69y0xajCd9H
         S8At8gYigBeFeP5bbHpq84Wie06JaCVYji+RCb0pgfq8TbHGwdtL54zdQhRH0XLDVBio
         5aX93SH+TlV3D9im5WrxnKzECU4pyTz5JKP/XIQ6rqzwVm8Nqq1+j3Q7jA+1Sm69gTqO
         PLPw==
X-Gm-Message-State: ANoB5pmkDDZkkYQwYcOaPEknLcoozYNQ6aoBfcvfud3H2KKN7/Kc3tMv
        pQpy4pmb/u/y/kQULVqyGj2bghnlqsY=
X-Google-Smtp-Source: AA0mqf50DhNOb5lbgPGLAIH5zjZ+3R6tf8GSbxMF9l6v/lAzqjftmq86jHoMGbFi3YeFowpKQCojPg==
X-Received: by 2002:a6b:f616:0:b0:6df:2c14:f642 with SMTP id n22-20020a6bf616000000b006df2c14f642mr17663728ioh.43.1669914790749;
        Thu, 01 Dec 2022 09:13:10 -0800 (PST)
Received: from [172.17.0.2] ([40.122.230.254])
        by smtp.gmail.com with ESMTPSA id q10-20020a02a98a000000b00388575d671fsm1826196jam.17.2022.12.01.09.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:13:10 -0800 (PST)
Message-ID: <6388e0a6.020a0220.7a53b.4ef2@mx.google.com>
Date:   Thu, 01 Dec 2022 09:13:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6345266085091628552=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, allenwebb@google.com
Subject: RE: bluetooth.ver: Export sanitizer symbols.
In-Reply-To: <20221201160941.1065499-2-allenwebb@google.com>
References: <20221201160941.1065499-2-allenwebb@google.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6345266085091628552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=700903

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       FAIL      0.52 seconds
BuildEll                      PASS      26.68 seconds
BluezMake                     PASS      842.23 seconds
MakeCheck                     PASS      11.03 seconds
MakeDistcheck                 PASS      143.48 seconds
CheckValgrind                 PASS      239.25 seconds
bluezmakeextell               PASS      93.39 seconds
IncrementalBuild              PASS      695.15 seconds
ScanBuild                     PASS      986.64 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/1] bluetooth.ver: Export sanitizer symbols.

1: T3 Title has trailing punctuation (.): "[BlueZ,1/1] bluetooth.ver: Export sanitizer symbols."


---
Regards,
Linux Bluetooth


--===============6345266085091628552==--
