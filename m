Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97866C636CC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Feb 2023 12:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjBGMmw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Feb 2023 07:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjBGMmo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Feb 2023 07:42:44 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C727710AB3
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Feb 2023 04:42:36 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id g7so16402678qto.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Feb 2023 04:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C7bYBKDyVXQuLqXKjLqHUvpYDoKtjEc8P3cVJiWDmAY=;
        b=CnDvBTn1UtxfDPpXLTR1UzJlh2U/vgS1d85pXsrCbIn6Kts/Qz5HGgfBXm7JxtQZix
         FGboHnu7LvsS48N2+KHNX/tWQa9Cfi6DPm4nWJ/+ibTWiwZP6GGlJ+jdJjex2G2Y0gTF
         pnT8HRXLHuSTUdreYmdoLSd8ypnPuCG/7L/vXre1J9TBcv2AF8PntM58JhCyYtOSg8ZP
         JFwdrU5Qa0k15maSqwdaZv8MsAqeSTU+8BdhNi6MOAsT6ho7gAdOBWE3AhG33M9lZxkx
         R4nMAqqoGQaMaeTOa0u20x+wVHDtdvicm7JnVBLz0SIV+Xv7UVqU8ka0su7At6igvEqV
         ujtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7bYBKDyVXQuLqXKjLqHUvpYDoKtjEc8P3cVJiWDmAY=;
        b=lQtknOwOWn15368OeR1QGrD09mefnSvF/y7aB795OTc8nz1zrgrLEqOIooo4KVuRzo
         7EesOSWjOxPbxnFhn/RmhpzTmmLqSuYVPB/eXx1u6mmqdt+5wUf0j6vhx3nKD3S/wgGw
         M0iFzzdSqwNcAI2l+uRW2jDk9JF8rnrgSyKz4QV/7gsVUbqbCfnHPdSlgF/biQHk5hPE
         YjrSAvq/aWoByW5wpZoGhRWihzBPI/4xYxg5qIqKLILqvpGRcN+JhfO+YEBGqbV6UU08
         ZwfsgzcmDggXIvdkxeHq5qz6CjIlUNxdYtn29Ms+YIO8wKLva4mRpxESuxXtDc5wJlBY
         rTEA==
X-Gm-Message-State: AO0yUKX7bwj/ICBFSYmKXb/VF5sTTSX0IX1xVhlPBfXnIhVHY0FFISep
        FrijyjrKn5+2tAkIU53WiRlmbd5luZ7kDg==
X-Google-Smtp-Source: AK7set8CIy0dPL6nMvCy9H7QoHuE97bddrxXHjG8A2O74XWmpkyGuGV8uZBqkMZGzgEBGHsZWKoHAQ==
X-Received: by 2002:ac8:5acb:0:b0:3b8:6b6b:28c2 with SMTP id d11-20020ac85acb000000b003b86b6b28c2mr5261038qtd.68.1675773755777;
        Tue, 07 Feb 2023 04:42:35 -0800 (PST)
Received: from [172.17.0.2] ([172.177.36.112])
        by smtp.gmail.com with ESMTPSA id v25-20020ae9e319000000b00720f61af739sm9227076qkf.115.2023.02.07.04.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 04:42:35 -0800 (PST)
Message-ID: <63e2473b.e90a0220.c4c35.a81c@mx.google.com>
Date:   Tue, 07 Feb 2023 04:42:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8915317333204268993=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tomasz.mon@nordicsemi.no
Subject: RE: Bluetooth: btusb: Do not require hardcoded interface numbers
In-Reply-To: <20230207115741.122854-1-tomasz.mon@nordicsemi.no>
References: <20230207115741.122854-1-tomasz.mon@nordicsemi.no>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8915317333204268993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=719475

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.90 seconds
CheckAllWarning               PASS      33.91 seconds
CheckSparse                   PASS      38.08 seconds
CheckSmatch                   PASS      106.45 seconds
BuildKernel32                 PASS      29.68 seconds
TestRunnerSetup               PASS      428.94 seconds
TestRunner_l2cap-tester       PASS      15.94 seconds
TestRunner_iso-tester         PASS      16.64 seconds
TestRunner_bnep-tester        PASS      5.43 seconds
TestRunner_mgmt-tester        PASS      108.68 seconds
TestRunner_rfcomm-tester      PASS      8.69 seconds
TestRunner_sco-tester         PASS      7.99 seconds
TestRunner_ioctl-tester       PASS      9.37 seconds
TestRunner_mesh-tester        PASS      6.89 seconds
TestRunner_smp-tester         PASS      7.89 seconds
TestRunner_userchan-tester    PASS      5.68 seconds
IncrementalBuild              PASS      27.68 seconds



---
Regards,
Linux Bluetooth


--===============8915317333204268993==--
