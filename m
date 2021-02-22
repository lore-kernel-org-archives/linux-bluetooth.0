Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B440BC433E9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 19:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832A664E25
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 19:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhBVTag (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhBVT2N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Feb 2021 14:28:13 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F42FC0617AB
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Feb 2021 11:27:31 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id 67so4729376uao.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Feb 2021 11:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=D1wWaEIGJXWO5gBuqz46HC93QEhv7Z1ffPZxN7pDEqs=;
        b=OCGDFtEETqFqCWNPsOk87qZGs0WGoFJNvY/gTWrIfrRajqPl3qvua41jqhgHuQWUiK
         B43GSMquszlrFJm5aApMXLT4ScIuT5SXpst3BTAGzQobTcSNQ79gJkXwcpbpNJeyBLPq
         HgW45UEJYD24oDz+f9x3GQYjK5kgQqfPhzNnDqGpbg9IUXM6JxjMkgvuxEumT3taJVxc
         VfI6Yw2Fr66yZYRjoO6uqDeHzoAtLWLPegnPPBT8/vp9KX1LQGyKRzMcw088FJpXKPl6
         iGU8BGVwA0VVLMJebSRaxDFbuV4VN+gDV/Bdllujg7fdIfYwcUFQdXdDLsde5CkUuNCy
         EFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=D1wWaEIGJXWO5gBuqz46HC93QEhv7Z1ffPZxN7pDEqs=;
        b=VUFcvkYecG9BsZxms2orBXoaIuk9+BkgJ8t2NlrCanB4m35rwiqfS15oYJ7VT0u+QB
         dIYqzPt7Bmv/aMn+Fk9+50azLYZ8Yc3zYYK+oLwhN6AZ+w4U0TdiJFvEyQhZ34qSwv33
         Kl8l3i1Xi8USnvT1WVmFgJYF8is9qAeKZoi3j/pGwADSpF2PZKFxv8N7P+D2eOzOWuwi
         qnyPDjmIGpLW8DQkHTE7Rr9pdtOFN6fVvSejEVslKJO9rz0Wj9Rr7YjpKeEobH5I0tYg
         vnv7lNSaqBmitlyx/DU9r5w9ukN5/U3lQZ1NQsZ3k4+k3XqKdZ1kryT7S4RxKa6hhGgQ
         wdlw==
X-Gm-Message-State: AOAM531SAFeRgUHFLIcfoqxIiO3wI1pms3BxEzpuhW05pMJFttMMQRDu
        FQBjU825ACFxaxogSqqZY5zNYH8mXAjOyXtStrkoV0l277py6Q==
X-Google-Smtp-Source: ABdhPJxbWEnNK3nlB+tfGP5BaNPG1sSh1CT1zNiXHGAnzX5P3Wwn/MC2mwM0cIUBxHcBnyA2zIHKns9Wv8XYTXWEpvY=
X-Received: by 2002:ab0:4244:: with SMTP id i62mr15502757uai.37.1614022049682;
 Mon, 22 Feb 2021 11:27:29 -0800 (PST)
MIME-Version: 1.0
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Mon, 22 Feb 2021 13:27:18 -0600
Message-ID: <CALaQ_hpL36xwJ3zujD6DsRKzQw_54TucEif=icMgN1CUpk9TNA@mail.gmail.com>
Subject: avdtp.c:cancel_request Times Out, Plus Other Failures
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

System updated 2021-02-19
Previous update 2020-12-18

Kernel:
    Current: Linux computerName 5.11.0-dirty #1 SMP PREEMPT Fri Feb 19
06:30:22 CST 2021 x86_64 GNU/Linux
    Previous: 5.8.7

Bluez:
    Current: 5.55-3
    Previous: 5.55-1

Journalctl:
*****
...
Feb 22 12:27:21 computerName systemsettings5[563003]:
org.kde.plasma.pulseaudio: No object for name
"bluez_sink.<sanitized>.a2dp_sink"
Feb 22 12:27:21 computerName plasmashell[500294]:
org.kde.plasma.pulseaudio: No object for name
"bluez_sink.<sanitized>.a2dp_sink"
...
Feb 22 12:27:21 computerName plasmashell[500294]:
file:///usr/share/plasma/plasmoids/org.kde.plasma.bluetooth/contents/ui/log=
ic.js:22:
TypeError: Cannot read property 'devices' of undefined
Feb 22 12:27:21 computerName kdeconnectd[500311]: org.kde.pulseaudio:
No object for name "bluez_sink.<sanitized>.a2dp_sink"
Feb 22 12:27:21 computerName dbus-daemon[933]: [system] Rejected send
message, 0 matched rules; type=3D"method_return", sender=3D":1.734"
(uid=3D1000 pid=3D500326 comm=3D"/usr/bin/pulseaudio --daemonize=3Dno
--log-target=3Djo") interface=3D"(unset)" member=3D>
Feb 22 12:27:21 computerName bluetoothd[565499]:
profiles/audio/avdtp.c:cancel_request() Abort: Connection timed out
(110)
Feb 22 12:27:19 computerName pulseaudio[500326]: Transport Acquire()
failed for transport /org/bluez/hci0/dev_<sanitized>/sep1/fd0
(Input/output error)
Feb 22 12:27:19 computerName bluetoothd[565499]:
profiles/audio/avdtp.c:cancel_request() Suspend: Connection timed out
(110)
Feb 22 12:27:09 computerName systemsettings5[563003]:
file:///usr/share/kpackage/kcms/kcm_pulseaudio/contents/ui/StreamListItem.q=
ml:36:
TypeError: Cannot read property 'width' of null
Feb 22 12:27:09 computerName bluetoothd[565499]:
profiles/audio/avdtp.c:cancel_request() Suspend: Connection timed out
(110)
Feb 22 12:18:43 computerName systemsettings5[563003]:
file:///usr/share/kpackage/kcms/kcm_pulseaudio/contents/ui/StreamListItem.q=
ml:36:
TypeError: Cannot read property 'width' of null
...
Feb 22 11:24:34 computerName kernel: Bluetooth: hci0: unexpected event
for opcode 0x0c03
Feb 22 11:24:33 computerName kded5[500252]: bluedevil: Requested default Ag=
ent
Feb 22 11:24:33 computerName kded5[500252]: bluedevil: Agent registered
Feb 22 11:24:33 computerName bluetoothd[565499]: Endpoint registered:
sender=3D:1.734 path=3D/MediaEndpoint/A2DPSource/sbc
Feb 22 11:24:33 computerName bluetoothd[565499]: Endpoint registered:
sender=3D:1.734 path=3D/MediaEndpoint/A2DPSink/sbc
Feb 22 11:24:33 computerName kded5[500252]: bluedevil: Bluetooth
operational changed true
...
Feb 22 11:24:33 computerName dbus-daemon[933]: [system] Activating via
systemd: service name=3D'org.freedesktop.hostname1'
unit=3D'dbus-org.freedesktop.hostname1.service' requested by ':1.829'
(uid=3D0 pid=3D565499 comm=3D"/usr/lib/bluetooth/bluetooth>
Feb 22 11:24:33 computerName bluetoothd[565499]: Bluetooth management
interface 1.19 initialized
...
Feb 22 11:24:33 computerName kded5[500252]: bluedevil: AGENT-Release
Feb 22 11:24:33 computerName bluetoothd[565355]: Exit
Feb 22 11:24:33 computerName bluetoothd[565355]: Stopping SDP server
Feb 22 11:24:33 computerName dbus-daemon[933]: [system] Rejected send
message, 0 matched rules; type=3D"error", sender=3D":1.734" (uid=3D1000
pid=3D500326 comm=3D"/usr/bin/pulseaudio --daemonize=3Dno --log-target=3Djo=
")
interface=3D"(unset)" member=3D"(unset)>
Feb 22 11:24:33 computerName dbus-daemon[933]: [system] Rejected send
message, 0 matched rules; type=3D"error", sender=3D":1.734" (uid=3D1000
pid=3D500326 comm=3D"/usr/bin/pulseaudio --daemonize=3Dno --log-target=3Djo=
")
interface=3D"(unset)" member=3D"(unset)>
Feb 22 11:24:33 computerName bluetoothd[565355]: Endpoint
unregistered: sender=3D:1.734 path=3D/MediaEndpoint/A2DPSource/sbc
Feb 22 11:24:33 computerName bluetoothd[565355]: Endpoint
unregistered: sender=3D:1.734 path=3D/MediaEndpoint/A2DPSink/sbc
Feb 22 11:24:33 computerName systemd[1]: Stopping Bluetooth service...
...
//Had to unblock a softblock to get the device to pair
Feb 22 11:23:07 computerName kded5[500252]: kf.bluezqt: PendingCall
Error: "Blocked through rfkill"
Feb 22 11:23:07 computerName bluetoothd[565355]: Failed to set mode:
Blocked through rfkill (0x12)
Feb 22 11:23:06 computerName kded5[500252]: bluedevil: Requested default Ag=
ent
Feb 22 11:23:06 computerName bluetoothd[565355]: Endpoint registered:
sender=3D:1.734 path=3D/MediaEndpoint/A2DPSource/sbc
Feb 22 11:23:06 computerName kded5[500252]: bluedevil: Agent registered
Feb 22 11:23:06 computerName bluetoothd[565355]: Endpoint registered:
sender=3D:1.734 path=3D/MediaEndpoint/A2DPSink/sbc
Feb 22 11:23:06 computerName kded5[500252]: bluedevil: Bluetooth
operational changed true
Feb 22 11:23:06 computerName dbus-daemon[933]: [system] Successfully
activated service 'org.freedesktop.hostname1'
Feb 22 11:23:06 computerName bluetoothd[565355]: Bluetooth management
interface 1.19 initialized
Feb 22 11:23:06 computerName dbus-daemon[933]: [system] Activating via
systemd: service name=3D'org.freedesktop.hostname1'
unit=3D'dbus-org.freedesktop.hostname1.service' requested by ':1.823'
(uid=3D0 pid=3D565355 comm=3D"/usr/lib/bluetooth/bluetooth>
Feb 22 11:23:06 computerName sudo[565352]: pam_unix(sudo:session):
session closed for user root
Feb 22 11:23:06 computerName bluetoothd[565355]: Starting SDP server
Feb 22 11:23:06 computerName dbus-daemon[933]: [system] Successfully
activated service 'org.bluez'
...
Feb 22 11:23:05 computerName bluetoothd[368526]: Endpoint
unregistered: sender=3D:1.734 path=3D/MediaEndpoint/A2DPSource/sbc
Feb 22 11:23:05 computerName systemd[1]: bluetooth.service: Succeeded.
=E2=96=91=E2=96=91 Subject: Unit succeeded
=E2=96=91=E2=96=91 Defined-By: systemd
=E2=96=91=E2=96=91 Support: https://lists.freedesktop.org/mailman/listinfo/=
systemd-devel
=E2=96=91=E2=96=91
=E2=96=91=E2=96=91 The unit bluetooth.service has successfully entered the =
'dead' state.
Feb 22 11:23:05 computerName bluetoothd[368526]: Endpoint
unregistered: sender=3D:1.734 path=3D/MediaEndpoint/A2DPSink/sbc
...
Feb 22 11:21:08 computerName kernel: Bluetooth: hci0: HCI reset during
shutdown failed
Feb 22 11:21:00 computerName kernel: Bluetooth: hci0: command 0x0c03 tx tim=
eout
Feb 22 11:20:54 computerName kwin_x11[500256]: qt.qpa.xcb:
QXcbConnection: XCB error: 3 (BadWindow), sequence: 21430, resource
id: 92274704, major code: 18 (ChangeProperty), minor code: 0
//Restarted the wizard multiple times because the pairing kept failing
Feb 22 11:20:54 computerName bluedevil-wizard[564973]:
bluedevil.wizard: Wizard done:  0
Feb 22 11:20:52 computerName bluedevil-wizard[564973]:
bluedevil.wizard: Initialize Fail Page
Feb 22 11:20:52 computerName bluedevil-wizard[564973]:
bluedevil.wizard:          errorText :  "Authentication Failed"
Feb 22 11:20:52 computerName bluedevil-wizard[564973]:
bluedevil.wizard:          error     :  true
Feb 22 11:20:52 computerName bluedevil-wizard[564973]:
bluedevil.wizard: Pairing finished:
Feb 22 11:20:52 computerName bluedevil-wizard[564973]: kf.bluezqt:
PendingCall Error: "Authentication Failed"
Feb 22 11:20:52 computerName bluedevil-wizard[564973]:
bluedevil.wizard: Initialize Pairing Page
Feb 22 11:20:52 computerName bluedevil-wizard[564973]:
bluedevil.wizard: PIN:  "0000"
Feb 22 11:20:52 computerName bluedevil-wizard[564973]:
bluedevil.wizard: From DB:  true
Feb 22 11:20:52 computerName bluedevil-wizard[564973]:
bluedevil.wizard: Legacy:  true
Feb 22 11:20:52 computerName bluedevil-wizard[564973]:
bluedevil.wizard: Device type:  "headset"
Feb 22 11:20:52 computerName bluedevil-wizard[564973]:
bluedevil.wizard: PIN:  "0000"
Feb 22 11:20:52 computerName bluedevil-wizard[564973]:
bluedevil.wizard: Stopping scanning
Feb 22 11:20:48 computerName plasmashell[500294]:
file:///usr/share/plasma/plasmoids/org.kde.desktopcontainment/contents/ui/F=
olderItemDelegate.qml:385:21:
Unable to assign [undefined] to bool
Feb 22 11:20:40 computerName bluedevil-wizard[564973]:
bluedevil.wizard: Starting scanning
Feb 22 11:20:40 computerName bluedevil-wizard[564973]:
bluedevil.wizard: Initialize Discover Page
...
Feb 22 11:04:00 computerName pulseaudio[500326]: connect(): Software
caused connection abort
...
Feb 22 11:03:43 computerName kernel: Bluetooth: hci0: HCI reset during
shutdown failed
Feb 22 11:03:33 computerName systemsettings5[563003]:
file:///usr/share/kpackage/kcms/kcm_pulseaudio/contents/ui/CardListItem.qml=
:30:
TypeError: Cannot read property 'width' of null
Feb 22 11:03:33 computerName bluetoothd[368526]:
src/profile.c:ext_io_disconnected() Unable to get io data for Headset
Voice gateway: getpeername: Transport endpoint is not connected (107)
...
Feb 22 11:01:58 computerName plasmashell[500294]:
org.kde.plasma.pulseaudio: No object for name
"bluez_sink.<sanitized>.a2dp_sink"
Feb 22 11:01:58 computerName plasmashell[500294]:
qrc:/plasma/plasmoids/org.kde.plasma.volume/contents/ui/ListItemBase.qml:15=
3:
TypeError: Cannot read property 'ports' of undefined
Feb 22 11:01:58 computerName dbus-daemon[933]: [system] Rejected send
message, 0 matched rules; type=3D"method_return", sender=3D":1.734"
(uid=3D1000 pid=3D500326 comm=3D"/usr/bin/pulseaudio --daemonize=3Dno
--log-target=3Djo") interface=3D"(unset)" member=3D>
Feb 22 11:01:58 computerName kdeconnectd[500311]: org.kde.pulseaudio:
No object for name "bluez_sink.<sanitized>.a2dp_sink"
Feb 22 11:01:58 computerName bluetoothd[368526]:
profiles/audio/avdtp.c:cancel_request() Abort: Connection timed out
(110)
Feb 22 11:01:56 computerName bluetoothd[368526]:
profiles/audio/avdtp.c:cancel_request() Suspend: Connection timed out
(110)
Feb 22 11:01:46 computerName bluetoothd[368526]:
profiles/audio/avdtp.c:cancel_request() Suspend: Connection timed out
(110)
...
Feb 22 11:01:31 computerName systemsettings5[562536]:
org.kde.plasma.pulseaudio: No object for name
"bluez_sink.<sanitized>.a2dp_sink"
Feb 22 11:01:31 computerName systemsettings5[562536]:
org.kde.plasma.pulseaudio: No object for name
"bluez_source.<sanitized>.headset_head_unit"
Feb 22 11:01:31 computerName systemsettings5[562536]:
org.kde.plasma.pulseaudio: No object for name
"bluez_sink.<sanitized>.headset_head_unit"
Feb 22 11:01:31 computerName systemsettings5[562536]:
org.kde.plasma.pulseaudio: No object for name
"bluez_sink.<sanitized>.headset_head_unit"
Feb 22 11:01:31 computerName plasmashell[500294]:
org.kde.plasma.pulseaudio: No object for name
"bluez_sink.<sanitized>.a2dp_sink"
Feb 22 11:01:31 computerName plasmashell[500294]:
org.kde.plasma.pulseaudio: No object for name
"bluez_source.<sanitized>.headset_head_unit"
Feb 22 11:01:31 computerName plasmashell[500294]:
org.kde.plasma.pulseaudio: No object for name
"bluez_sink.<sanitized>.headset_head_unit"
Feb 22 11:01:31 computerName plasmashell[500294]:
qrc:/plasma/plasmoids/org.kde.plasma.volume/contents/ui/ListItemBase.qml:15=
3:
TypeError: Cannot read property 'ports' of undefined
Feb 22 11:01:31 computerName kdeconnectd[500311]: org.kde.pulseaudio:
No object for name "bluez_sink.<sanitized>.a2dp_sink"
Feb 22 11:01:31 computerName plasmashell[500294]:
org.kde.plasma.pulseaudio: No object for name
"bluez_sink.<sanitized>.headset_head_unit"
Feb 22 11:01:31 computerName kdeconnectd[500311]: org.kde.pulseaudio:
No object for name "bluez_source.<sanitized>.headset_head_unit"
Feb 22 11:01:31 computerName plasmashell[500294]:
qrc:/plasma/plasmoids/org.kde.plasma.volume/contents/ui/ListItemBase.qml:15=
3:
TypeError: Cannot read property 'ports' of undefined
Feb 22 11:01:31 computerName kdeconnectd[500311]: org.kde.pulseaudio:
No object for name "bluez_sink.<sanitized>.headset_head_unit"
Feb 22 11:01:31 computerName kdeconnectd[500311]: org.kde.pulseaudio:
No object for name "bluez_sink.<sanitized>.headset_head_unit"
Feb 22 11:01:31 computerName rtkit-daemon[1459]: Supervising 4 threads
of 1 processes of 1 users.
Feb 22 11:01:31 computerName rtkit-daemon[1459]: Successfully made
thread 562947 of process 500326 owned by '1000' RT at priority 5.
Feb 22 11:01:31 computerName rtkit-daemon[1459]: Supervising 3 threads
of 1 processes of 1 users.
Feb 22 11:01:31 computerName bluetoothd[368526]:
/org/bluez/hci0/dev_<sanitized>/sep1/fd7: fd(43) ready
...
Feb 22 10:59:57 computerName systemd-logind[937]: Watching system
buttons on /dev/input/event21 (Motorola S705 (AVRCP))
Feb 22 10:59:57 computerName kernel: input: Motorola S705 (AVRCP) as
/devices/virtual/input/input47
Feb 22 10:59:50 computerName kernel: Bluetooth: hci0: SCO packet for
unknown connection handle 13
Feb 22 10:59:50 computerName kernel: Bluetooth: hci0: SCO packet for
unknown connection handle 13
Feb 22 10:59:50 computerName kernel: Bluetooth: hci0: SCO packet for
unknown connection handle 13
Feb 22 10:59:45 computerName plasmashell[500294]:
org.kde.plasma.pulseaudio: No object for name
"bluez_source.<sanitized>.headset_head_unit"
Feb 22 10:59:45 computerName systemsettings5[562536]:
org.kde.plasma.pulseaudio: No object for name
"bluez_source.<sanitized>.headset_head_unit"
Feb 22 10:59:45 computerName kdeconnectd[500311]: org.kde.pulseaudio:
No object for name "bluez_source.<sanitized>.headset_head_unit"
Feb 22 10:59:45 computerName rtkit-daemon[1459]: Supervising 4 threads
of 1 processes of 1 users.
Feb 22 10:59:45 computerName rtkit-daemon[1459]: Successfully made
thread 562711 of process 500326 owned by '1000' RT at priority 5.
Feb 22 10:59:45 computerName rtkit-daemon[1459]: Supervising 3 threads
of 1 processes of 1 users.
Feb 22 10:59:20 computerName systemsettings5[562536]:
file:///usr/share/kpackage/kcms/kcm_pulseaudio/contents/ui/StreamListItem.q=
ml:36:
TypeError: Cannot read property 'width' of null
Feb 22 10:59:19 computerName systemsettings5[562536]:
file:///usr/share/kpackage/kcms/kcm_pulseaudio/contents/ui/CardListItem.qml=
:30:
TypeError: Cannot read property 'width' of null
Feb 22 10:59:18 computerName systemsettings5[562536]:
org.kde.plasma.pulseaudio: No object for name
"bluez_sink.<sanitized>.a2dp_sink"
Feb 22 10:59:18 computerName plasmashell[500294]:
org.kde.plasma.pulseaudio: No object for name
"bluez_sink.<sanitized>.a2dp_sink"
Feb 22 10:59:18 computerName bluetoothd[368526]:
src/profile.c:ext_io_disconnected() Unable to get io data for Headset
Voice gateway: getpeername: Transport endpoint is not connected (107)
Feb 22 10:59:18 computerName plasmashell[500294]:
qrc:/plasma/plasmoids/org.kde.plasma.volume/contents/ui/ListItemBase.qml:15=
3:
TypeError: Cannot read property 'ports' of undefined
Feb 22 10:59:18 computerName kdeconnectd[500311]: org.kde.pulseaudio:
No object for name "bluez_sink.<sanitized>.a2dp_sink"
Feb 22 10:59:18 computerName dbus-daemon[933]: [system] Rejected send
message, 0 matched rules; type=3D"method_return", sender=3D":1.734"
(uid=3D1000 pid=3D500326 comm=3D"/usr/bin/pulseaudio --daemonize=3Dno
--log-target=3Djo") interface=3D"(unset)" member=3D>
Feb 22 10:59:18 computerName bluetoothd[368526]:
profiles/audio/avdtp.c:handle_unanswered_req() No reply to Suspend
request
Feb 22 10:59:18 computerName kernel: Bluetooth: hci0: killing stalled
connection <sanitized>
Feb 22 10:59:18 computerName kernel: Bluetooth: hci0: link tx timeout
...
Feb 22 10:10:38 computerName bluetoothd[368526]:
profiles/audio/avdtp.c:avdtp_connect_cb() connect to <sanitized>:
Operation already in progress (114)
Feb 22 10:10:36 computerName plasmashell[500294]: kf.bluezqt:
PendingCall Error: "Resource temporarily unavailable"
Feb 22 10:10:36 computerName bluetoothd[368526]:
profiles/audio/avdtp.c:avdtp_connect_cb() connect to <sanitized>:
Operation already in progress (114)
Feb 22 10:10:36 computerName bluetoothd[368526]:
src/profile.c:record_cb() Unable to get Headset Voice gateway SDP
record: Operation already in progress
...
Feb 22 10:09:57 computerName systemsettings5[557101]:
org.kde.plasma.pulseaudio: No object for name
"bluez_sink.<sanitized>.a2dp_sink"
Feb 22 10:09:57 computerName plasmashell[500294]:
org.kde.plasma.pulseaudio: No object for name
"bluez_sink.<sanitized>.a2dp_sink"
Feb 22 10:09:57 computerName plasmashell[500294]:
qrc:/plasma/plasmoids/org.kde.plasma.volume/contents/ui/ListItemBase.qml:15=
3:
TypeError: Cannot read property 'ports' of undefined
Feb 22 10:09:57 computerName kdeconnectd[500311]: org.kde.pulseaudio:
No object for name "bluez_sink.<sanitized>.a2dp_sink"
Feb 22 10:09:57 computerName dbus-daemon[933]: [system] Rejected send
message, 0 matched rules; type=3D"method_return", sender=3D":1.734"
(uid=3D1000 pid=3D500326 comm=3D"/usr/bin/pulseaudio --daemonize=3Dno
--log-target=3Djo") interface=3D"(unset)" member=3D>
Feb 22 10:09:57 computerName bluetoothd[368526]:
profiles/audio/avdtp.c:handle_unanswered_req() No reply to Suspend
request
Feb 22 10:09:57 computerName bluetoothd[368526]:
src/profile.c:ext_io_disconnected() Unable to get io data for Headset
Voice gateway: getpeername: Transport endpoint is not connected (107)
Feb 22 10:09:56 computerName kernel: Bluetooth: hci0: killing stalled
connection <sanitized>
Feb 22 10:09:56 computerName kernel: Bluetooth: hci0: link tx timeout
...
*****
Basically, you can see it is problematic pretty often. It had never
been a problem whatsoever prior to this last upgrade.


Tail end of btmon (I have the whole 1.2MB output saved):
*****
< ACL Data TX: Handle 1 flags 0x02 dlen 820            #9551 [hci0] 3253.31=
2691
< ACL Data TX: Handle 1 flags 0x01 dlen 44             #9552 [hci0] 3253.31=
2756
      Channel: 419 len 860 [PSM 25 mode Basic (0x00)] {chan 0}
> HCI Event: Number of Completed Pack.. (0x13) plen 5  #9553 [hci0] 3253.34=
2709
        Num handles: 1
        Handle: 1
        Count: 2
< ACL Data TX: Handle 1 flags 0x02 dlen 820            #9554 [hci0] 3253.34=
4394
< ACL Data TX: Handle 1 flags 0x01 dlen 44             #9555 [hci0] 3253.34=
4413
      Channel: 419 len 860 [PSM 25 mode Basic (0x00)] {chan 0}
< ACL Data TX: Handle 1 flags 0x00 dlen 7              #9556 [hci0] 3253.36=
6148
      Channel: 418 len 3 [PSM 25 mode Basic (0x00)] {chan 2}
      AVDTP: Suspend (0x09) Command (0x00) type 0x00 label 14 nosp 0
        ACP SEID: 1
> HCI Event: Number of Completed Pack.. (0x13) plen 5  #9557 [hci0] 3253.37=
5709
        Num handles: 1
        Handle: 1
        Count: 2
> HCI Event: Number of Completed Pack.. (0x13) plen 5  #9558 [hci0] 3253.37=
6706
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 6              #9559 [hci0] 3253.45=
3728
      Channel: 66 len 2 [PSM 25 mode Basic (0x00)] {chan 2}
      AVDTP: Suspend (0x09) Response Accept (0x02) type 0x00 label 14 nosp =
0
> HCI Event: Mode Change (0x14) plen 6                 #9560 [hci0] 3263.52=
3026
        Status: Success (0x00)
        Handle: 1
        Mode: Sniff (0x02)
        Interval: 640.000 msec (0x0400)
< ACL Data TX: Handle 1 flags 0x00 dlen 7
*****
