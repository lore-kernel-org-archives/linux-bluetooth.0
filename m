Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v3] Bluetooth: Fix channel check when binding RFCOMM sock
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1392910921-19348-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Thu, 20 Feb 2014 11:37:41 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <352D0B29-D18D-4372-8E7A-2E55100405E6@holtmann.org>
References: <1392910921-19348-1-git-send-email-andrzej.kaczmarek@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

> When binding RFCOMM socket with non-zero channel we're checking if
> there is already any other socket which has the same channel number
> assigned and then fail. This check does not consider situation where
> we have another socket connected to remote device on given channel
> number in which case we still should be able to bind local socket.
> 
> This patch changes __rfcomm_get_sock_by_addr() to return only sockets
> in either BT_BOUND or BT_LISTEN states, also name is updated to better
> describe what this function does now.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
> net/bluetooth/rfcomm/sock.c | 18 ++++++++++++------
> 1 file changed, 12 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

