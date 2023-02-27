Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90250C64ED6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Feb 2023 00:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjB0A6T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Feb 2023 19:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjB0A6S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Feb 2023 19:58:18 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB897EDF
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Feb 2023 16:58:17 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id t129so1950919iof.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Feb 2023 16:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677459496;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lA+VYdG+c5P9xbLSY6HfBAxBRH87Q3X97bCv0nhDB8c=;
        b=HBDn7N2a0L3pTkVwT68sY8EoSW+KSHnBoxQ0Dh3Gc/rlOTjSdnSVqD8wZv3yB3HaNx
         QJ+OtGtgdqkjF96sAjQimpTnFUisZ7dluwP4FGr0CFfZiZcTk8TNaaTuSMbkhQb0CdtD
         g912KYnNX1r/Zxih3d6YA9PzFxbOixdIfOD7ezQtnVF79ormOIhL8scZgL+jzahvPPYz
         T67Tb7FzIHh7gqsL1b4fkcI4u6eDdxTiAEcsSid5jY3TRhKqW3iLPtQuzNKW5VyDCouc
         iyxAj+uD+P9wso+oO0Ju3Y8ESkLxj79b9hHGxvqaLhr8cPt/qtUPHwqZoAc5OR7DHk8c
         Ysiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677459496;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lA+VYdG+c5P9xbLSY6HfBAxBRH87Q3X97bCv0nhDB8c=;
        b=OvLM+d1EiFVNrMTVIZP95ddgOuIwN2fdRd+RSZBRlsEFnUS+IFR0MlBaInz7+JqK5W
         jAE0zyzR75OrpQhhCLmwu+7tlRi5FUDicXlRI8o5cVm8LAAB034ndvpDY9XaZW0/wvbV
         QwwzlKH9u1G5TibyaxNMka6pLGSKSxbKzgr2WlfGP3trFHLRc7FYlSIjzNkDLZV0qLkb
         u7WJ0Hhw78l8Q0JZ+iJcuXQgcZbxrQs3iRHLIT8h8XzRwYxClAzGZ/r3D5H5yvMCLUKj
         GdayroCtuoO+8pQ/2iOw8yJq2bFDjvQAEgTNHaeu8Y9iTw5OC34SRJrd/X/sdeInAHnE
         xaGg==
X-Gm-Message-State: AO0yUKValI5+XKlGIIxiXnAcNhm7RO8WTqYyT6uIUeq4wYpigDELjL5W
        fvCq/Kl+d/zxxxIadIpKGf3/kpifwCU=
X-Google-Smtp-Source: AK7set+WNlXlu1P6J9Bs17QAMAHWyU0liv0FD/THDyZ6+NzfusAKlZCYiSuGZpedtwzNGcXJ89XHmQ==
X-Received: by 2002:a5d:891a:0:b0:722:b5a6:bde5 with SMTP id b26-20020a5d891a000000b00722b5a6bde5mr12605124ion.21.1677459496598;
        Sun, 26 Feb 2023 16:58:16 -0800 (PST)
Received: from [172.17.0.2] ([40.122.243.80])
        by smtp.gmail.com with ESMTPSA id g23-20020a02bb97000000b003a58ae912aasm1761467jan.28.2023.02.26.16.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 16:58:16 -0800 (PST)
Message-ID: <63fc0028.020a0220.60079.29cf@mx.google.com>
Date:   Sun, 26 Feb 2023 16:58:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2656672664414020672=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bugzilla-daemon@kernel.org
Subject: RE: [Bug,215167] Bluetooth: hci0: command 0xfc05 tx timeout
In-Reply-To: <bug-215167-62941-74zOg38pG8@https.bugzilla.kernel.org/>
References: <bug-215167-62941-74zOg38pG8@https.bugzilla.kernel.org/>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2656672664414020672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:901
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2656672664414020672==--
