Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A15C6FA8F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Aug 2023 11:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjH2LLf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Aug 2023 07:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjH2LLa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Aug 2023 07:11:30 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE2BEA
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Aug 2023 04:11:27 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7950fac19f2so17060139f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Aug 2023 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693307487; x=1693912287;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gSLDz4+qu/5PtHBiw2R/8FFOa2T0IxKQ9Gnk/1h6DKk=;
        b=pvO9hbmyCOuBbtv8vVNXp70r54Q6+QoiYu8PZ5BKt1osWT6+5NR69O64A1wHp111iE
         iaU+KVXVpBpssTwcqpya01zuPW5XxWfVVYU0ZeiUNdLzU8xR+E390qrr/i16O7RzI+F8
         qhc2SBGkp/y9QD7lSryNo6jHserwCNDkD23obG907jwPN+DQ0A02hb5zIJQ8v1u1Xyue
         KEbWwAMHYzJMkbfwUGgFy3Awh8C90kzvHyPeRfG/6ZCE2WfC6FrXW4h751SCd3vaeNyC
         LgdNBWWX/8x2nyZVUMkPrZs8DVQDu7759/Q5atC4R8KwXZsV6E6YXG/ONFaeZnfZv1O0
         Kdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693307487; x=1693912287;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSLDz4+qu/5PtHBiw2R/8FFOa2T0IxKQ9Gnk/1h6DKk=;
        b=PO81d+XyLyRAOIuOP7lQbuEPqzXsPhgIVSzAUqTX5ERNkdaPfeknvSNVwIIf0wL8kq
         8kSOi3WwzOtcdaoY0dRgsGcWxg92cl1xfV/0ZT/ny5EELksM+5lZ4OwTA3GYStS7Byt7
         /A/o5I/0RvpF1F0esx3Lm9nVsABfJrs91NcpkOZAoDxVmnEnzKQLRJZy+0AlhXeiSZPv
         vIkMZSZ1MO9/Bc6JVg5qFc9LYSEjPDprZzPLWUJgNYjKDq9RiHAiLSRq6nQeTfpuWoK6
         qFMQnZ3GcxqAcyHIyciOkxkym+HxSetGodJRoiHo1lTMieKN3GQyHKqV2Ms9Krl+58PQ
         kfiQ==
X-Gm-Message-State: AOJu0YyYt1JQ34t5xpv2w7MFRS4eUgWRU9fOe/ntTzrZ5fXITSlwlrZn
        Fjd8fWmUAicwklTRrPR966EMzYjcnJE=
X-Google-Smtp-Source: AGHT+IE+5/pBS1DTiGXvm2RVxPi/auuekXps+RgQU9u0/5Oj54Bep0cXGt/Ov8D2m1SayNMcseqfPQ==
X-Received: by 2002:a6b:fe03:0:b0:794:ed2b:2520 with SMTP id x3-20020a6bfe03000000b00794ed2b2520mr3793470ioh.15.1693307487151;
        Tue, 29 Aug 2023 04:11:27 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.3.145])
        by smtp.gmail.com with ESMTPSA id c11-20020a02c9cb000000b0042b2501485csm2929114jap.111.2023.08.29.04.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 04:11:26 -0700 (PDT)
Message-ID: <64edd25e.020a0220.7b7f2.337f@mx.google.com>
Date:   Tue, 29 Aug 2023 04:11:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3507839075349713087=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vijay.satija@intel.com
Subject: RE: [v1] Bluetooth: btusb: Add support for Intel Misty Peak - 8087:0038
In-Reply-To: <20230829165501.9277-1-vijay.satija@intel.com>
References: <20230829165501.9277-1-vijay.satija@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3507839075349713087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:476
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3507839075349713087==--
