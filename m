Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 1/1] Bluetooth: make hci_test_bit's addr const
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1424355643-30660-1-git-send-email-jslaby@suse.cz>
Date: Fri, 27 Feb 2015 09:31:51 -0800
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>
Message-Id: <9209F1E9-EE66-44C5-B144-28D8B5E4BF4C@holtmann.org>
References: <1424354164-11728-1-git-send-email-jslaby@suse.cz> <1424355643-30660-1-git-send-email-jslaby@suse.cz>
To: Jiri Slaby <jslaby@suse.cz>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jiri,

> gcc5 warns about passing a const array to hci_test_bit which takes a
> non-const pointer:
> net/bluetooth/hci_sock.c: In function ‘hci_sock_sendmsg’:
> net/bluetooth/hci_sock.c:955:8: warning: passing argument 2 of ‘hci_test_bit’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-array-qualifiers]
>        &hci_sec_filter.ocf_mask[ogf])) &&
>        ^
> net/bluetooth/hci_sock.c:49:19: note: expected ‘void *’ but argument is of type ‘const __u32 (*)[4] {aka const unsigned int (*)[4]}’
> static inline int hci_test_bit(int nr, void *addr)
>                   ^
> 
> So make 'addr' 'const void *'.
> 
> [v2] make the pointer in the cast const too. 

btw. the version comments should go after the --- so that git am takes it back out. I do not need them in the commit message.

> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> ---
> net/bluetooth/hci_sock.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Patch has been applied to bluetooth-next tree.

Regards

Marcel

