Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50399C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jan 2022 07:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiAMHll (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jan 2022 02:41:41 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:43429 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiAMHlk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jan 2022 02:41:40 -0500
X-Greylist: delayed 128508 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jan 2022 02:41:40 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1642059695;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ggK5ZcrUmltwKBGfrGYL1b6ls2ue+xfTDJ4iAkfr18c=;
    b=CRB4Ks6XoFxmZ+6LfrtnpsdgHerPcfIRFJNpypkEXH68hbsGGGYI6FWxejswnGdeC3
    Ptaf2GYoNswOAeksIAIRD6m3BOO692A0tjjSl2J0aEh2a/gmq+hH75oGCJzqjiH0Bxcy
    cZbnmadOkiGBJm0xNBOZ4dJ10jFXBR1+DAkn3TA5DnfJSEgfx7aWu6ofAOgFfyad/yTG
    zsuMzo/2z1wqBXTwWszRDbuX7b5hb1lp8PqtIzz2YoFliJFvjZS4dnC10sh0F30/DQdU
    fPJ8B8N42KF+FGe3T176fgZLCw2fct6Wtm3NON1znO2NCK8sqVJpCX7pg2Dyg+/dFhjF
    hUhw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdd0DIgVuBOfXW6v7w=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfa:f900::b82]
    by smtp.strato.de (RZmta 47.37.6 AUTH)
    with ESMTPSA id Rb080by0D7fZIAA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 13 Jan 2022 08:41:35 +0100 (CET)
Message-ID: <d488ac98-1c09-71f3-d92b-47ebcb64bd8c@hartkopp.net>
Date:   Thu, 13 Jan 2022 08:41:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Latest Linux tree (merge window): BT mouse does not work
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <0015e594-d888-f664-56c3-f4022286c736@hartkopp.net>
 <CABBYNZLLDip=q4VGP5Mx8fNrdxd8oHfzDJY9+XYxe11nLCU+yw@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CABBYNZLLDip=q4VGP5Mx8fNrdxd8oHfzDJY9+XYxe11nLCU+yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 12.01.22 21:55, Luiz Augusto von Dentz wrote:
> Hi Oliver,
> 
> On Wed, Jan 12, 2022 at 12:07 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>> Hi all,
>>
>> after upgrading from Linus' tree 5.16.0-rc7-00108-g800829388818 to the
>> current merge window version 5.16.0-05432-g6f38be8f2ccd my BT mouse is
>> not working anymore.
>>
>> I now get two new error messages:
>>
>>          hci0: unexpected event 0xff length: 5 > 0
>>
>> and
>>
>>          hci0: unexpected event 0xff length: 7 > 0
> 
> These are vendor events which I don't think were being handled anyway,
> so it is likely something else that is preventing it to work.
> 

In the working 5.16.0-rc7 daemon log there are tons of warning messages 
instead that do not show up in 5.16.0-05432-g6f38be8f2ccd ...

>> Any idea? Any new firmware required?
>>
>> Best regards,
>> Oliver
>>
>> [    8.790201] Bluetooth: Core ver 2.22
>> [    8.847435] Bluetooth: hci0: Bootloader revision 0.0 build 26 week 38
>> 2015
>> [    8.853022] Bluetooth: hci0: Device revision is 16
>> [    8.853025] Bluetooth: hci0: Secure boot is enabled
>> [    8.853026] Bluetooth: hci0: OTP lock is enabled
>> [    8.853027] Bluetooth: hci0: API lock is enabled
>> [    8.853028] Bluetooth: hci0: Debug lock is disabled
>> [    8.853028] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
>> [    8.855879] Bluetooth: hci0: Found device firmware: intel/ibt-12-16.sfi
>>
>> [    9.422098] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>> [    9.423532] Bluetooth: BNEP filters: protocol multicast
>> [    9.423537] Bluetooth: BNEP socket layer initialized
>> [    9.439281] iwlwifi 0000:01:00.0 wlp1s0: renamed from wlan0
>> [   10.391796] Bluetooth: hci0: Waiting for firmware download to complete
>> [   10.392752] Bluetooth: hci0: unexpected event 0xff length: 5 > 0
>> [   10.392789] Bluetooth: hci0: Firmware loaded in 1492456 usecs
>> [   10.392985] Bluetooth: hci0: Waiting for device to boot
>> [   10.404942] Bluetooth: hci0: unexpected event 0xff length: 7 > 0
>> [   10.404971] Bluetooth: hci0: Device booted in 11747 usecs
>> [   10.405416] Bluetooth: hci0: Found Intel DDC parameters:
>> intel/ibt-12-16.ddc
>> [   10.407835] Bluetooth: hci0: Applying Intel DDC parameters completed
>> [   10.408848] Bluetooth: hci0: Firmware revision 0.1 build 50 week 12 2019
>> [   10.468582] NET: Registered PF_ALG protocol family
>> [   11.277319] Bluetooth: RFCOMM TTY layer initialized
>> [   11.277343] Bluetooth: RFCOMM socket layer initialized
>> [   11.277367] Bluetooth: RFCOMM ver 1.11
> 
> Can you attach the bluetoothd and btmon logs when you attempt to
> connect the mouse, at least for the logs above it does seem the
> firmware is being loaded properly.
> 

