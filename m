Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92043C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 20:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiI2UxU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 16:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiI2UxQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 16:53:16 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA381876B9
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 13:53:15 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m130so2822402oif.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 13:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=975KFPPlUSSZO+khX3ad4mlgWFxHraKDsfvfXgRqbE0=;
        b=HW5FVEuJAZG/pcpPdXbq7kSHykYtoSdk8sajCEeab5fQAccbw/ngm6WVKpp32RS9eA
         wXCMMFt5xho/LdO0zsdFgURuepFY3iNSOe73+ifdWvoxBQj+rPRUJn+5jLfe1oIPVVYG
         dxgwR8grajFMUb+mY1isve9kLpD4NmMl0m7x2oY/BIomGa/1fDpp5aImosNmB69D28dk
         llHCoK2zK026MSBkq7j7c6PRgeWkpoO9cdVvK8OUWAj4vPjTH3UBGI7XyWQ06xsQEB5u
         56w0wNcgNuFCBKlFo2DPY/8k7haAqR+S7kXTROYGpeyXkXUHlOWvzS2azEJBpNmk+2Xf
         DRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=975KFPPlUSSZO+khX3ad4mlgWFxHraKDsfvfXgRqbE0=;
        b=QZNfY9tGz21Au8XfbmTiTRHkiEarHY4KGDKERfvg20tOT0JW2SRFD1PfeFxCvJnvQ+
         Q518E4pHvoZm+cGhVqQW8XLDng+X4FK//Focc1yReTpOd6OdnY79agpiAazkzNT4ffIG
         SLYarBbQc02OnpJ4xzWeqvmNncgoEd1mTn1xVDsnyqWFyZv52+D5S5qslmiPU9hcC45H
         JLo88fWMTb3jm5ceCIR+mws/nkUUq1fuOrJhgJp2J2ThYyuBNOjJM+wHavlDka6oyjX+
         1n07mKnXflRrVyNEXznEajbgItw4Uk6DKpqE9ybTLNw9MECLrR5mWsq9LPainw1QsC3H
         YIsA==
X-Gm-Message-State: ACrzQf2XIHSer5RqA26hFV3wpN2nvEwuGoBdpmycwqWbb8jmneFuOGYc
        MCay6x9bvPvPs+cfccSKnb7NhxnMFmvf9w==
X-Google-Smtp-Source: AMsMyM5UWlG0bhdSY4mj9BeQ0IhpuLAaxIfwWGbD8ShgCw7RT4alQtYHx9MHX1xSFWORh0jBTJAGJw==
X-Received: by 2002:aca:ab12:0:b0:350:26e2:370a with SMTP id u18-20020acaab12000000b0035026e2370amr8202097oie.156.1664484794690;
        Thu, 29 Sep 2022 13:53:14 -0700 (PDT)
Received: from [172.17.0.2] ([13.65.146.223])
        by smtp.gmail.com with ESMTPSA id b20-20020a056870b25400b0012c52bd4369sm207040oam.19.2022.09.29.13.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 13:53:14 -0700 (PDT)
Message-ID: <633605ba.050a0220.32664.143f@mx.google.com>
Date:   Thu, 29 Sep 2022 13:53:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9138677674315302108=="
MIME-Version: 1.0
Subject: RE: properties_changed: check for NULL iterator
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
In-Reply-To: <20220923145602.25872-2-ceggers@arri.de>
References: <20220923145602.25872-2-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9138677674315302108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: src/advertising.c:1055
error: src/advertising.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============9138677674315302108==--
