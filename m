Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/3] Bluetooth: Make hci_send_to_sock usable for
 management control sockets
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
In-Reply-To: <1290609575-28435-4-git-send-email-johan.hedberg@gmail.com>
References: <1290609575-28435-1-git-send-email-johan.hedberg@gmail.com>
	 <1290609575-28435-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Nov 2010 15:49:29 +0100
Message-ID: <1290610169.13641.16.camel@aeonflux.mpl.access-company.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> In order to send data to management control sockets the function should:
> 
>   - skip checks intended for raw HCI data and stack internal events
>   - make sure RAW HCI data or stack internal events don't go to
>     management control sockets
> 
> In order to accomplish this the patch adds a new member to the bluetooth
> skb private data to flag skb's that are destined for management control
> sockets.

looks fine to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


