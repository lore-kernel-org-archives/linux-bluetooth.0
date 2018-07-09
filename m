Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 09 Jul 2018 12:24:03 -0400
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: David Krauser <david@krauser.org>
Reply-To: David Krauser <david@krauser.org>
Subject: [PATCH v4 BlueZ 0/3] Provide MTU on GATT reads and writes.
Message-ID: <ChEt6IevVUjWIxK8LSxd-_mQL47nxsrsmQXAUtJ4vB8vApY4ILVJUlDFpKNfSxStiYamZxKZhRmVy9LWpyDlSM3R5LyJzjv5qIVXuKp-NAY=@krauser.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches will append the negotiated MTU to the options
dictionary that is provided over DBus on characteristic reads
and writes.

These will also allow a user to configure the max mtu in main.conf

v2: Lowercase "MTU" in options dict and mark old key as deprecated.
v3: Fix mangled whitespace. Renamed two options in main.conf
v4: Removing deprecated options

David Krauser (3):
  src: provide MTU on GATT value reads and writes
  doc: provide MTU on GATT value reads and writes
  src: make att le mtu configurable in main.conf

 doc/gatt-api.txt    |  6 ++++--
 src/device.c        |  2 +-
 src/gatt-database.c | 23 +++++++----------------
 src/hcid.h          |  1 +
 src/main.c          | 22 +++++++++++++++++++---
 src/main.conf       |  9 +++++++--
 6 files changed, 39 insertions(+), 24 deletions(-)

--=20
2.18.0

