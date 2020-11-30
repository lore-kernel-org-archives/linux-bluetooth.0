Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314EFC64E8A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 06:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4FFC20809
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 06:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh6SXdgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgK3GCE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 01:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgK3GCE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 01:02:04 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD7CC0613CF
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Nov 2020 22:01:23 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id q1so10163442ilt.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Nov 2020 22:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ty59jj7C7qRXga/b0QRLCg7wLniQmk8BW28HTTGm3Xc=;
        b=nh6SXdgpzYxO0jEhbjqOowkc4uPDnqc/qcKjC0vodPmXSZ5NHbvW7p9I7OSLMaZ57u
         tpwJjD70pBKrJ9AgPJR2ZF5uyG5rql8vnDZN5yKLKZqAUxGXPThb8ki1QPxPaMofc+ag
         Zl66IOQKR0iGg810E9QTOpiZYlEt0fDbaz3k6CZNuWa3qrNuotH7Ki5Bh1Qj1eZJBRlK
         lmw9S//wfsmHM+mgrVTWZKw+w5456xQFxnOtlED5wLyBi/8wxF0qJV0H9uTJBaJm1jMQ
         pLbAQ54fsicGCeZBruBo8gLkD1YdDDwS/LMjUg1acLjCryoY8Tr28s4vKtR2/C17Ot48
         9n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ty59jj7C7qRXga/b0QRLCg7wLniQmk8BW28HTTGm3Xc=;
        b=ZIGACy8S7kdpUeQj7Xw8DVgZXpOgHnYK4pN9SN9MzVqoaJ0N7/JcLFoWKJLARm/IUE
         A2yBejSQrIIJCT4DRnZRhhP8GsZ0BL0zXSPIvW7EJLwVuXTa2AjUoc4HAWNo8yLENlet
         nuTabOip9WafPZAStKM0LQOiB+ISOPuN7CumFbp+lkNi4rQ+RXZWXsSMI4+BBrWKGoWc
         q6B20guGedXvA/KQwIwFyXW3Z8gIXwMJwBZApZEjRG74VS/CJJLDsnKpqOZE3vkeE/yD
         1ZGpKX4Z0Q6ji4eEtGaTGDiz2nI0TYeUZlvYK/6Dd/Tvn1wpGIQ10GxT+iBukPD57jbm
         Gh8g==
X-Gm-Message-State: AOAM532Xp5T4L4Llx7UL4OVefWCO1OsZnKkvSNO79Gwuhem6lF8rEAIJ
        SzOzpaCEdrJlqGHyJaBH5ofacvrYhok=
X-Google-Smtp-Source: ABdhPJyyCmWqPpesyfprMQNN6kIrHeR1epH8prChJD+4a+18lBr0qTdz/SyYIG966kzlcARoIEqAPA==
X-Received: by 2002:a05:6e02:f43:: with SMTP id y3mr16378416ilj.187.1606716080373;
        Sun, 29 Nov 2020 22:01:20 -0800 (PST)
Received: from [172.17.0.2] ([52.232.185.233])
        by smtp.gmail.com with ESMTPSA id l78sm10606580ild.30.2020.11.29.22.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 22:01:20 -0800 (PST)
Message-ID: <5fc48ab0.1c69fb81.2c76a.32d5@mx.google.com>
Date:   Sun, 29 Nov 2020 22:01:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2617690716192384139=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hui.wang@canonical.com
Subject: RE: Bluetooth: btusb: Add a parameter to load fw forcibly for Intel BT
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201130052753.111742-1-hui.wang@canonical.com>
References: <20201130052753.111742-1-hui.wang@canonical.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2617690716192384139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=393001

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============2617690716192384139==--
