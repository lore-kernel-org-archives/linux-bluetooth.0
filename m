Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ v2 0/8] Add generators for bluetooth-player/obexctl
Message-ID: <2003783a-cdd8-597a-6438-967ffafe67c8@jp.fujitsu.com>
Date: Thu, 28 Dec 2017 14:36:51 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set adds generators for bluetooth-player and obexctl.
bluetooth-player and obexctl also use GList instead of GSList.

Changes in v2:
 - Add index to g_dbus_proxy_lookup().
 - Make g_dbus_proxy_lookup() check if the passed interface is NULL.
 - Rework callers of g_dbus_proxy_lookup() due to add the index argument.
 - Move strlen() outside loop.
 - Implement g_dbus_proxy_path_lookup() like g_dbus_proxy_lookup()


ERAMOTO Masaya (8):
  gdbus: Make proxy_lookup() global
  client: Use g_dbus_proxy_lookup()
  tools/bluetooth-player: Use g_dbus_proxy_lookup() instead of find_*
  tools/obexctl: Use g_dbus_proxy_lookup() instead of find_*
  gdbus: Introduce g_dbus_proxy_path_lookup()
  client: Use g_dbus_proxy_path_lookup()
  tools/bluetooth-player: Add generator for player/item
  tools/obexctl: Add generator for session/transfer

 client/gatt.c            |  57 ++---------
 client/main.c            |  15 +--
 gdbus/client.c           |  44 ++++++--
 gdbus/gdbus.h            |   4 +
 tools/bluetooth-player.c | 134 ++++++++++++-------------
 tools/obexctl.c          | 254 ++++++++++++++++++-----------------------------
 6 files changed, 221 insertions(+), 287 deletions(-)

-- 
2.14.1

