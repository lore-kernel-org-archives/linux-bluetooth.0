Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8369EEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 19:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjF0TO3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjF0TO1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 15:14:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D18CE52
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 12:14:25 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6a1fe5845so40231101fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687893263; x=1690485263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leubk9fGuvc32gjxSuNpo0WRzTUx0CV/wp3y3lpX+2A=;
        b=XCN33yEArw387RdrM/i9JSo7VkASNJMvgIKjhaDwl9MsZ6ikn44/naUyjgMUvmXcVf
         yLbpzNWKNOY9AVEIvdNtHtzdtfymyFD9XEF3kEkQRmrhY08AYrEE+cX/mwPo0Xs5x9WZ
         IiLE4NqtvvKbn8/zJTBbiKfhSLWNA2c4npIjec3zdGuWx4kGMASJGARCv0nQli9MMDQ6
         t9nD27kjzENgJqNGY2i/JGY8aIrqJBZaQnXWeCIqoxdIVGyQ+dbsM8I5+5Bq/W18tMVm
         LAH2NViLPhPULEfKCunBfjHSXBbhcP7w1V8JmfSo8unjFvuekQev0AVXa88A7ERb7wpu
         MU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687893263; x=1690485263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leubk9fGuvc32gjxSuNpo0WRzTUx0CV/wp3y3lpX+2A=;
        b=ENdnLGSfeIdLXApQSvmvjlbguUUpM1xXDtcp7JkQG/9hTqY8TsmX2oG3voCrpiwm7w
         XXfiy5hipQ3tFmfqv9YyvJvbfmNrKGkOhPQ6e9FkV/f39EYcwDuj7HDLjzTG7NuEWf5O
         l0adsT08/3tUjPv6W6PNDstRNHO7lrK9TeP6+vqpRz/qvhE20iT87D7ZZP6uyN892oM3
         KlYB0HVrl0S7ar+VG9fcwoFE1705roRdumpJuP6vp39yYANJkX8Kj6wzrt20tTZpCAJI
         ssOKYaOIZyEa34nmtnmx5aVg0sVBm/Td2mPwGuo2MyvPdT6cV2cwZCRwgXrvnoFQ33d/
         oQEg==
X-Gm-Message-State: AC+VfDzGopYxMkfC+ysRoeIQEPJWiewZp8QakQ7QV285BqZNgGZGjFws
        /MO6Rke++PIc8MpnAlTy/OajSyujExFXqA1oVSI=
X-Google-Smtp-Source: ACHHUZ4KQ2JBafgbu03fbJYJ06NTnor3AytF71WqyPuCaLy1MJOr/MOJ5mbsfpXin6hYknXBQ9bNVtsHMbexvNFB8ww=
X-Received: by 2002:a05:651c:207:b0:2b4:7d01:f174 with SMTP id
 y7-20020a05651c020700b002b47d01f174mr17996766ljn.13.1687893262860; Tue, 27
 Jun 2023 12:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230612133251.194-1-nitin.jadhav@nxp.com> <20230612133251.194-4-nitin.jadhav@nxp.com>
 <9239cf4864abf17bd50ece04ef4c93e9d8aecf8b.camel@iki.fi>
In-Reply-To: <9239cf4864abf17bd50ece04ef4c93e9d8aecf8b.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Jun 2023 12:14:10 -0700
Message-ID: <CABBYNZLDti7gguuJFd8TZJxnaN7HM1B_4dim=FRPXmx52zsmHQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 3/3] shared/vcp.c: Make VOCS as an included
 service of VCS
To:     Pauli Virtanen <pav@iki.fi>
Cc:     Nitin Jadhav <nitin.jadhav@nxp.com>,
        linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli, Nitin,

On Tue, Jun 27, 2023 at 12:05=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ma, 2023-06-12 kello 19:02 +0530, Nitin Jadhav kirjoitti:
> > Fixed the following issue observed during PTS testing
> > - Specified Upper and Lower Limit for Volume offset
> > - Corrected the number of handles for VOCS
> > - VOCS is made as included service of VCS
> >   (VOCS is secondary service and VSC is primary service)
>
> I'm seeing a crash on BlueZ master branch
> 6b9d167034b741605c3186e78e9742dda8e28e08 with this patch, when trying
> pair LE Audio TWS earbuds, with ControllerMode=3Dle and experimental
> features enabled in config and sound server with BAP support running.
> It seems to crash reproducibly here during pairing. Also trying to
> connect to previously paired BlueZ<->BlueZ seems to crash.
>
> Reverting commit d2d2d12f59d65002c4a671a5af1837f295181142
> ("shared/vcp.c: Make VOCS as an included service of VCS") makes it to
> not crash any more. Didn't try to look so far into detail if it's
> directly related to this patch, but something in VCP might not be quite
> right.

