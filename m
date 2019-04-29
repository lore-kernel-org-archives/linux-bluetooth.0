Return-Path: <SRS0=fAjn=S7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17FDC43219
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 11:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB09D2087B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Apr 2019 11:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNWuFXF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfD2LOy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:14:54 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46864 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfD2LOy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Apr 2019 07:14:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id d1so8720109edd.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2019 04:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lpXWBHj60MdMKUECcuuJrg9mOkk5zfohqMjzo/gmH9A=;
        b=CNWuFXF4RMJJXiXD1Fr8MI58OOVamqJUPKhY/5jsh1dGBUFsPEzEUVoWbKRKw0+wQN
         Ez4YDZBqj+oAa3FKKzOMeKSFiQIpENBF+cZ42SyN4yu7of8LncMCet2tM2gzMBOdSH7O
         EVsR4fj2g0lQFueCXWe7sY09nSf0H0tg0ER+a102JqC7FiDV7Xu+f1+X52o/pzOamMea
         8JRw/YBOald9krjk0TUad8bp+I2E47HKlAstoUtfCQmQxHXHMeSmWyCPkIGV73UKuLT5
         JorXDKF53jHwC0sRLD5/wU6c4Oi8kjP4+TH9yBIWwGZikTOLjLGMZ1RCU5V7HEx3j/ZJ
         /F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lpXWBHj60MdMKUECcuuJrg9mOkk5zfohqMjzo/gmH9A=;
        b=pEX4eosRGgiTidG5fHTeuNO+1KrxlPn6ibsxlb6ig6G4TveAeZkmogR5s/NHUgLY/3
         aQxwGICGQRjqMcj7cOg8UWvLuHptGBsgOBVHcOR4YAIyRZ1DborsXu4grWWhMUlhNpvq
         +3b/THffWI15tXt83p7fBLI9o4+fXPDFoyupN1rN/kWuMutH8BSB77+hoh8oGpQ9v6cg
         fxgRLBi20BZCzg8AGJVf0KGA/T+4XSc2dO+o8zVeLbw5vj2R++oGn4eO6OU0OMSFi/1o
         efLXRxY7GgeIFoeIeqrzGaFVb5ZRHQXjaw280S6hA8fYRlE2XOWlyfgwlT502b2nOjP5
         Vszw==
X-Gm-Message-State: APjAAAX4HqpXHG4LUvTMmDVA+LtKCht1buTJHu4tDbrnnL+KwJHD4Yd1
        fzfI97gTwWDiD9020YmvbzOnatq5ROw=
X-Google-Smtp-Source: APXvYqy/tnPqAWbfiGNRgR1hHB2PrbsKJu1cuQtXzJacYt5Dw5BvEVkP3qRYmAu+cm+u1U5vyNQKYA==
X-Received: by 2002:a50:f4fb:: with SMTP id v56mr9087620edm.13.1556536491803;
        Mon, 29 Apr 2019 04:14:51 -0700 (PDT)
Received: from bksv-VirtualBox.bkogc.com ([152.115.31.4])
        by smtp.gmail.com with ESMTPSA id s6sm1404786eji.13.2019.04.29.04.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 04:14:51 -0700 (PDT)
From:   Troels Dalsgaard Hoffmeyer <troels.d.hoffmeyer@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Troels Dalsgaard Hoffmeyer <troels.d.hoffmeyer@gmail.com>
Subject: [PATCH Bluez 0/1] advertising: Timeout of 0 should not fire a callback
Date:   Mon, 29 Apr 2019 13:14:40 +0200
Message-Id: <20190429111441.20481-1-troels.d.hoffmeyer@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When an advertisement with a timeout of 0 was registered, the timeout callback was immediately called.
The client received a signal that it was released even though it was still transmitted in the air. This seems unintended

Troels Dalsgaard Hoffmeyer (1):
  advertising: Timeout of 0 should not fire a callback Setting a timeout
    of 0 on an advertisement should let the advertisement run forever.
    The client was released immediately after, although the
    advertisement was still in the air.

 src/advertising.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.17.1

