Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FBFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 08:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C0020734
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 08:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgFJIcj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:32:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39874 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgFJIcj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 04:32:39 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9E78DCECE0;
        Wed, 10 Jun 2020 10:42:27 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Getting ADV_IND and SCAN_RSP data with DBus
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAAu3APZLXdgubFVzyF4G3fmnHjzTdmffiC234SCrzUsE_Skuaw@mail.gmail.com>
Date:   Wed, 10 Jun 2020 10:32:37 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <62ED48B7-8173-43A9-B75B-0ED1A72D8442@holtmann.org>
References: <CAAu3APZLXdgubFVzyF4G3fmnHjzTdmffiC234SCrzUsE_Skuaw@mail.gmail.com>
To:     Barry Byford <31baz66@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Barry,

> I attempting to get the advertising data from a commercially available
> sensor device using the DBus API.
> The sensor device gives different manufacturer data depending if the
> event type is ADV_IND or SCAN_RSP, as you can see below in the btmon
> output.
> 
> With DBus I am subscribing to the InterfacesAdded signal which
> triggers when the device has been found. However, it only seems to
> give me the information for the SCAN_RSP.
> If I subscribe to the PropertiesChanged signal on the device, that is
> also only giving the data from the SCAN_RSP event.
> 
> How do I access both types of data with the DBus API?
> 
> Thanks,
> Barry
> 
> $ bluetoothctl -v
> bluetoothctl: 5.50
> 
> 
> btmon output for sensor device:
> 
>> HCI Event: LE Meta Event (0x3e) plen 43                                                                    #1969 [hci0] 740.157687
>      LE Advertising Report (0x02)
>        Num reports: 1
>        Event type: Connectable undirected - ADV_IND (0x00)
>        Address type: Random (0x01)
>        Address: DC:76:F7:E1:62:E0 (Static)
>        Data length: 31
>        Flags: 0x06
>          LE General Discoverable Mode
>          BR/EDR Not Supported
>        Company: Blue Maestro Limited (307)
>          Data: 1b640e10010400e701a527f50100
>        Name (complete): DC76F7E1
>        RSSI: -44 dBm (0xd4)
>> HCI Event: LE Meta Event (0x3e) plen 41                                                                    #1970 [hci0] 740.158684
>      LE Advertising Report (0x02)
>        Num reports: 1
>        Event type: Scan response - SCAN_RSP (0x04)
>        Address type: Random (0x01)
>        Address: DC:76:F7:E1:62:E0 (Static)
>        Data length: 29
>        Company: Blue Maestro Limited (307)
>          Data: 27fd27f227ea0000010201b600e4017100f4018c0000000000
>        RSSI: -44 dBm (0xd4)
> @ MGMT Event: Device Found (0x0012) plen 74
>                                   {0x0002} [hci0] 740.158704
>        LE Address: DC:76:F7:E1:62:E0 (Static)
>        RSSI: -44 dBm (0xd4)
>        Flags: 0x00000000
>        Data length: 60
>        Flags: 0x06
>          LE General Discoverable Mode
>          BR/EDR Not Supported
>        Company: Blue Maestro Limited (307)
>          Data: 1b640e10010400e701a527f50100
>        Name (complete): DC76F7E1
>        Company: Blue Maestro Limited (307)
>          Data: 27fd27f227ea0000010201b600e4017100f4018c0000000000
> @ MGMT Event: Device Found (0x0012) plen 74
>                                   {0x0001} [hci0] 740.158704
>        LE Address: DC:76:F7:E1:62:E0 (Static)
>        RSSI: -44 dBm (0xd4)
>        Flags: 0x00000000
>        Data length: 60
>        Flags: 0x06
>          LE General Discoverable Mode
>          BR/EDR Not Supported
>        Company: Blue Maestro Limited (307)
>          Data: 1b640e10010400e701a527f50100
>        Name (complete): DC76F7E1
>        Company: Blue Maestro Limited (307)
>          Data: 27fd27f227ea0000010201b600e4017100f4018c0000000000
> 
> 
> Device information from the InterfacesAdded DBus signal:
> 
> {'Adapter': '/org/bluez/hci0',
> 'Address': 'DC:76:F7:E1:62:E0',
> 'AddressType': 'random',
> 'Alias': 'DC76F7E1',
> 'Blocked': False,
> 'Connected': False,
> 'LegacyPairing': False,
> 'ManufacturerData': {307: [39, 253, 39, 242, 39, 234, 0, 0, 1, 2, 1,
> 182, 0, 228, 1, 113, 0, 244,1, 140, 0, 0, 0, 0, 0]},
> 'Name': 'DC76F7E1',
> 'Paired': False,
> 'RSSI': -51,
> 'ServicesResolved': False,
> 'Trusted': False,
> 'UUIDs': []}
> 
> Looking at the propertiesChanged signal on the device, it is also only
> showing the same manufacturer data:
> org.bluez.Device1 {'RSSI': -45, 'ManufacturerData': {307: [39, 253,
> 39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
> 0, 0, 0, 0, 0]}} []
> org.bluez.Device1 {'RSSI': -52, 'ManufacturerData': {307: [39, 253,
> 39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
> 0, 0, 0, 0, 0]}} []
> org.bluez.Device1 {'RSSI': -54, 'ManufacturerData': {307: [39, 253,
> 39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
> 0, 0, 0, 0, 0]}} []
> org.bluez.Device1 {'RSSI': -45, 'ManufacturerData': {307: [39, 253,
> 39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
> 0, 0, 0, 0, 0]}} []
> org.bluez.Device1 {'RSSI': -54, 'ManufacturerData': {307: [39, 253,
> 39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
> 0, 0, 0, 0, 0]}} []
> org.bluez.Device1 {'RSSI': -52, 'ManufacturerData': {307: [39, 253,
> 39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
> 0, 0, 0, 0, 0]}} []

this is nasty from the device. So the MGMT event should return the combined data from ADV_IND and SCAN_RSP and as you see we just concat that information coming from the kernel. However when it goes out via D-Bus, it actually gets overwritten and only one is provided.

Now the question is how we represent the same manufacturer data coming once from ADV_IND and second from SCAN_RSP via the D-Bus API. You need to have a look into doc/device-api.txt and the code in src/device.c on how we handle this.

Regards

Marcel

