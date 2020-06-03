Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF414C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 09:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E4B2074B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 09:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgOUoIEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgFCJkX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgFCJkW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 05:40:22 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAA3C05BD43
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 02:40:21 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id i16so1448545qtr.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 02:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uJfn5hulAXHA6lsejOnOvGaLizMW9BuzMeLyaNu8eLI=;
        b=XgOUoIEbrAzNM0lWQifcXagw+Ax9YiQmuHiIITTssiam3rUneA5eImqmP/+qUUQeE0
         dN+doXX8Z1qPMeumtd8qE9cKhO8C33JaVucZx1bE5mE+axiPULyRTaMiE9AGjHi5L7xy
         hT8q5yXtgIgqhTl1urRng1lmdV7Y4Xwf5i3Fjs3v5quF+g3wJOPdm4jBfo40FHSMq1Tw
         7FjdtKoeleJb585VL2eML4ZWSweaXZ/AzGtXZj0pLHoM4JvssXhQLg6F3herfMZ5UfPM
         k4z4DXIY07B6TguxlsjSyP3pa+VS2KTf2CgRbDua69TS6EZc0h9e9mT4n//iLQcoggHP
         LyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=uJfn5hulAXHA6lsejOnOvGaLizMW9BuzMeLyaNu8eLI=;
        b=mvh8mdkFU2ZWC4Xos1LZ+6qTQ9urIhRu/iGSjcSGjaJW4yM32AOZd3PDdhu9XRtjjZ
         L1BUweIfkE/T3CH1npa5URh+uSrGuCeM9vGglZZwfl+0ms68s1OwPSrlzi4BNj+ZgZbZ
         5yovQVl3fZdaw9cTpVCPoPNVq0QZV4CWJnlMdFio2oE3PgqKK4pmidup5R+5Wra456gB
         5JdmzxL8HajBvt4YpAKGdwMoxZnr5TsY7ORdT3zmiZIWgmHICQbO1dMASQUE3GmEv2u/
         WV1Wprg/96GuAoKHRN/Ja/N/KpTW5cxNwGx8dNvKoYiiZAkYF5dQvPP7LXoWzI7H1x4Q
         ZO9g==
X-Gm-Message-State: AOAM533pxqnMomiowvzh47Xz5cyQ5KaUUukThK8EcKoVzZR0BnGNIpLg
        smQ6QPGqENU6E0noJeVNIB2tA6STYr1ViYvmti0QCWUfXUk=
X-Google-Smtp-Source: ABdhPJwZ/7oijvcXWmlez8M50fDH8b4n0zoey7xFvSMC8nMva+IPu/+0WR/HtfR6APpMjcUxZ4Uq7SouZP5TvH8bu8Y=
X-Received: by 2002:aed:35af:: with SMTP id c44mr31913751qte.349.1591177220225;
 Wed, 03 Jun 2020 02:40:20 -0700 (PDT)
MIME-Version: 1.0
From:   Arthur Lambert <lambertarthur22@gmail.com>
Date:   Wed, 3 Jun 2020 11:40:09 +0200
Message-ID: <CAGpqJgrBtwdauxv03jXsq+8+EG_BW-4QZXryXt-e5Y8HA_5+_g@mail.gmail.com>
Subject: Segmentation fault in bluetoothd with btgatt-client
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I am working on an embedded device with Bluez 5.54.
My bluez init script for the bluetoothd demon :

# cat /etc/init.d/S19_bluez
#!/bin/sh

start() {
echo -n "Starting $0: "
#bluetoothd -dE&
echo "Done."
}

(...)

To initialize my hci0, we are using btmgmt :

/usr/bin/btmgmt -i hci0 power off
/usr/bin/btmgmt -i hci0 le on
/usr/bin/btmgmt -i hci0 bredr on
/usr/bin/btmgmt -i hci0 connectable on
/usr/bin/btmgmt -i hci0 bondable on
/usr/bin/btmgmt -i hci0 discov on
/usr/bin/btmgmt -i hci0 name XXXXX-HEADBAND-V2
/usr/bin/btmgmt -i hci0 advertising on
/usr/bin/btmgmt -i hci0 power on

Log from bluetoothd:

# valgrind --leak-check=3Dno --show-reachable=3Dno
--show-possibly-lost=3Dno --track-origins=3Dyes bluetoothd -dEn
=3D=3D237=3D=3D Memcheck, a memory error detector
=3D=3D237=3D=3D Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et=
 al.
