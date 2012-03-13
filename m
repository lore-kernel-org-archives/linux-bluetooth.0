Return-Path: <cyrus@holtmann.org>
Message-ID: <1331651858.14217.94.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: trivial: Remove sparse warnings
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 13 Mar 2012 08:17:38 -0700
In-Reply-To: <1331626715-23685-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331626715-23685-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Fix sparse warnings related to incorrect type in assignment and static symbol.
> Also use const keyword. Warnings are shown below:
> 
> ...
> net/bluetooth/mgmt.c:305:28: warning: incorrect type in assignment
> (different base types)
> net/bluetooth/mgmt.c:305:28:    expected unsigned short [usertype] *opcode
> net/bluetooth/mgmt.c:305:28:    got restricted __le16 *<noident>
> ...
> net/bluetooth/mgmt.c:2609:3: warning: symbol 'mgmt_handlers' was not declared.
> Should it be static?
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/mgmt.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


