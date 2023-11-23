Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854B01A4
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 04:41:22 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40838915cecso5336335e9.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 04:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700743281; x=1701348081;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxWzdJJf6u+z+krCWGeryT8LI+5TgWyTZGZkOSaZ4vM=;
        b=CMLRQjnutL7l0aH4uqp3qirtIc9Oun0cad62giOPyqkQKYpbDAI/4LgSSrkVV8bLcU
         VmtSBrQPDFxTYmJwTdhZffrVAoQXg5GsbhyQpHAJmf6pibQi/ghgu16Qks75fvB+dT/i
         zFX40Vj5HtyybKFUblDWDAdjliH5Um2fNnfkVFLJGu8oVUJsQs4UT5atR+za+GUro647
         g83cTTfpbC5ttVWSk6BVLxg4M9hZDVKMlObmjCY0jTeMFZwHEDqguODwdgnbdbrWjtUh
         2qjERVpzMSMUDBdSO9Wu3Z7Rg/JSN/Ju74nK0cxkwi6zfTYJu9/XocmB1xRXriVOstpa
         0R8A==
X-Gm-Message-State: AOJu0Yztr9cGOUlhEhRLyklfy0GTmn+rI169X+TjZMUxE7VfPXvynEzh
	EbF86tQfeOs1WS6rPSjjPbX1wNOvNgroR/y2T5E=
X-Google-Smtp-Source: AGHT+IGwGVw/ENdBmTBuq/OsdGOVb9bL7dUVfHSIjD76u0nYDW4z51k8+asTg9udICSxRCYkIPEO0Q==
X-Received: by 2002:a7b:c38c:0:b0:40a:4609:9cbd with SMTP id s12-20020a7bc38c000000b0040a46099cbdmr4325372wmj.13.1700743280720;
        Thu, 23 Nov 2023 04:41:20 -0800 (PST)
Received: from xiaomi.filo.uk (lewi-26-b2-v4wan-163478-cust641.vm4.cable.virginm.net. [86.21.74.130])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c468500b004063d8b43e7sm2511878wmo.48.2023.11.23.04.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 04:41:20 -0800 (PST)
Message-ID: <38cb99f2b63dc55763e9e2c8ae4d4cb14afc6770.camel@tlvince.com>
Subject: MediaTek MT7922 controller crashes after LE Setup Isochronous Data
 Path
From: Tom Vincent <linux@tlvince.com>
To: linux-bluetooth@vger.kernel.org
Cc: pav@iki.fi
Date: Thu, 23 Nov 2023 12:41:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

I'm working through an issue with Bluetooth LE Audio with a new headset
(Creative Zen Hybrid Pro). The end result of which is no audio
input/output device is created.

