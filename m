Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93463C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 00:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA5B20691
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 00:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgLWAdk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 19:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgLWAdj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 19:33:39 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D0AC0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 16:32:59 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 11so13586309oty.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 16:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AczVIt4rKkWxgHRY6Pli8wC1ntZ5Dqn8zf7cOqXQQQs=;
        b=eTXEe+vryKI2hg5CdxG9B0j75ov2iTKbHi8dE5/C6QDmG1Vv1r0J9YojpLoIOHquUu
         DYOjPyTITFiPokNitvAB1AoouAbwkUGjy2Gc+thFuNuhcouR5iBLmS/zE9enYSI38Nta
         /uaP95h82H706CzNP9KG+bre7u6UjArjbZJjOE9QWMvX6fwldLwXsAoxR8m8/YqGF2JM
         YKTCSejs5qch2bammUloGrqt50+AvUoXx0+449yMJdYilFD+aVxBrkGNwxE0axIgVcOK
         mI7ui6WfKf65IVqb7EjcONOawVzjc435OMrcaUg+KIEc4sQnGbxaE3FFyyFP2cAJbbvh
         s+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AczVIt4rKkWxgHRY6Pli8wC1ntZ5Dqn8zf7cOqXQQQs=;
        b=ZJo+HPqc6sDT69esP5MPQfTnBIcLgzjdh19LrxN+6UCKl/9ByylmMEVCWWpiMVpP4z
         7vwWqkK3mRsL99tkkQC5G5Im6z6iiZs/tDpg1hEhtXOKD+56tOQpcDciDHlTGrI4ckhc
         uw0oCkxJ8iTeD8VeKW9QUhuyCUBA0xnA/3PQc9ZCVfC0K8S3n9+8xkui2nuaWL4GkrOc
         FWIAedIUQ6Rh9IadAwpvO9kavaG1Fndq6a5k0mXTd/QY7SDdprM+f6Hu9dyn5UNCiUte
         1iV1NP+11fg9JS/XehBCqQovfNf+lsxzNRX3tUNDskOd3b6IWoxngZ6VX8hy0yX0Cvgw
         fsTQ==
X-Gm-Message-State: AOAM530BHvDx32Mvh01MHjO99uqLR4i+ca6RJ8GtS3hXyIasiLNL8Pdl
        O+4sQDlxr1ac3h3s7KOftmzsXz4lhc3QeepdLZARlIGQzoo=
X-Google-Smtp-Source: ABdhPJx/ebVN7eoD1idt8NjGs3PPUhAem/A5oRa/F5UPJzRkEb6nHJU96yxM7YgKets50ANjB29s4iE3z3Twnk84LoE=
X-Received: by 2002:a9d:664f:: with SMTP id q15mr17011389otm.40.1608683578729;
 Tue, 22 Dec 2020 16:32:58 -0800 (PST)
MIME-Version: 1.0
From:   KeithG <ys3al35l@gmail.com>
Date:   Tue, 22 Dec 2020 18:32:48 -0600
Message-ID: <CAG17S_Oy_N_YPo6x5pmZ05p4MqH_gDUrRS0TR3ydQVG9BvmYEw@mail.gmail.com>
Subject: Request for help with btmgmt
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I am developing a RPi based audio player. We are trying to add
bluetooth capability to this player. We use alsa and not pulse-audio,
so we need a bit more granular info to get it to run. I have written a
script which is designed to be triggered by udev when a BT device is
added or removed. This script will then use bluetoothctl to get the
capabilities of the device and also add or remove it from a dynamic
database list of MACs in redis. I have a simple script working as I
want from the cli. The key command I am using is 'btmgmt con' which is
the only command I have found that tells me what MACs are currently
connected. I can run this command from the command line as root. I can
set the setuid bit of btmgmt and also get it to run as a user (http in
this case). I cannot, ever, get this command to run when triggered
from udev. I get no response and no error.

1) Why is this particular command (query attached BT MACs) not part of
bluetoothctl?  Is there a security issue?
2) Why can I not run 'btmgmt con' in a script (bash or php) triggered
by udev when the device is added or removed?
3) is there a 'better way' for me to know what device MAC addresses
are attached? I have not found another simple way to get this info.

What I am doing in the script is: if an audio source is attached, I
want to run a bluealsa-aplay service. When an audio sink is attached,
I want to re-set my audio output to the bluealsa device. If it is not
an audio device, I do not care, but do keep track of what is attached
in my database so that the next time the script runs that it is not
queried and is 'known'.

Thanks for the help.

Keith
