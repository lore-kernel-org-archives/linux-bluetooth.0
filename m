Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Apr 2014 10:55:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth@vger.kernel.org, bzhao@marvell.com
Subject: Re: [PATCH] Bluetooth: btmrvl: Fix btmrvl_send_module_cfg_cmd()
Message-ID: <20140422075522.GA31583@t440s.lan>
References: <20140415200001.1356C10153C@puck.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140415200001.1356C10153C@puck.mtv.corp.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Tue, Apr 15, 2014, Petri Gynther wrote:
> Change subcmd parameter from int to u8 to match its use:
> btmrvl_send_sync_cmd(priv, BT_CMD_MODULE_CFG_REQ, &subcmd, 1);
> 
> Signed-off-by: Petri Gynther <pgynther@google.com>
> ---
>  drivers/bluetooth/btmrvl_drv.h  | 2 +-
>  drivers/bluetooth/btmrvl_main.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
