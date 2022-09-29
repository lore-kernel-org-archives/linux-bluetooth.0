Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E02BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 22:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiI2Wiy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 18:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiI2Whd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 18:37:33 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB526BD57
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 15:32:53 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id d74-20020a4a524d000000b004755f8aae16so1081582oob.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 15:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=tIFWNHwAQWO2fJ2ea9fRnmTsWIDOna4X992BspfG6lE=;
        b=OLNtk7S5MbYXf/kQB4ILEIfnaqH4qIzI9sy2DO/jFNmLxmqlXdQqbmCTLHjNuPDNSK
         bSTILQ68jSyR9SGWEKCpUVA2rD+hHEQRSRFW9iMXcytyc8FAG9LdKE8hRobxKCg7HWS/
         8bgHZrlUbQgX2eMfOXkcXDWn8fF94JEDA/JbyRyfpKoogrEFsVf4HV6rzE+k13h4TLe+
         X0ZV8Wg3xG5inHr7JrFLCNIf65TG4fHXMplM45+SwqI2cJmwPd90DjeABQpzxBhr+eKq
         jiJyfzKLZLqf1TRCfhJmUNgdfuSWrINQVFpeIP6/yEeBO6iSvQa+TFVOP9lcVuIoa8GX
         YlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=tIFWNHwAQWO2fJ2ea9fRnmTsWIDOna4X992BspfG6lE=;
        b=rDeYwl9zpyDfMquT+wfWkokBMi1IpGS2b73Tm35hxtGd0Xx01pibaP9nV3RJLqQWng
         z1LL+C8cmavh4eqAU3PIY6n9udNbuAOxUI0GHpxNMD3Cx/H3dLo+zxFeLpumRFgBbz0h
         04QSuIdg9j3MK6mCtlIijye1kAomyv3Mrz0cAMctv+n5jcXI0ZrLLN+5eP6lSKc0hwHV
         MAi5TOLjhkIJ9sqJ3kW9ZYXP+Ye18UGqp+StIz2cYX4vRUeS1R8TffKRuquuFB3vq34M
         kncQZiVdWjN4XNNzEJsx9K3GwXs2gKOz7a53SfShsG5ilAr9L3RGsxf2aoAJou7Zvpkp
         w5gA==
X-Gm-Message-State: ACrzQf0oYpYFd1SVCAXoQxOZzMBFnAKE/U5ltVpmSDkgp6lN2lBs82KB
        1TGZW0bsZ1y4rQBDoik72lcBhLxPJzJeAQ==
X-Google-Smtp-Source: AMsMyM6tC/tcxginH38O27ZbKTZmXrUc0zUJ0ixeVsK5RWrMiWVuxpjp/wHbQ3FJi9uEJmweIYnIMw==
X-Received: by 2002:a4a:5d44:0:b0:44e:2b42:316c with SMTP id w65-20020a4a5d44000000b0044e2b42316cmr2295167ooa.15.1664490771992;
        Thu, 29 Sep 2022 15:32:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.165.30.87])
        by smtp.gmail.com with ESMTPSA id bx21-20020a056830601500b0065689e13f52sm206624otb.71.2022.09.29.15.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 15:32:51 -0700 (PDT)
Message-ID: <63361d13.050a0220.210ca.115b@mx.google.com>
Date:   Thu, 29 Sep 2022 15:32:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8218061035539804607=="
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

--===============8218061035539804607==
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


--===============8218061035539804607==--
