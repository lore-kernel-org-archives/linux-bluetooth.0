Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB79AC2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 00:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9048D2072A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 00:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8hfTrH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgDGA0V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:26:21 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:35693 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgDGA0V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 20:26:21 -0400
Received: by mail-ot1-f48.google.com with SMTP id v2so1367729oto.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 17:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/laaeLvmkfkrqy8iegGID7kS8kJxp8pbToaGXzwNiRE=;
        b=c8hfTrH++ULQ8eFmzaN5u5VCTcKHkRPW5k28VVrcAhEQzsV8wCag16O2jjJSaOMD7I
         EcFSKcy37530ztcP9hrgRvqi6gNK4S90ZxJMSCksyOx+9cclJIQbRrU+rvx7JTkmA4CV
         Ncr+hpHBcu9+p0GLYSfx8RdgjAkCOarhO6FzGUJCkYMTM3ZXI3OqkOKOCH698H7UND/L
         J21hf8jlCJE90M9EBb26E3cjPjYRJzOAKb5/aUy2/eTKL6igqcOiTtizjt8S4soUMzLJ
         qcdjBgU3IPoWV+iJjVPFG1C4X4wGxSrI7TP9gdTXgyDfJ0Cz+zeQYf740UY9tzga0dbt
         /DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/laaeLvmkfkrqy8iegGID7kS8kJxp8pbToaGXzwNiRE=;
        b=oq9gcwZZCCjlaa+RXmeNRbR1hyesMK6qpZxtFwRdvoA+oPpO5EaeyzyxwEKlo3/rVk
         drYWE9+dZQyxzvCr2RzzDWnngi5E/O4ySnJFsCgRPDqFy2tMOASg+PI8HtpkiwOgVE2Q
         /5kQ+oIZSDcMzUaMS4Yy5rz5St/pTQRXVkQuAGYpNG+9UZnF8yH+B5WrZrb++Z/22mx7
         rapvHSbQp1LvJLG5mCuDclJxf3IIpeFQHp/zOC3T18k8GAyDCaqqS2X8hQkdnN3A+M4c
         eHGZhrQm2IXbjLwI0ChFC88jgKZHQTe8VH/x7dR1jkke+YtHX+v4D9OuQjaav1lUXuy+
         GlIg==
X-Gm-Message-State: AGi0PuZSq2cXdAhF8Ap3j/F3lChtnT2TWcGH8eK7m83C3xgEctMBo6CR
        5PPo+RBuaG+S8ejghwP/B4Wbo/IDfp8buOYmdKo=
X-Google-Smtp-Source: APiQypLeEVtP32TtgZ4HKKxaOp3ZRJyZz+5b5ziPvt/INgm2tk286drTPB/I5xPInElV8CFXiKqMREZO4PjhOrokLuw=
X-Received: by 2002:a9d:644:: with SMTP id 62mr17757851otn.177.1586219179925;
 Mon, 06 Apr 2020 17:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <6cf0d3da-a7d0-c820-3343-3f3722bae9a4@labapart.com> <638ce0f7-3075-c7d2-57c4-55392f8f5e0a@labapart.com>
In-Reply-To: <638ce0f7-3075-c7d2-57c4-55392f8f5e0a@labapart.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Apr 2020 17:26:08 -0700
Message-ID: <CABBYNZKpLr6Bj4U7ryJe7512uuGPW7v84xb+8Z-BKAd_rHNURQ@mail.gmail.com>
Subject: Re: btvirt with two virtual controllers: Cannot connect to GATT server
To:     Olivier MARTIN <olivier@labapart.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Olivier,

