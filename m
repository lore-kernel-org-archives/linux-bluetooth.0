Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Feb 2011 09:14:22 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-bluetooth@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH -next] bluetooth: fix build break
Message-ID: <20110222121422.GA2249@joana>
References: <1298358789-13202-1-git-send-email-gadiyar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298358789-13202-1-git-send-email-gadiyar@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anand,

* Anand Gadiyar <gadiyar@ti.com> [2011-02-22 12:43:09 +0530]:

> Linux-next as of 20110217 complains when building for OMAP1.
> 
>   LD      vmlinux
> `hci_sock_cleanup' referenced in section `.init.text' of net/built-in.o: defined in discarded section `.exit.text' of net/built-in.o
> `hci_sock_cleanup' referenced in section `.init.text' of net/built-in.o: defined in discarded section `.exit.text' of net/built-in.o
> make: *** [vmlinux] Error 1
> 
> A recent patch by Gustavo (Bluetooth: Merge L2CAP and SCO modules
> into bluetooth.ko) introduced this by calling the hci_sock_cleanup
> function in the error path of bt_init.
> 
> Fix this by dropping the __exit marking for hci_sock_cleanup.
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/hci_sock.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I didn't catch on my system, applied. Thanks for fixing this.

-- 
Gustavo F. Padovan
http://profusion.mobi
