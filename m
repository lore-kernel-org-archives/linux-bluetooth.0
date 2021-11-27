Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97CAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Nov 2021 23:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356604AbhK0X4K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 27 Nov 2021 18:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhK0XyJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 27 Nov 2021 18:54:09 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAFBC061574
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Nov 2021 15:50:54 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id kl8so10616553qvb.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Nov 2021 15:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8BBtcq/Xu53rbPLWo6wgbDd2j3SlCnqr6HCR0su9dCs=;
        b=YP4VmPDHLE9sg3okn6R5vT8/K/i3R5rAiDR8GtqLdzhKaYm462is6oyEa8uw7s4Zf5
         xNiPwgW8bLlJYW04GZrdI+ZkVHObfnF0AJhgF9VzRLk9hDM0fIN2u1XVRL4xDx+IVuNN
         VBD0N15jJYk2X6pP/aidbsJqPesDzyJ6EjkRk9PFzu4UVrJ2sZGfkMuRRurPkZ4vBUaX
         gKsD+NjQDM3JHWROvDgc7MzxxQNQYpffBBjAn9MhRk/g4nIJA9VvpjhQH6UZQ9Yem0s7
         7DuEHhqV9I1QfG5t6VwUWU2hgIZ7sitHBiyVH+LoDOm4hAxPrbuXgDciq5R75ccmeZiz
         7M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8BBtcq/Xu53rbPLWo6wgbDd2j3SlCnqr6HCR0su9dCs=;
        b=NDMKsYplpFBHM2yzitDgmypxeHfhh+ckDcdVz1H3foZQBTh+RjkVrnfp/Y1tER8C9F
         aKzFs5X/ZLD37IAS7WAqTslr1SBfq+++pRRQDZzERbgu6FHo3eWSxqKo2JaJDDhjzn/h
         5EwIQUJ2d9RDVsy3BH2SS8oK1w3HezGfWq+54QsXAMmMOR+uNDR9MFFCMdaMEPsbsELL
         W2SnQoCLap2+K5+fe6nQbfuPtMwsF77LiEzQcgjRZIQhYH7kJ6YEmeI9zdw48fJ2pfhp
         aj8er4Xcf7t0aCVebMr8FEKXc2wh2GD8WizMcysKZ15/sM12jNOLKmQ/JumJvou+VUO5
         y++g==
X-Gm-Message-State: AOAM530Af/pq8Xi6jp/Zl+AGBSpok6FdMAV/8abaXMy3n4jNz6OiMyMW
        3RXbSG3b4bTYB1bVRXf3b3NUSpfkijw=
X-Google-Smtp-Source: ABdhPJx6BP5cYN/k810GSgg0NRVquMHvGuvIPAo82m9CSo8yVeowUA0ltRoJ4zQyhbezg+61dW3giQ==
X-Received: by 2002:a05:6214:c47:: with SMTP id r7mr34089500qvj.51.1638057053135;
        Sat, 27 Nov 2021 15:50:53 -0800 (PST)
Received: from [172.17.0.2] ([52.149.181.23])
        by smtp.gmail.com with ESMTPSA id a17sm4698098qkp.108.2021.11.27.15.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 15:50:52 -0800 (PST)
Message-ID: <61a2c45c.1c69fb81.b79eb.6ab4@mx.google.com>
Date:   Sat, 27 Nov 2021 15:50:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4004468836938962090=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dev.git@javispedro.com
Subject: RE: gatt-client: when disconnected return default MTU for GattCharacteristic1.MTU
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211127222132.14351-1-dev.git@javispedro.com>
References: <20211127222132.14351-1-dev.git@javispedro.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4004468836938962090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=586773

---Test result---

Test Summary:
CheckPatch                    PASS      1.34 seconds
GitLint                       PASS      0.93 seconds
Prep - Setup ELL              PASS      51.78 seconds
Build - Prep                  PASS      0.51 seconds
Build - Configure             PASS      9.44 seconds
Build - Make                  PASS      222.52 seconds
Make Check                    PASS      9.90 seconds
Make Distcheck                PASS      263.17 seconds
Build w/ext ELL - Configure   PASS      9.56 seconds
Build w/ext ELL - Make        PASS      209.87 seconds



---
Regards,
Linux Bluetooth


--===============4004468836938962090==--
