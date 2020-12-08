Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32014C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 11:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2C45239EB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 11:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgLHLaI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 06:30:08 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:50941 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgLHLaI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 06:30:08 -0500
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C2A4624000A;
        Tue,  8 Dec 2020 11:29:25 +0000 (UTC)
Message-ID: <e0087211e96b5f687401cba75e501cbffb9bf4c1.camel@hadess.net>
Subject: Re: sixaxis patch proposal
From:   Bastien Nocera <hadess@hadess.net>
To:     Lionel Jeanson <lionel.jeanson@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Tue, 08 Dec 2020 12:29:25 +0100
In-Reply-To: <CADrX+XvHL76f8mT29MO8xUGwKzhjeZTXqiSUAQnR5_JrCZ65_Q@mail.gmail.com>
References: <CAMxp894ThdL9qxNz49561WrDj3XhWxpFMf+9afMD9WqMbSPBbw@mail.gmail.com>
         <2fb922ffced103ba09571567366968d5462f9267.camel@hadess.net>
         <CAMxp8948=LGwO6NE_oij2WgXxzXCY7nByj_XmmhPZFMiookseA@mail.gmail.com>
         <699f55a2f9d574943af0b5cc80c47d08d48953f7.camel@hadess.net>
         <CAMxp897-xWxkcBfmjdXYUt6i3jLJ5ZJ67Vs8NZ_6ukBL9v+L6Q@mail.gmail.com>
         <42a369804808a2be8012b950a7db9f6ab8f27936.camel@hadess.net>
         <CADrX+XvHL76f8mT29MO8xUGwKzhjeZTXqiSUAQnR5_JrCZ65_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 2020-12-08 at 12:21 +0100, Lionel Jeanson wrote:
> My bad :
> 
> 
> 1) connect and pair :
> 
> 
> déc. 08 12:14:44 lionelux bluetoothd[16446]: sixaxis: compatible
> device connected: Sony PLAYSTATION(R)3 Controller (054C:0268
> /sys/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-
> 1:1.0/0003:054C:0268.0010/hidraw/hidraw0)
> déc. 08 12:14:44 lionelux bluetoothd[16446]:
> src/device.c:device_create() dst 44:D8:32:7E:6B:6A
> déc. 08 12:14:44 lionelux bluetoothd[16446]:
> src/device.c:device_new() address 44:D8:32:7E:6B:6A
> déc. 08 12:14:44 lionelux bluetoothd[16446]:
> src/device.c:device_new() Creating device
> /org/bluez/hci0/dev_44_D8_32_7E_6B_6A
> déc. 08 12:14:44 lionelux bluetoothd[16446]: sixaxis: setting up new
> device
> déc. 08 12:14:44 lionelux bluetoothd[16446]:
> src/device.c:btd_device_device_set_name()
> /org/bluez/hci0/dev_44_D8_32_7E_6B_6A Sony PLAYSTATION(R)3 Controller
> déc. 08 12:14:44 lionelux bluetoothd[16446]: src/agent.c:agent_ref()
> 0x5579c3bc4e70: ref=2
> déc. 08 12:14:44 lionelux bluetoothd[16446]:
> src/agent.c:agent_call_authorize_service() authorize service request
> was sent for /org/bluez/hci0/dev_44_D8_32_7E_6B_6A
> déc. 08 12:14:47 lionelux bluetoothd[16446]: src/agent.c:agent_ref()
> 0x5579c3bc4e70: ref=3
> déc. 08 12:14:47 lionelux bluetoothd[16446]:
> src/device.c:btd_device_set_trusted() trusted 1
> déc. 08 12:14:47 lionelux bluetoothd[16446]:
> src/device.c:btd_device_set_temporary() temporary 0
> déc. 08 12:14:47 lionelux bluetoothd[16446]:
> src/device.c:device_probe_profiles() Probing profiles for device
> 44:D8:32:7E:6B:6A
> déc. 08 12:14:47 lionelux bluetoothd[16446]:
> profiles/input/device.c:input_device_register()
> /org/bluez/hci0/dev_44_D8_32_7E_6B_6A
> déc. 08 12:14:47 lionelux bluetoothd[16446]:
> src/service.c:btd_service_ref() 0x5579c3bca4f0: ref=2
> déc. 08 12:14:47 lionelux bluetoothd[16446]:
> src/service.c:change_state() 0x5579c3bca4f0: device 44:D8:32:7E:6B:6A
> profile input-hid state changed: unavailable -> disconnected (0)
> déc. 08 12:14:47 lionelux bluetoothd[16446]:
> src/device.c:device_svc_resolved()
> /org/bluez/hci0/dev_44_D8_32_7E_6B_6A err 0
> déc. 08 12:14:47 lionelux bluetoothd[16446]:
> plugins/sixaxis.c:agent_auth_cb() remote 44:D8:32:7E:6B:6A old_master
> A4:34:D9:3F:36:93 new_master A4:34:D9:3F:36:93
> déc. 08 12:14:47 lionelux bluetoothd[16446]:
> src/agent.c:agent_unref() 0x5579c3bc4e70: ref=2
> déc. 08 12:14:47 lionelux bluetoothd[16446]:
> src/agent.c:agent_unref() 0x5579c3bc4e70: ref=1
> déc. 08 12:14:47 lionelux bluetoothd[16446]:
> src/adapter.c:add_whitelist_complete() 44:D8:32:7E:6B:6A added to
> kernel whitelist
> déc. 08 12:14:47 lionelux bluetoothd[16446]: Set device flags return
> status: Unknown Command

What's the output of:
bluetoothctl info for the device after this?

Also, long-pressing the PS button on PS3 joypads will start a new one-
time pairing, making the device visible. I don't think that's what you
want to do.

The only way to turn off the joypad is to "disconnect" from it via
Bluetooth, IIRC.