Yep, Ive seem this as well, looks like we need to work on a unit
tester to avoid such regressions to be introduced, in the meantime Im
using -P vcp to exclude vcp for now.

> Logs:
>
> bluetoothd[38339]: src/device.c:gatt_client_ready_cb() status: success, e=
rror: 0
> bluetoothd[38339]: src/device.c:update_gatt_uuids() UUID Added: 00001800-=
0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: src/device.c:update_gatt_uuids() UUID Added: 00001801-=
0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: src/device.c:update_gatt_uuids() UUID Added: 0000180a-=
0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: src/device.c:update_gatt_uuids() UUID Added: 0000180f-=
0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: src/device.c:update_gatt_uuids() UUID Added: 0000180f-=
0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: src/device.c:update_gatt_uuids() UUID Added: a7a473e9-=
19c6-491b-aea6-7ea92b8f043a
> bluetoothd[38339]: src/device.c:update_gatt_uuids() UUID Added: 0000184f-=
0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: src/device.c:update_gatt_uuids() UUID Added: 0000184e-=
0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: src/device.c:update_gatt_uuids() UUID Added: 00001850-=
0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: src/device.c:update_gatt_uuids() UUID Added: 0000184d-=
0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: src/device.c:update_gatt_uuids() UUID Added: 00001844-=
0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: src/device.c:update_gatt_uuids() UUID Added: 00001855-=
0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: src/device.c:update_gatt_uuids() UUID Added: 00008fe1-=
0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: src/device.c:update_gatt_uuids() UUID Added: 00001846-=
0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: src/device.c:update_gatt_uuids() UUID Added: 00001853-=
0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: src/device.c:device_probe_profiles() Probing profiles =
for device 28:3D:C2:4A:7D:2A
> bluetoothd[38339]: profiles/gap/gas.c:gap_probe() GAP profile probe (28:3=
D:C2:4A:7D:2A)
> bluetoothd[38339]: src/service.c:change_state() 0x6040000409d0: device 28=
:3D:C2:4A:7D:2A profile gap-profile state changed: unavailable -> disconnec=
ted (0)
> bluetoothd[38339]: profiles/gap/gas.c:gap_accept() GAP profile accept (28=
:3D:C2:4A:7D:2A)
> bluetoothd[38339]: profiles/gap/gas.c:handle_characteristic() Unsupported=
 characteristic: 00002aa6-0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: src/service.c:change_state() 0x6040000409d0: device 28=
:3D:C2:4A:7D:2A profile gap-profile state changed: disconnected -> connecte=
d (0)
> bluetoothd[38339]: src/device.c:device_probe_profiles() Probing profiles =
for device 28:3D:C2:4A:7D:2A
> bluetoothd[38339]: src/device.c:device_probe_profiles() Probing profiles =
for device 28:3D:C2:4A:7D:2A
> bluetoothd[38339]: src/service.c:change_state() 0x604000040cd0: device 28=
:3D:C2:4A:7D:2A profile deviceinfo state changed: unavailable -> disconnect=
ed (0)
> bluetoothd[38339]: profiles/deviceinfo/deviceinfo.c:deviceinfo_accept() d=
eviceinfo profile accept (28:3D:C2:4A:7D:2A)
> bluetoothd[38339]: profiles/deviceinfo/deviceinfo.c:handle_characteristic=
() Unsupported characteristic: 00002a29-0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: profiles/deviceinfo/deviceinfo.c:handle_characteristic=
() Unsupported characteristic: 00002a24-0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: profiles/deviceinfo/deviceinfo.c:handle_characteristic=
() Unsupported characteristic: 00002a25-0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: profiles/deviceinfo/deviceinfo.c:handle_characteristic=
() Unsupported characteristic: 00002a27-0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: profiles/deviceinfo/deviceinfo.c:handle_characteristic=
() Unsupported characteristic: 00002a26-0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: profiles/deviceinfo/deviceinfo.c:handle_characteristic=
() Unsupported characteristic: 00002a28-0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: profiles/deviceinfo/deviceinfo.c:handle_characteristic=
() Unsupported characteristic: 00002a23-0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: profiles/deviceinfo/deviceinfo.c:handle_characteristic=
() Unsupported characteristic: 00002a2a-0000-1000-8000-00805f9b34fb
> bluetoothd[38339]: src/service.c:change_state() 0x604000040cd0: device 28=
:3D:C2:4A:7D:2A profile deviceinfo state changed: disconnected -> connected=
 (0)