=3D=3D237=3D=3D Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyrig=
ht info
=3D=3D237=3D=3D Command: bluetoothd -dEn
=3D=3D237=3D=3D
=3D=3D237=3D=3D Invalid read of size 4
=3D=3D237=3D=3D    at 0x4005458: _dl_get_ready_to_run (in /lib/ld-uClibc-1.=
0.31.so)
=3D=3D237=3D=3D  Address 0x7dffc934 is on thread 1's stack
=3D=3D237=3D=3D  20 bytes below stack pointer
=3D=3D237=3D=3D
=3D=3D237=3D=3D Invalid read of size 4
=3D=3D237=3D=3D    at 0x4B05AB8: __uClibc_main (in /lib/libuClibc-1.0.31.so=
)
=3D=3D237=3D=3D  Address 0x7dffcbec is on thread 1's stack
=3D=3D237=3D=3D  20 bytes below stack pointer
=3D=3D237=3D=3D
bluetoothd[237]: Bluetooth daemon 5.54
bluetoothd[237]: src/main.c:parse_config() parsing /etc/bluetooth/main.conf
bluetoothd[237]: src/main.c:parse_config() Key file does not have key
=E2=80=9CDiscoverableTimeout=E2=80=9D in group =E2=80=9CGeneral=E2=80=9D
bluetoothd[237]: src/main.c:parse_config() Key file does not have key
=E2=80=9CAlwaysPairable=E2=80=9D in group =E2=80=9CGeneral=E2=80=9D
bluetoothd[237]: src/main.c:parse_config() Key file does not have key
=E2=80=9CPairableTimeout=E2=80=9D in group =E2=80=9CGeneral=E2=80=9D
bluetoothd[237]: src/main.c:parse_config() Key file does not have key
=E2=80=9CPrivacy=E2=80=9D in group =E2=80=9CGeneral=E2=80=9D
bluetoothd[237]: src/main.c:parse_config() Key file does not have key
=E2=80=9CJustWorksRepairing=E2=80=9D in group =E2=80=9CGeneral=E2=80=9D
bluetoothd[237]: src/main.c:parse_config() name=3DXXXXX-HEADBAND-V2
bluetoothd[237]: src/main.c:parse_config() Key file does not have key
=E2=80=9CClass=E2=80=9D in group =E2=80=9CGeneral=E2=80=9D
bluetoothd[237]: src/main.c:parse_config() Key file does not have key
=E2=80=9CDeviceID=E2=80=9D in group =E2=80=9CGeneral=E2=80=9D
bluetoothd[237]: src/main.c:parse_config() Key file does not have key
=E2=80=9CReverseServiceDiscovery=E2=80=9D in group =E2=80=9CGeneral=E2=80=
=9D
bluetoothd[237]: src/main.c:parse_config() Key file does not have group =E2=
=80=9CGATT=E2=80=9D
bluetoothd[237]: src/main.c:parse_config() Key file does not have group =E2=
=80=9CGATT=E2=80=9D
bluetoothd[237]: src/main.c:parse_config() Key file does not have group =E2=
=80=9CGATT=E2=80=9D
bluetoothd[237]: src/main.c:parse_config() Key file does not have group =E2=
=80=9CGATT=E2=80=9D
bluetoothd[237]: src/adapter.c:adapter_init() sending read version command
bluetoothd[237]: Starting SDP server
bluetoothd[237]: src/sdpd-service.c:register_device_id() Adding device
id record for 0002:1d6b:0246:0536
bluetoothd[237]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[237]: src/plugin.c:add_plugin() Loading hostname plugin
bluetoothd[237]: src/plugin.c:add_plugin() Loading wiimote plugin
bluetoothd[237]: src/plugin.c:add_plugin() Loading autopair plugin
bluetoothd[237]: src/plugin.c:add_plugin() Loading policy plugin
bluetoothd[237]: src/plugin.c:add_plugin() Loading network plugin
bluetoothd[237]: src/plugin.c:add_plugin() Loading input plugin
bluetoothd[237]: src/plugin.c:add_plugin() Loading hog plugin
bluetoothd[237]: src/plugin.c:add_plugin() Loading gap plugin
bluetoothd[237]: src/plugin.c:add_plugin() Loading scanparam plugin
bluetoothd[237]: src/plugin.c:add_plugin() Loading deviceinfo plugin
bluetoothd[237]: src/plugin.c:plugin_init() Loading plugins
/usr/lib/bluetooth/plugins
bluetoothd[237]: profiles/input/suspend-none.c:suspend_init()
bluetoothd[237]: profiles/network/manager.c:read_config() Config
options: Security=3Dtrue
bluetoothd[237]: Failed to open RFKILL control device
bluetoothd[237]: src/main.c:main() Entering main loop
bluetoothd[237]: Bluetooth management interface 1.9 initialized
bluetoothd[237]: src/adapter.c:read_version_complete() sending read
supported commands command
bluetoothd[237]: src/adapter.c:read_version_complete() sending read
index list command
bluetoothd[237]: src/adapter.c:read_commands_complete() Number of commands:=
 61
