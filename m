Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ 0/8] Add generators for bluetooth-player/obexctl
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-ID: <6f0b4053-4936-8d8c-3095-d6326d9a0e93@jp.fujitsu.com>
Date: Fri, 22 Dec 2017 16:29:53 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set adds generators for bluetooth-player and obexctl.
bluetooth-player and obexctl also use GList instead of GSList.

ERAMOTO Masaya (8):
  gdbus: Make proxy_lookup() global
  client: Use g_dbus_proxy_lookup()
  tools/bluetooth-player: Use g_dbus_proxy_lookup() instead of find_*
  tools/obexctl: Use g_dbus_proxy_lookup() instead of find_*
  gdbus: Introduce g_dbus_proxy_path_lookup()
  client: Use g_dbus_proxy_path_lookup()
  tools/bluetooth-player: Add generator for player/item
  tools/obexctl: Add generator for session/transfer

 client/gatt.c            |  56 ++---------
 client/main.c            |  15 +--
 gdbus/client.c           |  32 +++++-
 gdbus/gdbus.h            |   4 +
 tools/bluetooth-player.c | 132 ++++++++++++-------------
 tools/obexctl.c          | 253 ++++++++++++++++++-----------------------------
 6 files changed, 206 insertions(+), 286 deletions(-)

-- 
2.14.1

