Return-Path: <SRS0=SB5R=BN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF66C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 09:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39CD02067D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 09:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWnSzNM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgHCJ1m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Aug 2020 05:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCJ1m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Aug 2020 05:27:42 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4830CC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2020 02:27:42 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id e11so3229418otk.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Aug 2020 02:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xZua3WLGIsLHsuGx6nc6hFbCI7jWaIIkx7pcm6vifGI=;
        b=UWnSzNM2Z0VZpZJAPTye3jDsDPF7YuFb3z1pmwmNPBXbEvO7gN0lFIGKmuqo3KQSub
         DkpRRjmd7RngiQ2dbc2luJt2LiopPeGjmV2FETVgg6tu0W9NuiLrQ0KiLiv2vw42O9R6
         PB05ie8rZLH2WTsfgcExRuw8BfdOZ4tzq+SjfcSlL/73sZKhjv1qAlmdocicKS0M77BM
         Uywo5sdoYYdtO+tRnymlY6kBe/wf+a3bVxfKM/zkwj76J1g0viWrno/NxtmPq9bujU1X
         8ixlcMuw+bh4QOi8cdae68GTk6dB7LZLLaEJ9Saw5ISRf5oLxhXQlpEKAoSDj4SZXufu
         XW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xZua3WLGIsLHsuGx6nc6hFbCI7jWaIIkx7pcm6vifGI=;
        b=dPa7NDfgdL6yAwialviaGHWW09/6qilr2nHrhzHemi0Tiabl8JcktBcPxLnMclrBvP
         rbGXWVQyNB3KJIEfqlqYH9i00iS/uB8SMA2dx6d2jPzyPiJ7zbI2XNd+bUNjO5hQp9ta
         RgM4i0UCAYxJ7LK+Tf9MZ8YBG9SJ3mL4gdItNFe2V6dggM5iIgtZjfsEMpKSqPiXZI97
         lmtT7or1HhIDX8U6KQNuN6ATmtgF+ysyWRtOXOqrCfWGnvLs19I4rqEPh3lQDCU1akth
         IYYK0sy0YrRtB3zHSdXFQIDSLWrboZfipzYPwyuxxndJrr1u8MyluxXTNGBkSh65R8US
         UGhw==
X-Gm-Message-State: AOAM530H/AhXDu4n0D3EuaKBt4y1OZJWjzyOSLsA4fI7S8x+HMhc0fTw
        OLl5MH2qmvS8S7YFN3e4nFCNn9rGFCV5DJaOvMFXAuE=
X-Google-Smtp-Source: ABdhPJwa2XIgb0WXt7OlAfF4pnzJAJlpJJsQKIkvzecKWab+Yxgs1i/xp41vpghdj5w1r42sJQPjuY6sXfyykqg7NPA=
X-Received: by 2002:a05:6830:4d9:: with SMTP id s25mr13287236otd.153.1596446861239;
 Mon, 03 Aug 2020 02:27:41 -0700 (PDT)
MIME-Version: 1.0
From:   Click2 work <clicktowork2@gmail.com>
Date:   Mon, 3 Aug 2020 14:57:30 +0530
Message-ID: <CAPWCbyVpt6vzgrK+wZ5POtD6kORFASg5gY1A9ddnpOPBaGNk8w@mail.gmail.com>
Subject: BlueZ Features
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi ,

I am nubie to BlueZ , so please bear with me if my questions sounds
dumb. I have some queries regarding the Bluez stack and I don't know
where exactly I can post the questions. Can you please help me with
this?.Basically my queries are listed below.

1) Does BlueZ support the latest BT 5.2/5.1/5.0 features?
2) What is the maximum BT specification BlueZ support?
3)What are the changes needed if we want to support the latest BT features?

Please let me know where I can get this information?. Looking forward
to hearing from you.

Regards,
Sri.
