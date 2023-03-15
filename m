Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019AFC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 11:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjCOLNk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 07:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjCOLNU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 07:13:20 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481745584
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 04:11:27 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 97so2968149qvb.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678878605;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XSTsT0WZPFEtSquwPjG8rnWeYQhT/lzNPKMBbpT9JZM=;
        b=NKrvM25GltLI9JY4/YFvzwy5CCKb1grOzWgpsyZK9VNedvg4V6rOA1yiWHmRHpRomJ
         LPQU3GF8pH9MEU3bMCOWUsdhuvE9dXLPOMT8588/ZQkb+y11GZXMyN6OeYbOvGle6uGY
         tmGjbcHtz1zbt56kfiL3Df5YMGom1sBCXaz1mSnis9Jbec5UI90VLWb482HWK0T0PG95
         WQVxs+IB5VOWG1ZcdEwziC4gGXA1jTbLsYOZWyLTFaiF7CZUGHl3TgQynQjLvTv/pDof
         p3rfctswlrSDKI6G+Gy87F0ncFjcXbNTuFgCRfyQhNyysaAsxBFS5Ideatc6LMBrEXWk
         cxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678878605;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSTsT0WZPFEtSquwPjG8rnWeYQhT/lzNPKMBbpT9JZM=;
        b=V6t2zXhHmUKe9jXvjMSJbgVzPzxZWNi4BXKE/bmP3JBZuZcUs5eoJfed0+bRYI58c/
         ENsc70z2E+rv6bF9IMhicavQTnfm3csWjxkrvLu/lYK9OEcUSADBpGXEbRe8JEV3GsC5
         9vonUz07UcADY6ip31pxHYoG8b9+1uoC93G+LW7pIFQGD10yiwqW+fUlWFtrR8iRImbt
         gQrlqYZAkoZ/SwH4iNK4cPMlYDbgEEJkb2T8zwBpJX/DlfGtYdIW2U1EC3OAjNYAu5i9
         dx8qwpt+WFdqLph9FrfeLdaR/GeTUamqmiBjWhabKSGmNxcbYYPEr7f2jR+mGZVaJnn1
         cWWQ==
X-Gm-Message-State: AO0yUKVJm68c1e7QGPefwGtn6tJyXdjXAJ1srhD3pd+xWnmY45KzuOuw
        6jzIjQ/tXEn3xHdaDF57gyWwwlLsXzw=
X-Google-Smtp-Source: AK7set9qnxtkNiCDutVBe70VITOir4SpMPqRj/96KIu2eXZ4ZCKtjETA2c9e9sFza64t/m9JX7HEYw==
X-Received: by 2002:ac8:4904:0:b0:3bd:15d4:ff65 with SMTP id e4-20020ac84904000000b003bd15d4ff65mr50279332qtq.40.1678878605508;
        Wed, 15 Mar 2023 04:10:05 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.98.54])
        by smtp.gmail.com with ESMTPSA id cp4-20020a05622a420400b003bfb0ea8094sm3404738qtb.83.2023.03.15.04.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:10:05 -0700 (PDT)
Message-ID: <6411a78d.050a0220.0a79.d629@mx.google.com>
Date:   Wed, 15 Mar 2023 04:10:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2955042887014275726=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, aarongt.shen@gmail.com
Subject: RE: [BlueZ] obexd: reject to accept file when replying reject message
In-Reply-To: <20230315100435.5424-1-aarongt.shen@gmail.com>
References: <20230315100435.5424-1-aarongt.shen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2955042887014275726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730253

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      26.74 seconds
BluezMake                     PASS      755.96 seconds
MakeCheck                     PASS      10.87 seconds
MakeDistcheck                 PASS      151.05 seconds
CheckValgrind                 PASS      243.76 seconds
CheckSmatch                   PASS      326.15 seconds
bluezmakeextell               PASS      98.46 seconds
IncrementalBuild              PASS      612.42 seconds
ScanBuild                     PASS      975.66 seconds



---
Regards,
Linux Bluetooth


--===============2955042887014275726==--
