Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DEAC433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 14:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA977206FA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 14:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Afr+ZR7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgIAObR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgIAOap (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 10:30:45 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB79C061244
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2020 07:30:43 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id n133so908613qkn.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2020 07:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=zhSxzJ6LF79ywCvIZM4CCFow54C4LxbwybdeH+ffbuY=;
        b=Afr+ZR7Xr3I0ENjZ9INeMJtofyk7AivtXlmK+1Xg5P7MlpUAz6pgt8LzoJlns44t3o
         OUmoFxUh/F61+1nRn4qVZYDqXypzkJWse5h6Ql9rNh8GtJKRRFrI0Y7CxFrL6syNyHys
         BfCvySTtBIpAxsBWf2Y382wyb5bLFLta7q3r7TOjrUrYVcZaG7PCUJBi/78keUgL4iQY
         x7o9YyrUrraS1B/4x75aXOO8yPDJd7YicXDyI9UHdV1fJ46KllqiI2ShsF+oROWqSnVN
         eYWYt+4LEqMJtiDUDQTdwytpDQRTTD66nrpmenVjtwyoH46oJWzKNW+xq5RAaaFTlbTl
         WvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=zhSxzJ6LF79ywCvIZM4CCFow54C4LxbwybdeH+ffbuY=;
        b=BVcYqoeQBrtCWQgL0QeXXLqb0+9VTAJ44w5Nllgiz05KKjPyTSKFwvOdF3sG/6vCfs
         cD0752L55ds9aulav4OnJnUTEW7XKq5If6P62JFENbQdqHJrM3jJmqlc1MDeqrTr9hM1
         /qNbyp9LBwe0MaoMKenCHBHR9ZaZ9oNuOOGQQkjpvJfUde73z8jm6KrZTsdENCeKgmzX
         9QjiljC3ELBfoBrU+BFyNSrzZWHggsMO7OxHkvCQF8JQj6gJIRxg+0FnVegd/g+GbawS
         uUbE3YQSXel+fduGOMJvVpBkK93sAWksG0NbuWU/BKqeRVpJBB/TfB/oYH2k4N2BCV09
         YQAQ==
X-Gm-Message-State: AOAM533AjBKFYCSpnls7ihwwXtGjlXm9Ql3Go9yHxuf5d/zVrQ1jCooz
        YgOQuaf8eeuqAFmZbwn7DiC8B9ohH1hfKA==
X-Google-Smtp-Source: ABdhPJxwQ0A3hNC1qrjRDcR2hb6YTu6fo7tqyKCYatzmLgAwbmeB7K66C9cacvp1Vpmn3G4GaqGPYQ==
X-Received: by 2002:a37:c09:: with SMTP id 9mr2182239qkm.471.1598970640811;
        Tue, 01 Sep 2020 07:30:40 -0700 (PDT)
Received: from [172.17.0.2] ([52.232.245.24])
        by smtp.gmail.com with ESMTPSA id d49sm470816qtc.55.2020.09.01.07.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:30:40 -0700 (PDT)
Message-ID: <5f4e5b10.1c69fb81.e7d6.2030@mx.google.com>
Date:   Tue, 01 Sep 2020 07:30:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4368723395144955242=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, daan@dptechnics.com
Subject: RE: [BlueZ,1/1] Mesh: make SIG model header file locations more consistent
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200901115418.82056-2-daan@dptechnics.com>
References: <20200901115418.82056-2-daan@dptechnics.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4368723395144955242==
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
3: B6 Body message is missing



---
Regards,
Linux Bluetooth

--===============4368723395144955242==--
