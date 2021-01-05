Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FBDC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 08:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 132D822525
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 08:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbhAEIkB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jan 2021 03:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbhAEIkB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jan 2021 03:40:01 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE71C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jan 2021 00:39:20 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b26so70791870lff.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Jan 2021 00:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sztnYGxfY/gXyvWcGTSBWU7Fe5aWpfjANOfCN0PIPbY=;
        b=Jlr1U69vMhglMOizb9jRM6sWY5oR7d5Vbg/2ZX3zwABXni1F2L92rorYC/EVSg/llI
         DKcKSoNGHgxvSAHa6cgMGcAFaK6mwJiEdFdS+l688th94ipijqU8yFPAcYn7W8oKs/ab
         7TLgMdfo0S58x5YxffN64nzVVPW2mBU1DeH1zJWj/7P7/2ekWlhHWXIclzR5cs8IkCAd
         KKx/cE1sa+ncUr9/HBpIDSov4n9yTgFGReEzuoPQshsCk064P4Osf1sG8Q2otUqml/gt
         I7czK8CEUhRz2bQNOmBCJOVa19Zw/M1Zg0pEPkZKVHBYvo1llcTYl1nucaavUOfwleac
         4yZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sztnYGxfY/gXyvWcGTSBWU7Fe5aWpfjANOfCN0PIPbY=;
        b=Y903iyiCwoDB7FgrmYdDVqqhXJdxvajh6vfbRDkcBaefDcoITTLt61XbK+ts+L8vRR
         UK6+krQjGaARqLuDpU2XtX/Cm2Zb6rBhQ9cGFbAOjQiuE1K+492oWi1j4k3avSaIINNw
         eeNLUvt4dyJdFrEyoZlE9iFSChZMdMsxh3yBBhLFGGcJ+EeCMj/KMgiltk625dzGAAlf
         uJW/71WdJcl+ADfhXBpu2BXiaYcI+T3KuC1tjm/wqKOxPtRILpnxl1+jp50z++BLf0SQ
         GtSRnNyChfWV1H+5GR/zKU8LdydGexs9MYgeOK0/G3+gPXLzD3Aj8iFp8uITVKrnwwBA
         aNGg==
X-Gm-Message-State: AOAM533Ao2I6DTzLsbIpmZcczVnF3dIkOoCHMx4GKdN15v/47G6uOc2+
        A3n16DmHv5tEQErfSc21iOd20VanjfetGiu8XjG3bjjlo1E=
X-Google-Smtp-Source: ABdhPJyzpAOP6elEF2ZghA98NNbFK18oAFVedW2NJDCweoogUKs78Sb8L85wyGGAdOqGgkGq8aMEJRHcnCI88L9n5nM=
X-Received: by 2002:a19:c6c1:: with SMTP id w184mr36114927lff.553.1609835959201;
 Tue, 05 Jan 2021 00:39:19 -0800 (PST)
MIME-Version: 1.0
From:   Barry Byford <31baz66@gmail.com>
Date:   Tue, 5 Jan 2021 08:39:07 +0000
Message-ID: <CAAu3APY+EUOAeo3W5ay=_SsNUH4sKVpXaDy-dgAvvyCOCJdhTQ@mail.gmail.com>
Subject: Re: btvirt with two virtual controllers: Cannot connect to GATT server
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Cc:     Olivier MARTIN <olivier@labapart.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Olivier,

