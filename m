Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Tue, 19 Apr 2016 16:56:18 +0200
Message-ID: <CAEZxfGMCA_A1RQVmxr6DWgweD5Qg6e34F-09Ws=stLpV=YU5=w@mail.gmail.com>
Subject: Add Eddystone GATT Config Service to known UUIDs
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'd love to see the new Eddystone Configuration GATT Service
(https://github.com/google/eddystone/tree/master/configuration-service)
being recognized by BlueZ.
Could you guys make this happen?

Something like:

[bluetooth]# info F1:6F:DE:EC:F1:D6
Device F1:6F:DE:EC:F1:D6
        Name: ES G-SLOTS-X
        Alias: ES G-SLOTS-X
        Appearance: 0x0200
        Paired: no
        Trusted: yes
        Blocked: no
        Connected: no
        LegacyPairing: no
        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
        UUID: Eddystone Configuration GATT Service
(a3c87500-8ed3-4bdf-8a39-a01bebede295)

instead of

[bluetooth]# info F1:6F:DE:EC:F1:D6
Device F1:6F:DE:EC:F1:D6
        Name: ES G-SLOTS-X
        Alias: ES G-SLOTS-X
        Appearance: 0x0200
        Paired: no
        Trusted: yes
        Blocked: no
        Connected: no
        LegacyPairing: no
        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
        UUID: Vendor specific           (a3c87500-8ed3-4bdf-8a39-a01bebede295)
