Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59345C56202
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 18:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE787208FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 18:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tc3W/yj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404145AbgKXSaS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 13:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbgKXSaS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 13:30:18 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E29C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 10:30:18 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id u23so11103041qvf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=BixqKfuMtyGZUGszWVkUThk1Q6ghdnuaimo8CblxpyU=;
        b=tc3W/yj7at2Hc6EPyP7MG9xfNLQjX1CX3xwt5uWhqvdv5TgQ2pq5vvckcnhRcq78w7
         dJztZXQ4c6AyNmhAQiy5xE9iqauhUb9HbrGhcHYnfY7JDeg6pb/ajaU/oi8wggoB0n98
         cEGAHpSA9H6LP6jlOZPi/nVdLcpflkjLLRHyTA3jzoSlew4MuYKuVA6ssMXJdU8zWu5f
         DW3Kb3wogV3rot+mEf0AN4zA+I+WtS9Q6km3RW2c7eHk03q+r66oACAl83DjzQsTESb6
         7JVGwcNgRodQr3hLIt+fD5KrNUFu19ljwlAJT1JRG8zdAgQRZN+QjCnnM+FN2AR2zIj4
         BFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=BixqKfuMtyGZUGszWVkUThk1Q6ghdnuaimo8CblxpyU=;
        b=U1xxZSVlUtneBAxoPrX320hcW5l0XJeOV7m9TT1//yV8vDobMZAeF02zrns9ub6yJ8
         JFq6rB8KmYqGGAG+Ewn4nJccRncP7qPCsCySkCrP+YYAwju1ce7Z3gij+78wOkHUrLNM
         eo3jKlAOupco7mEQkcZ+tDTaOI8DxC3KoaCRbcq7iOok1Fo3lAvjKHc0RZUQxJHxoauM
         1EKVBeL/+xLRmeo/b91klAOA6SFTUVRMpn5jTvJzjaW9AJPIYpsCZa3gIxgdosSTggCH
         Zhj0PRBFc1/sf5nlU3CDAciL9iCnV23GXCpwbrWdtMzM9IW/Hm4H3r9yMKgAh3Qipwq7
         FjZA==
X-Gm-Message-State: AOAM5324KYGsJf5IPAhAyvp0ila4e5xUyMiG+Tw30LDCDvjV7zYO7p6y
        MxP2RPeJyf5lEUcA4aygjOwlyZGMb9UVOg==
X-Google-Smtp-Source: ABdhPJzytPWE5gyX63f0Us+H9VNSKvYQn3dYznjPOLpdhfVOqui7RkuVRczhGrziOKr8vND0j80Tew==
X-Received: by 2002:a05:6214:5cd:: with SMTP id t13mr6119990qvz.56.1606242615972;
        Tue, 24 Nov 2020 10:30:15 -0800 (PST)
Received: from [172.17.0.2] ([52.177.118.218])
        by smtp.gmail.com with ESMTPSA id n93sm13618244qtd.7.2020.11.24.10.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 10:30:15 -0800 (PST)
Message-ID: <5fbd5137.1c69fb81.316dc.ed8b@mx.google.com>
Date:   Tue, 24 Nov 2020 10:30:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7505926530567412039=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, danielwinkler@google.com
Subject: RE: [Bluez] doc/mgmt-api: Minor reword for Supported Min/Max Tx Power doc entry
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201124101832.Bluez.1.I3f5d0cd1842ec756731360d5ef1a6c5eb8543336@changeid>
References: <20201124101832.Bluez.1.I3f5d0cd1842ec756731360d5ef1a6c5eb8543336@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7505926530567412039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=390435

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============7505926530567412039==--
