Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43187C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 22:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiKAWUq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiKAWUo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 18:20:44 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9021A21A
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 15:20:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id f5so19151421ejc.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Nov 2022 15:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WRrN2JNvrw/Lxmr+UOWvkeKiXy4AdPPchFYyYnA+jJs=;
        b=RqN4/aFD3NZwhgmavKLUGS5mDGKcx/pemLkR017Aqlm0lY78WPxWs5Hkrmm5E0CjRe
         zDrcb6l40EV8F5b47gx761zfV/J/dQTUN1Vmpc8AU4JFNWEUXPXXYtQCcmJCnUkKecsp
         VuyuMBCITd6iBQRseN9AJGJuTJ+0S/7wfT6115kI4RsvyDyI4yEGINQhrqUG7cPaXjDq
         OwLI/Ka6ThyEaPjMOJrlFMSJYbhehKvcw0Q4JYACIs+AJOT6T9cMd0o6ZOjAVtR2QUYT
         RNhrcufN/n2UH69JgbZOvhPzm1yGrRBhPn+kSKyJyJUPOwstYLRn84wMZUHmgVwxz3ci
         nv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRrN2JNvrw/Lxmr+UOWvkeKiXy4AdPPchFYyYnA+jJs=;
        b=biM+FG85pr6WYf44uYi2O3W3RjUc8kjpTxFBZzb1a+t0nzZ5yLllNB225uFwE1zqzb
         UdUhzAVrnDFq0RM2V59ja1L4MaTPJJbcWpLBKexbzGY/K+sZHNz9EuNnnn5SJEwN1FeA
         D68Qizptc8TPJ5WXA8U7aUfJM0vVENjYiFb9NE7uX5aSRx5LshTBQ7CF6ag4X5VAoq4Q
         taKbgDLlPHaqlK6NUIK6/+RKq7SdOAouLm62YS0G0KqCrb29wsB5KSXxHGbpu09YvK+V
         iSapI5KIo9lqEpCo4QOTCc4FjyniEwehB04ASmR3JACl6a5ncLeHXzpRmPlI80Cc66I9
         tImQ==
X-Gm-Message-State: ACrzQf0cFuN7oynwPRHKHoKgth5CldQVYOMLucvh/GVK8wc0i7/+H17b
        pLAUUEfaLP3Amb2e6PkkTiRIpWY3MS1fEhsi2GSINQ==
X-Google-Smtp-Source: AMsMyM7OY7jYHupzKNa+H059InLE6G87GEMrdV6G0H7id3YMnfPSnGmg5DSRvp8jlEWcRYlfoigQdUBIUw5ZE5IJq+o=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr20888450ejc.440.1667341240927; Tue, 01
 Nov 2022 15:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221031204804.195267-1-marex@denx.de>
In-Reply-To: <20221031204804.195267-1-marex@denx.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Nov 2022 23:20:30 +0100
Message-ID: <CACRpkdZPzFivWwQV1X8qWfXdrTmrx5gHCk0ZMKJ+5ovNPgqxrw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: broadcom-bluetooth: Add CYW4373A0
 DT binding
To:     Marek Vasut <marex@denx.de>
Cc:     linux-bluetooth@vger.kernel.org,
        Hakan Jansson <hakan.jansson@infineon.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Oct 31, 2022 at 9:48 PM Marek Vasut <marex@denx.de> wrote:

> CYW4373A0 is a Wi-Fi + Bluetooth combo device from Cypress.
> This chip is present e.g. on muRata 2AE module. Extend the
> binding with its DT compatible.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
