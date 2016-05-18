Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 May 2016 15:55:33 -0700
Message-ID: <CADEbe8No6u7Bw3scdyZqApxx9JUNxYrEOGxGJ_2gnFGNpvJ4Xg@mail.gmail.com>
Subject: Create Connection Cancel after 2 seconds
From: Aaron Okano <aaron@thetileapp.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all!

I am using a Raspberry Pi 3 to scan for and connect to BLE devices
using the BlueZ DBus API. However, I frequently receive the error:

    GDBus.Error:org.bluez.Error.Failed: Software caused connection abort

This appears to be because the connection request is cancelled after 2
seconds. Below is the relevant btmon dump:

< HCI Command: LE Create Connection (0x08|0x000d) plen 25      [hci0] 58.198376
        Scan interval: 60.000 msec (0x0060)
        Scan window: 60.000 msec (0x0060)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Peer address: E3:2E:9A:D6:29:93 (Static)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 58.199341
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection Ca.. (0x08|0x000e) plen 0  [hci0] 60.198208
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 60.239715
      LE Create Connection Cancel (0x08|0x000e) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                      [hci0] 60.239957
      LE Connection Complete (0x01)
        Status: Unknown Connection Identifier (0x02)
        Handle: 64
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: E3:2E:9A:D6:29:93 (Static)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
@ Connect Failed: E3:2E:9A:D6:29:93 (2) status 0x02


It seems that this is expected behavior:
http://marc.info/?l=linux-bluetooth&m=144830298701744&w=2

It is possible to decrease the probability of the error by making the
advertising interval of the device smaller, but I would prefer a fix
that can be implemented on the Raspberry Pi instead. Is it possible to
adjust the 2 second parameter? If not, are there any workarounds that
can mitigate the connection delays caused by the error? I am currently
re-issuing the connection request when I receive the error, but it
takes much more than 2 seconds for the error to be received, and also
it often takes several connection attempts before one is successful.

Here also is further information about my setup:
* BlueZ 5.39, with patches for hciattach that are required for the
Raspberry Pi 3
* Kernel 4.4.9-v7+
* Ubuntu 16.04


Thanks,
Aaron Okano
