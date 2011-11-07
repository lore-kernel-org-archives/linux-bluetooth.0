Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Nov 2011 17:30:10 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Define HCI reasons instead of magic number
Message-ID: <20111107193010.GC3707@joana>
References: <1320668425-11251-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320668425-11251-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-11-07 14:20:25 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Use HCI error reasons instead of magic numbers.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h      |    7 +++++++
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_conn.c         |    2 +-
>  net/bluetooth/hci_event.c        |    4 ++--
>  net/bluetooth/l2cap_core.c       |    8 ++++----
>  5 files changed, 15 insertions(+), 8 deletions(-)

Applied, thanks.

	Gustavo
