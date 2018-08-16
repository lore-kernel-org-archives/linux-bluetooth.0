Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Karabin, Josh" <George.Karabin@Honeywell.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ 0/2] Change ConnectDevice to optionally connect services
Date: Thu, 16 Aug 2018 20:26:20 +0000
Message-ID: <BN7PR07MB4305C0AA4DBCB0136D7F72199D3E0@BN7PR07MB4305.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set makes it possible to use the experimental Adapter1
ConnectDevice DBUS API to connect to a device without also
connecting each of the devices service. This enables out-of-band
discovery of an address with the conditional behavior of calling
ConnectProfile on a discovered device.

I chose to change the default behavior of the ConnectDevice API.
It will only connect all services if you set a new ConnectAllDevices
boolean value in the dictionary argument.

I feel that that makes a better default, and with this still being
an experimental API, I'll ask to see how others feel.

This would require changes to users of the original commit:

commit c3f7b6733c5f ("adapter: Add ConnectDevice method")

I would be fine with changing the API in some other way that makes this
use case possible - this is just my preference.

You may have seen questions about this a little bit ago - this is the
follow-up:

https://marc.info/?l=3Dlinux-bluetooth&m=3D153317507925739&w=3D2
https://marc.info/?l=3Dlinux-bluetooth&m=3D153315011619515&w=3D2

George Josh Karabin (2):
  Change the experimental Adapter1 ConnectDevice api to default to not
    connecting all profiles, using an optional parameter to restore the
    current behavior.
  Update the Adapter1 API to match the change to ConnectDevice.

 doc/adapter-api.txt | 15 ++++++++++-----
 src/adapter.c       | 18 +++++++++++++++---
 2 files changed, 25 insertions(+), 8 deletions(-)

--=20
2.17.1
