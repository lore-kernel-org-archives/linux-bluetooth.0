Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F77C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Nov 2022 13:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbiKWN2P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Nov 2022 08:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbiKWN1d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Nov 2022 08:27:33 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8602C689C
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Nov 2022 05:06:32 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id cz18so5740876qvb.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Nov 2022 05:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hVJ9oDbtziKmBh/RoAxUfq4MF3G45PXs8248DeTJQNk=;
        b=fhJsrqbGBCd2Mc0FAvX7opzmfIa3TEwpmhPM/tbAlSNXSwQ21Mp3o8YVszY0uaLJJE
         oMRDq0rRejgoUZscvh01jfdhjI334nHyohD7UppD0HlvbaynH0TOrUdHISjuYXU7PSfR
         jrERJaASPmjTDS/gsQiuZGvEhd+hJxvlngCVruMh8XsfR2+aAnOVuHmgpZwP6nmfhPKY
         lg+atHwwGzQTv5sbWiKgCW7eAC/O7ssTfZdNX3cSslv2K9QPSvU0r9dQ0FR4BEUMpyjh
         lq+9QzazaTrd5nmQm+IBE8QfMwWv7c4IrdkZf46gIrbaBHtfFHDU8ag5nPT6Qr5P99L9
         bB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVJ9oDbtziKmBh/RoAxUfq4MF3G45PXs8248DeTJQNk=;
        b=hPejsJbbgFbcWE0T6ai6m7I7MmmhUZi/NPHtGI5CeS/RbrIxE+RVJVn4hvO/XpFEi6
         WkmUZ2norD2RC/cEhuwNDrMNkhlgIkTjuLzUj2Yk5PS23Ii0gisuQHfrY2rOJyBsWSbR
         Gt+ubc6EJu4jzCQVvaazXC5iyLH+vadRG+GMxX+YdPwJma5Wk8mwFl8gobiHsYpt03UT
         ewMngrb8wwc2n1PpA8xAxeOu8tvvCgPkxqj5sLarl7s6OG8IWnSply+1lWKFE6frkp8e
         A57tEwiPr4IlTdhqD+g7tBUW6UN4PMET6pA5RoOIyqP3lhL4OZiPtBiYkiXXikMWl4wn
         LEzA==
X-Gm-Message-State: ANoB5pkjojZnQEJ08yqQaGPc3CBAbMcKijbEgTppfN+u3DAWm1d4Rpnf
        0QUJZcvbb0zrFKrtyNduvLeQB99jZng=
X-Google-Smtp-Source: AA0mqf4lexbg1izfsElnG+hSJ6/5WwP4kKgvlU03ky49tg6NrybY8TtARdZfd/yrWgadH9sJ93vxww==
X-Received: by 2002:a05:6214:3701:b0:4c6:af10:5e78 with SMTP id np1-20020a056214370100b004c6af105e78mr8016245qvb.125.1669208791749;
        Wed, 23 Nov 2022 05:06:31 -0800 (PST)
Received: from [172.17.0.2] ([20.1.188.139])
        by smtp.gmail.com with ESMTPSA id bn4-20020a05622a1dc400b003a62dcf09f0sm8405228qtb.6.2022.11.23.05.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:06:31 -0800 (PST)
Message-ID: <637e1ad7.050a0220.709e9.c916@mx.google.com>
Date:   Wed, 23 Nov 2022 05:06:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0814703345906044417=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v3,1/2] Bluetooth: Add hci_nxp to hci_uart module to support NXP BT chipsets
In-Reply-To: <1669207413-9637-1-git-send-email-neeraj.sanjaykale@nxp.com>
References: <1669207413-9637-1-git-send-email-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0814703345906044417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: tools/btattach.c: does not exist in index
error: tools/hciattach.h: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0814703345906044417==--