bluetoothd[237]: src/adapter.c:read_commands_complete() Number of events: 3=
4
bluetoothd[237]: src/adapter.c:read_commands_complete() enabling
kernel-side connection control
bluetoothd[237]: src/adapter.c:read_index_list_complete() Number of
controllers: 0
bluetoothd[237]: src/adapter.c:index_added() index 0
bluetoothd[237]: src/adapter.c:btd_adapter_new() System name: XXXXXX-HEADBA=
ND-V2
bluetoothd[237]: src/adapter.c:btd_adapter_new() Major class: 0
bluetoothd[237]: src/adapter.c:btd_adapter_new() Minor class: 0
bluetoothd[237]: src/adapter.c:btd_adapter_new() Modalias: usb:v1D6Bp0246d0=
536
bluetoothd[237]: src/adapter.c:btd_adapter_new() Discoverable timeout:
180 seconds
bluetoothd[237]: src/adapter.c:btd_adapter_new() Pairable timeout: 0 second=
s
bluetoothd[237]: src/adapter.c:index_added() sending read info command
for index 0
bluetoothd[237]: src/adapter.c:read_info_complete() index 0 status 0x00
bluetoothd[237]: src/adapter.c:clear_uuids() sending clear uuids
command for index 0
bluetoothd[237]: src/adapter.c:clear_devices() sending clear devices
command for index 0
bluetoothd[237]: src/adapter.c:set_mode() sending set mode command for inde=
x 0
bluetoothd[237]: src/adapter.c:set_mode() sending set mode command for inde=
x 0
bluetoothd[237]: src/adapter.c:set_mode() sending set mode command for inde=
x 0
bluetoothd[237]: src/adapter.c:set_privacy() sending set privacy
command for index 0
bluetoothd[237]: src/adapter.c:set_privacy() setting privacy mode 0x00
for index 0
bluetoothd[237]: src/gatt-database.c:btd_gatt_database_new() GATT
Manager registered for adapter: /org/bluez/hci0
bluetoothd[237]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[237]: src/sdpd-service.c:add_record_to_server() Adding
record with handle 0x10001
bluetoothd[237]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000007-0000-1000-8000-00805f9
bluetoothd[237]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[237]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[237]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001800-0000-1000-8000-00805f9
bluetoothd[237]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[237]: src/adapter.c:add_uuid() sending add uuid command for inde=
x 0
bluetoothd[237]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[237]: src/sdpd-service.c:add_record_to_server() Adding
record with handle 0x10002
bluetoothd[237]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000007-0000-1000-8000-00805f9
bluetoothd[237]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[237]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[237]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001801-0000-1000-8000-00805f9
bluetoothd[237]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[237]: src/adapter.c:add_uuid() sending add uuid command for inde=
x 0
bluetoothd[237]: src/advertising.c:btd_adv_manager_new() LE
Advertising Manager created for adapter: /org/bluez/hci0
bluetoothd[237]: plugins/hostname.c:hostname_probe()
bluetoothd[237]: profiles/network/manager.c:panu_server_probe() path
/org/bluez/hci0
bluetoothd[237]: profiles/network/server.c:server_register()
Registered interface org.bluez.NetworkServer1 on path /org/bluez/hci0
bluetoothd[237]: profiles/network/manager.c:gn_server_probe() path
/org/bluez/hci0
bluetoothd[237]: profiles/network/manager.c:nap_server_probe() path
/org/bluez/hci0
bluetoothd[237]: src/adapter.c:btd_adapter_unblock_address() hci0
00:00:00:00:00:00
bluetoothd[237]: src/adapter.c:load_link_keys() hci0 keys 0 debug_keys 0
bluetoothd[237]: src/adapter.c:load_ltks() hci0 keys 0
bluetoothd[237]: src/adapter.c:load_irks() hci0 irks 0
bluetoothd[237]: src/adapter.c:load_conn_params() hci0 conn params 0
bluetoothd[237]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[237]: src/adapter.c:add_uuid() sending add uuid command for inde=
x 0
bluetoothd[237]: src/adapter.c:set_did() hci0 source 2 vendor 1d6b
product 246 version 536
bluetoothd[237]: src/adapter.c:adapter_register() Adapter
/org/bluez/hci0 registered
bluetoothd[237]: src/adapter.c:set_dev_class() sending set device
class command for index 0
bluetoothd[237]: src/adapter.c:set_name() sending set local name
command for index 0
bluetoothd[237]: src/adapter.c:new_settings_callback() Settings: 0x00000280
bluetoothd[237]: src/adapter.c:settings_changed() Changed settings: 0x00000=
200
bluetoothd[237]: src/adapter.c:settings_changed() Pending settings: 0x00000=
000
bluetoothd[237]: src/adapter.c:new_settings_callback() Settings: 0x00000282
bluetoothd[237]: src/adapter.c:settings_changed() Changed settings: 0x00000=
002
bluetoothd[237]: src/adapter.c:settings_changed() Pending settings: 0x00000=
000
bluetoothd[237]: src/adapter.c:new_settings_callback() Settings: 0x00000292
bluetoothd[237]: src/adapter.c:settings_changed() Changed settings: 0x00000=
010
bluetoothd[237]: src/adapter.c:settings_changed() Pending settings: 0x00000=
000
bluetoothd[237]: src/adapter.c:new_settings_callback() Settings: 0x0000029a
bluetoothd[237]: src/adapter.c:settings_changed() Changed settings: 0x00000=
008
bluetoothd[237]: src/adapter.c:settings_changed() Pending settings: 0x00000=
000
bluetoothd[237]: src/adapter.c:local_name_changed_callback() Name: TESTBENC=
H-V2
bluetoothd[237]: src/adapter.c:local_name_changed_callback() Short name:
bluetoothd[237]: src/adapter.c:local_name_changed_callback() Current
alias: TESTBENCH-V2
bluetoothd[237]: src/adapter.c:new_settings_callback() Settings: 0x0000069a
bluetoothd[237]: src/adapter.c:settings_changed() Changed settings: 0x00000=
400
bluetoothd[237]: src/adapter.c:settings_changed() Pending settings: 0x00000=
000
bluetoothd[237]: Failed to clear UUIDs: Busy (0x0a)
bluetoothd[237]: src/adapter.c:new_settings_callback() Settings: 0x0000069b
bluetoothd[237]: src/adapter.c:settings_changed() Changed settings: 0x00000=
001
bluetoothd[237]: src/adapter.c:settings_changed() Pending settings: 0x00000=
000
bluetoothd[237]: src/adapter.c:adapter_start() adapter /org/bluez/hci0
has been enabled
bluetoothd[237]: src/adapter.c:trigger_passive_scanning()
bluetoothd[237]: src/adapter.c:new_settings_callback() Settings: 0x000006db
bluetoothd[237]: src/adapter.c:settings_changed() Changed settings: 0x00000=
040
bluetoothd[237]: src/adapter.c:settings_changed() Pending settings: 0x00000=
000
bluetoothd[237]: src/adapter.c:new_settings_callback() Settings: 0x00000edb
bluetoothd[237]: src/adapter.c:settings_changed() Changed settings: 0x00000=
800
bluetoothd[237]: src/adapter.c:settings_changed() Pending settings: 0x00000=
000
bluetoothd[237]: Failed to set privacy: Rejected (0x0b)
bluetoothd[237]: src/adapter.c:load_link_keys_complete() link keys
loaded for hci0
bluetoothd[237]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
bluetoothd[237]: src/adapter.c:load_irks_complete() IRKs loaded for hci0
bluetoothd[237]: src/adapter.c:load_conn_params_complete() Connection
Parameters loaded for hci0
bluetoothd[237]: src/adapter.c:local_name_changed_callback() Name:
XXXXXX-HEADBAND-V2
bluetoothd[237]: src/adapter.c:local_name_changed_callback() Short name:
bluetoothd[237]: src/adapter.c:local_name_changed_callback() Current
alias: XXXXXXX-HEADBAND-V2

