Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7480CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 19:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242663AbiCBTBk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 14:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbiCBTBj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 14:01:39 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC1647056
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 11:00:55 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id n185so2092352qke.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 11:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=pq38HuAc4Esqla2wpSGIWmG6q8Y45SuA10jvEHLWEK8=;
        b=bSKXgL0Bn7UR1Y98jwiH3FdcjnQ7QQkkwUPg8AbU9xeU61cGC7wKQQhViW+OyutZs7
         IbKF7GaLVkbIWqOqpGDGUN4+mAvf5bs3lJ4jq/YnG43+k3pPsLTWlMcglBby3tOwYKLc
         JgqZRbB0A4rWf7ZW5yXgt7W7E6W2o59Pq4xOsXDdBXO/LPYGjVn5wWh5evvitJTzm7v6
         2fYMrkZKPv7DDG/QJZvgHo9e5VGSw9a0KZdDH34NhZGhu3GH3/1gt2YohYxHdri2wyd3
         7aJkNyWAGU7K3nvbilXHqWsiMmjsqBtN4+sdSJVwdGjC7SeWMsmgnLkPpsLwjPXngIjr
         iHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=pq38HuAc4Esqla2wpSGIWmG6q8Y45SuA10jvEHLWEK8=;
        b=O8W2sdLPDw6C+JyqXF/T1rWjNzeKgX1yHnpmJJzXZFpxe8E1v5nYZ6GXV1T/UHhfaU
         nCUIfEsf571GTFJqWMbY+IEMtYc+Vuk07Bx/b7I90tLp6dZcisDB+eje3vDrVvQVXKpG
         Z4ppK/dwHYUvwzB4DUVosH4Bq6vKIKdzA0ecS57hdPeWAxsKwGB4N0TdoUTDMNHC3g+r
         Cf3yBqhpQV8BQ3UWm4e4gjll5/Sk906hHLE1em2htTakXw6laRmTvCGNHiwJWioSnV9y
         VE8eK+9kwg0aezuDz4JC2CDzH4nW/5tfAdmELKYRdzhV44tSebw9oOWCzKgMgSWEzuIs
         4pKQ==
X-Gm-Message-State: AOAM532A9xjF9qGtjCflt1BU2zKOzRV3KN9yw7hYLEcA0lL4h27vX3Ae
        PZ3TZC6j7B6i/XBWT3ouY4ljYGFzy+Q+4g==
X-Google-Smtp-Source: ABdhPJxe/KZuxeC8KFO9r/xAZBM8fY8M2ajqyFrdKOxQpBUTkujq455EuKQ/sfPR50IyqmrrekOKMA==
X-Received: by 2002:a37:9d17:0:b0:5e9:6598:df83 with SMTP id g23-20020a379d17000000b005e96598df83mr16762495qke.319.1646247654848;
        Wed, 02 Mar 2022 11:00:54 -0800 (PST)
Received: from [172.17.0.2] ([52.179.13.33])
        by smtp.gmail.com with ESMTPSA id w9-20020a05620a148900b005f188f755adsm8435498qkj.32.2022.03.02.11.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:00:54 -0800 (PST)
Message-ID: <621fbee6.1c69fb81.3c4d3.d50a@mx.google.com>
Date:   Wed, 02 Mar 2022 11:00:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8037587361754530135=="
MIME-Version: 1.0
Subject: RE: [v2] bluetooth: hci_event: don't print an error on vendor events
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, caleb.connolly@linaro.org
In-Reply-To: <20220302183515.448334-1-caleb.connolly@linaro.org>
References: <20220302183515.448334-1-caleb.connolly@linaro.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8037587361754530135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: net/bluetooth/hci_event.c:6822
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8037587361754530135==--
