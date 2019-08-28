Return-Path: <SRS0=N1M0=WY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1015C3A5A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Aug 2019 17:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8D022CF8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Aug 2019 17:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfH1Rer (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:34:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51167 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfH1Rer (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Aug 2019 13:34:47 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dan.streetman@canonical.com>)
        id 1i31qH-0004QI-4s
        for linux-bluetooth@vger.kernel.org; Wed, 28 Aug 2019 17:34:45 +0000
Received: by mail-io1-f70.google.com with SMTP id h7so520338ioj.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2019 10:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JDO/ZAWmDwqlIFQKgZ7irqNQBWEkXm9mnlvbokZ/EUI=;
        b=ifoCjQdx1bK/qwCdPDbxKI+9K19Lr9vQCbUYwtKue5JRasXsiXPSDxa8dnRRzwIEFT
         OVL6CEEAiX4xUq7Au7x6hdBfVu7a9dHzz+U1p7hTbrvvZ7GcCDDbbN904G+1e9apSyhX
         uM0alboy0PsOId95RCYwCPEVq9fjDHeEKf/imi+4i1FhZQfwp/tXBoBfy3NsbNrtQQR2
         xce8/jSYF3lptTkPx7r6JX1ooXgQgFH63N+teTETTNJrIGdXiMD6kWMXHxMcxhzQ0ZDh
         S3GI+3+lTejp7TwTqqu/3gOnFPn0HeCoK1HbiAu1GcfzkvOg3R7z3EUrLqssBF8Vm0Mo
         3KbA==
X-Gm-Message-State: APjAAAW9TzFW5ZMrvYkOWwAqMmTB8e0/4TXnTh1ko3NBChgvQ+1hZGMm
        ez9v9SmCajf7wzIQVZ6ODYLFepCh+xEtEDY4J7NryqduvzEwqBgkv7oxRx0r3f4NrnfT+o5Rsdo
        G2u6D3I2wGSjBxbuJVhv6eWJFHLxIF7ZVpme7T9sI/+sTSzVulnUZhNvFugCQVg==
X-Received: by 2002:a5e:a80f:: with SMTP id c15mr2335633ioa.270.1567013683895;
        Wed, 28 Aug 2019 10:34:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwReRHDJzBqbcjCQ9ykmP4NTlw5EHtIzg+irqu6rpg7RNmmuhDExVR/uYQLTliuqctvbpgIOdsecvTgW7hQ7aY=
X-Received: by 2002:a5e:a80f:: with SMTP id c15mr2335603ioa.270.1567013683665;
 Wed, 28 Aug 2019 10:34:43 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Streetman <dan.streetman@canonical.com>
Date:   Wed, 28 Aug 2019 13:34:07 -0400
Message-ID: <CAOZ2QJOZStRYa=5fyod_AEJcJQw90_yX40dPYY3Dhvfso1e=RA@mail.gmail.com>
Subject: Follow up on hid2hci: Fix udev rules for linux-4.14+
To:     linux-bluetooth@vger.kernel.org, ville.syrjala@linux.intel.com
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Kay Sievers <kay.sievers@vrfy.org>,
        systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It looks like this patch got lost at some point:
https://lore.kernel.org/patchwork/patch/902126/#1138115

but it seems to still be a problem and I'd like to pull it into Ubuntu:
https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/1759836

Ville, did you ever follow up with a v2 for that patch and/or do you
know if it will be accepted soon?