On 2020-04-08 21:40:03, Olivier MARTIN wrote:
> Hi Luiz,
>
> On 07.04.20 08:30, Olivier MARTIN wrote:
>> Hi Luiz,
>>
>> On 07.04.20 02:26, Luiz Augusto von Dentz wrote:
>>> Hi Olivier,
>>>
>>> On Mon, Apr 6, 2020 at 4:06 PM Olivier MARTIN <olivier@labapart.com>
>>> wrote:
>>>> Hi all,
>>>>
>>>> I am trying to test BLE connection between two virtual controllers
>>>> (created with 'btvirt'). But when trying to connect to the GATT server
>>>> running on the first virtual controller, I have the error
>>>> "src/device.c:att_connect_cb() connect error: Transport endpoint is not
>>>> connected (107)"
>>>>
>>>>
>>>> To test my test case, I am using the head of Bluez (2a7df9323e, Sunday
>>>> 5th April).
>>>>
>>>> Here is the test case:
>>>>
>>>> 1. Start btvirt for BLE: sudo ./emulator/btvirt -L -U2 (you will
>>>> need my
>>>> patch to fix command line parsing I sent a couple of minutes ago)
>>>>
>>>> 2. Start bluetoothctl to initialize the Virtual Controller that would
>>>> play the role of GATT Server:
>>>>
>>>>      $ bluetoothctl
>>>>      [NEW] Controller DB:E3:2A:E8:90:C4 olivier-ThinkPad-T480 #2
>>>> [default]
>>>>      [NEW] Device E3:01:36:88:4C:DE TestAdvertisement
>>>>      [NEW] Controller E3:01:36:88:4C:DE olivier-ThinkPad-T480
>>>>      [NEW] Device DB:E3:2A:E8:90:C4 TestAdvertisement
>>>>
>>>>      [bluetooth]# list
>>>>      Controller DB:E3:2A:E8:90:C4 olivier-ThinkPad-T480 #2 [default]
>>>>      Controller E3:01:36:88:4C:DE olivier-ThinkPad-T480
>>>>
>>>>      [bluetooth]# power on
>>>>      Changing power on succeeded
>>>>      [CHG] Controller DB:E3:2A:E8:90:C4 Powered: yes
>>>>
>>>>      [bluetooth]# discoverable on
>>>>      Changing discoverable on succeeded
>>>>      [CHG] Controller DB:E3:2A:E8:90:C4 Discoverable: yes
>>> Try with advertise.discoverable on, advertise instances actually have
>>> their discoverable flag.
>>
>> I am not sure to understand how "advertise.discoverable on" will fix
>> my issue.
>>
>> I do not have any issue to discover the GATT server running on the
>> first instance of the virtual controller from the second one (see log
>> below).
>>
>> The only issue is when I try connecting to the GATT server with
>> 'connect DB:E3:2A:E8:90:C4', I have the error "Failed to connect:
>> org.bluez.Error.Failed" with the error in bluetoothd
>> "src/device.c:att_connect_cb() connect error: Transport endpoint is
>> not connected (107)".
>
> I still wanted to make sure "advertise.discoverable on" would not solve
> my issue. I have just tested with the latest bluez (commit 60423fed392a)
> by adding "menu advertise" + "discoverable on" to the steps to duplicate
> the issue. And I still see the error:
>
> bluetoothd[14755]: src/device.c:btd_device_set_temporary() temporary 0
> bluetoothd[14755]: src/device.c:device_connect_le() Connection attempt
> to: DB:E3:2A:E8:90:C4
> bluetoothd[14755]: src/device.c:att_connect_cb() connect error:
> Transport endpoint is not connected (107)
>

I was having similar issues with getting btvirt working. I resolved my
issue by using btmgmt to set the virtual adapter I was trying to
connect to have "connectable on".

As you can see below, the two virtual adapters are created without
being connectable:

pi@raspberrypi:~ $ btmgmt info | grep -P "hci|current settings"
hci2:   Primary controller
        current settings: powered bondable ssp br/edr le secure-conn
hci1:   Primary controller
        current settings: powered bondable ssp br/edr le secure-conn
hci0:   Primary controller
        current settings: powered connectable bondable ssp br/edr le secure-conn
pi@raspberrypi:~ $ sudo btmgmt --index 1 connectable on
hci1 Set Connectable complete, settings: powered connectable bondable
ssp br/edr le secure-conn
pi@raspberrypi:~ $ btmgmt info | grep -P "hci|current settings"
hci2:   Primary controller
        current settings: powered bondable ssp br/edr le secure-conn
hci1:   Primary controller
        current settings: powered connectable bondable ssp br/edr le secure-conn