# run btgatt client here...

bluetoothd[237]: src/adapter.c:connected_callback() hci0 device
80:32:53:37:58:A6 connected eir_len 0
bluetoothd[237]: src/device.c:device_create() dst 80:32:53:37:58:A6
bluetoothd[237]: src/device.c:device_new() address 80:32:53:37:58:A6
bluetoothd[237]: src/device.c:device_new() Creating device
/org/bluez/hci0/dev_80_32_53_37_58_A6
bluetoothd[237]: src/gatt-database.c:connect_cb() New incoming LE ATT conne=
ction
bluetoothd[237]: attrib/gattrib.c:g_attrib_ref() 0x4c56848: g_attrib_ref=3D=
1
bluetoothd[237]: src/device.c:load_gatt_db() Restoring
80:32:53:37:58:A6 gatt database from file
bluetoothd[237]: No cache for 80:32:53:37:58:A6
bluetoothd[237]: src/gatt-client.c:btd_gatt_client_connected() Device conne=
cted.
bluetoothd[237]: src/device.c:gatt_debug() MTU exchange complete, with MTU:=
 256
bluetoothd[237]: src/device.c:gatt_debug() Read By Type - start:
0x0001 end: 0xffff
bluetoothd[237]: src/device.c:gatt_debug() MTU Exchange failed. ATT ECODE: =
0x06
bluetoothd[237]: src/device.c:gatt_debug() Read By Grp Type - start:
0x0001 end: 0xffff
bluetoothd[237]: src/device.c:gatt_debug() Read By Type - start:
0x0010 end: 0xffff
bluetoothd[237]: src/device.c:gatt_debug() Primary service discovery
failed. ATT ECODE: 0x06
bluetoothd[237]: src/device.c:gatt_debug() Failed to initialize gatt-client
bluetoothd[237]: src/device.c:gatt_client_ready_cb() status: failed, error:=
 6
