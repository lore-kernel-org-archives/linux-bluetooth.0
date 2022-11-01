Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74576C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 22:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiKAWjh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiKAWjg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 18:39:36 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AFAE14;
        Tue,  1 Nov 2022 15:39:35 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id j14so22931626ljh.12;
        Tue, 01 Nov 2022 15:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GeigVI+V5xySLHwa2uoMXywRzDo/9AKQ0VmpZC55SVM=;
        b=HhcR6dNxu36C2QsltNXnoi9BKUuV7yfmnrMN/IpskveeWEAURnGiu5FwESJpXmdoQ2
         gjBn1fFAaoF0N56ZAbydnD7m0TO74RqIAHgw5yUCwjPxvXV4uJmo9ettyyP/4uwK+nyO
         ouUsQ5gNhOQgKKeW3FYqOoF9hOqEepdquWGiCI0DMKPwfFX11BEanIHlznasp3mCuc77
         jZLfsju2ZKY3jLms0j+yNvku49wKIzJSnGKx8WWZDYm2hcH1uvxxI3H70zrjy9kgOt6P
         HG5sFvaxe1VG33+hxXmPOF+1XGJ2Uqzuki1IJdqrVGr8aKBa08mVHTmQvNWXoqf4Uwny
         MwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GeigVI+V5xySLHwa2uoMXywRzDo/9AKQ0VmpZC55SVM=;
        b=Xhm0HL5JK75aosf+cy6fZETkhOOT1cCejWAlr8zU2PTc19W493XxZIdfY2xvQMwySM
         oA7OZk7BHFxQ9m1uz2ER3v3shAR8HoWZX6PIHJXCcUdcFBVrH/J+5FNbK0Hg3ulKcwB5
         5kV9y6pOXRV4Pj/KnpmADYcT75DHETLgMAQ9iGOt4v/9mepeJq3Im30NIJCi/CfPNVj0
         yEwpOM7YeLL3CPLhVh3yt5mMpX3/LhUeyw1bg87xTYOobF34vJn0Qc2OTHe6Vg+WUwiw
         cIDfCst5ufV0ZyCiPyk6bqzlBtZJy0H1W+TFoU4sEjKE4/o9ldyNtQmOUjFUHgscLVb0
         RdDw==
X-Gm-Message-State: ACrzQf2ho9M3OJ5G/58T7eQjbD6qIgr6mNTtuYCtrFMedsiESUfVfGGW
        SZK1wXPBdUT94rE878lBllS45FqtoPZRlT47wa9vbiv1
X-Google-Smtp-Source: AMsMyM4VGAGwJoePKPhWw8zlSBHacFf+rvRwheNIwDhv6SJ7ohRiQEdAMEnhCeiOdxaIy5altMC8z47kvHzd+TFbQaU=
X-Received: by 2002:a2e:9ac3:0:b0:277:1c8e:684f with SMTP id
 p3-20020a2e9ac3000000b002771c8e684fmr7601225ljj.260.1667342373498; Tue, 01
 Nov 2022 15:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221031204804.195267-1-marex@denx.de> <CACRpkdZPzFivWwQV1X8qWfXdrTmrx5gHCk0ZMKJ+5ovNPgqxrw@mail.gmail.com>
In-Reply-To: <CACRpkdZPzFivWwQV1X8qWfXdrTmrx5gHCk0ZMKJ+5ovNPgqxrw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 1 Nov 2022 15:39:21 -0700
Message-ID: <CABBYNZ+CgFbKtLsvwbZOo=NA=rgnaKDY0wWRUKTccBm39F+HPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: broadcom-bluetooth: Add CYW4373A0
 DT binding
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marek Vasut <marex@denx.de>, linux-bluetooth@vger.kernel.org,
        Hakan Jansson <hakan.jansson@infineon.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Linus,

On Tue, Nov 1, 2022 at 3:30 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Oct 31, 2022 at 9:48 PM Marek Vasut <marex@denx.de> wrote:
>
> > CYW4373A0 is a Wi-Fi + Bluetooth combo device from Cypress.
> > This chip is present e.g. on muRata 2AE module. Extend the
> > binding with its DT compatible.
> >
> > Signed-off-by: Marek Vasut <marex@denx.de>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Should we have these changes in bluetooth-next or dt has a dedicated tree?

-- 
Luiz Augusto von Dentz
