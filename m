Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3577CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 14:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC432067B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 14:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vvi0Ax6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgFJO1P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgFJO1P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 10:27:15 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3727FC03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 07:27:15 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id g7so1812003oti.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JMtrzVPd3Sa/kz/sSw3pnartXKyBz40zqDBmZeKx7Us=;
        b=Vvi0Ax6EQaWmd/+x0IVohohtc7kIocuG/O1kEcrN4h2Ox6RndogwsOZr2bY1YVBNlI
         R5TkirBJC5JI0bf7sRsnInuRUVNomSJ6M/gVKRliZLGS/opaQuEh2sWf4VjkkCSIoGJW
         tayn3ZHcUyae9VIm3DxFrWyVQdbBoawcf1Pj3WoygvFFS2fkx2cEnT/jP05PfAUvC5uk
         IgPGfMzgbqGwafapTJEnXGpjYqdQPqBijqUoIY48HFYE8cMzzVMUF0AcpSPgqNWgGvWm
         yKWzV02aVFEqxZbE9eeBT8rbP3RboIRtA7QvGT9+MKoPzPwsoHHGD3epJiNh/rN+Jogs
         DIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JMtrzVPd3Sa/kz/sSw3pnartXKyBz40zqDBmZeKx7Us=;
        b=e1FgUiFiNS7o9o3EwShirLpicokAzylF3alcpHmqkqFJilx+hsY8uFz6dz/1fng+vh
         NRjygtBfyYgzrjWnF4oLreQl356exnbtFIqdonx4WefqGjLGv+nNg0GkAB1ohpolz7pn
         X9K/2vbOaWXEtcAR6ItkkTJpdjZZbA3UlahtiyfW2Die2u2TMEDC/6+3PN/vN1qn5IjY
         abjjqiMTCLzgr272saS41eM7qD92X9Hl0rrkhkFFEVtv4FQ6e70LzWuQEbVI911MlZti
         1XRJbkRI43SUBzq02UgpI/2YKUagiAxSNPjFxIn5ix3Tm8W5OWanoBtnD6eZrOxS+FvU
         4xFA==
X-Gm-Message-State: AOAM532sCX+cZIT3DkQ/Nh9EYei7eB8cuAjU6b/Hxhn9piXTqbLnZfRz
        +/JiQLTXUdo2L2aQRcUPAuVhtEyW49YN96pTivN6RWcE
X-Google-Smtp-Source: ABdhPJweFllkNpRhk88PLN0tK+z+NwHpS+xRBxFuYz9BUopHHxxh2CIGAx7l07kQU8WhcqG7evVNfuI74e8JJ9Mqkkk=
X-Received: by 2002:a9d:2d88:: with SMTP id g8mr2665011otb.149.1591799234550;
 Wed, 10 Jun 2020 07:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAAu3APZLXdgubFVzyF4G3fmnHjzTdmffiC234SCrzUsE_Skuaw@mail.gmail.com>
 <62ED48B7-8173-43A9-B75B-0ED1A72D8442@holtmann.org>
In-Reply-To: <62ED48B7-8173-43A9-B75B-0ED1A72D8442@holtmann.org>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Wed, 10 Jun 2020 16:27:03 +0200
Message-ID: <CAO1O6sfmf2t3xSb=d1pOdL_WG27-gRFWS-iN23wcgF4+ejAQjw@mail.gmail.com>
Subject: Re: Getting ADV_IND and SCAN_RSP data with DBus
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Barry Byford <31baz66@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,


Den ons 10 juni 2020 kl 16:00 skrev Marcel Holtmann <marcel@holtmann.org>:
>
> Hi Barry,
>
> > I attempting to get the advertising data from a commercially available
> > sensor device using the DBus API.
> > The sensor device gives different manufacturer data depending if the
> > event type is ADV_IND or SCAN_RSP, as you can see below in the btmon
> > output.
> >
> > With DBus I am subscribing to the InterfacesAdded signal which
> > triggers when the device has been found. However, it only seems to
> > give me the information for the SCAN_RSP.
> > If I subscribe to the PropertiesChanged signal on the device, that is
> > also only giving the data from the SCAN_RSP event.
> >
> > How do I access both types of data with the DBus API?
> >
> > Thanks,
> > Barry
> >
> > $ bluetoothctl -v
> > bluetoothctl: 5.50
> >
> >
> > btmon output for sensor device:
> >
> >> HCI Event: LE Meta Event (0x3e) plen 43                               =
                                     #1969 [hci0] 740.157687
> >      LE Advertising Report (0x02)
> >        Num reports: 1
> >        Event type: Connectable undirected - ADV_IND (0x00)
> >        Address type: Random (0x01)
> >        Address: DC:76:F7:E1:62:E0 (Static)
> >        Data length: 31
> >        Flags: 0x06
> >          LE General Discoverable Mode
> >          BR/EDR Not Supported
> >        Company: Blue Maestro Limited (307)
> >          Data: 1b640e10010400e701a527f50100
> >        Name (complete): DC76F7E1
> >        RSSI: -44 dBm (0xd4)
> >> HCI Event: LE Meta Event (0x3e) plen 41                               =
                                     #1970 [hci0] 740.158684
