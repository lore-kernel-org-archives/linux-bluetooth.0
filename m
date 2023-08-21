Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05685EE4993
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 19:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjHUTIV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 15:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjHUTIU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 15:08:20 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A681A1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 12:08:18 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4103fdba0fbso19855641cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692644887; x=1693249687;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eAQSiQrjEbf5f9eHROp1/uZfSrTyESaAC3kxaEZw4cg=;
        b=EpJLLKGzUNRK7EqvZ+f9Y8VjRTImJzBx6Gitxg8nztU8yONQlCo6TSSARF2+LyfZRn
         /VQT+lZ/tysxZok9EG68vmj8DybFt3Qhsg/4M6Kscx2y/5O4IfM1GeCzCIkHnz9CQ737
         TFoKhE+GGrKCkA5vd6ZJkJR0WTHeXxBLuIb0YH4mXlOZg77W8SYpRCo4TfUEW4ZfMyn1
         CAxdgcdL2eTvB07+4KiRQsYlmLWInlDUut0vUrS63bhYKyx8vUU/FThsHchbn2TVkAMk
         wWItzTlUgahStQ7eGru+bb12C4nWat657ZEvi3oyAQbZ8TjeB1ilgB5yojl31VdqOgjZ
         gYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692644887; x=1693249687;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAQSiQrjEbf5f9eHROp1/uZfSrTyESaAC3kxaEZw4cg=;
        b=FKTTBRVZtIlqYnl7qBR1Sir4TVEeln2qoZj5DG/e12WwAOcUf5xKd5zc3+AHKWHMKb
         dGPKwVMgPC8OxC0n7PmjIcyd/jRAm1r91JPbg+kVfKaOEoe7fyLPO7WbLWmuakav7aUr
         XwUsaTOzqcHsx1ldXwCOlXcZ0Ng4YYKlg0wK58DfckJdfuNTizG5iDf6yP0X8ii2PaQc
         r5Yz3lPB6iaawvVL7B6fZMAvDDI3tHV3VYQECnENVhLw7Ka8GLdr4Sz7FIhB0R9agi4V
         8kbcI7lf4cJXtodogsytmDJctr7QuwyJ90bTV8t3UlWtdauYWi2xhKJ829FbF+mMbjTt
         MeZw==
X-Gm-Message-State: AOJu0YzsfGgFpfmWWEVWCmq/exjfj3iYN0MDwuhCsgnh9Pwoajm1LAMh
        /oz9fTR2f2lorKuv6pFIlkrPj52DT+8=
X-Google-Smtp-Source: AGHT+IGfyXH3lDFvputQU5+t/S3cDcgGXo8s4BNbdgn25Yr7vV3vLq54YHFg3lmcQQnp5+aVsnV7Og==
X-Received: by 2002:a05:622a:550:b0:40d:19a4:5fd0 with SMTP id m16-20020a05622a055000b0040d19a45fd0mr6838795qtx.38.1692644887662;
        Mon, 21 Aug 2023 12:08:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.17.200])
        by smtp.gmail.com with ESMTPSA id i8-20020a37c208000000b0076da0a9ea32sm1522546qkm.1.2023.08.21.12.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 12:08:07 -0700 (PDT)
Message-ID: <64e3b617.370a0220.ca502.5270@mx.google.com>
Date:   Mon, 21 Aug 2023 12:08:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1359704096422167409=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Add support for BAP broadcast sink
In-Reply-To: <20230821155104.86954-2-claudia.rosu@nxp.com>
References: <20230821155104.86954-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1359704096422167409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=777937

---Test result---

Test Summary:
CheckPatch                    PASS      4.64 seconds
GitLint                       PASS      2.29 seconds
BuildEll                      PASS      35.00 seconds
BluezMake                     PASS      1234.14 seconds
MakeCheck                     PASS      13.00 seconds
MakeDistcheck                 PASS      204.78 seconds
CheckValgrind                 PASS      331.47 seconds
CheckSmatch                   PASS      458.26 seconds
bluezmakeextell               PASS      138.77 seconds
IncrementalBuild              PASS      6381.91 seconds
ScanBuild                     PASS      1451.58 seconds



---
Regards,
Linux Bluetooth


--===============1359704096422167409==--
