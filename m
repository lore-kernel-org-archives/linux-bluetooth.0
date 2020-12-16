Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50205C4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 03:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B2722D6E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 03:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgLPD6s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 22:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgLPD6s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 22:58:48 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251BFC061793
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 19:58:08 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id i67so13887888qkf.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 19:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=goiJfzdzja1sGnXrZ9ljJp4dkJIkFVzy2YAwxxMcK/0=;
        b=h1HseQIF8d0C1V+jyzs8nXfviCBYJSD8whhgGScCSW1/8nfLwRt6EiL5zwCKFFB/YP
         3ih9IzadmuwEDsPujdnHgbwu3gUZUURTx0GcFpv+BQ6Amshx0G+7AqbRs1lPOFZSTjtM
         Z3i0DeqYbX1r7B+YiE5cRXeE51u5X+vCPRyv/8Mm5RC5F6UVysnb7+i0Z+gv+/y8Ajef
         71KSMsWKejQiJv82yOIxJTNoBbYOnm+GAXzr0Le8TQiZ0GD9Y29LarMwJ+yfgY7Yllzz
         MWloU/H0qAngBm+mDazL5FEzgkfPliQe80f8LUxDDOTMEqRz56qXWRsjNpeRs8XohIR8
         d8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=goiJfzdzja1sGnXrZ9ljJp4dkJIkFVzy2YAwxxMcK/0=;
        b=rXAhfe3AKPrdmDo5tBrNbobZsZId/SdzCKY9CJBsg+IBIYiYxSlYvXSGjK2U6hRPn9
         ULRt/lEO2MLGi3IThLFE+tvUfHtlc0Uk7tPRx+e2shs7pJnsZiCCMFhx7H+bEN6Noh50
         a+ZJyKpNBQKeJTIWChyq4P2QKYD2HUyfHQGWRGItM9G3+2Uajd6v3iyhJOFpIDXdvYQu
         cLT29QVichjHXWQ8YP1FAJ/fA44gY/8MboW5dpBP0b4e7VWczPvA32dTXnoHeYRlUm4w
         8WbQstL666iTb7f99HHJ5l2yN/rYDxz9/XL0NNhezrCQpOJNJU97efFEgNyByo9fr/un
         z/bQ==
X-Gm-Message-State: AOAM533neioQhpzX/TZT+BBNK0nBh5pHPuecJT7eMcXEtkgQAE+Ru22t
        eAHIvIJRpQuwORbeAJwa58TGU3eEnXshwQ==
X-Google-Smtp-Source: ABdhPJy6VB1//TZPpi1IovANK1plzr5xmZylA+4NFnnC0+wBj9U2k8nIPBlOUF7vjFMh8A+rPjSnWg==
X-Received: by 2002:a37:8dc7:: with SMTP id p190mr16218218qkd.308.1608091086723;
        Tue, 15 Dec 2020 19:58:06 -0800 (PST)
Received: from [172.17.0.2] ([40.70.64.252])
        by smtp.gmail.com with ESMTPSA id a13sm402822qtj.69.2020.12.15.19.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 19:58:06 -0800 (PST)
Message-ID: <5fd985ce.1c69fb81.ee704.29f3@mx.google.com>
Date:   Tue, 15 Dec 2020 19:58:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1063170111205651753=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v3,1/2] doc/mgmt-api: Add opcode for adding advertisement monitor with RSSI
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201216114231.Bluez.v3.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
References: <20201216114231.Bluez.v3.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1063170111205651753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=402647

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


--===============1063170111205651753==--