The BT mouse just is not connecting at all and the btmon says nothing 
(with the latest tree) - whatever I do with the mouse.


So this is the deamon.log output of the BROKEN 
5.16.0-05432-g6f38be8f2ccd (grepped for "blue"):

Jan 13 08:12:02 silver bluetoothd[540]: Bluetooth daemon 5.55
Jan 13 08:12:02 silver bluetoothd[540]: Starting SDP server
Jan 13 08:12:02 silver blueman-mechanism[465]: Unable to init server: 
Could not connect: Connection refused
Jan 13 08:12:02 silver bluetoothd[540]: Bluetooth management interface 
1.21 initialized
Jan 13 08:12:02 silver blueman-mechanism[465]: Unable to init server: 
Could not connect: Connection refused
Jan 13 08:12:02 silver NetworkManager[478]: <info>  [1642057922.9396] 
Loaded device plugin: NMBluezManager 
(/usr/lib/x86_64-linux-gnu/NetworkManager/1.30.0/libnm-device-plugin-bluetooth.so)
Jan 13 08:12:04 silver bluetoothd[540]: 
profiles/sap/server.c:sap_server_register() Sap driver initialization 
failed.
Jan 13 08:12:04 silver bluetoothd[540]: sap-server: Operation not 
permitted (1)
Jan 13 08:12:05 silver bluetoothd[540]: Endpoint registered: 
sender=:1.26 path=/MediaEndpoint/A2DPSink/sbc
Jan 13 08:12:05 silver bluetoothd[540]: Endpoint registered: 
sender=:1.26 path=/MediaEndpoint/A2DPSource/sbc
Jan 13 08:12:13 silver bluetoothd[540]: Endpoint unregistered: 
sender=:1.26 path=/MediaEndpoint/A2DPSink/sbc
Jan 13 08:12:13 silver bluetoothd[540]: Endpoint unregistered: 
sender=:1.26 path=/MediaEndpoint/A2DPSource/sbc
Jan 13 08:12:13 silver bluetoothd[540]: Endpoint registered: 
sender=:1.40 path=/MediaEndpoint/A2DPSink/sbc
Jan 13 08:12:13 silver bluetoothd[540]: Endpoint registered: 
sender=:1.40 path=/MediaEndpoint/A2DPSource/sbc
Jan 13 08:12:15 silver dbus-daemon[1235]: [session uid=1000 pid=1235] 
Activating via systemd: service name='org.bluez.obex' 
unit='obex.service' requested by ':1.47' (uid=1000 pid=1416 
comm="/usr/bin/python3 /usr/bin/blueman-applet ")
Jan 13 08:12:15 silver dbus-daemon[1235]: [session uid=1000 pid=1235] 
Successfully activated service 'org.bluez.obex'
Jan 13 08:12:45 silver systemd[1]: blueman-mechanism.service: Succeeded.


And this is the deamon.log output of the WORKING 
5.16.0-rc7-00108-g800829388818 (grepped for "blue"):

