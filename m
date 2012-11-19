Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Nov 2012 19:57:16 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: Increase HCI command tx timeout
Message-ID: <20121119215716.GE14006@joana>
References: <1352714465-17015-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352714465-17015-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

* Szymon Janc <szymon.janc@tieto.com> [2012-11-12 11:01:05 +0100]:

> Read Local OOB Data command can take more than 1 second on some chips.
> e.g. on CSR 0a12:0001 first call to Read Local OOB Data after reset
> takes about 1300ms resulting in tx timeout error.
> 
> [27698.368655] Bluetooth: hci0 command 0x0c57 tx timeout
> 
> 2012-10-31 15:53:36.178585 < HCI Command: Read Local OOB Data (0x03|0x0057) plen 0
> 2012-10-31 15:53:37.496996 > HCI Event: Command Complete (0x0e) plen 36
>     Read Local OOB Data (0x03|0x0057) ncmd 1
>     status 0x00
>     hash 0x92219d9b447f2aa9dc12dda2ae7bae6a
>     randomizer 0xb1948d0febe4ea38ce85c4e66313beba
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
> 
> Spec doesn't seem to be posing any restrictions on how fast should HCI response...
> I've increased timeout to 2 secs as this seems to fix this for me, but maybe this
> could be increased to something more, like 5 secs or sth to minimize tx timeout
> chance for other slow chips?  If chip doesn't response for command it is FUBAR
> anyway and having longer timeout would not make things that much worse (and
> could even improve things on slow chips..).
> 
> 
>  include/net/bluetooth/hci.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch is now on bluetooth-next. Thanks. Moreover there was never a real
reason to have the timeout with a 1 second value, it just proved to be enough
at the time we added the timeout mechanism for hci commands.

	Gustavo
