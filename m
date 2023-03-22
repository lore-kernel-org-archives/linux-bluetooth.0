Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B19C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Mar 2023 02:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCVCI6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Mar 2023 22:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVCI5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Mar 2023 22:08:57 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795544A1E0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 19:08:54 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id q30so5524212oiw.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 19:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679450933;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IDo7RwP0nP911ycBg5Qba1BdrX0ErDHS6itJnzcuy9Y=;
        b=Sw3vlZMo8GJfxK0nD69PqF7xZxlTIu9lo6GgiIjmVxvkM6sYH0brnekcsENJAWsSpW
         RlbScAivYwt66kBBntoexD219/8PNoEFRyMe2XFawKK3k7OYOZDZTEtNzu4cKIfg+E44
         6Rz/9vmoB2M0Ewdx9sYhSMAsaZRGCoONxlGoxD6yrYV1KqVMWFQkKZlbwIbLXqP585c3
         T51cBinDYcOZ6Rav2cQFg5Q9nFP1dYH3uJJMCuOi3V6x/kiUn1A7Y1ReFrEiYz/hrT94
         5TY/AwOP8XYJzUvTDhsNaQYCshUbX0xbxs2hOpPAgLdKe3+ST0jkAeislk6kvocNqPPU
         0K2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679450933;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDo7RwP0nP911ycBg5Qba1BdrX0ErDHS6itJnzcuy9Y=;
        b=8K2EmV7xduE7HfxKk9/iLAN91hKm4DgAgFUO3XjkbvS+nKPP9c6r6IFEJzfSnc3NyH
         Um6GUqwd4TVssYCdoTXfhGPhl85QM3ocUfpjtPlKCYBnoOzx+tCpBM3QeMig6M2ebX8I
         KYJnUfRSXgSePtmbxjLM2XTOrxQNJoEZSbdD/tSNxsxhHXQtxl0caIPTQQT7hc52Jqum
         mDdKgaGt6kmPgDDBehztUsKYoL8pLPLbjdga1Q81wIGZcXtsKOmC4zamgfSMPkQqIwln
         rqi5YeHUBuxUooFwa6bsG0JXroYKNJOTi1HdwxKSOdW6lzcl7m1z1OW0qNWns/ijubTJ
         gKww==
X-Gm-Message-State: AO0yUKXklVmcDn1Y3BL1eGOVQACabiS1Ay5xu1OT+Pqs6HT6adZDhoA2
        RU1KRwroUTbdhmE87WvYOS9+9Cegf7k=
X-Google-Smtp-Source: AK7set9bKtQwyHcHVNNFhRn4wKxH/YH5dG6dJsm5ehP8tqEZTZfhgkKpFJtVHXtUhbkMxZaNlBiYQQ==
X-Received: by 2002:a05:6808:6147:b0:386:932d:b3c8 with SMTP id dl7-20020a056808614700b00386932db3c8mr503117oib.25.1679450933729;
        Tue, 21 Mar 2023 19:08:53 -0700 (PDT)
Received: from [172.17.0.2] ([13.65.246.135])
        by smtp.gmail.com with ESMTPSA id v8-20020a9d69c8000000b0069f951899e1sm523851oto.24.2023.03.21.19.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 19:07:53 -0700 (PDT)
Message-ID: <641a62f9.9d0a0220.cf635.323c@mx.google.com>
Date:   Tue, 21 Mar 2023 19:07:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5457373353044661116=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, steev@kali.org
Subject: RE: Add WCN6855 Bluetooth support
In-Reply-To: <20230322011442.34475-2-steev@kali.org>
References: <20230322011442.34475-2-steev@kali.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5457373353044661116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sc8280xp.dtsi:1209
error: arch/arm64/boot/dts/qcom/sc8280xp.dtsi: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5457373353044661116==--
