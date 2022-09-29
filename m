Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5066CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 18:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbiI2Skt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 14:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiI2Skq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 14:40:46 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EE41080B5
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 11:40:42 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i3so1424994qkl.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 11:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=+xgKHuoAy0O6W5ceSlGTBXxzRbk0UtblV0nIrSVVd6g=;
        b=ILnz2vjqC1YefvnP3hBeSDde/EATmVjCOO3tf3MkRHritWVEspEbiTc+Iw9/2W66il
         X2y3mL49sTthXCxMH3X92Jd/5xEYnISMc0FWznTFyNLu1nuJeZyoZBsdUpL6xbby8Y4y
         nd3Gm2dqpir8krSq07BlNCzyyno/5C4+H59tT8j4sJVlEPByX1v9j8R5Fbunm71DZH5m
         bmXapfk1X1EmwD5Lwuh1NvHrL7fPnHh+773hpEgNRAbRhttIFX+81twxSi4Z9BjnEJRO
         LYwyXkKlGysdlTc2g9cz97JYCwNQ7zRZkJvEDcxOfsFMTWVdDzT3nHycKhbxuc6SlfUl
         d09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=+xgKHuoAy0O6W5ceSlGTBXxzRbk0UtblV0nIrSVVd6g=;
        b=WOIIiS0hG/Dh1yX6UU9xv0zQYGcVdh2qWcPYJKmXi9LN/aPI3MryWqQntwDpaxVN9L
         V1w95BofyWUVHetr8hNKQ679VdrOL+4sqKbiG2vTe1GVlGS/a27smeVM+Zea9h5Ax+Nn
         VQa8vv1va06vRSkRI5gFzsab2mA1IKsxFCzWKSVF0HYJzehLBsGNV+fbPW1K1qcNKpwN
         GY3raPvWbifqlclTllf/9niJ6oFagWBlUV10qyKQl7UApAfePdRqVi41g0Si9GejZX9j
         vNZVh8MtMwsBdYqvPTf6TMfItFiK4oLYc922jpOmsbIWMBGcAp9SaHkep3slgz2sYMdl
         41hw==
X-Gm-Message-State: ACrzQf28qCF86THLmRpVIlXZuBOw8mYI265BQySXgJGNUqIrNbaYpUgo
        nvPQknVFIufVbmTxBXACFh0HAs2yO8iE4Q==
X-Google-Smtp-Source: AMsMyM7jsWXQWgIfMsBegM/UroVVZE/XEhMfyL/so5PtGlZZKCYAn3kfFX3IAV4503ned0GxGbSCwQ==
X-Received: by 2002:a37:8c9:0:b0:6cf:821d:3e8d with SMTP id 192-20020a3708c9000000b006cf821d3e8dmr3390952qki.654.1664476841352;
        Thu, 29 Sep 2022 11:40:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.221.155])
        by smtp.gmail.com with ESMTPSA id bb20-20020a05622a1b1400b003435bb7fe9csm5790944qtb.78.2022.09.29.11.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 11:40:40 -0700 (PDT)
Message-ID: <6335e6a8.050a0220.5b3e2.184b@mx.google.com>
Date:   Thu, 29 Sep 2022 11:40:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4958496451316839082=="
MIME-Version: 1.0
Subject: RE: plugins: Do not try to autopair with Nissan Connect devices
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, florian@ubports.com
In-Reply-To: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4958496451316839082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: plugins/autopair.c:66
error: plugins/autopair.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4958496451316839082==--
