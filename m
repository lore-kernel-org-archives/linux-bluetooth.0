Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E05C77B73
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Apr 2023 17:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjD3Rhl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Apr 2023 13:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjD3Rhj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Apr 2023 13:37:39 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00656E5F
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Apr 2023 10:37:38 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-187ef4d7863so810260fac.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Apr 2023 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682876258; x=1685468258;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=STkTP+M9iNs/GIYeEi/5aLg5AfB/0odbe9P5aXHSCG0=;
        b=S1xEr1b0ASQnPuhfX78MKP7hec673gMyN+RX0+DmRh4QIPWIzCR9vwmOPklLkdlrZU
         fNArJHafRskFjZtrP1cxiawtEp/SCtici5MZvCojDQKprInIRwt2MrZxiSTZkITyvjsS
         TTxwAGjVjpHXah88N4OX2+U16gFlS3cHpvVQUcA/5CmYPCXqnrxHm0xEWbnRH0rHkhfc
         uSV+uUnkFBiIkjGsWc+O9oipXUURn72P5fl1d3f3crhBL9tC2Sx1WZz3cDMtSFuV4rhJ
         WgjSb2rTI7UBPsEldT5RgYD1bRznBTKBn6QmceSLpbvY62ZdZDeIsqKNeeGhWKM88S2s
         v/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682876258; x=1685468258;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STkTP+M9iNs/GIYeEi/5aLg5AfB/0odbe9P5aXHSCG0=;
        b=UsLqiWvdA+K2YfoiWrI7Oys2qGpHARK9ziSjAb2iekL3stvRweM4m/P7ZnZN/ehtA6
         zEkP2W9ABj3GB2/7H2hRk5R2+m1Ze6Tc59INRnIRB2+ZUTEUOYNfks9VoB/w3+XucNQO
         sSzKqtass+eLi41cYv6sa+Li1ms+fGk7uvlBL6uOZuWP5gKkow9rIkCuMF+71GJ64PV/
         oM32wCDKEgQRaaqFhT9ukP4pq8AgdfKx86JD2KwVT5yHAly3cgE/YP26bIypHaGRPkE6
         YNZUOatQ80FEvzs1TrGNqJjIvR/p+3boZUK8wc1EqGJAwNw2RMCBttJO/PLgYYeXETzI
         c+ZQ==
X-Gm-Message-State: AC+VfDw8QaPuRXA25hc4qnWU5n3VJmucWth/6vsHYLpIjb4cxekfQv16
        1fscnAEWIF6FOYEMGY+Ql0MeOr/ghUY=
X-Google-Smtp-Source: ACHHUZ5R1NefXeqc31RXaa6SvtCCRlA062szeuZSJ1gR3dAuQVV5hSY07JO67wmvML1MdzP4VoV8wQ==
X-Received: by 2002:a05:6870:4313:b0:180:c733:284e with SMTP id w19-20020a056870431300b00180c733284emr4481890oah.12.1682876258102;
        Sun, 30 Apr 2023 10:37:38 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.71])
        by smtp.gmail.com with ESMTPSA id x12-20020a056820104c00b00524f381f681sm9632131oot.27.2023.04.30.10.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 10:37:37 -0700 (PDT)
Message-ID: <644ea761.050a0220.1323d.e593@mx.google.com>
Date:   Sun, 30 Apr 2023 10:37:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3816095331265475437=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lrh2000@pku.edu.cn
Subject: RE: Bluetooth: Fix potential double free caused by hci_conn_unlink
In-Reply-To: <20230430172937.157999-1-lrh2000@pku.edu.cn>
References: <20230430172937.157999-1-lrh2000@pku.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3816095331265475437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_conn.c:1100
error: net/bluetooth/hci_conn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3816095331265475437==--
