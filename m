Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Karabin, Josh" <George.Karabin@Honeywell.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: RE: [External] [PATCH BlueZ v2 0/2] Change ConnectDevice to connect a
 subset of services
Date: Fri, 31 Aug 2018 13:47:15 +0000
Message-ID: <BN7PR07MB430554B9AF5693730B7A4F6C9D0F0@BN7PR07MB4305.namprd07.prod.outlook.com>
References: <BN7PR07MB4305F612204DE3F155FDF7329D310@BN7PR07MB4305.namprd07.prod.outlook.com>
In-Reply-To: <BN7PR07MB4305F612204DE3F155FDF7329D310@BN7PR07MB4305.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all - I would like to point your attention to this
patch set again. I realize it's more complicated than v1, and likely
needs more time for review.

> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Karabin, Josh
> Sent: Tuesday, August 21, 2018 11:37 AM
> To: linux-bluetooth@vger.kernel.org
> Subject: [External] [PATCH BlueZ v2 0/2] Change ConnectDevice to connect =
a
> subset of services
>=20
> This patch set makes it possible to use the experimental Adapter1
> ConnectDevice DBUS API to connect to a device without also
> connecting each of the device's services. This enables the out-of-band
> discovery of an address and expected service set without a
> general discovery procedure.
>=20
> This patch builds on this previous commit:
>=20
> commit c3f7b6733c5f ("adapter: Add ConnectDevice method")
>=20
> and review feedback on an earlier patch here:
>=20
> https://marc.info/?l=3Dlinux-bluetooth&m=3D153451634605069&w=3D2
>=20
> George Josh Karabin (2):
>   Allow Adapter1 ConnectDevice method to connect a limited set of
>     service UUIDs
>   Update the Adapter1 API to match the change to ConnectDevice.
>=20
> George Josh Karabin (2):
>   Allow Adapter1 ConnectDevice method to connect a limited set of
>     service UUIDs
>   Update the Adapter1 API to match the change to ConnectDevice.
>=20
>  doc/adapter-api.txt | 16 +++++---
>  src/adapter.c       | 91 +++++++++++++++++++++++++++++++++++++++++--
> --
>  2 files changed, 95 insertions(+), 12 deletions(-)
>=20
> --
> 2.17.1