With the generous help from Pauli (cc'ed) of the pipewire team, we can
see the headset connection establishes OK, but then appears to hit a
bug in the adapter's firmware (MediaTek MT7922), which triggers a
coredump and restarts.

Full logs and other context can be found at
https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/3666#note_2179246

... but as an overview of logs via btmon:

=3D Note: Linux version 6.6.1 (x86_64)                                 =20
0.069372
=3D Note: Bluetooth subsystem version 2.22                             =20
0.069374
=3D New Index: 14:AC:60:46:9E:9C (Primary,USB,hci3)               [hci3]
0.069375
=3D Open Index: 14:AC:60:46:9E:9C                                 [hci3]
0.069375
=3D Index Info: 14:AC:60:46:9E:9C (MediaTek, Inc.)                [hci3]
0.069376
@ MGMT Open: bluetoothd (privileged) version 1.22             {0x0001}
0.069377
@ MGMT Open: bluetoothctl version 1.22                        {0x0002}
0.069378

> ACL Data RX: Handle 512 flags 0x01 dlen 24              #142 [hci3]
12.183718
      ATT: Handle Value Notification (0x1b) len 46
< HCI Command: LE Set Connected... (0x08|0x0062) plen 24  #143 [hci3]
12.183932
        CIG ID: 0x00
> HCI Event: Command Complete (0x0e) plen 8               #144 [hci3]
12.184357
      LE Set Connected Isochronous Group Parameters (0x08|0x0062) ncmd
1

[ ... snip ... ]

> HCI Event: Command Status (0x0f) plen 4                 #170 [hci3]
12.664283
      LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1

[ ... snip ... ]

> HCI Event: LE Meta Event (0x3e) plen 29                 #186 [hci3]
13.203205
      LE Connected Isochronous Stream Established (0x19)
< HCI Command: LE Setup Isochron.. (0x08|0x006e) plen 13  #187 [hci3]
13.203326
        Handle: 1024
@ RAW Open: btmon (privileged) version 2.22                  {0x0003}
13.203504
@ RAW Close: btmon                                           {0x0003}
13.203512
> HCI Event: Command Complete (0x0e) plen 6               #188 [hci3]
13.203576
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
< HCI Command: LE Setup Isochron.. (0x08|0x006e) plen 13  #189 [hci3]
13.203606
        Handle: 1024
> HCI Event: Command Complete (0x0e) plen 6               #190 [hci3]
13.203929
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
< ACL Data TX: Handle 512 flags 0x00 dlen 10              #191 [hci3]
13.214209
      ATT: Write Command (0x52) len 5
=3D Vendor Diagnostic (len 72)                                   [hci3]
13.323162
        6f fc 44 00 3c 41 53 53 45 52 54 3e 20 2e 2e 2f  o.D.<ASSERT>
../

[ ... snip ... ]

=3D Vendor Diagnostic (len 19)                                   [hci3]
14.095706
        6f fc 0f 00 0a 3b 63 6f 72 65 64 75 6d 70 20 65  o....;coredump
e

[ ... snip ... ]
=3D bluetoothd: profiles/audio/transport.c:link_set_state() Unable... =20
14.143326
=3D Close Index: 14:AC:60:46:9E:9C                               [hci3]
14.188719
@ MGMT Event: Index Removed (0x0005) plen 0           {0x0001} [hci3]
14.188726
@ MGMT Event: Index Removed (0x0005) plen 0           {0x0002} [hci3]
14.188726
=3D Delete Index: 14:AC:60:46:9E:9C                              [hci3]
14.188733
=3D bluetoothd: profiles/audio/micp.c:micp_detached() unable to fin.. =20
14.189265
=3D bluetoothd: profiles/audio/vcp.c:vcp_detached() Unable to find... =20
14.189498
=3D bluetoothd: Endpoint unregistered: sender=3D:1.163 path=3D/MediaEnd.. =
=20
14.190532
=3D bluetoothd: Endpoint unregistered: sender=3D:1.163 path=3D/MediaEnd.. =
=20
14.190598
=3D bluetoothd: Endpoint unregistered: sender=3D:1.163 path=3D/MediaEnd.. =
=20
14.190653
=3D bluetoothd: Endpoint unregistered: sender=3D:1.163 path=3D/MediaEnd.. =
=20
14.190714
=3D bluetoothd: profiles/audio/bap.c:bap_detached() Unable to find... =20
14.197087
=3D bluetoothd: Battery Provider Manager destroyed                    =20
14.197851
=3D New Index: 00:00:00:00:00:00 (Primary,USB,hci0)           #0 [hci0]
14.436548
=3D Open Index: 00:00:00:00:00:00                                [hci0]
14.436637
=3D Index Info: 00:00:00:00:00:00 (MediaTek, Inc.)               [hci0]
14.436640

From the kernel/dmesg side:

[   19.567508] mt7921e 0000:01:00.0: enabling device (0000 -> 0002)
[   19.584454] mt7921e 0000:01:00.0: ASIC revision: 79220010
[   19.662305] mt7921e 0000:01:00.0: HW/SW Version: 0x8a108a10, Build
Time: 20230627143702a
[   20.048165] mt7921e 0000:01:00.0: WM Firmware Version: ____000000,
Build Time: 20230627143946
[   21.137805] mt7921e 0000:01:00.0 wlp1s0: renamed from wlan0
[  256.380280] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time:
20230627144220
[  256.521395] Bluetooth: hci0: Device setup in 144287 usecs
[  256.521408] Bluetooth: hci0: HCI Enhanced Setup Synchronous
Connection command is advertised, but not supported.
[  291.819885] Bluetooth: hci0: Opcode 0x2065 failed: -22
[  293.109210] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time:
20230627144220
[  293.246331] Bluetooth: hci0: Device setup in 138096 usecs
[  293.246342] Bluetooth: hci0: HCI Enhanced Setup Synchronous
Connection command is advertised, but not supported.
[  315.219892] Bluetooth: hci0: Mediatek coredump end
[  315.431355] usb 1-5: reset high-speed USB device number 3 using
xhci_hcd
[  618.882312] bluetoothd[9227]: segfault at 55b685cb1f50 ip
00007f07b909d2ce sp 00007ffee7201e40 error 4 in
libc.so.6[7f07b9028000+15a000] likely on CPU 7 (core 3, socket 0)
[  618.882350] Code: ff 66 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48
85 ff 0f 84 bb 00 00 00 55 48 8d 77 f0 53 48 83 ec 18 48 8b 1d 42 db 13
00 <48> 8b 47 f8 64 8b 2b a8 02 75 57 48 8b 15 d0 da 13 00 64 48 83 3a


The adapter's firmware `HW/SW Version: 0x008a008a, Build Time:
20230627144220` is the latest in linux-firmware
(https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.gi=
t/tree/WHENCE?id=3Dba1aa06f37477a702ebabf14b5753378460c9343#n5579)

Please let me know how best to proceed with this. Thanks!