On Mon, Apr 6, 2020 at 4:06 PM Olivier MARTIN <olivier@labapart.com> wrote:
>
> Hi all,
>
> I am trying to test BLE connection between two virtual controllers
> (created with 'btvirt'). But when trying to connect to the GATT server
> running on the first virtual controller, I have the error
> "src/device.c:att_connect_cb() connect error: Transport endpoint is not
> connected (107)"
>
>
> To test my test case, I am using the head of Bluez (2a7df9323e, Sunday
> 5th April).
>
> Here is the test case:
>
> 1. Start btvirt for BLE: sudo ./emulator/btvirt -L -U2 (you will need my
> patch to fix command line parsing I sent a couple of minutes ago)
>
> 2. Start bluetoothctl to initialize the Virtual Controller that would
> play the role of GATT Server:
>
>     $ bluetoothctl
>     [NEW] Controller DB:E3:2A:E8:90:C4 olivier-ThinkPad-T480 #2 [default]
>     [NEW] Device E3:01:36:88:4C:DE TestAdvertisement
>     [NEW] Controller E3:01:36:88:4C:DE olivier-ThinkPad-T480
>     [NEW] Device DB:E3:2A:E8:90:C4 TestAdvertisement
>
>     [bluetooth]# list
>     Controller DB:E3:2A:E8:90:C4 olivier-ThinkPad-T480 #2 [default]
>     Controller E3:01:36:88:4C:DE olivier-ThinkPad-T480
>
>     [bluetooth]# power on
>     Changing power on succeeded
>     [CHG] Controller DB:E3:2A:E8:90:C4 Powered: yes
>
>     [bluetooth]# discoverable on
>     Changing discoverable on succeeded
>     [CHG] Controller DB:E3:2A:E8:90:C4 Discoverable: yes

Try with advertise.discoverable on, advertise instances actually have
their discoverable flag.

>     [bluetooth]# advertise on
>     [CHG] Controller DB:E3:2A:E8:90:C4 SupportedInstances: 0x04
>     [CHG] Controller DB:E3:2A:E8:90:C4 ActiveInstances: 0x01
>     Advertising object registered
>
>
> 3. Use './test/example-gatt-server' to simulate GATT server. I confirm
> the server is started on DB:E3:2A:E8:90:C4 (first virtual controller)
>
> 4. Return to bluetoothctl to switch to second virtual controller and
> connect to the first one
>
>     [bluetooth]# select E3:01:36:88:4C:DE
>     Controller E3:01:36:88:4C:DE olivier-ThinkPad-T480 [default]
>
>     [bluetooth]# power on
>     Changing power on succeeded
>     [CHG] Controller E3:01:36:88:4C:DE Powered: yes
>
>     [bluetooth]# scan on
>     Discovery started
>     [CHG] Controller E3:01:36:88:4C:DE Discovering: yes
>     [NEW] Device DB:E3:2A:E8:90:C4
>     [bluetooth]# scan off
>     Discovery stopped
>     [CHG] Controller E3:01:36:88:4C:DE Discovering: no
>
>     [bluetooth]# connect DB:E3:2A:E8:90:C4
>     Attempting to connect to DB:E3:2A:E8:90:C4
>     Failed to connect: org.bluez.Error.Failed
>     [CHG] Controller DB:E3:2A:E8:90:C4 Discoverable: no
>
>
> And in the bluetoothd log:
>
>     bluetoothd[15175]: src/adapter.c:start_discovery() sender :1.6483
>     bluetoothd[15175]: src/adapter.c:update_discovery_filter()
>     bluetoothd[15175]: src/adapter.c:discovery_filter_to_mgmt_cp()
>     bluetoothd[15175]: src/adapter.c:trigger_start_discovery()
>     bluetoothd[15175]: src/adapter.c:cancel_passive_scanning()
>     bluetoothd[15175]: src/adapter.c:start_discovery_timeout()
>     bluetoothd[15175]: src/adapter.c:start_discovery_timeout() adapter->current_discovery_filter == 0
>     bluetoothd[15175]: src/adapter.c:start_discovery_complete() status 0x00
>     bluetoothd[15175]: src/adapter.c:discovering_callback() hci0 type 6 discovering 1 method 0
>     bluetoothd[15175]: src/adapter.c:device_found_callback() hci0 addr DB:E3:2A:E8:90:C4, rssi 0 flags 0x0000 eir_len 3
>     bluetoothd[15175]: src/device.c:device_set_legacy() legacy 0
>     bluetoothd[15175]: src/device.c:device_set_flags() flags 6
>     bluetoothd[15175]: src/adapter.c:stop_discovery() sender :1.6483
>     bluetoothd[15175]: src/adapter.c:stop_discovery_complete() status 0x00
>     bluetoothd[15175]: src/adapter.c:trigger_passive_scanning()
>     bluetoothd[15175]: src/adapter.c:discovery_remove() owner :1.6483
>     bluetoothd[15175]: src/adapter.c:discovering_callback() hci0 type 6 discovering 0 method 0
>     bluetoothd[15175]: src/device.c:device_connect_le() Connection attempt to: DB:E3:2A:E8:90:C4
>     bluetoothd[15175]: src/device.c:att_connect_cb() connect error: Transport endpoint is not connected (107)
>


-- 
Luiz Augusto von Dentz
