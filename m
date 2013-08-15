Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Aug 2013 10:18:38 +0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Set different event mask for LE-only
 controllers
Message-ID: <20130815081838.GD1980@joana>
References: <1376413254-36536-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1376413254-36536-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2013-08-13 10:00:54 -0700]:

> In case of a Low Energy only controller it makes no sense to configure
> the full BR/EDR event mask. It will just enable events that can not be
> send anyway and there is no guarantee that such a controller will accept
> this value.
> 
> Use event mask 0x90 0xe8 0x04 0x02 0x00 0x80 0x00 0x20 for LE-only
> controllers which enables the following events:
> 
>           Disconnection Complete
>           Encryption Change
>           Read Remote Version Information Complete
>           Command Complete
>           Command Status
>           Hardware Error
>           Number of Completed Packets
>           Data Buffer Overflow
>           Encryption Key Refresh Complete
>           LE Meta
> 
> This is according to Core Specification, Part E, Section 3.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
