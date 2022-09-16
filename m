Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B812ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Sep 2022 20:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIPULm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Sep 2022 16:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiIPULl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Sep 2022 16:11:41 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3FDA285A
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Sep 2022 13:11:40 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id t184so34195112yba.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Sep 2022 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=xFv4c5vgIPhnrUnnlimN+PSFxLx42+5xoaRpY/hoGcg=;
        b=eDXg0XdKlu3mN55zsMJKwjlLrrsxIrjC6kcFIdBNAwnqBa48SydhErs0gpdrfIsVKM
         K6R/pJ5iHNFMQPSjB+TyAVAwatJZ/5Kb4LEBo7IljGJeWoFZnHZbhWYbgDh01Sr0kKXb
         Ab5pTU9lfBpNB/455RiMV9EkiWlHCRergno6V2gWr2h5Uwk1qnUAYc3EbM1sqBT6m63d
         hxE6q6AuzkerOvtMZZS57ysoZ2vf+g7r7Q5k8hJssicfvhbRx9J/RLuWQVw37B8nKT1j
         UmN6cTGI6Y6Q00G24A9OlxpFMGoNOwZxzDtYXPi8nFxHhqlwYkHtBUgSCCqkDMj+sW7Z
         SCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=xFv4c5vgIPhnrUnnlimN+PSFxLx42+5xoaRpY/hoGcg=;
        b=wzNN+EGwlcE3ZYCPzAoM3aHVIBZ8M3iiBIjOP8YKCjDNsaX99rFLMBRJgPf4RbqsSO
         I+/wdiJBajOhYiHk7vYs2rTwpKy/W9POdHo8SVRgYdMpPW+KO40gomEx1L7WgHgYokFF
         8CML3kdcKgLMmdhNZKEHimKAgKRm/VSpyV3sGIzUwQs/oRjcHhxM43HdMDw6i233ixEj
         bOCZcMFmAfnnISVQUWrY2EEzwYo/sHt4dtXhFkCCcyMos/NW2IhB15yejrVSTdteArR/
         x85uJhkYMrcnCmp21vzQXNev9VkO6eKeuLn/N4uHzZIxY5kmBLZny7hv5XYg+qU/xlwe
         NpiA==
X-Gm-Message-State: ACrzQf30G9+6EaWsVkLL+VxpIUrIDj8djGs3eOXUydxP7hVi+rCIShPm
        nFp9pmAbIGgO8E0xE0lnIXHr0H9E0+JYJUqLAG+gCzVRSI4htw==
X-Google-Smtp-Source: AMsMyM64L5c0bilpW4/5BQLNrb11PameMPYJy6tmk0g7zBrsj4Btb+6PbqIJ6uChmU4hqftDpZSDbJaPDgf1E0IxIqo=
X-Received: by 2002:a25:8550:0:b0:691:11f9:41dd with SMTP id
 f16-20020a258550000000b0069111f941ddmr5315344ybn.600.1663359099570; Fri, 16
 Sep 2022 13:11:39 -0700 (PDT)
MIME-Version: 1.0
From:   Jake Rue <jakerue222@gmail.com>
Date:   Fri, 16 Sep 2022 13:11:28 -0700
Message-ID: <CAHe0yEYV49DT8RSgYVjA_kui_Hh1GxR-35kw-aBP0ccwS+psYA@mail.gmail.com>
Subject: How does btmon know that type 9 is "Apple TV"?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In an advertisement like this:

> HCI Event: LE Meta Event (0x3e) plen 27                                                                                                                                                              #86 [hci0] 44.156857
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 0D:07:B9:9A:33:0F (Non-Resolvable)
        Data length: 15
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Apple TV (9)
          Data: 0376c0a801f5
        RSSI: -80 dBm (0xb0)

Where does the mapping of Type 9 to "Apple TV" come from in the code?
When I search the bluez github repository for "Apple TV"
(https://github.com/bluez/bluez/search?q=%22Apple+TV%22), I don't get
any hits. (In contrast I can find the switch statement that encodes 76
== "Apple, Inc." fine.) I'd like to see what table encodes that
information so I can use it in my code as well (and what all it knows
about other types.)

- Thank You
Jake Rue
