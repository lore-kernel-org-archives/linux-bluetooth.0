Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Dec 2010 23:09:08 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Subject: Re: [PATCH 3/3] Bluetooth: Make hci_send_to_sock usable for
 management control sockets
Message-ID: <20101208010908.GA2659@vigoh>
References: <1291760467-1569-1-git-send-email-johan.hedberg@gmail.com>
 <1291760467-1569-4-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291760467-1569-4-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2010-12-08 00:21:07 +0200]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> In order to send data to management control sockets the function should:
> 
>   - skip checks intended for raw HCI data and stack internal events
>   - make sure RAW HCI data or stack internal events don't go to
>     management control sockets
> 
> In order to accomplish this the patch adds a new member to the bluetooth
> skb private data to flag skb's that are destined for management control
> sockets.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

All 3 patches have been applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
