Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACD0C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 19:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357627AbiFNTA1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357869AbiFNTAL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 15:00:11 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912CF4A91F
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 11:53:24 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x18so6780722qtj.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=PAn+Kc0LFHIf71uX7yKin8Eax5Gq3W6bCIHSgnsFmks=;
        b=CzYZ6B/TimH58ew89JxBHBBssGu3ZAVqT20N1h0VAE3j+4VPoLEWla0HHtpHy98Qnu
         dUrrBbG24HmS/sZHXr1WE9bzdXoSQJcd8YMlj4Lw3mogM3ko9/ebC7GZVtpBYAQ4LUbl
         Bs71rt8FoKeen/W/N/oNGfsQ8vKrGcRYvxWkIWfbMW72LoKvZXEAIHAUpkfY2/dsx1wU
         5CyDGL8N/9AtNb2LgP0rQd7eNUEgmm3RDbKx0beRQtxjVBxHDCBe0U+0xeTv/Oc1do5+
         OXxaT/nNOc88tX9FQExhbXY/9h8W2X7B6E+bXPFaIgk0Jn9W5s2n4vfDipobwBL91QV1
         Kh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=PAn+Kc0LFHIf71uX7yKin8Eax5Gq3W6bCIHSgnsFmks=;
        b=dGGSAhPoEIejCPJOCllwEPLLlRj7/DzpE+C2gl6deoc/PFPIh/OWs9PhqA30xhxcpK
         RSzTj/5qOPUh5ZismL/s3tc6ZRYhvE6XyvwkBWpA/782Qnoekgw9JjLFzzGYIpJ6ri+R
         b3Bt5Bp9Dta0EYoj6K6paxIS9YguQhmzAtzTn+arzd3dsAq8k75BngOyQ//Tz1+p8dxR
         duOK4upQ5wnQkySGi0sZewiWTGyQHS2IxdrsFQhJ9aMNL4aCzkvsuWDHFWbFujy+lCyT
         l1gjxwfOvbeCUoOu/cdmkAGTjzp8wgi6Dk6B/ZNYEcXzIAFooNYH9inGT3/BuR8Ty7EL
         FIFQ==
X-Gm-Message-State: AOAM531daSPNvEBfx6cQMc92OTLFnroY5Ojm+dohPTuITr+Flv3j6A61
        EdcEjzeiaxdVVjsshnvj0ie5Vg7/+F8=
X-Google-Smtp-Source: ABdhPJx/0V6MzGz8AkFwRU4eJzM0gkMKswfDnlR1SLko5x7tmVscAWK5lHanh3Hl+fqioxbOQ/QZ7Q==
X-Received: by 2002:a05:622a:1994:b0:304:f463:148c with SMTP id u20-20020a05622a199400b00304f463148cmr5451547qtc.358.1655232803542;
        Tue, 14 Jun 2022 11:53:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.65.53.189])
        by smtp.gmail.com with ESMTPSA id y18-20020ac85f52000000b003050bd1f7c9sm8004787qta.76.2022.06.14.11.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 11:53:23 -0700 (PDT)
Message-ID: <62a8d923.1c69fb81.7be7c.e3a9@mx.google.com>
Date:   Tue, 14 Jun 2022 11:53:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8272274052684745175=="
MIME-Version: 1.0
Subject: RE: [v1] Revert "Bluetooth: core: Fix missing power_on work cancel on HCI close"
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.oss.09@gmail.com
In-Reply-To: <20220614181706.26513-1-max.oss.09@gmail.com>
References: <20220614181706.26513-1-max.oss.09@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8272274052684745175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: net/bluetooth/hci_core.c:2675
error: net/bluetooth/hci_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8272274052684745175==--
