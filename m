Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: Fix user channel for 32bit userspace on 64bit
 kernel
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170425012504.30505-1-szymon.janc@codecoup.pl>
Date: Tue, 25 Apr 2017 04:53:08 +0200
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Marko Kiiskila <marko@runtime.io>
Message-Id: <A041B612-929F-4CFA-9C99-C4AFEDE6C09B@holtmann.org>
References: <20170425012504.30505-1-szymon.janc@codecoup.pl>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Running 32bit userspace on 64bit kernel results in MSG_CMSG_COMPAT being
> defined as 0x80000000. This results in sendmsg failure if used from 32bit
> userspace running on 64bit kernel. Fix this by accounting for MSG_CMSG_COMPAT
> in flags check in hci_sock_sendmsg.
> 
> Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
> Signed-off-by: Marko Kiiskila <marko@runtime.io>
> ---
> net/bluetooth/hci_sock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

