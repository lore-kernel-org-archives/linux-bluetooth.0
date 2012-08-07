Return-Path: <cyrus@holtmann.org>
Message-ID: <1344354304.2083.47.camel@aeonflux>
Subject: Re: [PATCHv1 0/4] Remove unsafe batostr
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 07 Aug 2012 08:45:04 -0700
In-Reply-To: <1344351906-27563-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1344351906-27563-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Since the patch "vsprintf: add %pMR for Bluetooth MAC address" in in linux-next and wireless-testing
> remove batostr.
> 
> http://git.kernel.org/?p=linux/kernel/git/linville/wireless-testing.git;a=commitdiff;h=76597ff989a1fbaa9b9a1e54007cd759bf257ab7
> 
> Andrei Emeltchenko (4):
>   Bluetooth: Use %pMR BT addr print spec instead of batostr
>   Bluetooth: trivial: Shorten variable scope
>   Bluetooth: Use %pMR instead of baswap in seq_show
>   Bluetooth: trivial: Use preferred method for NULL check
> 
>  include/net/bluetooth/bluetooth.h |    1 -
>  net/bluetooth/af_bluetooth.c      |   20 ++++++++------------
>  net/bluetooth/bnep/core.c         |    3 +--
>  net/bluetooth/cmtp/core.c         |    2 +-
>  net/bluetooth/hci_conn.c          |    6 +++---
>  net/bluetooth/hci_core.c          |   22 +++++++++++-----------
>  net/bluetooth/hci_event.c         |   15 +++++++--------
>  net/bluetooth/hci_sysfs.c         |   10 +++++-----
>  net/bluetooth/hidp/core.c         |    8 ++++++--
>  net/bluetooth/l2cap_core.c        |   11 +++++------
>  net/bluetooth/lib.c               |   14 --------------
>  net/bluetooth/rfcomm/core.c       |   15 +++++++--------
>  net/bluetooth/rfcomm/sock.c       |    9 ++++-----
>  net/bluetooth/rfcomm/tty.c        |    6 +++---
>  net/bluetooth/sco.c               |   12 ++++++------
>  15 files changed, 67 insertions(+), 87 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