> bluetoothd[38339]: src/device.c:device_probe_profiles() Probing profiles =
for device 28:3D:C2:4A:7D:2A
> bluetoothd[38339]: profiles/battery/battery.c:batt_probe() BATT profile p=
robe (28:3D:C2:4A:7D:2A)
> bluetoothd[38339]: src/service.c:change_state() 0x604000040e50: device 28=
:3D:C2:4A:7D:2A profile batt-profile state changed: unavailable -> disconne=
cted (0)
> bluetoothd[38339]: profiles/battery/battery.c:batt_accept() BATT profile =
accept (28:3D:C2:4A:7D:2A)
> bluetoothd[38339]: profiles/battery/battery.c:foreach_batt_service() More=
 than one BATT service exists for this device
> bluetoothd[38339]: src/service.c:change_state() 0x604000040e50: device 28=
:3D:C2:4A:7D:2A profile batt-profile state changed: disconnected -> connect=
ed (0)
> bluetoothd[38339]: src/device.c:device_probe_profiles() Probing profiles =
for device 28:3D:C2:4A:7D:2A
> bluetoothd[38339]: src/device.c:device_probe_profiles() Probing profiles =
for device 28:3D:C2:4A:7D:2A
> bluetoothd[38339]: profiles/audio/bass.c:bass_probe() 28:3D:C2:4A:7D:2A
> bluetoothd[38339]: src/gatt-database.c:gatt_db_service_added() GATT Servi=
ce added to local database
> bluetoothd[38339]: src/gatt-database.c:send_notification_to_device() GATT=
 server sending indication
> bluetoothd[38339]: src/gatt-database.c:db_hash_read_cb() Database Hash re=
ad
> bluetoothd[38339]: profiles/audio/bass.c:bass_data_add() data 0x603000087=
b20
> bluetoothd[38339]: src/service.c:change_state() 0x6040000410d0: device 28=
:3D:C2:4A:7D:2A profile bass state changed: unavailable -> disconnected (0)
> bluetoothd[38339]: profiles/audio/bass.c:bass_accept() 28:3D:C2:4A:7D:2A
> bluetoothd[38339]: src/shared/bass.c:foreach_bass_char() Broadcast Audio =
Scan Control Point found: handle 0x003d
> bluetoothd[38339]: src/shared/bass.c:foreach_bass_char() Broadcast Receiv=
e State found: handle 0x003f
> bluetoothd[38339]: src/service.c:change_state() 0x6040000410d0: device 28=
:3D:C2:4A:7D:2A profile bass state changed: disconnected -> connected (0)
> bluetoothd[38339]: src/device.c:device_probe_profiles() Probing profiles =
for device 28:3D:C2:4A:7D:2A
> bluetoothd[38339]: src/device.c:device_probe_profiles() Probing profiles =
for device 28:3D:C2:4A:7D:2A
> bluetoothd[38339]: profiles/audio/bap.c:bap_probe() 28:3D:C2:4A:7D:2A
> bluetoothd[38339]: profiles/audio/bap.c:bap_data_add() data 0x60b000022fe=
0
> bluetoothd[38339]: src/service.c:change_state() 0x604000042b10: device 28=
:3D:C2:4A:7D:2A profile bap state changed: unavailable -> disconnected (0)
> bluetoothd[38339]: profiles/audio/bap.c:bap_accept() 28:3D:C2:4A:7D:2A
> bluetoothd[38339]: profiles/audio/bap.c:bap_attached() 0x60e0000043a0
> bluetoothd[38339]: src/shared/bap.c:foreach_pacs_char() PAC Context found=
: handle 0x0050
> bluetoothd[38339]: src/shared/bap.c:foreach_pacs_char() PAC Supported Con=
text found: handle 0x0053
> bluetoothd[38339]: src/shared/bap.c:foreach_pacs_char() Sink PAC Location=
 found: handle 0x0056
