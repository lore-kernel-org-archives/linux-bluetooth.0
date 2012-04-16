Return-Path: <cyrus@holtmann.org>
Message-ID: <1334566621.16897.168.camel@aeonflux>
Subject: Re: [PATCHv2 1/2] Bluetooth: hci_persistent_key should return bool
From: Marcel Holtmann <marcel@holtmann.org>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 16 Apr 2012 10:57:01 +0200
In-Reply-To: <1334319203-9482-1-git-send-email-vishal.agarwal@stericsson.com>
References: <1334319203-9482-1-git-send-email-vishal.agarwal@stericsson.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

> This patch changes the return type of function hci_persistent_key
> from int to bool because it makes more sense to return information
> whether a key is persistent or not as a bool.
> 
> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_core.c         |   21 +++++++++++----------
>  net/bluetooth/mgmt.c             |    2 +-
>  3 files changed, 13 insertions(+), 12 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


