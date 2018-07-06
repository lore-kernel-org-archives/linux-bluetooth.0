Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 05 Jul 2018 20:42:52 -0400
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: David Krauser <david@krauser.org>
Reply-To: David Krauser <david@krauser.org>
Subject: [PATCH BlueZ 0/3] Provide MTU on GATT reads and writes.
Message-ID: <3GnQ1PTiUy_muwmwh57SSbQhkJeTd7vqdz_O5V0PLRADpTmYtoJ4XcJvwGz76Pn8OxW3MCc8IklJhl9C-LISya-_vLYEas63C3eKZXD62XM=@krauser.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches will append the negotiated MTU to the options
dictionary that is provided over DBus on characteristic reads
and writes.

These will also allow a user to configure the max mtu in main.conf

David Krauser (3):
  src: provide MTU on GATT value reads and writes
  doc: provide MTU on GATT value reads and writes
  src: make att max le mtu configurable in main.conf

 doc/gatt-api.txt    |  2 ++
 src/device.c        |  2 +-
 src/gatt-database.c | 23 +++++++----------------
 src/hcid.h          |  1 +
 src/main.c          | 16 ++++++++++++++++
 src/main.conf       |  5 +++++
 6 files changed, 32 insertions(+), 17 deletions(-)

--=20
2.18.0

