Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2003783a-cdd8-597a-6438-967ffafe67c8@jp.fujitsu.com>
References: <2003783a-cdd8-597a-6438-967ffafe67c8@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Jan 2018 14:29:44 -0200
Message-ID: <CABBYNZ+o6Q1ysUr_L7aeSiGveJF2-j3AsJGhXxVmKZ3_tbT4+g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/8] Add generators for bluetooth-player/obexctl
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Thu, Dec 28, 2017 at 3:36 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> This patch set adds generators for bluetooth-player and obexctl.
> bluetooth-player and obexctl also use GList instead of GSList.
>
> Changes in v2:
>  - Add index to g_dbus_proxy_lookup().
>  - Make g_dbus_proxy_lookup() check if the passed interface is NULL.
>  - Rework callers of g_dbus_proxy_lookup() due to add the index argument.
>  - Move strlen() outside loop.
>  - Implement g_dbus_proxy_path_lookup() like g_dbus_proxy_lookup()
>
>
> ERAMOTO Masaya (8):
>   gdbus: Make proxy_lookup() global
>   client: Use g_dbus_proxy_lookup()
>   tools/bluetooth-player: Use g_dbus_proxy_lookup() instead of find_*
>   tools/obexctl: Use g_dbus_proxy_lookup() instead of find_*
>   gdbus: Introduce g_dbus_proxy_path_lookup()
>   client: Use g_dbus_proxy_path_lookup()
>   tools/bluetooth-player: Add generator for player/item
>   tools/obexctl: Add generator for session/transfer
>
>  client/gatt.c            |  57 ++---------
>  client/main.c            |  15 +--
>  gdbus/client.c           |  44 ++++++--
>  gdbus/gdbus.h            |   4 +
>  tools/bluetooth-player.c | 134 ++++++++++++-------------
>  tools/obexctl.c          | 254 ++++++++++++++++++-----------------------------
>  6 files changed, 221 insertions(+), 287 deletions(-)
>
> --
> 2.14.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