> bluetoothd[38339]: src/shared/bap.c:foreach_pacs_char() Sink PAC found: h=
andle 0x0059
> bluetoothd[38339]: src/shared/bap.c:foreach_pacs_char() Source PAC Locati=
on found: handle 0x005c
> bluetoothd[38339]: src/shared/bap.c:foreach_pacs_char() Source PAC found:=
 handle 0x005f
> bluetoothd[38339]: src/shared/bap.c:foreach_ascs_char() ASE Control Point=
 found: handle 0x0043
> bluetoothd[38339]: src/shared/bap.c:bap_cp_attach() ASE CP handle 0x0043
> bluetoothd[38339]: src/shared/bap.c:foreach_ascs_char() ASE Sink found: h=
andle 0x0046
> bluetoothd[38339]: src/shared/bap.c:bap_endpoint_attach() ASE handle 0x00=
46
> bluetoothd[38339]: src/shared/bap.c:foreach_ascs_char() ASE Sink found: h=
andle 0x0049
> bluetoothd[38339]: src/shared/bap.c:bap_endpoint_attach() ASE handle 0x00=
49
> bluetoothd[38339]: src/shared/bap.c:foreach_ascs_char() ASE Source found:=
 handle 0x004c
> bluetoothd[38339]: src/shared/bap.c:bap_endpoint_attach() ASE handle 0x00=
4c
> bluetoothd[38339]: src/service.c:change_state() 0x604000042b10: device 28=
:3D:C2:4A:7D:2A profile bap state changed: disconnected -> connected (0)
> bluetoothd[38339]: src/device.c:device_probe_profiles() Probing profiles =
for device 28:3D:C2:4A:7D:2A
> bluetoothd[38339]: src/device.c:device_probe_profiles() Probing profiles =
for device 28:3D:C2:4A:7D:2A
> bluetoothd[38339]: profiles/audio/vcp.c:vcp_probe() 28:3D:C2:4A:7D:2A
> bluetoothd[38339]: profiles/audio/vcp.c:vcp_data_add() data 0x60300008ab2=
0
> bluetoothd[38339]: src/service.c:change_state() 0x6040000432d0: device 28=
:3D:C2:4A:7D:2A profile vcp state changed: unavailable -> disconnected (0)
> bluetoothd[38339]: profiles/audio/vcp.c:vcp_accept() 28:3D:C2:4A:7D:2A
> bluetoothd[38339]: src/shared/vcp.c:foreach_vcs_char() VCS Vol state foun=
d: handle 0x0024
> bluetoothd[38339]: src/shared/vcp.c:foreach_vcs_char() VCS Volume CP foun=
d: handle 0x0027
> bluetoothd[38339]: src/shared/vcp.c:foreach_vcs_char() VCS Vol Flag found=
: handle 0x0029
> bluetoothd[38339]: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> bluetoothd[38339]: =3D=3D38339=3D=3DERROR: AddressSanitizer: heap-buffer-=
overflow on address 0x60400003db08 at pc 0x0000006368fe bp 0x7ffd259cd910 s=
p 0x7ffd259cd908
> bluetoothd[38339]: READ of size 8 at 0x60400003db08 thread T0
> bluetoothd[38339]:     #0 0x6368fd in gatt_db_attribute_get_char_data src=
/shared/gatt-db.c:1877
> bluetoothd[38339]:     #1 0x6135ac in notify_chrc_create src/shared/gatt-=
client.c:323
> bluetoothd[38339]:     #2 0x61b275 in register_notify src/shared/gatt-cli=
ent.c:1765
> bluetoothd[38339]:     #3 0x624940 in bt_gatt_client_register_notify src/=
shared/gatt-client.c:3741
> bluetoothd[38339]:     #4 0x66472e in vcp_register_notify src/shared/vcp.=
c:1517
> bluetoothd[38339]:     #5 0x664eac in foreach_vcs_char src/shared/vcp.c:1=
586
> bluetoothd[38339]:     #6 0x6351a2 in gatt_db_service_foreach src/shared/=
gatt-db.c:1524
> bluetoothd[38339]:     #7 0x635234 in gatt_db_service_foreach_char src/sh=
ared/gatt-db.c:1532
> bluetoothd[38339]:     #8 0x665993 in foreach_vcs_service src/shared/vcp.=
c:1686
> bluetoothd[38339]:     #9 0x634452 in foreach_service_in_range src/shared=
/gatt-db.c:1413
> bluetoothd[38339]:     #10 0x6347ba in foreach_in_range src/shared/gatt-d=
b.c:1436
> bluetoothd[38339]:     #11 0x5f7364 in queue_foreach src/shared/queue.c:2=
07
> bluetoothd[38339]:     #12 0x634d75 in gatt_db_foreach_service_in_range s=
rc/shared/gatt-db.c:1478
> bluetoothd[38339]:     #13 0x634198 in gatt_db_foreach_service src/shared=
/gatt-db.c:1383
> bluetoothd[38339]:     #14 0x665c15 in bt_vcp_attach src/shared/vcp.c:172=
2
> bluetoothd[38339]:     #15 0x4b3ebc in vcp_accept profiles/audio/vcp.c:25=
1
> bluetoothd[38339]:     #16 0x561410 in service_accept src/service.c:203
> bluetoothd[38339]:     #17 0x58275e in add_gatt_service src/device.c:3979
> bluetoothd[38339]:     #18 0x634452 in foreach_service_in_range src/share=
d/gatt-db.c:1413
> bluetoothd[38339]:     #19 0x6347ba in foreach_in_range src/shared/gatt-d=
b.c:1436
> bluetoothd[38339]:     #20 0x5f7364 in queue_foreach src/shared/queue.c:2=
07
> bluetoothd[38339]:     #21 0x634d75 in gatt_db_foreach_service_in_range s=
rc/shared/gatt-db.c:1478
> bluetoothd[38339]:     #22 0x634198 in gatt_db_foreach_service src/shared=
/gatt-db.c:1383
> bluetoothd[38339]:     #23 0x582929 in device_add_gatt_services src/devic=
e.c:3993
> bluetoothd[38339]:     #24 0x58a590 in register_gatt_services src/device.=
c:5368
> bluetoothd[38339]:     #25 0x58a6ad in gatt_client_ready_cb src/device.c:=
5386
> bluetoothd[38339]:     #26 0x619375 in notify_client_ready src/shared/gat=
t-client.c:1390
> bluetoothd[38339]:     #27 0x61cf29 in init_complete src/shared/gatt-clie=
nt.c:2092
> bluetoothd[38339]:     #28 0x614439 in discovery_op_complete src/shared/g=
att-client.c:476
> bluetoothd[38339]:     #29 0x619cec in db_hash_read_cb src/shared/gatt-cl=
ient.c:1496
> bluetoothd[38339]:     #30 0x673d37 in discovery_op_complete src/shared/g=
att-helpers.c:615
> bluetoothd[38339]:     #31 0x677336 in read_by_type_cb src/shared/gatt-he=
lpers.c:1344
> bluetoothd[38339]:     #32 0x60d878 in handle_rsp src/shared/att.c:860
> bluetoothd[38339]:     #33 0x60e5cd in can_read_data src/shared/att.c:105=
2
> bluetoothd[38339]:     #34 0x66f30e in watch_callback src/shared/io-glib.=
c:157
> bluetoothd[38339]:     #35 0x7fdd0af8239b in g_main_context_dispatch (/li=
b64/libglib-2.0.so.0+0x5c39b) (BuildId: b0e6a618cd46494b058c5f00ce2f1a650b2=
00ce3)
> bluetoothd[38339]:     #36 0x7fdd0afe0437 in g_main_context_iterate.isra.=
0 (/lib64/libglib-2.0.so.0+0xba437) (BuildId: b0e6a618cd46494b058c5f00ce2f1=
a650b200ce3)
> bluetoothd[38339]:     #37 0x7fdd0af8199e in g_main_loop_run (/lib64/libg=
lib-2.0.so.0+0x5b99e) (BuildId: b0e6a618cd46494b058c5f00ce2f1a650b200ce3)
> bluetoothd[38339]:     #38 0x66fd29 in mainloop_run src/shared/mainloop-g=
lib.c:66
> bluetoothd[38339]:     #39 0x67077e in mainloop_run_with_signal src/share=
d/mainloop-notify.c:188
> bluetoothd[38339]:     #40 0x4da138 in main src/main.c:1450
> bluetoothd[38339]:     #41 0x7fdd0a649b49 in __libc_start_call_main (/lib=
64/libc.so.6+0x27b49) (BuildId: 245240a31888ad5c11bbc55b18e02d87388f59a9)
> bluetoothd[38339]:     #42 0x7fdd0a649c0a in __libc_start_main_alias_2 (/=
lib64/libc.so.6+0x27c0a) (BuildId: 245240a31888ad5c11bbc55b18e02d87388f59a9=
)
> bluetoothd[38339]:     #43 0x40c974 in _start (/usr/local/stow/bluez-dev/=
libexec/bluetooth/bluetoothd+0x40c974) (BuildId: 339d83124c60413f66f5c84af6=
2cd00e236e7733)
> bluetoothd[38339]: 0x60400003db08 is located 8 bytes before 40-byte regio=
n [0x60400003db10,0x60400003db38)
> bluetoothd[38339]: allocated by thread T0 here:
> bluetoothd[38339]:     #0 0x7fdd0a8d92ff in malloc (/lib64/libasan.so.8+0=
xd92ff) (BuildId: dc689b05ca2577037af24700212bb5cce1f91c8a)
> bluetoothd[38339]:     #1 0x5f86b7 in util_malloc src/shared/util.c:46
> bluetoothd[38339]:     #2 0x62fe56 in gatt_db_service_create src/shared/g=
att-db.c:533
> bluetoothd[38339]:     #3 0x631171 in gatt_db_insert_service src/shared/g=
att-db.c:734
> bluetoothd[38339]:     #4 0x61844f in discovery_parse_services src/shared=
/gatt-client.c:1205
> bluetoothd[38339]:     #5 0x618e8f in discover_primary_cb src/shared/gatt=
-client.c:1326
> bluetoothd[38339]:     #6 0x673d37 in discovery_op_complete src/shared/ga=
tt-helpers.c:615
> bluetoothd[38339]:     #7 0x67432e in read_by_grp_type_cb src/shared/gatt=
-helpers.c:717
> bluetoothd[38339]:     #8 0x60d878 in handle_rsp src/shared/att.c:860
> bluetoothd[38339]:     #9 0x60e5cd in can_read_data src/shared/att.c:1052
> bluetoothd[38339]:     #10 0x66f30e in watch_callback src/shared/io-glib.=
c:157
> bluetoothd[38339]:     #11 0x7fdd0af8239b in g_main_context_dispatch (/li=
b64/libglib-2.0.so.0+0x5c39b) (BuildId: b0e6a618cd46494b058c5f00ce2f1a650b2=
00ce3)
> bluetoothd[38339]:     #12 0x7fdd0afe0437 in g_main_context_iterate.isra.=
0 (/lib64/libglib-2.0.so.0+0xba437) (BuildId: b0e6a618cd46494b058c5f00ce2f1=
a650b200ce3)
> bluetoothd[38339]:     #13 0x7fdd0af8199e in g_main_loop_run (/lib64/libg=
lib-2.0.so.0+0x5b99e) (BuildId: b0e6a618cd46494b058c5f00ce2f1a650b200ce3)
> bluetoothd[38339]:     #14 0x66fd29 in mainloop_run src/shared/mainloop-g=
lib.c:66
> bluetoothd[38339]:     #15 0x67077e in mainloop_run_with_signal src/share=
d/mainloop-notify.c:188
> bluetoothd[38339]:     #16 0x4da138 in main src/main.c:1450
> bluetoothd[38339]:     #17 0x7fdd0a649b49 in __libc_start_call_main (/lib=
64/libc.so.6+0x27b49) (BuildId: 245240a31888ad5c11bbc55b18e02d87388f59a9)
> bluetoothd[38339]:     #18 0x7fdd0a649c0a in __libc_start_main_alias_2 (/=
lib64/libc.so.6+0x27c0a) (BuildId: 245240a31888ad5c11bbc55b18e02d87388f59a9=
)
> bluetoothd[38339]:     #19 0x40c974 in _start (/usr/local/stow/bluez-dev/=
libexec/bluetooth/bluetoothd+0x40c974) (BuildId: 339d83124c60413f66f5c84af6=
2cd00e236e7733)
> bluetoothd[38339]: SUMMARY: AddressSanitizer: heap-buffer-overflow src/sh=
ared/gatt-db.c:1877 in gatt_db_attribute_get_char_data
> bluetoothd[38339]: Shadow bytes around the buggy address:
> bluetoothd[38339]:   0x60400003d880: fa fa fd fd fd fd fd fd fa fa fd fd =
fd fd fd fa
> bluetoothd[38339]:   0x60400003d900: fa fa fd fd fd fd fd fd fa fa fd fd =
fd fd fd fd
> bluetoothd[38339]:   0x60400003d980: fa fa fd fd fd fd fd fa fa fa fd fd =
fd fd fd fd
> bluetoothd[38339]:   0x60400003da00: fa fa fd fd fd fd fd fa fa fa fd fd =
fd fd fd fd
> bluetoothd[38339]:   0x60400003da80: fa fa fd fd fd fd fd fa fa fa fd fd =
fd fd fd fd
> bluetoothd[38339]: =3D>0x60400003db00: fa[fa]00 00 00 00 00 fa fa fa 00 0=
0 00 00 00 fa
> bluetoothd[38339]:   0x60400003db80: fa fa 00 00 00 00 00 00 fa fa fd fd =
fd fd fd fa
> bluetoothd[38339]:   0x60400003dc00: fa fa fd fd fd fd fd fd fa fa fd fd =
fd fd fd fd
> bluetoothd[38339]:   0x60400003dc80: fa fa fd fd fd fd fd fa fa fa fd fd =
fd fd fd fd
> bluetoothd[38339]:   0x60400003dd00: fa fa fd fd fd fd fd fa fa fa fd fd =
fd fd fd fd
> bluetoothd[38339]:   0x60400003dd80: fa fa fd fd fd fd fd fd fa fa fd fd =
fd fd fd fa
> bluetoothd[38339]: Shadow byte legend (one shadow byte represents 8 appli=
cation bytes):
> bluetoothd[38339]:   Addressable:           00
> bluetoothd[38339]:   Partially addressable: 01 02 03 04 05 06 07
> bluetoothd[38339]:   Heap left redzone:       fa
> bluetoothd[38339]:   Freed heap region:       fd
> bluetoothd[38339]:   Stack left redzone:      f1
> bluetoothd[38339]:   Stack mid redzone:       f2
> bluetoothd[38339]:   Stack right redzone:     f3
> bluetoothd[38339]:   Stack after return:      f5
> bluetoothd[38339]:   Stack use after scope:   f8
> bluetoothd[38339]:   Global redzone:          f9
> bluetoothd[38339]:   Global init order:       f6
> bluetoothd[38339]:   Poisoned by user:        f7
> bluetoothd[38339]:   Container overflow:      fc
> bluetoothd[38339]:   Array cookie:            ac
> bluetoothd[38339]:   Intra object redzone:    bb
> bluetoothd[38339]:   ASan internal:           fe
> bluetoothd[38339]:   Left alloca redzone:     ca
> bluetoothd[38339]:   Right alloca redzone:    cb
> bluetoothd[38339]: =3D=3D38339=3D=3DABORTING
> systemd[1]: bluetooth.service: Main process exited, code=3Ddumped, status=
=3D6/ABRT
> systemd[1]: bluetooth.service: Failed with result 'core-dump'.
>
>
> > ---
> > v2: Cosmetic Changes (Bluez Test Bot)
> > v5: Resolved GitLint warning (tedd_an/GitLint)
> > ---
> >
> >  src/shared/vcp.c | 25 ++++++++++++++++++-------
> >  1 file changed, 18 insertions(+), 7 deletions(-)
> >
> > diff --git a/src/shared/vcp.c b/src/shared/vcp.c
> > index 92f21fd0b..74bd01729 100644
> > --- a/src/shared/vcp.c
> > +++ b/src/shared/vcp.c
> > @@ -32,9 +32,13 @@
> >
> >  #define VCP_STEP_SIZE 1
> >
> > +#define VOCS_VOL_OFFSET_UPPER_LIMIT   255
> > +#define VOCS_VOL_OFFSET_LOWER_LIMIT  -255
> > +
> >  /* Apllication Error Code */
> >  #define BT_ATT_ERROR_INVALID_CHANGE_COUNTER  0x80
> >  #define BT_ATT_ERROR_OPCODE_NOT_SUPPORTED    0x81
> > +#define BT_ATT_ERROR_VALUE_OUT_OF_RANGE              0x82
> >
> >  #define BT_VCP_NA                   BIT(0)
> >  #define BT_VCP_FRONT_LEFT           BIT(1)
> > @@ -100,7 +104,7 @@ struct bt_vcs_ab_vol {
> >
> >  struct bt_vocs_set_vol_off {
> >       uint8_t change_counter;
> > -     uint8_t set_vol_offset;
> > +     int16_t set_vol_offset;
> >  } __packed;
> >
> >  struct bt_vcp_cb {
> > @@ -167,7 +171,7 @@ struct bt_vcs {
> >
> >  /* Contains local bt_vcp_db */
> >  struct vol_offset_state {
> > -     uint16_t vol_offset;
> > +     int16_t vol_offset;
> >       uint8_t counter;
> >  } __packed;
> >
> > @@ -705,6 +709,11 @@ static uint8_t vocs_set_vol_offset(struct bt_vocs =
*vocs, struct bt_vcp *vcp,
> >               return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
> >       }
> >
> > +     if (req->set_vol_offset > VOCS_VOL_OFFSET_UPPER_LIMIT ||
> > +             req->set_vol_offset < VOCS_VOL_OFFSET_LOWER_LIMIT) {
> > +             DBG(vcp, "error: Value Out of Range");
> > +             return BT_ATT_ERROR_VALUE_OUT_OF_RANGE;
> > +     }
> >       vstate->vol_offset =3D req->set_vol_offset;
> >       vstate->counter =3D -~vstate->counter; /*Increment Change Counter=
*/
> >
> > @@ -971,7 +980,7 @@ static void vocs_voaodec_read(struct gatt_db_attrib=
ute *attrib,
> >                                                       iov.iov_len);
> >  }
> >
> > -static struct bt_vcs *vcs_new(struct gatt_db *db)
> > +static struct bt_vcs *vcs_new(struct gatt_db *db, struct bt_vcp_db *vd=
b)
> >  {
> >       struct bt_vcs *vcs;
> >       struct vol_state *vstate;
> > @@ -990,6 +999,8 @@ static struct bt_vcs *vcs_new(struct gatt_db *db)
> >       /* Populate DB with VCS attributes */
> >       bt_uuid16_create(&uuid, VCS_UUID);
> >       vcs->service =3D gatt_db_add_service(db, &uuid, true, 9);
> > +     gatt_db_service_add_included(vcs->service, vdb->vocs->service);
> > +     gatt_db_service_set_active(vdb->vocs->service, true);
> >
> >       bt_uuid16_create(&uuid, VOL_STATE_CHRC_UUID);
> >       vcs->vs =3D gatt_db_service_add_characteristic(vcs->service,
> > @@ -1048,7 +1059,8 @@ static struct bt_vocs *vocs_new(struct gatt_db *d=
b)
> >
> >       /* Populate DB with VOCS attributes */
> >       bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
> > -     vocs->service =3D gatt_db_add_service(db, &uuid, true, 9);
> > +
> > +     vocs->service =3D gatt_db_add_service(db, &uuid, false, 12);
> >
> >       bt_uuid16_create(&uuid, VOCS_STATE_CHAR_UUID);
> >       vocs->vos =3D gatt_db_service_add_characteristic(vocs->service,
> > @@ -1110,11 +1122,10 @@ static struct bt_vcp_db *vcp_db_new(struct gatt=
_db *db)
> >       if (!vcp_db)
> >               vcp_db =3D queue_new();
> >
> > -     vdb->vcs =3D vcs_new(db);
> > -     vdb->vcs->vdb =3D vdb;
> > -
> >       vdb->vocs =3D vocs_new(db);
> >       vdb->vocs->vdb =3D vdb;
> > +     vdb->vcs =3D vcs_new(db, vdb);
> > +     vdb->vcs->vdb =3D vdb;
> >
> >       queue_push_tail(vcp_db, vdb);
> >
>


--=20
Luiz Augusto von Dentz
