Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694E0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 22:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7A6603E5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 22:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhKAW7o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 18:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhKAW7n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 18:59:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3927C061714
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 15:57:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g11so6377692pfv.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Nov 2021 15:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=OPc/9EHZzB/JKWrfpZ/9Txbi4KeWafmgfv+yqbWSqCA=;
        b=mtGyVkpUpPBHnWRka72ysJ7tZt18kL+6RKw1f6udXs8snkjw7v3KjX9vEYzoCoMZvk
         raz4zcQFHqf/uNnbdq7OV56QQZZzcLsvWOdlLNeIAX6Y4fv+Nf3gpl0owrefbGxvvRDl
         sgQ13r2vYyoLLbF3DI71jltn8A4HLkvQVz11VFWEhAxtVV5PQm7VYIbOoj8P0lgmoMHH
         FjaIXndfHgGoWbDySp5gPvInrPz1vetSsoZ8PrrRF3+PZAEH4ZwteaQ8dBhNiXEA6hme
         /M94bKZDRyr6OqemvIXbKdfY0H9snGJrmoqItSR99eup9ZTCxamSZWl8wTiK26cVRfpx
         yJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=OPc/9EHZzB/JKWrfpZ/9Txbi4KeWafmgfv+yqbWSqCA=;
        b=Ourfga1BxzUSSP16lg9ymFKdKaATDSuOKzpkpdeq/giPma7yexIQ2+X3dFKydyWd/Q
         0rCixJjlBcbxp9gqZuh7ShB11BE/FMyQZur+DJ2/ktpTu2cEJxN+cAywNZcOXs+9vaPW
         e850k4ZeKEGTzKHRQ4XY3+oWr+8RM8AtHQ7cJ/jYXa7vkDfWF8dXCR99qXbE88Z3h5fl
         SFajziq2WD1v8bhvJZWM9Dk1ltDxjZb6Yp/pMcpnXdX0ZV1Yq5qEp4aBXaMasqWoXauP
         Xo+dtxDxX67D5WlnHrqIDqSb2A4FPzQwaFJej1st2wrWAgQdDXU2DwRIUoRZ0JYosOUS
         9YEA==
X-Gm-Message-State: AOAM533gaqWVxdQD/g0IIU9xxjfLpRcLNC/9n0tatl0j6qjjRjJpE9t+
        pGbTP++wm3rrGs5zylu95vw4vULV9uE=
X-Google-Smtp-Source: ABdhPJx+PREih6DUoYRMAE4lfkzj9+Ztq3CmCWplRHhcEQC1zI/rLoWm1IM3oFkzHKvrYHzO4RJppQ==
X-Received: by 2002:a63:b252:: with SMTP id t18mr5368207pgo.19.1635807429026;
        Mon, 01 Nov 2021 15:57:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.242.3])
        by smtp.gmail.com with ESMTPSA id h10sm18135023pfc.104.2021.11.01.15.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 15:57:08 -0700 (PDT)
Message-ID: <618070c4.1c69fb81.6bef6.1857@mx.google.com>
Date:   Mon, 01 Nov 2021 15:57:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7587632166895869964=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] mgmt-tester: Add test for Limited/Device Privacy
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211101222725.2766736-2-luiz.dentz@gmail.com>
References: <20211101222725.2766736-2-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7587632166895869964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=573767

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       PASS      0.33 seconds
Prep - Setup ELL              PASS      54.47 seconds
Build - Prep                  PASS      0.24 seconds
Build - Configure             PASS      9.89 seconds
Build - Make                  PASS      236.63 seconds
Make Check                    PASS      9.80 seconds
Make Distcheck                PASS      272.03 seconds
Build w/ext ELL - Configure   PASS      9.67 seconds
Build w/ext ELL - Make        PASS      217.11 seconds



---
Regards,
Linux Bluetooth


--===============7587632166895869964==--
