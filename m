Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: John Klug <ski.brimson@gmail.com>
Date: Wed, 15 Nov 2017 11:03:40 -0600
Message-ID: <CADU0VqzNOZraF0Gptccz+Hu=1mZEc4ki9Nm96Spexf4h6M2wfg@mail.gmail.com>
Subject: When can I trust with bluetoothctl and 5.47?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Over and over again it says device is not available.  When does it
become available?  Is there a way to do this deterministically?  I
quickly entered trust (it was saved from previous executions
unsuccessfully) after pairing.  Then after connecting, all to no
avail.

Is there documentation on this?

The remote in this case is Broadcom 6.5.1.6000 stack.

[agent] Confirm passkey 702629 (yes/no): yes
[CHG] Device 5C:F3:70:74:04:AF UUIDs: 00001000-0000-1000-8000-00805f9b34fb
[CHG] Device 5C:F3:70:74:04:AF UUIDs: 00001115-0000-1000-8000-00805f9b34fb
[CHG] Device 5C:F3:70:74:04:AF ServicesResolved: yes
[CHG] Device 5C:F3:70:74:04:AF Paired: yes
[John Conduit Klug (SGH-M919)]# trust  5C:F3:70:74:04:AF
Device  5C:F3:70:74:04:AF not available
[CHG] Device 5C:F3:70:74:04:AF ServicesResolved: no
[CHG] Device 5C:F3:70:74:04:AF Connected: no
[John Conduit Klug (SGH-M919)]# trust  5C:F3:70:74:04:AF
Device  5C:F3:70:74:04:AF not available
[John Conduit Klug (SGH-M919)]# devices
Device BC:44:86:56:6B:95 John Conduit Klug (SGH-M919)
Device 5C:F3:70:74:04:AF CALMQUIST-L1
[John Conduit Klug (SGH-M919)]# info 5C:F3:70:74:04:AF
Device 5C:F3:70:74:04:AF
    Name: CALMQUIST-L1
    Alias: CALMQUIST-L1
    Class: 0x0002010c
    Icon: computer
    Paired: yes
    Trusted: no
    Blocked: no
    Connected: no
    LegacyPairing: no
    UUID: Service Discovery Serve.. (00001000-0000-1000-8000-00805f9b34fb)
    UUID: PANU                      (00001115-0000-1000-8000-00805f9b34fb)
[John Conduit Klug (SGH-M919)]# trust  5C:F3:70:74:04:AF
Device  5C:F3:70:74:04:AF not available
[CHG] Device BC:44:86:56:6B:95 Connected: no
[bluetooth]# trust  5C:F3:70:74:04:AF
Device  5C:F3:70:74:04:AF not available
[bluetooth]# devices
Device BC:44:86:56:6B:95 John Conduit Klug (SGH-M919)
Device 5C:F3:70:74:04:AF CALMQUIST-L1
[CHG] Device 5C:F3:70:74:04:AF Connected: yes
Authorize service
[agent] Authorize service 0000000f-0000-1000-8000-00805f9b34fb (yes/no): yes
[CALMQUIST-L1]# trust  5C:F3:70:74:04:AF
Device  5C:F3:70:74:04:AF not available
[CALMQUIST-L1]# info 5C:F3:70:74:04:AF
Device 5C:F3:70:74:04:AF
    Name: CALMQUIST-L1
    Alias: CALMQUIST-L1
    Class: 0x0002010c
    Icon: computer
    Paired: yes
    Trusted: no
    Blocked: no
    Connected: yes
    LegacyPairing: no
    UUID: Service Discovery Serve.. (00001000-0000-1000-8000-00805f9b34fb)
    UUID: PANU                      (00001115-0000-1000-8000-0080
