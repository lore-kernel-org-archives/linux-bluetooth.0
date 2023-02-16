Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6952BC636CC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Feb 2023 19:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBPTL3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Feb 2023 14:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBPTL3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Feb 2023 14:11:29 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F382A6D7
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Feb 2023 11:11:28 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id bl9so1047759iob.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Feb 2023 11:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t3tUvnnW+m6n6sDbGR/sjWW/QlHAzvqIN2yJjZ7FFrM=;
        b=OedRrJMXZjOvPYPR2yQMVbH81VMVTPqGRC8frhwx3bNvYiMFMbzWFG0xUQOxt8KOto
         2gu1Apo87i0THFUiQPd2z9EmsZ7fMEhx3G6Npy+BXybu6IlM1cz9GAs5NDv3+6+KOIGc
         eUBDTXESlWd+skeX/rnBA8WJHyRAOkUOSOBNReZ6yhXJeorsPalWJKYFp/4N2UnbJ8XP
         VSy1LbrNHxw3aYCq8VFMJ7F7tGcXTlJjDqkmt3ea/CNBvMCrW6qoouYDVY+VVHbNKFCS
         frVsSTKU1wz1oYfuLWWtVwbOUkRx9zrr+8resQygRCZhGydJN0NVHXsptXMmVCvgWFvv
         zQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t3tUvnnW+m6n6sDbGR/sjWW/QlHAzvqIN2yJjZ7FFrM=;
        b=b/oj12f9RPNLvyAh8RTWisahY46vj8ndQNIP/wP3uEwASnYPASTulbrtWPoa/C/vft
         y/EHXC1OmXMW0t/7TBZZ+lpUiBp0wbGjovk9uHqr6hAi1GBYORaL4o6kStVvkkiF5KeU
         n2cvery7zF4NejfyoZWl4gkOMGR4qcfpi68ZMHMvgSVx5xgkM+40lZsL2XllbgTL1jnq
         QhpYqWQmgdo63gA28NCqseLbnmDiiJiiRiPgNh3PkeqdnjRd1N7cQVjiRVNx6/saYLy7
         BN2AUi1k2OjHxDpyvTc0Ql80hY2Bzn6JXK14hOMZq195+NtOJ7hSOPbdHnPLLS/R9enc
         wFlQ==
X-Gm-Message-State: AO0yUKU8wBKHBbT/0hKjlO7uST+Sx4gIOtq3/O/11At7aaTcsVjCLa/v
        esgjb+Lk2IsIlbMUkBiMFio0JpYs1UiRNHtRWLY8/ziaqII=
X-Google-Smtp-Source: AK7set9jVpCqBw1I/A3oVaZjTlL424r28A7gR8jTbYidL54NTYCbHGPydWQF11HGBmEYwj3pb3iaS/WvxsEPSD/R694=
X-Received: by 2002:a05:6638:3824:b0:3a9:5ec2:ef41 with SMTP id
 i36-20020a056638382400b003a95ec2ef41mr2699572jav.3.1676574687404; Thu, 16 Feb
 2023 11:11:27 -0800 (PST)
MIME-Version: 1.0
From:   Neacsu Cristian <neacsu.cristianstefan@gmail.com>
Date:   Thu, 16 Feb 2023 21:11:15 +0200
Message-ID: <CADBWZmXM7NO_mbw-ka9WYg2fMVhxD2ByFR1PJBDVc2e1yf_8Tw@mail.gmail.com>
Subject: Need a BLE socket to connect to a nRF52832 Nordic (Low energy BT 5)
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

    Long story short, I am trying to connect with a linux PC using a
Bluetooth 5 universal adapter (Asus USB-BT500) to a Bluetooth 5 module
PCB, called BT832X which is using a Bluetooth Low Energy Technology
that is using a chip Nordic nRF52832 (see url for the module
documentation https://static1.squarespace.com/static/561459a2e4b0b39f5cefa12e/t/63de8b578e4d7813cde64445/1675529048975/BT832X-p+Product+Specifications.pdf).
    Therefore I tried everything, reading docs, sniffing through the
bluetoothctl sources, gatttools sources, and I am not able to open and
connect on a socket on my PC to connect properly.
Usually for legacy Bluetooth stuff, I create a RF_COMM socket, and the
magic is done by itself. No biggie.
    Here I tried an L2CAP approach (not sure if I had a proper
configuration), I tried to use the gatttool as it is, without success.
I feel a bit lost.
    The remote device is working properly, because using the Nordic
demo Android app (downloadable from Google Play Store), I am able to
communicate with the PCB and exchange packages.
    Do you have a functional, very simple sample, or suggestion,
preferably in C, to help me to open a socket and send a data package?
I mean, you have a BLE module, you want to connect with it using
BlueZ, how do you open a socket, how do you configure it, connect to
it and send a byte through it?
    Let's keep in mind that I am already able to scan for the
destination address (I created a custom agent in bluetoothctl that is
fishing data using the "scan on" command), so the address that I'm
connecting to is already known.

Thank you and I'm really really looking forward to your reply.

Cristian-Stefan
