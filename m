Return-Path: <SRS0=dAEe=7O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79580C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 07:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444B4206E2
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 07:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neRr65H0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgFAHmo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFAHmn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jun 2020 03:42:43 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391CDC061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2020 00:42:43 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a25so6926395ljp.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2020 00:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Fga0SccuTIM5lD/5v50L6qFcKMfg0jwbtDVQEVZqdOY=;
        b=neRr65H0rUn4YxCTPoFklDMgeQt99qZFn/9MIXljnpnMR7yrkutL6lseTpKO8mU0Au
         df/ipcZeTpvmVS38MObHZf1t3zzJE95r43+hQVWsiuw0HqPJOFABehuWIF+wYFbwNpSl
         Qk2TyaL32P7+bFf0y0J+RPfUtS0IjsNgiUQNwp81iZ78HM3lgVA4HABcCoEJWB9b+okR
         0sBKiVDnR9pURrx2rMHui99qgHPfL3Gf7bsyWhMuxQr++XnDRaJIMoh9r95d8KaU82Ws
         3BKny4BzPva9+apHDHYECYYoGvEz83ESfQxIgM0ohX+I6w5d1AWjmxn7tjQ4dbx2KGxp
         DfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Fga0SccuTIM5lD/5v50L6qFcKMfg0jwbtDVQEVZqdOY=;
        b=iVatUjEJ/Qn86VocjeS9lPoRUZTe+RQ9qHi66MzxLIsXgw3tKwu/V88F7ZbUsbYjDX
         ffXVbJNOxa7SMME2PAz0BET5YY1MU1r1OXR1ZE31AjclM/u/XxXKUj+WYSoRbmSB9FiU
         +OZ4HC/TX8ZTYAKrMH9knGDEMwxb5WO+kv4FzIDXxe6jvTnJEdQQ16zSq0gq67oheY9P
         5LcfxRCAPnLMQ9xZHNYKAtAaTesroIOb2f9XUnTGnEggG87U3WyDxQ41AgeN6py7yCaQ
         62udNn3fFQtMl9VrRInrk/w1nr3LteZOqesbBy2Vx9YN9oNiJWStmZyTaJXBUMB00iIr
         r0kg==
X-Gm-Message-State: AOAM530vUcTBbKYSYqdNF239Nbz6w/MBukSa8tGAkC/FD3dguQ4yvLIi
        XqFd7AMfxkKrm6jlozWPCOHlUWKXNTRgZJlvOrCWzZXC
X-Google-Smtp-Source: ABdhPJxFaf6x8lkv2ElUAZMOpooFtqXOiV288/K28tJVUHJf46HZl82p67hHwCOcnfGHG9cc1HICOY8NQ2Ic/EzpaMg=
X-Received: by 2002:a2e:9608:: with SMTP id v8mr9442895ljh.420.1590997360838;
 Mon, 01 Jun 2020 00:42:40 -0700 (PDT)
MIME-Version: 1.0
From:   Barry Byford <31baz66@gmail.com>
Date:   Mon, 1 Jun 2020 08:42:29 +0100
Message-ID: <CAAu3APZLXdgubFVzyF4G3fmnHjzTdmffiC234SCrzUsE_Skuaw@mail.gmail.com>
Subject: Getting ADV_IND and SCAN_RSP data with DBus
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I attempting to get the advertising data from a commercially available
sensor device using the DBus API.
The sensor device gives different manufacturer data depending if the
event type is ADV_IND or SCAN_RSP, as you can see below in the btmon
output.

With DBus I am subscribing to the InterfacesAdded signal which
triggers when the device has been found. However, it only seems to
give me the information for the SCAN_RSP.
If I subscribe to the PropertiesChanged signal on the device, that is
also only giving the data from the SCAN_RSP event.

How do I access both types of data with the DBus API?

Thanks,
Barry

$ bluetoothctl -v
bluetoothctl: 5.50


btmon output for sensor device:

> HCI Event: LE Meta Event (0x3e) plen 43                                                                    #1969 [hci0] 740.157687
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: DC:76:F7:E1:62:E0 (Static)
        Data length: 31
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Company: Blue Maestro Limited (307)
          Data: 1b640e10010400e701a527f50100
        Name (complete): DC76F7E1
        RSSI: -44 dBm (0xd4)
> HCI Event: LE Meta Event (0x3e) plen 41                                                                    #1970 [hci0] 740.158684
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Random (0x01)
        Address: DC:76:F7:E1:62:E0 (Static)
        Data length: 29
        Company: Blue Maestro Limited (307)
          Data: 27fd27f227ea0000010201b600e4017100f4018c0000000000
        RSSI: -44 dBm (0xd4)
@ MGMT Event: Device Found (0x0012) plen 74
                                   {0x0002} [hci0] 740.158704
        LE Address: DC:76:F7:E1:62:E0 (Static)
        RSSI: -44 dBm (0xd4)
        Flags: 0x00000000
        Data length: 60
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Company: Blue Maestro Limited (307)
          Data: 1b640e10010400e701a527f50100
        Name (complete): DC76F7E1
        Company: Blue Maestro Limited (307)
          Data: 27fd27f227ea0000010201b600e4017100f4018c0000000000
@ MGMT Event: Device Found (0x0012) plen 74
                                   {0x0001} [hci0] 740.158704
        LE Address: DC:76:F7:E1:62:E0 (Static)
        RSSI: -44 dBm (0xd4)
        Flags: 0x00000000
        Data length: 60
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Company: Blue Maestro Limited (307)
          Data: 1b640e10010400e701a527f50100
        Name (complete): DC76F7E1
        Company: Blue Maestro Limited (307)
          Data: 27fd27f227ea0000010201b600e4017100f4018c0000000000


Device information from the InterfacesAdded DBus signal:

{'Adapter': '/org/bluez/hci0',
 'Address': 'DC:76:F7:E1:62:E0',
 'AddressType': 'random',
 'Alias': 'DC76F7E1',
 'Blocked': False,
 'Connected': False,
 'LegacyPairing': False,
 'ManufacturerData': {307: [39, 253, 39, 242, 39, 234, 0, 0, 1, 2, 1,
182, 0, 228, 1, 113, 0, 244,1, 140, 0, 0, 0, 0, 0]},
 'Name': 'DC76F7E1',
 'Paired': False,
 'RSSI': -51,
 'ServicesResolved': False,
 'Trusted': False,
 'UUIDs': []}

Looking at the propertiesChanged signal on the device, it is also only
showing the same manufacturer data:
org.bluez.Device1 {'RSSI': -45, 'ManufacturerData': {307: [39, 253,
39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
0, 0, 0, 0, 0]}} []
org.bluez.Device1 {'RSSI': -52, 'ManufacturerData': {307: [39, 253,
39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
0, 0, 0, 0, 0]}} []
org.bluez.Device1 {'RSSI': -54, 'ManufacturerData': {307: [39, 253,
39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
0, 0, 0, 0, 0]}} []
org.bluez.Device1 {'RSSI': -45, 'ManufacturerData': {307: [39, 253,
39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
0, 0, 0, 0, 0]}} []
org.bluez.Device1 {'RSSI': -54, 'ManufacturerData': {307: [39, 253,
39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
0, 0, 0, 0, 0]}} []
org.bluez.Device1 {'RSSI': -52, 'ManufacturerData': {307: [39, 253,
39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
0, 0, 0, 0, 0]}} []
