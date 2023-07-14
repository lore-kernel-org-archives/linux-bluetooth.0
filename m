Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DADEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jul 2023 16:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbjGNQQp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jul 2023 12:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjGNQQp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jul 2023 12:16:45 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7121B5
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 09:16:44 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-767feb71282so139197785a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689351403; x=1691943403;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JyWLc+/VqcheBku7c3fDu0ZOvJhTaDkfavSYMjGqy5Q=;
        b=XpMPxrBsHQ6CVyttgE5G35EHRO3D9mQleiyZd4XOE5bsF78Tqx4BPxpUVMc7H/35Qw
         6f4mvFWG3dZdEAnZ5kviavezLxrHkg2LYn+vD0odqHMIqHiR0xIpWHB0TpXyqM0h9E8L
         6S6aC/p/tbTv1LydhGYLHR6eih3IcN4dKArKo1YT8RmL/5khk2zGPkKFGMj+JX7XfcRu
         EXF8M0qQbVIV7+E1eyaunIVQM9mf8WKYrwnfoKnHijX2vUg8Io+QCPrwsHmCD1tZ/xGa
         mC9L59QbauzMoBN/dtH25xxriyLR07G5V6DLDtkjqhtHuX1BJVYfWCVr/GZvCSpI9YAH
         JRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689351403; x=1691943403;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyWLc+/VqcheBku7c3fDu0ZOvJhTaDkfavSYMjGqy5Q=;
        b=b7m5fFJjbsY9x5JVGJgxc7lub8KCMB96PlSRwCY0m5muNHs3J2QqzbTAupq/L0vkxr
         PUj6sb/NW6LmoEcYeJcTMcXPYxUUXt8JWr8BnCyS4FRQhzSHEf9SoV14+rhLFL/hHOOf
         5CTVhOaEOvm+bW10MZ+C3NHAuDuGsUnlqjy4Euuzr78G8i3dl3RnALns6UKQy780ylAQ
         /XPeaiymC4zyFzBDbFBPhuEBqt6kb1exgIpQs45AzVyb2/paSj3K9IvVtRfJI49bjcbX
         c1M8+VPAsIoHDciyEtHF+gdf+oY5AhxdmlXexLb9+LvuAf5XFM/U1sGhsnLEB6LwFu8R
         X2PQ==
X-Gm-Message-State: ABy/qLZSBQ2bc5oTyqFZ7BC2eI6M4bDlP+RDzYocB0Zj6znUgchEyVVX
        xEMDJTKN07aV393QCKfWN8JnNTlIsbt9Fg==
X-Google-Smtp-Source: APBJJlGYhF8Y8gPTj7gIMqCdGxV4mrlxjRt1gD534r2gH+/J4DDE12IkvRz5qfOLhNGSOZzSBiCkzA==
X-Received: by 2002:a05:620a:4720:b0:767:26ad:bb19 with SMTP id bs32-20020a05620a472000b0076726adbb19mr6581564qkb.66.1689351403254;
        Fri, 14 Jul 2023 09:16:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.24.94])
        by smtp.gmail.com with ESMTPSA id cx18-20020a05620a51d200b007678973eaa1sm3906148qkb.127.2023.07.14.09.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 09:16:42 -0700 (PDT)
Message-ID: <64b174ea.050a0220.4a237.f0ab@mx.google.com>
Date:   Fri, 14 Jul 2023 09:16:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1769894430976982735=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, joeyli.kernel@gmail.com
Subject: RE: Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO
In-Reply-To: <20230714160854.20562-1-jlee@suse.com>
References: <20230714160854.20562-1-jlee@suse.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1769894430976982735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_ldisc.c:770
error: drivers/bluetooth/hci_ldisc.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1769894430976982735==--
