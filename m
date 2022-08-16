Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C492C2BB41
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 06:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiHPG6U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 02:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiHPG5z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 02:57:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30481D1223
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 20:01:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 17so8017841plj.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 20:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc;
        bh=VWhqx41B8K3u/VpdG+xMlhQp9QmAvjZHRXkCwTDoSFA=;
        b=YYfxgIN+T+wp8Me+oK/GkI2CLciabXbBjcpPzG5zUfRb0yUjP4lTCgZdGUSqF4tdiL
         v54HoJT3o2qVXyqFpiUi7wEla+fulqiap/WdAHd+tqtoKDoii2E7rXHU9zroN6qEtk4w
         8ZRTDAQVXRknm8OZYPw7dhivLgnxNq9VEUyFPQBCWoGLOtKXLm+zJEFbdsjaPcGIehXn
         7/4vcwEuThpe6B/6byGq4FjqOD5dMBa9iiAzXOaDcVgLwxaqNJbKJXe/moCzuzFLLiZI
         yEgZ4d6HVMY13+zh+ZRWeBh8SRyHv4CHQ0NeevrkttqPH/YGg9NHDx+tBDEpfXX+FCzy
         3mQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=VWhqx41B8K3u/VpdG+xMlhQp9QmAvjZHRXkCwTDoSFA=;
        b=HYar+HsOUdSXoCYUNA/c5jGmWyXnppmcvoQbi62Y4oAzbEXVnT64M4sprew+Pg4FhN
         hTrD7wJAuz9a2Y2daY5iYWD7mWkeeCTvVd+iFKFQFV+WwXCDPVJ7nZFegsRt/X758kGS
         6UBITD+rSPBYK54AfGc+vu12tOGzE45Z6AkNlDeN+aWpnixwvQn+Xdm0lWMlkQOE72h2
         dSaRwUW/UFhFmbnerXw8BysTzJonQQyJl6b+JmjCyP37Yo8hBQ6eWV7aSVux+wiEZSrD
         GDNPuqrHjve0WE3JYujOUMr8z3BqUaRcOpQkidcNw2vIeKqu15Awy3hPEqr/AXpV+dwA
         jhHA==
X-Gm-Message-State: ACgBeo0PGZPmwp7rcqNUkzy8ErMGwoCpTZ+H/CwES/kSlaxDnJ6KySZb
        Typ5b0dtOsv7J9ufDXH2vmAXY3g3hXU=
X-Google-Smtp-Source: AA6agR5cE2MNkIBldqeNKUqvKdIVgvTravkyJkNI1ppOsaUEOTPJvHIkhHzPWeZICBG7IjrX7E5URw==
X-Received: by 2002:a17:902:eac2:b0:172:57c5:42f8 with SMTP id p2-20020a170902eac200b0017257c542f8mr15071957pld.139.1660618873783;
        Mon, 15 Aug 2022 20:01:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.247.77])
        by smtp.gmail.com with ESMTPSA id 5-20020a621505000000b0052b6ed5ca40sm7147124pfv.192.2022.08.15.20.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 20:01:13 -0700 (PDT)
Message-ID: <62fb0879.620a0220.4b7cd.bf24@mx.google.com>
Date:   Mon, 15 Aug 2022 20:01:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2356503353565524539=="
MIME-Version: 1.0
Subject: RE: Bluetooth: Move hci_abort_conn to hci_conn.c
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
In-Reply-To: <20220815211349.879531-1-brian.gix@intel.com>
References: <20220815211349.879531-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2356503353565524539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: net/bluetooth/hci_request.c:909
error: net/bluetooth/hci_request.c: patch does not apply
error: patch failed: net/bluetooth/hci_request.h:73
error: net/bluetooth/hci_request.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2356503353565524539==--