> >      LE Advertising Report (0x02)
> >        Num reports: 1
> >        Event type: Scan response - SCAN_RSP (0x04)
> >        Address type: Random (0x01)
> >        Address: DC:76:F7:E1:62:E0 (Static)
> >        Data length: 29
> >        Company: Blue Maestro Limited (307)
> >          Data: 27fd27f227ea0000010201b600e4017100f4018c0000000000
> >        RSSI: -44 dBm (0xd4)
> > @ MGMT Event: Device Found (0x0012) plen 74
> >                                   {0x0002} [hci0] 740.158704
> >        LE Address: DC:76:F7:E1:62:E0 (Static)
> >        RSSI: -44 dBm (0xd4)
> >        Flags: 0x00000000
> >        Data length: 60
> >        Flags: 0x06
> >          LE General Discoverable Mode
> >          BR/EDR Not Supported
> >        Company: Blue Maestro Limited (307)
> >          Data: 1b640e10010400e701a527f50100
> >        Name (complete): DC76F7E1
> >        Company: Blue Maestro Limited (307)
> >          Data: 27fd27f227ea0000010201b600e4017100f4018c0000000000
> > @ MGMT Event: Device Found (0x0012) plen 74
> >                                   {0x0001} [hci0] 740.158704
> >        LE Address: DC:76:F7:E1:62:E0 (Static)
> >        RSSI: -44 dBm (0xd4)
> >        Flags: 0x00000000
> >        Data length: 60
> >        Flags: 0x06
> >          LE General Discoverable Mode
> >          BR/EDR Not Supported
> >        Company: Blue Maestro Limited (307)
> >          Data: 1b640e10010400e701a527f50100
> >        Name (complete): DC76F7E1
> >        Company: Blue Maestro Limited (307)
> >          Data: 27fd27f227ea0000010201b600e4017100f4018c0000000000
> >
> >
> > Device information from the InterfacesAdded DBus signal:
> >
> > {'Adapter': '/org/bluez/hci0',
> > 'Address': 'DC:76:F7:E1:62:E0',
> > 'AddressType': 'random',
> > 'Alias': 'DC76F7E1',
> > 'Blocked': False,
> > 'Connected': False,
> > 'LegacyPairing': False,
> > 'ManufacturerData': {307: [39, 253, 39, 242, 39, 234, 0, 0, 1, 2, 1,
> > 182, 0, 228, 1, 113, 0, 244,1, 140, 0, 0, 0, 0, 0]},
> > 'Name': 'DC76F7E1',
> > 'Paired': False,
> > 'RSSI': -51,
> > 'ServicesResolved': False,
> > 'Trusted': False,
> > 'UUIDs': []}
> >
> > Looking at the propertiesChanged signal on the device, it is also only
> > showing the same manufacturer data:
> > org.bluez.Device1 {'RSSI': -45, 'ManufacturerData': {307: [39, 253,
> > 39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
> > 0, 0, 0, 0, 0]}} []
> > org.bluez.Device1 {'RSSI': -52, 'ManufacturerData': {307: [39, 253,
> > 39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
> > 0, 0, 0, 0, 0]}} []
> > org.bluez.Device1 {'RSSI': -54, 'ManufacturerData': {307: [39, 253,
> > 39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
> > 0, 0, 0, 0, 0]}} []
> > org.bluez.Device1 {'RSSI': -45, 'ManufacturerData': {307: [39, 253,
> > 39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
> > 0, 0, 0, 0, 0]}} []
> > org.bluez.Device1 {'RSSI': -54, 'ManufacturerData': {307: [39, 253,
> > 39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
> > 0, 0, 0, 0, 0]}} []
> > org.bluez.Device1 {'RSSI': -52, 'ManufacturerData': {307: [39, 253,
> > 39, 242, 39, 234, 0, 0, 1, 2, 1, 182, 0, 228, 1, 113, 0, 244, 1, 140,
> > 0, 0, 0, 0, 0]}} []
>
> this is nasty from the device. So the MGMT event should return the combin=
ed data from ADV_IND and SCAN_RSP and as you see we just concat that inform=
ation coming from the kernel. However when it goes out via D-Bus, it actual=
ly gets overwritten and only one is provided.
>
> Now the question is how we represent the same manufacturer data coming on=
ce from ADV_IND and second from SCAN_RSP via the D-Bus API. You need to hav=
e a look into doc/device-api.txt and the code in src/device.c on how we han=
dle this.
>
> Regards
>
> Marcel
>

To me it appears there is a "bug" in the BlueZ API specification.
Manufacturer data is stored as a key-value dictionary, where key is
the manufacturer id and the value is the byte array. But the Bluetooth
Core Specification Supplement explicitly allows more than one
appearance of Manufacturer Specific Data (see the first section in
CSS_v9.pdf), and it does not prohibit more than one record from the
same manufacturer. A correct API would have Manufacturer data as a
key-value dictionary, where the key is the manufacturer id but the
value is an array of byte arrays.

The AdvertisingData experimental API seems to have the same kind of
issue "The Advertising Data of the remote device. Keys are are 8 bits
AD Type followed by data as byte array." But each AD type can appear
more than once and hence the value should be an array of byte arrays.

/Emil
