Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 07 Jul 2018 22:07:15 -0400
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: David Krauser <david@krauser.org>
Reply-To: David Krauser <david@krauser.org>
Subject: [PATCH v3 BlueZ 0/4] Provide MTU on GATT reads and writes.
Message-ID: <lfAZ3aaVFr39yrDTnm8tsEbi_RssnjM0GdmRrmL5h4ZCGLmenHFnB0kRmHR9ZNBYlbwm2OMG4Y4Jt4rIuoDBPZPGiAFa78nieXDeHrztYCE=@krauser.org>
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

David Krauser (4):
  src: provide MTU on GATT value reads and writes
  doc: provide MTU on GATT value reads and writes
  src: make att le mtu configurable in main.conf
  src: rename MinEncKeySize

 doc/gatt-api.txt    | 10 ++++++++--
 src/device.c        |  2 +-
 src/gatt-database.c | 26 ++++++++++----------------
 src/hcid.h          |  1 +
 src/main.c          | 32 +++++++++++++++++++++++++++++---
 src/main.conf       |  9 +++++++--
 6 files changed, 56 insertions(+), 24 deletions(-)

--=20
2.18.0

