Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998E0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 10:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F976610FC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 10:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240271AbhI1KtD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 06:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240211AbhI1KtD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 06:49:03 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37067C061575
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 03:47:24 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id bb10so13911622plb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 03:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=eZzDSGsAYfkw+wEKsnlQJRlSmK7/bRMQ18wGzqFBD6I=;
        b=PkWbwF/J9iIJ7sJzsyUiv6w6MalTzywZPPvrvGf0ZOj0U3l/LR/OybE5+6l4Aw31+f
         V+h7346pBl9GfR+RxMzVnBVMIg+kCdoyg9FrZhYFNod+CcBMK5P0diUf48iEozIl+Jg0
         gN0BTphzVLor8OGbKCpR4Yqyyw/ffaHFfnooZEbzE4a7JLhmu2thSIJRIGh15U2IzHDG
         8vOcIyIUjn+luDEEkaIJHCnzAb7PEzl3HEGPzGnIy58rL3MBSo2TCBOTyC6PGYLOjbL2
         uHYz1BIYniC2uQaef0m2Oxj/mgzpnLjek5pWnDArAmzAXjCM+ge6vWc5KZeOhBd8CFsl
         emSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eZzDSGsAYfkw+wEKsnlQJRlSmK7/bRMQ18wGzqFBD6I=;
        b=kmd+lRlGHxMQwJFAcTbI0dOPYy146vKubZGDdt9oiWO50zZAMWqY6wf6ezO3a8+B4W
         9BlBVYSRbBs/OzNc+sY8ZHw3rH4cIXctrKRTfuLR+eDPvUbcCRQ8rGMtZILlIeuv8dh/
         ki5FBKQT7S5q/TFqxBtRNJ/1gJMotwKiUka7LoiZN8rB9XB+EJ+xDJYNHo0uzWtLlCde
         Aoy/gwwgQcH4ceg7c4+/0ZZ4C6MLrLjM+779m8QGYZOUtYeAqCqgUtTXeoEHBU676AF+
         ok/lyaZ3t8ewA0RQrmoqVb2owC/VRQYnDQDumkh1qtX2HuWzI+ySOUHkAfZpW+hN90WR
         I0qQ==
X-Gm-Message-State: AOAM531ZApKZgqgFp6mei/Np8ZNFwMjdlcVDj8maBQFdz3tHRA6Kyog5
        9NUVLcSL/z1vA0OrPD5iHwXzEbsu8CSuBPhDri30vg==
X-Google-Smtp-Source: ABdhPJxhq8lQbGG0E285+/0QLOzqQYLsK/HeRGuS+o3ezMbOvem9+/gUNnt/AUUVlHN1TJiIIv/7y0uivWTDCNEf+aA=
X-Received: by 2002:a17:902:7d95:b0:13e:1272:884a with SMTP id
 a21-20020a1709027d9500b0013e1272884amr4491692plm.34.1632826043690; Tue, 28
 Sep 2021 03:47:23 -0700 (PDT)
MIME-Version: 1.0
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Tue, 28 Sep 2021 13:47:13 +0300
Message-ID: <CAD8XO3Z3FDFdaJOgoXgjn=_Ly6AQp+wugKNDN01098EVJB4qEw@mail.gmail.com>
Subject: [RFC] bt control interface out from debugfs
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I think we need to move control for BT 6lowpan connection out of
kernel debugfs to user space tools. I.e. use hcitool or iproute2 and
add proper non debug kernel interface for the tools.
I would like to hear about some suggestions on what is the best interface here.

Currently commands to setup connection are:
echo 1 > /sys/kernel/debug/bluetooth/6lowpan_enable
echo "connect 80:E1:26:1B:95:81 1" > /sys/kernel/debug/bluetooth/6lowpan_control

It looks logical to enable 6lowpan inside hcitool. I.e. extend current
AF_BLUETOOTH socket protocol:
dd = socket(AF_BLUETOOTH, SOCK_RAW | SOCK_CLOEXEC, BTPROTO_HCI)
getsockopt(dd, SOL_HCI, HCI_FILTER, ..
add some HCI_6LOWPAN_ENABLE call.
What are your thoughts on that?

Then we have an IP stack on top of the BT layer, and hcitool does not
intend to setup ip connection. iproute2 might be more suitable for
this case. Something like:
ip link connect dev bt0 type bt 80:E1:26:1B:95:81 type local
(type 1- local, 2- public) .

But here is the problem that "ip link connect" is missing in current
tools. And usually we just set up a local connection and connect from
the app using a socket.  With IP over BT connection is different  -
we should be connected before.

If we implement "ip link connect" then it will be possible to reuse it
for all other pear to pear connections like vpn wireguard.

Any thoughts on an interface here?

Links:  kernel: ./net/bluetooth/6lowpan.c line 1283

Best regards,
Maxim.
