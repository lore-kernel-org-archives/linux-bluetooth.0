Return-Path: <SRS0=VvJN=D3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69A1C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Oct 2020 10:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A3BA222E8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Oct 2020 10:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBDb4tL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392148AbgJTKeo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Oct 2020 06:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392120AbgJTKeo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Oct 2020 06:34:44 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B70C061755
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2020 03:34:44 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id z2so1507169ilh.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2020 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hqPzWhSUoTgWg7dEHRIj5xaAtGtEmJV5bjPLcHko29w=;
        b=cBDb4tL3o5jwmHqHPQGwXNfePER1t4IZGpek2sPW3wKDfQ/FiKyCqrqTUwqi60rEDD
         A3s0COwACBCA9LNqYOrvkWB2Ub+16mCOKTs9IqdnpzYPyJu4vjGnVBQTqN+AU+VtZ8dt
         sJNPiHM6TyxspTUNTuzoAAj1j4DLTeYbjscUo5vQRmcnmC2k6wKeO/FxvtR/DQWrCesG
         ybGD1KJIlK8gSPdEFwHwXkdmI6VTZucqJjgZejWVIBKRhVvXUXfcrmscN9xPPASL+q8Y
         5gVZfg5VHeIXB3efp7VJ/6Nv17AZHetHJhHUoUIHB1G2TG7YnbwEE/2H0ErITfbNi+Gr
         YxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hqPzWhSUoTgWg7dEHRIj5xaAtGtEmJV5bjPLcHko29w=;
        b=o8H270xBJ+5Hp195h6OYmGiAMZO+RqW9ZxEFrG23mdDKXWNfceJ8XhgMWDZ941U0eU
         BRVYGek/1yXJpV2nspW2cld+rlFI29vw7fQYaCq6YTM0rCBU2ei56izTisFFo+qtlUIO
         /dL9TTz//pHhk5QqM87DLHfxlsijGbrLZDQSuEt1fRk7yrrkKJrp7m3ROZd2m0y/cn3i
         l6rb8QTqV1+5mHxb9PilRNEA6f2/2WVR45+dK1BJ6hVJ35GvRzfHcc56ilsbpjh8N4C0
         SKR03axVOh11XVq808DufK6wNfmvOy6RaevfkQooyTHR/PI2oz0aoxL/eK85x+NaNTSI
         9ASQ==
X-Gm-Message-State: AOAM533YTHo3AjxTdSX4MMz5e4YoGLD7/AxymRgY+5rewHmcxdFhf/6D
        TaAp2T+Wwx5yUewFZotX1K/+7GFtZXg=
X-Google-Smtp-Source: ABdhPJxvH7Gq7EUuPtnW477kgPFYHT5j9rliJlC1BoM6EVqZLmbqSaL6AHd3BCiOq+S5wLsCBqO7Sw==
X-Received: by 2002:a92:c7d2:: with SMTP id g18mr1341304ilk.17.1603190083484;
        Tue, 20 Oct 2020 03:34:43 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.91.216])
        by smtp.gmail.com with ESMTPSA id y3sm1439929ilc.49.2020.10.20.03.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 03:34:43 -0700 (PDT)
Message-ID: <5f8ebd43.1c69fb81.78a60.5ecc@mx.google.com>
Date:   Tue, 20 Oct 2020 03:34:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3339038360568884395=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez] device: fix temporary_timer double free
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201020180230.Bluez.1.I67bbd887ee5c0b214a77cb0ed8f9e1d3812ffe73@changeid>
References: <20201020180230.Bluez.1.I67bbd887ee5c0b214a77cb0ed8f9e1d3812ffe73@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3339038360568884395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=367425

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


--===============3339038360568884395==--
