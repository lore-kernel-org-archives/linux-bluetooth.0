Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F381C77B73
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 14:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjDSOhr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 10:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjDSOhq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 10:37:46 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FE7E62
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 07:37:45 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id ff18so10787002qtb.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681915064; x=1684507064;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NbhKNQ99K0LAZTt/JBzTOAxMjzxLoGcooK0ArbFcB8A=;
        b=mbkssqVwTu+85AV99ga9XW58n5WIoxnqAR10wA3TqLKtgk56MLIZiXoVwfrXLH04Wk
         1B9ujvnH1M7mMgy4p59SPC8M79JBuvlkAGVp+Ea5MkKwC/fOqZZjfOzil6pY0BsaVZIz
         pc+2O1LxfJN8ZsJjkNKYAp1yt8UWVuWubloyk07bHkqaZw1ieqo7Keao6W3Q/Val3cMp
         0BW12Rh/Qu/UplwJirXa/73Wm9ESh7u9/xnmAxUzvpJIqXsPqgJYUbNIYeppam5zVR2m
         FSls22cTcOHF4braaK7LB/7QPwIJYhtaKJcfdp/RGAsIBWzmgnzBaQc3Co6U2GyMCiNA
         dBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681915064; x=1684507064;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbhKNQ99K0LAZTt/JBzTOAxMjzxLoGcooK0ArbFcB8A=;
        b=EFFB8grLTl74jWcBcBeVHxuyHzWjc5UrZP+rOJNOWK6aSzqS8ZHRC8iBkbpTW1xiiW
         kwFTjL0uwcUI2aX/aLJUMJdjhtGYvH1RcZG0lCmzPsSNAEIcEs2fxbLiDijHduqAfXzm
         WcY5JFWCrlXeeXeXeCxkLlHRs+nIKtPVeEwDmBI+cSaC4JzPCRuDZoR8pEhqa7aGmhqD
         vA5kJlZ6DPWdES5XMGvKUjukz8rhHEDmgt1Qr3u2T+HDYJ0Ut+ydLWGDJ4Rz8pxFkO7X
         wN0EO6746GZ+5Pk4T1voMDRa0/bCLcolgSIxd+43sJldMurf4wnTqGQbqPvtrA8JJS1R
         8Yng==
X-Gm-Message-State: AAQBX9djV8ysTV7fg2ad+Ofjq0flJ/CUOwBInruTbM8REPrIZ6+hP4K8
        iVGNoAMuLsbKSxILP0shxUTBKFikw4A=
X-Google-Smtp-Source: AKy350ZtF4QdH9iyl8yHo6ZVQtwgoH7ehF27iqugndHLGiLSoWV0/sMz4iv/DZLKAlRBgp/GyAwozg==
X-Received: by 2002:ac8:4e46:0:b0:3e8:eabf:d63 with SMTP id e6-20020ac84e46000000b003e8eabf0d63mr7167744qtw.0.1681915064509;
        Wed, 19 Apr 2023 07:37:44 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.55])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a400c00b0074236d3a149sm4703233qko.92.2023.04.19.07.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:37:44 -0700 (PDT)
Message-ID: <643ffcb8.050a0220.2c7ce.94df@mx.google.com>
Date:   Wed, 19 Apr 2023 07:37:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6895037739264650976=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2] Bluetooth: btnxpuart: Enable flow control before checking boot signature
In-Reply-To: <20230419142333.1687267-1-neeraj.sanjaykale@nxp.com>
References: <20230419142333.1687267-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6895037739264650976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btnxpuart.c:755
error: drivers/bluetooth/btnxpuart.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6895037739264650976==--