hci0:   Primary controller
        current settings: powered connectable bondable ssp br/edr le secure-conn

>
>>
>>>>      [bluetooth]# advertise on
>>>>      [CHG] Controller DB:E3:2A:E8:90:C4 SupportedInstances: 0x04
>>>>      [CHG] Controller DB:E3:2A:E8:90:C4 ActiveInstances: 0x01
>>>>      Advertising object registered
>>>>
>>>>
>>>> 3. Use './test/example-gatt-server' to simulate GATT server. I confirm
>>>> the server is started on DB:E3:2A:E8:90:C4 (first virtual controller)
>>>>
>>>> 4. Return to bluetoothctl to switch to second virtual controller and
>>>> connect to the first one
>>>>
>>>>      [bluetooth]# select E3:01:36:88:4C:DE
>>>>      Controller E3:01:36:88:4C:DE olivier-ThinkPad-T480 [default]
>>>>
>>>>      [bluetooth]# power on
>>>>      Changing power on succeeded
>>>>      [CHG] Controller E3:01:36:88:4C:DE Powered: yes
>>>>
>>>>      [bluetooth]# scan on
>>>>      Discovery started
>>>>      [CHG] Controller E3:01:36:88:4C:DE Discovering: yes
>>>>      [NEW] Device DB:E3:2A:E8:90:C4
>>>>      [bluetooth]# scan off
>>>>      Discovery stopped
>>>>      [CHG] Controller E3:01:36:88:4C:DE Discovering: no
>>>>
>>>>      [bluetooth]# connect DB:E3:2A:E8:90:C4
>>>>      Attempting to connect to DB:E3:2A:E8:90:C4
>>>>      Failed to connect: org.bluez.Error.Failed
>>>>      [CHG] Controller DB:E3:2A:E8:90:C4 Discoverable: no
>>>>
>>>>
>>>> And in the bluetoothd log:
>>>>
>>>>      bluetoothd[15175]: src/adapter.c:start_discovery() sender :1.6483
>>>>      bluetoothd[15175]: src/adapter.c:update_discovery_filter()
>>>>      bluetoothd[15175]: src/adapter.c:discovery_filter_to_mgmt_cp()
>>>>      bluetoothd[15175]: src/adapter.c:trigger_start_discovery()
>>>>      bluetoothd[15175]: src/adapter.c:cancel_passive_scanning()
>>>>      bluetoothd[15175]: src/adapter.c:start_discovery_timeout()
>>>>      bluetoothd[15175]: src/adapter.c:start_discovery_timeout()
>>>> adapter->current_discovery_filter == 0
>>>>      bluetoothd[15175]: src/adapter.c:start_discovery_complete()
>>>> status 0x00
>>>>      bluetoothd[15175]: src/adapter.c:discovering_callback() hci0
>>>> type 6 discovering 1 method 0
>>>>      bluetoothd[15175]: src/adapter.c:device_found_callback() hci0
>>>> addr DB:E3:2A:E8:90:C4, rssi 0 flags 0x0000 eir_len 3
>>>>      bluetoothd[15175]: src/device.c:device_set_legacy() legacy 0
>>>>      bluetoothd[15175]: src/device.c:device_set_flags() flags 6
>>>>      bluetoothd[15175]: src/adapter.c:stop_discovery() sender :1.6483
>>>>      bluetoothd[15175]: src/adapter.c:stop_discovery_complete()
>>>> status 0x00
>>>>      bluetoothd[15175]: src/adapter.c:trigger_passive_scanning()
>>>>      bluetoothd[15175]: src/adapter.c:discovery_remove() owner :1.6483
>>>>      bluetoothd[15175]: src/adapter.c:discovering_callback() hci0
>>>> type 6 discovering 0 method 0
>>>>      bluetoothd[15175]: src/device.c:device_connect_le() Connection
>>>> attempt to: DB:E3:2A:E8:90:C4
>>>>      bluetoothd[15175]: src/device.c:att_connect_cb() connect error:
>>>> Transport endpoint is not connected (107)
>>>>
>>>