bluetoothd[237]: src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_80_32_53_37_58_A6 err -5
bluetoothd[237]: src/device.c:gatt_debug() Read By Grp Type - start:
0x0010 end: 0xffff
bluetoothd[237]: src/device.c:gatt_debug() Read By Grp Type - start:
0x0001 end: 0xffff
bluetoothd[237]: src/device.c:gatt_debug() Read By Type - start:
0x0001 end: 0x000f
bluetoothd[237]: src/device.c:gatt_debug() Read By Type - start:
0x0001 end: 0x000f
bluetoothd[237]: src/device.c:gatt_debug() Read By Type - start:
0x000f end: 0x000f
bluetoothd[237]: src/device.c:gatt_debug() Read By Type - start:
0x0001 end: 0xffff
bluetoothd[237]: src/gatt-database.c:db_hash_read_cb() Database Hash read
=3D=3D237=3D=3D Invalid read of size 1
=3D=3D237=3D=3D    at 0x4831BA4: memcpy (vg_replace_strmem.c:1035)
=3D=3D237=3D=3D    by 0x79E1B: ??? (in /usr/bin/bluetoothd)
=3D=3D237=3D=3D  Address 0x0 is not stack'd, malloc'd or (recently) free'd
=3D=3D237=3D=3D
=3D=3D237=3D=3D
=3D=3D237=3D=3D Process terminating with default action of signal 11 (SIGSE=
GV)
=3D=3D237=3D=3D  Access not within mapped region at address 0x0
=3D=3D237=3D=3D    at 0x4831BA4: memcpy (vg_replace_strmem.c:1035)
=3D=3D237=3D=3D    by 0x79E1B: ??? (in /usr/bin/bluetoothd)
=3D=3D237=3D=3D  If you believe this happened as a result of a stack
=3D=3D237=3D=3D  overflow in your program's main thread (unlikely but
=3D=3D237=3D=3D  possible), you can try to increase the size of the
=3D=3D237=3D=3D  main thread stack using the --main-stacksize=3D flag.
=3D=3D237=3D=3D  The main thread stack size used in this run was 8388608.
/usr/bin/bluetoothd: can't resolve symbol '__libc_freeres'
=3D=3D237=3D=3D
=3D=3D237=3D=3D HEAP SUMMARY:
=3D=3D237=3D=3D     in use at exit: 40,320 bytes in 860 blocks
=3D=3D237=3D=3D   total heap usage: 4,297 allocs, 3,437 frees, 981,133 byte=
s allocated
=3D=3D237=3D=3D
=3D=3D237=3D=3D For a detailed leak analysis, rerun with: --leak-check=3Dfu=
ll
=3D=3D237=3D=3D
=3D=3D237=3D=3D For counts of detected and suppressed errors, rerun with: -=
v
=3D=3D237=3D=3D ERROR SUMMARY: 57 errors from 3 contexts (suppressed: 0 fro=
m 0)
Segmentation fault

From my host, I run this command to trigger the segmentation fault :
[arthur ] sudo ./btgatt-client -i hci0 -d cc:c0:79:ce:f9:56 -m 256
Connecting to device... Done
[GATT client]# Service Added - UUID:
00001800-0000-1000-8000-00805f9b34fb start: 0x0001 end: 0x0005
[GATT client]# Service Added - UUID:
00001801-0000-1000-8000-00805f9b34fb start: 0x0006 end: 0x000f
[GATT client]# GATT discovery procedures failed - error code: 0x00
[GATT client]# Device disconnected: Connection reset by peer
Shutting down...

When I run the test with btgatt-client from 5.50 release, there is no issue=
.
Is it normal?
