Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E364C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 22:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiI2Wwh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 18:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiI2Wwb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 18:52:31 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28DF1231E2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 15:52:26 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id h10so102896qvq.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 15:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=pXhAlccm4h9RFmY+kqNdrQZ6Dg9w9EpuMM6TgSFOYO8=;
        b=JD7eopikh1pnvG2sbzD79I+lF0XeGkD7lEnD4a6KC7rNW8q29ZwjsBe1WPrai9E21g
         xVapKRnly3g3yzSNm3mnKXEIMeIIAzZ+Oz68PYkhLZNHBzBWcddqA6ncYKDe7p44la6V
         9bQ61UF34fFve413xeQaNnfR3hcQNgbrnJSYD+D9fnkzGJogwolkT5Ahk75Sim32wgFQ
         La1L3cYpknohbmhc7XWYk5WtQUsucjh1e55Jn9aqiv0PM3ROXkRvv7zdHJCZvslhe7dU
         1hy9f23xiNlGqd2CbiTgKzY/81B+cEdEFam5tivLMedBxzXeZObtgmyohFD6JR6kuX4W
         ui5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=pXhAlccm4h9RFmY+kqNdrQZ6Dg9w9EpuMM6TgSFOYO8=;
        b=vIDc3C6Q6PyrpuBzrfDO58vdOaHu+BmWlJi9AvPD4MJW0gFsNY7AhWyoQKFKXuisc6
         /8QLgMgL6Oq7AYo5wz9M2/+sUDE9fzbsLr60th92MUbWHttmpp6zDjUGg9i9xNO0FU5A
         0MWhyQVP2Eqj591omtdbMh2nLYX1WRIzBo71YfQSKNjyKYytZzroB4XpBo9CcMyRp6Cl
         KndkHBpVJ98KP3E5hVj9RiJKEGv8cmbrL+zc15IQeutxGLQbQFWHZklazOs7g831ZbIQ
         dkXx0/FaKpvRGXaE579RiH3fN8kF8juMAdXuiv2fkfel3eNFPmeJbJDmXSfUlwaDlnVz
         JYGg==
X-Gm-Message-State: ACrzQf3+tabnj6GlF/GRL5JFxcv28aSzBBHe3ec6BKyW69Aekv3AtbTz
        9PXTtV6loo/CmdSdQaCF4BwWkHX1sfqL/g==
X-Google-Smtp-Source: AMsMyM7IS7oYfqkpuEM7weRPWS2xnr2Tq0US0hb9WIZrYeoAh4u4nixwSECsQE2xO365FvEW9YzS4w==
X-Received: by 2002:a05:6214:260b:b0:4af:b18a:b30c with SMTP id gu11-20020a056214260b00b004afb18ab30cmr3487469qvb.116.1664491945015;
        Thu, 29 Sep 2022 15:52:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.250.166])
        by smtp.gmail.com with ESMTPSA id x17-20020a05620a259100b006ce5ba64e30sm648124qko.136.2022.09.29.15.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 15:52:24 -0700 (PDT)
Message-ID: <633621a8.050a0220.2a32e.1d8f@mx.google.com>
Date:   Thu, 29 Sep 2022 15:52:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0840468044612616690=="
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

--===============0840468044612616690==
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


--===============0840468044612616690==--
