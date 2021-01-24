Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC40DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Jan 2021 08:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8372C22C9D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Jan 2021 08:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbhAXIn3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Jan 2021 03:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbhAXInW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Jan 2021 03:43:22 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A37DC061573
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jan 2021 00:42:42 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id x81so6841444qkb.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jan 2021 00:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=taEWJJyWJyZx8rbXKxxdh3Oq3vnA5E7IUJ4lTnx3UDs=;
        b=qk0yjKS3fvv/kR2XTbRP+/mkEeNb36F0k8+r+mRb7crjw+AaiIkvDl3RpL+VHcNSMZ
         rcJRt5eheOqbIcfXyly+elhpuFCYssAZ6lI75SJm0SigXREM9dODnRjoYvnTStv8pOIY
         rdoBQ1ssRwycVYlnrU5JxRF0fvO+XuXw6MFY0I+PRQnIUcT7bBjtABRte58hiMUvWSFD
         U+2jIANoDiYZJC6P6JkmMm3fsQDMITnlOIQq/970EskqE5qS4/nosIJB/dAzc1kmY+HU
         7orqtk2lHDlkGziy8ldpOwFV2hcCZQs88GE850i6ptabx/IQ0iaVlrEsOuWPweZVbDmH
         v9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=taEWJJyWJyZx8rbXKxxdh3Oq3vnA5E7IUJ4lTnx3UDs=;
        b=MlQePPO5t16VEbvPpvYZZvGsk/G5mJ9rNifrMKcB862AfUWlkl1qYg5SQEOXqyoupl
         aI/x4yuErK521bCsIgQpHf3G/+DKNtvJxPrFlYDUya2ICbGF6Np+Mbv3ALxRr02GxbX8
         QOHpHlk+bZEgjG9AWXJnHyt6pr2RDIOLwfRJRTczZBasS4Z69Y9JLCAiNwvoQPf5p43v
         c/JEXy4YHUPvbuMNH6vNomNdwVKDVEJF3I/ZJRJ7Rw6cWgQyL9Gb/MS9AOH3GcsnKcuG
         FcdWz/UP0umWep8wBpChduEEBgW/0cM51vkf+KSAe1+Nw7WJcLUhKiDUYtFqpxTYgjCd
         kQtg==
X-Gm-Message-State: AOAM53322J1M+yJzwBkfUumHO5qz7e3NWvIfIA0FIbXOAWW1lyBmKj6y
        BkKYNXrBMEdLfSZW+R0mxtXgNeupt3wMuTwBQcdvuP7ouSp2
X-Google-Smtp-Source: ABdhPJyqvbYxGpRYK5qRMGOQKXETfF3obY7/ZMh53de/PdXyqGnh8a7sRhOv0gS5iXSK2mlkz24gLkVfGxACkkdnVdY=
X-Received: by 2002:a37:8204:: with SMTP id e4mr108966qkd.351.1611477761481;
 Sun, 24 Jan 2021 00:42:41 -0800 (PST)
MIME-Version: 1.0
From:   Kenny Bian <kennybian@gmail.com>
Date:   Sun, 24 Jan 2021 00:42:30 -0800
Message-ID: <CAC9s0NazfjTcapy52XSdJSKSmoAQmBom_JTfgROKRkVmAbaMDg@mail.gmail.com>
Subject: How to add "Service Changed Indication"
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

We implemented a GATT server on Linux in Python. The code is based on
the code sample(https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-gatt-server).
The BlueZ version is 5.48. But we found a problem. The cached data in
/var/lib/bluetooth caused the mobile app to crash if some
characteristics are changed. After some research, we found "Under BLE
standard 'Generic Attribute'(0x1801), there is a Characteristic
'Service Changed' (0x2A05) with 'indicate' property", see
https://github.com/espressif/esp-idf/issues/1777.

The questions we have:
How to enable the "Service Changed Indication"(0x2A05) in the
bluetooth? Is there any code example in Python?

Thanks in advance!
