Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1460307544.1800.53.camel@perches.com>
Subject: Re: [PATCH] Bluetooth: Deinline large functions
From: Joe Perches <joe@perches.com>
To: Denys Vlasenko <dvlasenk@redhat.com>,
	Johan Hedberg <johan.hedberg@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 10 Apr 2016 09:59:04 -0700
In-Reply-To: <1460305444-14159-1-git-send-email-dvlasenk@redhat.com>
References: <1460305444-14159-1-git-send-email-dvlasenk@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2016-04-10 at 18:24 +0200, Denys Vlasenko wrote:
> Fastest existing Bluetooth standard's top speed is 2.4 MB/s.
> It is way off from being CPU limited, no need to squeeze
> last few cycles by excessive inlining.
> 
> This patch delinlines the following functions:
> 
> hci_conn_hash_lookup_handle: 345 bytes, 39 calls
> hci_conn_hash_lookup_ba: 372 bytes, 36 calls
> hci_conn_hash_lookup_le: 382 bytes, 8 calls
> hci_conn_hash_lookup_state: 356 bytes, 3 calls
> hci_lookup_le_connect: 378 bytes, 7 calls
> hci_conn_drop: 186 bytes, 30 calls
> hci_connect_cfm: 121 bytes, 15 calls
> hci_disconn_cfm: 121 bytes, 2 calls
> hci_auth_cfm: 156 bytes, 2 calls
> hci_encrypt_cfm: 156 bytes, 3 calls
> 
> Size reduction is about 40k:
> 
>     text     data      bss       dec     hex filename
> 95943139 20860256 35991552 152794947 91b7743 vmlinux_before
> 95903714 20860256 35991552 152755522 91add42 vmlinux

Hello Denys

While removing unnecessary inlines is generally a
good thing, for extremely low power embedded systems
like a coin-battery operated bicycle computer or a
heart rate monitor, this might cause a throughput
reduction.

Also, the size decrease for a defconfig should be
quite a bit smaller than this.

Can you please also show the size decrease when done
with a defconfig with bluetooth support?

And for these types of patches in general, please
add a defconfig size reduction to the commit message.

This is an x86-64 defconfig with bluetooth with and
without this patch:

$ size vmlinux.defconfig.*
   text	   data	    bss	    dec	    hex	filename
10214414	4313816	1097728	15625958	 ee6ee6	vmlinux.defconfig.new
10224014	4313816	1097728	15635558	 ee9466	vmlinux.defconfig.old

~10k total
