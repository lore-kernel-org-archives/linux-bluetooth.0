Return-Path: <cyrus@holtmann.org>
Message-ID: <1327960796.1955.181.camel@aeonflux>
Subject: Re: [PATCH 3/4] Bluetooth: Introduce to_hci_conn
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Date: Mon, 30 Jan 2012 13:59:56 -0800
In-Reply-To: <1327679246-2667-4-git-send-email-dh.herrmann@googlemail.com>
References: <1327679246-2667-1-git-send-email-dh.herrmann@googlemail.com>
	 <1327679246-2667-4-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> This avoids using the dev_set/get_drvdata() functions to retrieve a
> pointer to our own structure. We can use simple pointer arithmetic here.
> The drvdata field is actually not needed by any other code-path but this
> makes the code more consistent with hci_dev.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_sysfs.c        |   10 ++++------
>  2 files changed, 5 insertions(+), 6 deletions(-)

I read through the comment and I am fine with to_hci_conn.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


