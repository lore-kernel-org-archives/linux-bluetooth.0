Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0446EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jul 2023 02:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGGCsY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jul 2023 22:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjGGCsX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jul 2023 22:48:23 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197DA1BF4
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jul 2023 19:48:18 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-401e23045beso11431431cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jul 2023 19:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688698097; x=1691290097;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=46JYVnd8843AMaqEU9fUGIR8AskH1T18CAJB4lGH4ko=;
        b=mkRSxqV9ckuk3C+dIW8dQLI2v3/sI0kIthXow5UP1Ls5UVl8T/euDEypHxm8lfckbH
         uEwAKaQ1KOUtr8QBzSAulne/1U/cLNC8CPdvLmqweFKWO+un1o8iczNWp25eiJ4QjRVD
         JR1ZGkb6rIz/3Mywpxz6pLBdnxKam9IGw0g8QtFnHDXBm2CwvQ7ubBqZco+U05jGo2W8
         GMLmnGDwtJePY79H9FGhCAFPankTm4UkTiKRNVvNKgrcoor0yCSiuyqbXecx0/DdBWUR
         ZTGEGJlDfvpTOw1yc4mw9eH52A4giObOb7eUBknAttoTv8f1uMTDpiZMU1cSnXjlE9jA
         sXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688698097; x=1691290097;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46JYVnd8843AMaqEU9fUGIR8AskH1T18CAJB4lGH4ko=;
        b=kXnoB5/2aOtkfaFIh2NADtXdvWZq80gIW16LA6NpJgLF9MNEoRlvfYMx86DUtNkTdG
         R6/O3iNT11PleIcQOtHOpMQ9JiDYp/c5JzeCyc9nzpbSE+tonqA4E0LD/I2wxmM71Obp
         qKxaq/qquxMgFLNtFF129r5bji+bZD6pvYvAkUURDnydWzSrZu0WovheQS+eOttTNn3o
         bWPCgQ/FGzk+o1BIgXeDUikDrqE5A/7HfCIaHIHvyP0QL4dKhUEGrCENPMOmNjDNVHHl
         QihCyqM3LKKteOvH4h1EgJQ0O6MPvDf+79dDfevpRgNnPA2ILlR9GfDsdmeyfKTbItxi
         ERXA==
X-Gm-Message-State: ABy/qLb1eL+aLJd0iuaKSOVha7/ossj3IYVP7vOfbAtd03Y/CNkGuXAm
        yg3U0n6tKrlnVkqu5nTWFnDOnMUXNGw=
X-Google-Smtp-Source: APBJJlHs1lXD1OX5figexpLsSssJo7c+QkbdZBVXWivR/1wmHe9NJJwLSpLha4STT48ZYjqvKLKxmQ==
X-Received: by 2002:ac8:5a4f:0:b0:3f1:f599:c259 with SMTP id o15-20020ac85a4f000000b003f1f599c259mr4987064qta.24.1688698097050;
        Thu, 06 Jul 2023 19:48:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.76.160])
        by smtp.gmail.com with ESMTPSA id y3-20020a0cd983000000b0063596878aaasm1599632qvj.18.2023.07.06.19.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 19:48:16 -0700 (PDT)
Message-ID: <64a77cf0.0c0a0220.d4b26.5167@mx.google.com>
Date:   Thu, 06 Jul 2023 19:48:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1190355393544793561=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, Xigang.Feng@gallagher.com
Subject: RE: Bluetooth: Fix for Bluetooth SIG test L2CAP/COS/CED/BI-02-C
In-Reply-To: <ME3PR01MB56237F9982C4F3C9201AFF1FF02DA@ME3PR01MB5623.ausprd01.prod.outlook.com>
References: <ME3PR01MB56237F9982C4F3C9201AFF1FF02DA@ME3PR01MB5623.ausprd01.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1190355393544793561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/l2cap_core.c:6534
error: net/bluetooth/l2cap_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1190355393544793561==--
