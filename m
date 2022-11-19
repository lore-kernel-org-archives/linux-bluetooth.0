Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E3CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 21:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiKSVOQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 16:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiKSVOO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 16:14:14 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3EB110E
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Nov 2022 13:14:13 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id n205so9011417oib.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Nov 2022 13:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XGYVq4Vz3dLa5WPP771mzGFYAB5BPt60SIm2ijjZaqQ=;
        b=CCyZSLqZzCnfEbHQRc9i7XAg70dxHDURlKvUeWH2Q7tjxkI1GkOMSz/+4Yp2M/BgRC
         nLIS18G75iC8ZVGSAQu/l3/guxjS7XfYKOh1efrPbc5rrTXesJZyGSRv6Y0UKjmhdrzU
         B3S6R5jP8vslT97MWvrkV7JFJm4Mus28hfFiw+qi5VHKPDrSF1+uM40o/CPhEIyMPZHn
         RzwFv0QQCR/iuwiPGmnAnP4ki0a5uhha4bv28UJC28xm51ryYcHjP7JUJ7oX0ZrLStiE
         4Nuo+v9279RtC3ORPC2RUoswil48wDmvL50sA/LSKdafjPbv7Vr+vjsuHtJ4Q+XfJ4Vu
         8NKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGYVq4Vz3dLa5WPP771mzGFYAB5BPt60SIm2ijjZaqQ=;
        b=eiKoxJYaxj1+iDRk51Zuj4k6Tssj1l0wZgxYdeIvDgla8OsWAVYaX5KVij+ZPZThHu
         xRO7KqcGJPb2x6hJX4JHzQozUDCygj4lUW4qecODYlHfYDX6aitq5pqHHYPq/JbTWh/K
         aQfCqb0gCg53dnudLdjQbPA56nLPXMzuzvBepmrRoQIGU6BwJy21Kj6PqlKyqZoEi0W9
         wrzJeK2CMOY82TgrQ+/E1ztq+Qj11vQD4Q4VfYwC1cxh4BWXvtQ8JsoOsf4HNchm0qUN
         42HJjSMml/mEGqj7QWtBphPIA7BKaQZLRGJIyjowQ2jhgBL6l8ffTLVHHUIcffb8TVrc
         8Thg==
X-Gm-Message-State: ANoB5pk3xl/rZq2ZNyooTZ5/gZFBeYOXz2zDkOjfBocwWExFUgz3QgC1
        RCQD/vyKy0LD/1XowKiIs1qEbEY6CzQ=
X-Google-Smtp-Source: AA0mqf52ZD4yGtjDCSvrVe5Hnsq+flmecwM9fdiOL1pk57fju70ulXtNstkE94KykmJHh8LizgoYsQ==
X-Received: by 2002:a05:6808:648:b0:35a:1139:37fb with SMTP id z8-20020a056808064800b0035a113937fbmr9365100oih.158.1668892452988;
        Sat, 19 Nov 2022 13:14:12 -0800 (PST)
Received: from [172.17.0.2] ([13.66.10.160])
        by smtp.gmail.com with ESMTPSA id r1-20020a4ae5c1000000b004968311a31asm2717837oov.39.2022.11.19.13.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 13:14:12 -0800 (PST)
Message-ID: <63794724.4a0a0220.a3b3c.b534@mx.google.com>
Date:   Sat, 19 Nov 2022 13:14:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1190448233636200341=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, drv@mailo.com
Subject: RE: [RESEND] Bluetooth: hci_conn: Use kzalloc for kmalloc+memset
In-Reply-To: <Y3lCNjPGoVJT9Y35@qemulion>
References: <Y3lCNjPGoVJT9Y35@qemulion>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1190448233636200341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_conn.c:824
error: net/bluetooth/hci_conn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1190448233636200341==--
