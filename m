Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5401DC2BA1A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 23:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272DB2072A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 23:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDFXE3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:04:29 -0400
Received: from 12.mo7.mail-out.ovh.net ([178.33.107.167]:48876 "EHLO
        12.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgDFXE3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 19:04:29 -0400
X-Greylist: delayed 7199 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2020 19:04:28 EDT
Received: from player697.ha.ovh.net (unknown [10.108.42.176])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id 347AA15C52F
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2020 00:45:04 +0200 (CEST)
Received: from labapart.com (i577BCB24.versanet.de [87.123.203.36])
        (Authenticated sender: olivier@labapart.com)
        by player697.ha.ovh.net (Postfix) with ESMTPSA id E6C3B112EE927
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2020 22:45:03 +0000 (UTC)
Subject: btvirt with two virtual controllers: Cannot connect to GATT server
References: <6cf0d3da-a7d0-c820-3343-3f3722bae9a4@labapart.com>
To:     linux-bluetooth@vger.kernel.org
From:   Olivier MARTIN <olivier@labapart.com>
X-Forwarded-Message-Id: <6cf0d3da-a7d0-c820-3343-3f3722bae9a4@labapart.com>
Message-ID: <638ce0f7-3075-c7d2-57c4-55392f8f5e0a@labapart.com>
Date:   Tue, 7 Apr 2020 00:45:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6cf0d3da-a7d0-c820-3343-3f3722bae9a4@labapart.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Ovh-Tracer-Id: 12749690548979920460
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeggdduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepufhfvffhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepqfhlihhvihgvrhcuofettffvkffpuceoohhlihhvihgvrheslhgrsggrphgrrhhtrdgtohhmqeenucfkpheptddrtddrtddrtddpkeejrdduvdefrddvtdefrdefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepohhlihhvihgvrheslhgrsggrphgrrhhtrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,

I am trying to test BLE connection between two virtual controllers 
(created with 'btvirt'). But when trying to connect to the GATT server 
running on the first virtual controller, I have the error 
"src/device.c:att_connect_cb() connect error: Transport endpoint is not 
connected (107)"


To test my test case, I am using the head of Bluez (2a7df9323e, Sunday 
5th April).

Here is the test case:

1. Start btvirt for BLE: sudo ./emulator/btvirt -L -U2 (you will need my 
patch to fix command line parsing I sent a couple of minutes ago)

2. Start bluetoothctl to initialize the Virtual Controller that would 
play the role of GATT Server:

    $ bluetoothctl
    [NEW] Controller DB:E3:2A:E8:90:C4 olivier-ThinkPad-T480 #2 [default]
    [NEW] Device E3:01:36:88:4C:DE TestAdvertisement
    [NEW] Controller E3:01:36:88:4C:DE olivier-ThinkPad-T480
    [NEW] Device DB:E3:2A:E8:90:C4 TestAdvertisement

    [bluetooth]# list
    Controller DB:E3:2A:E8:90:C4 olivier-ThinkPad-T480 #2 [default]
    Controller E3:01:36:88:4C:DE olivier-ThinkPad-T480

    [bluetooth]# power on
    Changing power on succeeded
    [CHG] Controller DB:E3:2A:E8:90:C4 Powered: yes

    [bluetooth]# discoverable on
    Changing discoverable on succeeded
    [CHG] Controller DB:E3:2A:E8:90:C4 Discoverable: yes

    [bluetooth]# advertise on
    [CHG] Controller DB:E3:2A:E8:90:C4 SupportedInstances: 0x04
    [CHG] Controller DB:E3:2A:E8:90:C4 ActiveInstances: 0x01
    Advertising object registered


3. Use './test/example-gatt-server' to simulate GATT server. I confirm 
the server is started on DB:E3:2A:E8:90:C4 (first virtual controller)

4. Return to bluetoothctl to switch to second virtual controller and 
connect to the first one

    [bluetooth]# select E3:01:36:88:4C:DE
    Controller E3:01:36:88:4C:DE olivier-ThinkPad-T480 [default]

    [bluetooth]# power on
    Changing power on succeeded
    [CHG] Controller E3:01:36:88:4C:DE Powered: yes

    [bluetooth]# scan on
    Discovery started
    [CHG] Controller E3:01:36:88:4C:DE Discovering: yes
    [NEW] Device DB:E3:2A:E8:90:C4
    [bluetooth]# scan off
    Discovery stopped
    [CHG] Controller E3:01:36:88:4C:DE Discovering: no

    [bluetooth]# connect DB:E3:2A:E8:90:C4
    Attempting to connect to DB:E3:2A:E8:90:C4
    Failed to connect: org.bluez.Error.Failed
    [CHG] Controller DB:E3:2A:E8:90:C4 Discoverable: no


And in the bluetoothd log:

    bluetoothd[15175]: src/adapter.c:start_discovery() sender :1.6483
    bluetoothd[15175]: src/adapter.c:update_discovery_filter()
    bluetoothd[15175]: src/adapter.c:discovery_filter_to_mgmt_cp()
    bluetoothd[15175]: src/adapter.c:trigger_start_discovery()
    bluetoothd[15175]: src/adapter.c:cancel_passive_scanning()
    bluetoothd[15175]: src/adapter.c:start_discovery_timeout()
    bluetoothd[15175]: src/adapter.c:start_discovery_timeout() adapter->current_discovery_filter == 0
    bluetoothd[15175]: src/adapter.c:start_discovery_complete() status 0x00
    bluetoothd[15175]: src/adapter.c:discovering_callback() hci0 type 6 discovering 1 method 0
    bluetoothd[15175]: src/adapter.c:device_found_callback() hci0 addr DB:E3:2A:E8:90:C4, rssi 0 flags 0x0000 eir_len 3
    bluetoothd[15175]: src/device.c:device_set_legacy() legacy 0
    bluetoothd[15175]: src/device.c:device_set_flags() flags 6
    bluetoothd[15175]: src/adapter.c:stop_discovery() sender :1.6483
    bluetoothd[15175]: src/adapter.c:stop_discovery_complete() status 0x00
    bluetoothd[15175]: src/adapter.c:trigger_passive_scanning()
    bluetoothd[15175]: src/adapter.c:discovery_remove() owner :1.6483
    bluetoothd[15175]: src/adapter.c:discovering_callback() hci0 type 6 discovering 0 method 0
    bluetoothd[15175]: src/device.c:device_connect_le() Connection attempt to: DB:E3:2A:E8:90:C4
    bluetoothd[15175]: src/device.c:att_connect_cb() connect error: Transport endpoint is not connected (107)

