Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Karabin, Josh" <George.Karabin@Honeywell.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ v2 0/2] Change ConnectDevice to connect a subset of
 services
Date: Tue, 21 Aug 2018 15:36:57 +0000
Message-ID: <BN7PR07MB4305F612204DE3F155FDF7329D310@BN7PR07MB4305.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set makes it possible to use the experimental Adapter1
ConnectDevice DBUS API to connect to a device without also
connecting each of the device's services. This enables the out-of-band
discovery of an address and expected service set without a
general discovery procedure.

This patch builds on this previous commit:

commit c3f7b6733c5f ("adapter: Add ConnectDevice method")

and review feedback on an earlier patch here:

https://marc.info/?l=3Dlinux-bluetooth&m=3D153451634605069&w=3D2

George Josh Karabin (2):
  Allow Adapter1 ConnectDevice method to connect a limited set of
    service UUIDs
  Update the Adapter1 API to match the change to ConnectDevice.

George Josh Karabin (2):
  Allow Adapter1 ConnectDevice method to connect a limited set of
    service UUIDs
  Update the Adapter1 API to match the change to ConnectDevice.

 doc/adapter-api.txt | 16 +++++---
 src/adapter.c       | 91 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 95 insertions(+), 12 deletions(-)

--=20
2.17.1
