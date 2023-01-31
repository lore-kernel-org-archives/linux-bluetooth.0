Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE359C636CD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Jan 2023 05:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjAaFNo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Jan 2023 00:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjAaFNn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Jan 2023 00:13:43 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22353526E
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 21:13:41 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c124so9430049pfb.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 21:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9XJ5jG68NuP/zHCB8iHwu9328X63VCrkpzoGhzcdpTc=;
        b=WUISFya/1/At5cqpz7oM8E1aThKkqIXanoNIBaBDT43c/lJ4o7Vepmz5/1/KEBXjIO
         HdsILXOaQmhLbDRbnzmeGhf27y0zncsMvjiouBsqiIRgWPozAdMXekd+KoyQCVpAhksq
         dX6yoCd7s4H2DLlEN/hRiS5aJddul+jeusSXJitXzQDH627c1PuQimA/onrAFPdZFGDx
         n5FVZTG+w6q75lHzCuFLkmW+y1W++8XeJXP4g7v7IGXkfhwaSB+FpiBTblQ1f0d/fsw7
         48UJZTlAu+7X1cxve6/Ds4fV18PkeIgEAbxM8Wea+koEOFTSS26ijMr99da9Grt6B9Mg
         DQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XJ5jG68NuP/zHCB8iHwu9328X63VCrkpzoGhzcdpTc=;
        b=R8J0vwfWme7yIu26h2Tx8Bb2sal0TgQKWdw+o1cDfEL5jcoCEm9pyYna1e267SRNh8
         j0J09TnKmtKvzAIcMcbIQ4+tjmBHPtuIBYVj5YbC4f2S84e5ZiI07FZwhWTPixjtPL78
         YTw35L0YZLzLhfNUN5cs5RpABXrlCLblHrJlmXaAbca929wz5bGU7NxzjyF5m481vDcI
         2PJJPDEvsUX5xdKdOAcXj9epPJYVtrEpQtnlty+clwon+F+CEiUvjfk+rAb36OgZhquc
         wwfmTKuJOm+tJotV5FDmq0M7ZEcKntF8Olnj/QJqI4BaU5ueLY8Yo73qezcoPe4ZzKDE
         SPWg==
X-Gm-Message-State: AO0yUKUFXJRhFd3lTxbAvuQszPF3WUowc19zoXXSyqJoDKFlnEABJnE6
        30kiG8et5UZ+0BQJEaEnGv/AamkNGvw=
X-Google-Smtp-Source: AK7set+Uvo588fm7j3BRvNK5uUDiOqU4QwxlG0W87bef1yJiYJVlwHPwK3EBRRdKWeyTNeeaenQbEQ==
X-Received: by 2002:a62:19c4:0:b0:592:3bf3:f557 with SMTP id 187-20020a6219c4000000b005923bf3f557mr18379665pfz.22.1675142021104;
        Mon, 30 Jan 2023 21:13:41 -0800 (PST)
Received: from [172.17.0.2] ([13.64.13.81])
        by smtp.gmail.com with ESMTPSA id k62-20020a628441000000b00581dd94be3asm4161877pfd.61.2023.01.30.21.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 21:13:40 -0800 (PST)
Message-ID: <63d8a384.620a0220.2c22b.7944@mx.google.com>
Date:   Mon, 30 Jan 2023 21:13:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6367146291339365782=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, steev@kali.org
Subject: RE: Attempt at adding WCN6855 BT support
In-Reply-To: <20230131043816.4525-2-steev@kali.org>
References: <20230131043816.4525-2-steev@kali.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6367146291339365782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sc8280xp.dtsi:1207
error: arch/arm64/boot/dts/qcom/sc8280xp.dtsi: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6367146291339365782==--
