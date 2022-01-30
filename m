Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73F0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Jan 2022 15:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355376AbiA3PCz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Jan 2022 10:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355374AbiA3PCz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Jan 2022 10:02:55 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B367C061714
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Jan 2022 07:02:54 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id j2so19731002ybu.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Jan 2022 07:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaishome.de; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=A9rXa8MOMOqUl59jZILcjrVHPpj0gaywXdH3Ebep4zI=;
        b=fcpnd6x/yCzjJpJ4UJVM3bR8MB9UNlFJokooCvtABL/RkxtFAvFTxMcPq5wZMqdXJ/
         tqL4U7B9L5FJ1uDLG3STX6aIPtaPz/76vniurYz/RolRiOUoVf9/eeHzROb3KbBXH/4j
         Xk8upP54EUwR95zRtYjOrYCJAJBUU0uZxgolE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=A9rXa8MOMOqUl59jZILcjrVHPpj0gaywXdH3Ebep4zI=;
        b=pN1cmkVoiuf0Yz5pQLo9mX6973KueKYlPB39p7dFeqCcVNXUSIBVAVw/8hhneUO1DB
         5CxrtPBMNd5CIUvrPTic0Nb5X4BqadHsZZHFfuJBqvZCJBP+xuJbPTo7HMzMlTrHvJDm
         yyryu8Hh5bjKc8r0qXUpWeJqt8b/4tVtTwLM9kPrtpSpkkvIH1uQmtA3Ts/IbiMF5HPf
         ZpbNKfSTt/CvQP7q3015jIr4De4IRNcP7zFEHQsANNMEL7W7/V+XR8sAOECkGFsIhPph
         ST9b7udAAls7dNYSZwvVGezFnm50UYJ0zP68tsu2ELYOv5tCtH8GV0lO88v2N0jw4wiD
         spLQ==
X-Gm-Message-State: AOAM5335PLH1ghIyQUsBAiy3tqds+AexHNZ41CDyN4rEe4oSBPQDrBfF
        TBa/Wpb823xKTmv6N7H/9HYUR0gU+bsoQVArrxWL09r1LXUd5w==
X-Google-Smtp-Source: ABdhPJy/WGDDxbPKC2HIp7fXUegT+1wuCSlr5P16Jw6nm8KsVFBFBDkL/3X1D0H4uFJHAHcFfhD2yd69XdAmPiwwxa8=
X-Received: by 2002:a25:42c5:: with SMTP id p188mr24595258yba.154.1643554973588;
 Sun, 30 Jan 2022 07:02:53 -0800 (PST)
MIME-Version: 1.0
From:   Kai Krakow <kai@kaishome.de>
Date:   Sun, 30 Jan 2022 16:02:43 +0100
Message-ID: <CAC2ZOYu4zy0CPTW40qy3vJJDFuWEUvqqPJdMgtKL9=7Xh-YVEA@mail.gmail.com>
Subject: kernel 5.15.17: Spamming dmesg with "Malicious advertising data"
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello!

Since kernel 5.15.17, dmesg is spammed with the following log,
sometimes multiple times per second:

> Bluetooth: hci0: Malicious advertising data. Stopping processing

This was probably introduced by commit 2de0e6a71ceb056e17e4684dce8b7640367996f9.

I'm not sure which device causes it, and it seems quite useless to
repeat this message without any rate limiting, especially when no
source of the incident is indicated.

I'm suspecting that something is messed up here, and there's not
really any malicious advertising going on. At least, there's a lot of
LE advertising going on but that looks sane:

```
> HCI Event: LE Meta Event (0x3e) plen 40                                                                                                                                                                                                  #63 [hci0] 3.466120
     LE Advertising Report (0x02)
       Num reports: 1
       Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
       Address type: Public (0x00)
       Address: F8:04:2E:8A:20:C1 (SAMSUNG ELECTRO-MECHANICS(THAILAND))
       Data length: 28
       Company: Samsung Electronics Co. Ltd. (117)
         Data: 42040180aef8042e8a20c1fa042e8a20c001000000000000
       RSSI: -68 dBm (0xbc)
> HCI Event: LE Meta Event (0x3e) plen 40                                                                                                                                                                                                  #64 [hci0] 3.469127
     LE Advertising Report (0x02)
       Num reports: 1
       Event type: Connectable undirected - ADV_IND (0x00)
       Address type: Public (0x00)
       Address: 74:AC:B9:41:D2:23 (Ubiquiti Networks Inc.)
       Data length: 28
       128-bit Service UUIDs (partial): 1 entry
         Vendor specific
       Service Data (UUID 0x252a): 74acb941d21c
       RSSI: -37 dBm (0xdb)
> HCI Event: LE Meta Event (0x3e) plen 40                                                                                                                                                                                                  #65 [hci0] 3.540118
     LE Advertising Report (0x02)
       Num reports: 1
       Event type: Scannable undirected - ADV_SCAN_IND (0x02)
       Address type: Random (0x01)
       Address: 53:F3:43:9B:9D:13 (Resolvable)
       Data length: 28
       16-bit Service UUIDs (complete): 1 entry
         Google (0xfe9f)
       Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
       RSSI: -70 dBm (0xba)
> HCI Event: LE Meta Event (0x3e) plen 40                                                                                                                                                                                                  #66 [hci0] 3.596124
     LE Advertising Report (0x02)
       Num reports: 1
       Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
       Address type: Public (0x00)
       Address: 68:72:C3:A0:AA:75 (Samsung Electronics Co.,Ltd)
       Data length: 28
       Company: Samsung Electronics Co. Ltd. (117)
         Data: 420401806e6872c3a0aa756a72c3a0aa7401000000000000
       RSSI: -55 dBm (0xc9)
```

System info:

> Linux jupiter 5.15.17-gentoo #1 SMP PREEMPT Sat Jan 29 07:32:24 CET 2022 x86_64 12th Gen Intel(R) Core(TM) i7-12700K GenuineIntel GNU/Linux
> Bluetooth monitor ver 5.63
> = Note: Linux version 5.15.17-gentoo (x86_64)                          0.256208
> = Note: Bluetooth subsystem version 2.22                               0.256210
> = New Index: 00:1A:7D:DA:71:15 (Primary,USB,hci0)               [hci0] 0.256211
> = Open Index: 00:1A:7D:DA:71:15                                 [hci0] 0.256212
> = Index Info: 00:1A:7D:DA:71:15 (Cambridge Silicon Radio)       [hci0] 0.256212
> @ MGMT Open: bluetoothd (privileged) version 1.21             {0x0001} 0.256213


Regards,
Kai
