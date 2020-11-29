Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C64C3E8C5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Nov 2020 05:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2019207CD
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Nov 2020 05:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbKMp4jz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgK2F3h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Nov 2020 00:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2F3g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Nov 2020 00:29:36 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C33EC0613D1
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Nov 2020 21:28:56 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id p12so4146147qvj.13
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Nov 2020 21:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6ouxMPVlzqHXz1h76nMEJw/0jwgr2iYUlfxi99I2bxE=;
        b=ZbKMp4jzKaA9cSuyV6PtAeu3c758o2qfU9CfSuN8q7sJCFkrOalrkvlOk/e7A5QprU
         gp5AzKV6J6aJtBtF0lj2he2aQWW4KyXvPHQaLHb8TwUEUWqYtSb1CGAUyA49VfH74ASG
         VS2RUrMV4vOHmZk2RiB+yU3S4JnZUMUJLfGuYmouGkBahtsgkGc4ZT7B1BJy1hFiWUw8
         ltObAGfyyEC2VYn6vXgMn3Tlrl9TJbGVJO2wVmSZQIimaeSItwXgCNupH2uTkJd8kOAm
         0mPfbdkzvsIFtTvB0bUlgFD5oG3WqTjqivZW6XQjWbrDTtIdAQAMoccXOtVp7Yxl9kr+
         O9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6ouxMPVlzqHXz1h76nMEJw/0jwgr2iYUlfxi99I2bxE=;
        b=UIm+RsusBe/bpOFelosI2sm8jJm9XAp1/MTKsPIE4ZSOeHwvkIy0kyY5sEJtBDwzjv
         2dl+kMbUmmS/NVcN2oFnpVokOtFJFV5TJtrDHQc7LzgAc0hpfO1RG1aHl6Tvab4yjyW2
         Sct8yQQaPIy2EDdbVtPNM6EL/hffHDaMHab2ESEXlg8JLXFLDFwYzZv3gARMMTNhT/SL
         YyEXsCou4RCcER5GCgxgMxDfSeysR31sVjMmxhKmXO1jgMQ3nNQ88vLAvQLkNyIQrtdz
         vaJNOKWUETTdOMs7hWdE3T6rhScNs4T0KbvuzrsKOgdtBaOOWc7jC9jhekMa8ZoMfCU/
         te5A==
X-Gm-Message-State: AOAM530ZiVd4i4CjaxPNE+369jhCC/913JkT4zK95KuBrlzW+dTOuHzc
        STJxKIQgnZ9jQq78ZOFV3+IP468I8Hkz3Q==
X-Google-Smtp-Source: ABdhPJwg5JoF0Gx7dkTLvbu6vOrzrlN3EFQ4osmv+zgCvkOxWT9/J+WCCg2g5GzZ9S1I/g0x3XypxQ==
X-Received: by 2002:a05:6214:1848:: with SMTP id d8mr15580868qvy.7.1606627735275;
        Sat, 28 Nov 2020 21:28:55 -0800 (PST)
Received: from [172.17.0.2] ([40.75.118.157])
        by smtp.gmail.com with ESMTPSA id l28sm10561613qkl.7.2020.11.28.21.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 21:28:54 -0800 (PST)
Message-ID: <5fc33196.1c69fb81.48c65.cf02@mx.google.com>
Date:   Sat, 28 Nov 2020 21:28:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2645447628619850260=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] mesh: Fix check for mkdir return value
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201129051838.82091-1-inga.stotland@intel.com>
References: <20201129051838.82091-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2645447628619850260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=392789

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============2645447628619850260==--
