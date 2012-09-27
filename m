Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Sep 2012 18:11:25 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 0/4] Remove unsafe batostr
Message-ID: <20120927211125.GE15463@joana>
References: <20120821175534.GD17005@joana>
 <1348566586-28572-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348566586-28572-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-09-25 12:49:42 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Since the patch "vsprintf: add %pMR for Bluetooth MAC address" in in bluetooth-next resend the patch series.
> 
> Changes:
> 	* v2: Rebase against recent bluetooth-next.
> 
> Andrei Emeltchenko (4):
>   Bluetooth: Use %pMR in debug instead of batostr
>   Bluetooth: Use %pMR in sprintf/seq_printf  instead of batostr
>   Bluetooth: Use %pMR instead of baswap in seq_show
>   bluetooth: Remove unneeded batostr function
> 
>  include/net/bluetooth/bluetooth.h |    1 -
>  net/bluetooth/af_bluetooth.c      |   10 ++++------
>  net/bluetooth/bnep/core.c         |    3 +--
>  net/bluetooth/cmtp/core.c         |    2 +-
>  net/bluetooth/hci_conn.c          |    6 +++---
>  net/bluetooth/hci_core.c          |   22 +++++++++++-----------
>  net/bluetooth/hci_event.c         |   15 +++++++--------
>  net/bluetooth/hci_sysfs.c         |   10 +++++-----
>  net/bluetooth/hidp/core.c         |    8 ++++++--
>  net/bluetooth/l2cap_core.c        |   17 ++++++++---------
>  net/bluetooth/lib.c               |   14 --------------
>  net/bluetooth/rfcomm/core.c       |   15 +++++++--------
>  net/bluetooth/rfcomm/sock.c       |    9 ++++-----
>  net/bluetooth/rfcomm/tty.c        |    6 +++---
>  net/bluetooth/sco.c               |   12 ++++++------
>  15 files changed, 66 insertions(+), 84 deletions(-)

all 4 patches are now applied to bluetooth-next. Thanks.

	Gustavo
