Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 06 Jul 2018 19:21:46 -0400
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: David Krauser <david@krauser.org>
Reply-To: David Krauser <david@krauser.org>
Subject: [PATCH v2 BlueZ 0/3] Provide MTU on GATT reads and writes.
Message-ID: <tbEkxAi6z5_yX1KV8JBrb4crH8z0WB81VCeGSOs-g34KwxLkCYn1i_3eRwuHEn0OrZ2E0-J8sk3SKtNJIIa-HQewOerVMJGPsrC3nRT-g1A=@krauser.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches will append the negotiated MTU to the options
dictionary that is provided over DBus on characteristic reads
and writes.

These will also allow a user to configure the max mtu in main.conf

v2: Lowercase "MTU" in options dict and mark old key as deprecated

David Krauser (3):
  src: provide MTU on GATT value reads and writes
  doc: provide MTU on GATT value reads and writes
  src: make att max le mtu configurable in main.conf

 doc/gatt-api.txt    | 10 ++++++++--
 src/device.c        |  2 +-
 src/gatt-database.c | 26 ++++++++++----------------
 src/hcid.h          |  1 +
 src/main.c          | 16 ++++++++++++++++
 src/main.conf       |  5 +++++
 6 files changed, 41 insertions(+), 19 deletions(-)

--
2.18.0

