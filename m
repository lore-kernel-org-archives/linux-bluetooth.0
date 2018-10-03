Return-Path: <SRS0=yBkr=MP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9068BC64EBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Oct 2018 00:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B062082A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Oct 2018 00:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Frg7U7QO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B062082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbeJCHDE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Oct 2018 03:03:04 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:43338 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeJCHDE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Oct 2018 03:03:04 -0400
Received: by mail-pf1-f172.google.com with SMTP id p24-v6so749876pff.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Oct 2018 17:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=N8bGhwwp8MZB1oDUvnBfEIOyvsyqvwwgX4spon1HLxE=;
        b=Frg7U7QOBxzFTUiilGDIKW/hbByEe8uGyR1U35Ano8Keri+Ia0gOYqvDQb+t3F8IW5
         YwFcE5DjMbd27QZDFYL+FRM9yKo17EFKdhmTBOhc/+KejcPT96sbkzbN5bFHo7cDNAQP
         plH8eMyykTEo3Ay2NqqRZiy+IUnYEJku3rGFkXnrgjLj3Td33FxTBski+PNcznH1c0D6
         yoruapdq9kmrFtSLVXPi0+c5E03oVWMe3QVQVyTer6z3KodDppnoZngpvROoqSe9NNYM
         mmzRrupgAi6YRJIgL/aWAPRw6PDEO94z/Ih5SCZSzjDlMt9V1p8yzJJz5upMIua85T6C
         ZweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=N8bGhwwp8MZB1oDUvnBfEIOyvsyqvwwgX4spon1HLxE=;
        b=EjYHvmEn5zL3doO0mJMcPvkeOKYbvRSZGM+96qN02OiNvQyJ8bYg3tzDE8McN4K+Zo
         zxQecXW6K25Kw2LM0ffiJ/8NnZ8p8CcftfI1+M9WqEChm/jIOHmS2WD7eBQ3lS5YBeh7
         K4KHqcBG9EZyiMdO2mlODQcSwQCSUt7d3wjgGIASmDQO2hIFrSFwSsNLkOaFuEFKGwtn
         kHk1Cxz29G0LpB1XDx8/bxEEnudijy72adArVvkZiJi0GUq0rXC7PFbklxGS3SixtqzT
         yUuyo/kWwRMBdtOOnQJzNcs3gGw6bkzBVzJC8gc674wOvj7EjdF8wvbAIYz2bK6fLs26
         IlMQ==
X-Gm-Message-State: ABuFfoiIiX3XYyUMegHuFG6y7KsDYMk6YvZ9RK6DuvkRZ+bGqGhoMQxW
        jCiXvXm5Q9Uv/sudyQMvRoE4zUhGM5/0Ptnw9rVew7OG+9o=
X-Google-Smtp-Source: ACcGV61Vm4ejHUVYL1jKbvhGe7ExqNE5+QH9DYDMk8ERFg94zhRhkoN2DulHF4lAMgfP93amwRQKWapHie3aik24l5o=
X-Received: by 2002:a63:bd01:: with SMTP id a1-v6mr16335982pgf.12.1538525827133;
 Tue, 02 Oct 2018 17:17:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:25c4:0:0:0:0 with HTTP; Tue, 2 Oct 2018 17:17:06
 -0700 (PDT)
From:   Eric Cooper <coopereric@google.com>
Date:   Tue, 2 Oct 2018 17:17:06 -0700
Message-ID: <CAGp4uecwQ03-Zwk0MWpejDAauo40hBHLN6+JFK7bY1Dc4OTDkA@mail.gmail.com>
Subject: Raspberry Pi and Zephyr Controller: Can't init device hci1
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello, I am running the Zephyr BLE Controller described
https://devzone.nordicsemi.com/b/blog/posts/nrf5x-support-within-the-zephyr-project-rtos
and I can't bring up the hci interface.

sudo hciconfig hci1 up
Can't init device hci1: Cannot assign requested address (99)

This is the same issue as described here
https://www.spinics.net/lists/linux-bluetooth/msg71100.html except I
am running Raspberry Pi version 9.4 and bluez 5.50.

hciconfig does show the device:

hciconfig
hci1: Type: Primary  Bus: UART
BD Address: 00:00:00:00:00:00  ACL MTU: 27:7  SCO MTU: 0:0
DOWN
RX bytes:245 acl:0 sco:0 events:18 errors:0
TX bytes:103 acl:0 sco:0 commands:18 errors:0




btmon output during the hci up operation:

@ RAW Open: hciconfig (privileged) version 2.22

{0x0005} 290.771000
@ RAW Close: hciconfig



This bug from 2014 describes it as maybe not fixed in Raspbian -
https://bugzilla.kernel.org/show_bug.cgi?id=60824 and
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=f9f462faa02777f497eb25255683a94e0c054de6.
Is there a way to determine if it is included in the current version
of Raspbian?

The same board works fine when connected to a Ubuntu 16 system.

Please let me know if there is more information I can provide and
thanks in advance,
Eric
