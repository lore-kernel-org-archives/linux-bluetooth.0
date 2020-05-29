Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B113C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C53C2067B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+1J1MIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgE2PJI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 11:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2PJI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 11:09:08 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19998C03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:09:07 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id s1so2453475qkf.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=cv2Cd3zhagROEVc1e/k2SLmO2bz1Le8K+6hZsBPhgAU=;
        b=X+1J1MIkNOPK8SkdE8JdQ+8ImOQfrmstN/AbHQYbTzGQ+k4YMN3Xmr7dLsCty1Aiv0
         O2Ots0w2i+WCQf/z/O1TY7frlsC2XmoFjetawZPvnV6I3zHGBre+QckRnx90MYqIyCWE
         QzBReBFaceQ/RrmA2F2jR0KOttDGX2H0CV2gzMJflJYV0f5HUDCSPUVpc1N3QwrSm8uu
         FtLKm56Kjr9HLF5jBEx9DWcv3AQH7w7V5jMFhcFDFgc4gnzsXsA7R7KIHc5Z5fZCqMZ3
         zRmtD5eHRMeQz814WOQhyuAu9l9emMUl4OgAf6CFGLfSY85tOZsbR87VFFXlBgMwOV8y
         k3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=cv2Cd3zhagROEVc1e/k2SLmO2bz1Le8K+6hZsBPhgAU=;
        b=M+5g3xDuIVeMognsf8b3l8JN+rv+SaMxRYH32EDDbAUjv+3joWw7GuK1kB2spRYdGE
         P2Z+I6YLdwfmlcd67jG8lDqHaBF1pt9Nv7+TfPr08OHP0fyKT41vYQQm9pFvoaxXjqu7
         6tjeHLmvcBjDIO/GDeaz2FJCglORdRCODcV8cgomedDc1xlqsqACnX3NRQa6cupDY7Iv
         RCM5xHd5YYa38cYhz8QCg1OLrfi7ZggeJenUAm+q/q8XiqKAY/tvkeHR8Z4WA3j4eYjS
         Ru77MVvOdgHbMbFaYBQc+TodqxDG/ZZvcmPVmqZ2MOTl+na40STZNXa6eJjV61bLfIsc
         /Czg==
X-Gm-Message-State: AOAM531nixcxZPpiJx4nuPGnCXFFEsrRj3d8KpW7WiGijsmezpAKi4RR
        yAir+cKdF4dYKC5fwiYQU+GzPmcq9OY=
X-Google-Smtp-Source: ABdhPJxMMsdsOMldwNBxXHKeRGvj+tV/5NUZmmeahzPON+r4rBWz7uz4UvMnLvrGKI3P/Inmd9s7+w==
X-Received: by 2002:a37:8844:: with SMTP id k65mr8276725qkd.309.1590764946144;
        Fri, 29 May 2020 08:09:06 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.58.192])
        by smtp.gmail.com with ESMTPSA id j5sm5382748qtr.73.2020.05.29.08.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:09:05 -0700 (PDT)
Message-ID: <5ed12591.1c69fb81.90732.ed10@mx.google.com>
Date:   Fri, 29 May 2020 08:09:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0709654876178842439=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alainm@chromium.org
Subject: RE: [BlueZ,3/3] main:read default system configuration from the conf file.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200529145007.198906-4-alainm@chromium.org>
References: <20200529145007.198906-4-alainm@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0709654876178842439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
1: T3 Title has trailing punctuation (.): "main:read default system configuration from the conf file."



---
Regards,
Linux Bluetooth

--===============0709654876178842439==--