Jan 12 19:11:38 silver bluetoothd[578]: Bluetooth daemon 5.55
Jan 12 19:11:38 silver bluetoothd[578]: Starting SDP server
Jan 12 19:11:38 silver bluetoothd[578]: Bluetooth management interface 
1.21 initialized
Jan 12 19:11:38 silver dbus-daemon[484]: [system] Activating via 
systemd: service name='org.freedesktop.hostname1' 
unit='dbus-org.freedesktop.hostname1.service' requested by ':1.4' (uid=0 
pid=578 comm="/usr/libexec/bluetooth/bluetoothd ")
Jan 12 19:11:39 silver blueman-mechanism[479]: Unable to init server: 
Could not connect: Connection refused
Jan 12 19:11:39 silver blueman-mechanism[479]: Unable to init server: 
Could not connect: Connection refused
Jan 12 19:11:39 silver NetworkManager[490]: <info>  [1642011099.0811] 
Loaded device plugin: NMBluezManager 
(/usr/lib/x86_64-linux-gnu/NetworkManager/1.30.0/libnm-device-plugin-bluetooth.so)
Jan 12 19:11:40 silver bluetoothd[578]: 
profiles/sap/server.c:sap_server_register() Sap driver initialization 
failed.
Jan 12 19:11:40 silver bluetoothd[578]: sap-server: Operation not 
permitted (1)
Jan 12 19:11:40 silver bluetoothd[578]: Endpoint registered: 
sender=:1.26 path=/MediaEndpoint/A2DPSink/sbc
Jan 12 19:11:40 silver bluetoothd[578]: Endpoint registered: 
sender=:1.26 path=/MediaEndpoint/A2DPSource/sbc
Jan 12 19:12:08 silver systemd[1]: blueman-mechanism.service: Succeeded.
Jan 12 19:12:23 silver bluetoothd[578]: Endpoint unregistered: 
sender=:1.26 path=/MediaEndpoint/A2DPSink/sbc
Jan 12 19:12:23 silver bluetoothd[578]: Endpoint unregistered: 
sender=:1.26 path=/MediaEndpoint/A2DPSource/sbc
Jan 12 19:12:23 silver bluetoothd[578]: Endpoint registered: 
sender=:1.40 path=/MediaEndpoint/A2DPSink/sbc
Jan 12 19:12:23 silver bluetoothd[578]: Endpoint registered: 
sender=:1.40 path=/MediaEndpoint/A2DPSource/sbc
Jan 12 19:12:24 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:24 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:24 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:24 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:24 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:24 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:24 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:24 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:24 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:24 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:25 silver dbus-daemon[484]: [system] Activating via 
systemd: service name='org.blueman.Mechanism' 
unit='blueman-mechanism.service' requested by ':1.51' (uid=1000 pid=1407 
comm="/usr/bin/python3 /usr/bin/blueman-applet ")
Jan 12 19:12:25 silver blueman-mechanism[1542]: Unable to init server: 
Could not connect: Connection refused
Jan 12 19:12:25 silver dbus-daemon[1232]: [session uid=1000 pid=1232] 
Activating via systemd: service name='org.blueman.Applet' 
unit='blueman-applet.service' requested by ':1.52' (uid=1000 pid=1538 
comm="/usr/bin/python3 /usr/bin/blueman-tray ")
Jan 12 19:12:25 silver blueman-mechanism[1542]: Unable to init server: 
Could not connect: Connection refused
Jan 12 19:12:25 silver dbus-daemon[484]: [system] Successfully activated 
service 'org.blueman.Mechanism'
Jan 12 19:12:25 silver dbus-daemon[1232]: [session uid=1000 pid=1232] 
Successfully activated service 'org.blueman.Applet'
Jan 12 19:12:25 silver dbus-daemon[1232]: [session uid=1000 pid=1232] 
Activating via systemd: service name='org.bluez.obex' 
unit='obex.service' requested by ':1.43' (uid=1000 pid=1407 
comm="/usr/bin/python3 /usr/bin/blueman-applet ")
Jan 12 19:12:25 silver dbus-daemon[1232]: [session uid=1000 pid=1232] 
Successfully activated service 'org.bluez.obex'
Jan 12 19:12:25 silver blueman-applet[1546]: blueman-applet version 
2.1.4 starting
Jan 12 19:12:25 silver blueman-applet[1546]: There is an instance 
already running
Jan 12 19:12:25 silver systemd[1208]: blueman-applet.service: Succeeded.
Jan 12 19:12:56 silver systemd[1]: blueman-mechanism.service: Succeeded.
Jan 12 19:12:56 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:56 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:56 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:56 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:56 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:56 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:56 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:56 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:56 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:56 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:56 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:56 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:56 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:56 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 19:12:56 silver bluetoothd[578]: 
profiles/input/hog-lib.c:report_value_cb() bt_uhid_send: Invalid 
argument (22)
Jan 12 22:11:55 silver bluetoothd[578]: Terminating


Best regards,
Oliver
