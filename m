Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Apr 2013 23:41:20 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3 01/18] Bluetooth: hidp: remove redundant error message
Message-ID: <20130406024120.GA10666@joana>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
 <1365166670-3271-2-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365166670-3271-2-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@gmail.com> [2013-04-05 14:57:33 +0200]:

> We print this error twice in the first error-path so remove it. One error
> message is enough.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  net/bluetooth/hidp/sock.c | 1 -
>  1 file changed, 1 deletion(-)

Patch has been applied. Thanks.

	Gustavo
