Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ 4/4] tools/bluetooth-player: Use bt_shell helpers
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>
References: <20171205183327.853-1-luiz.dentz@gmail.com>
 <20171205183327.853-4-luiz.dentz@gmail.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <07ebaaad-59ec-c890-d202-fbbdc6fc4f71@jp.fujitsu.com>
Date: Wed, 6 Dec 2017 12:00:37 +0900
MIME-Version: 1.0
In-Reply-To: <20171205183327.853-4-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 12/06/2017 03:33 AM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes bluetooth-player use bt_shell to manage the menus and
> command handling.
> ---
>  Makefile.tools           |   4 +-
>  tools/bluetooth-player.c | 473 +++++++++++------------------------------------
>  2 files changed, 111 insertions(+), 366 deletions(-)
> 

Probably, bluetooth-player has the similar problem as obexctl.


Regards,
Eramoto

