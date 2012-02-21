Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Feb 2012 15:25:49 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 03/14] Bluetooth: Add l2cap_chan_lock
Message-ID: <20120221172549.GB866@joana>
References: <1329821707-11817-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1329821707-11817-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329821707-11817-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-02-21 12:54:56 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Channel lock will be used to lock L2CAP channels which are locked
> currently by socket locks.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h |   11 +++++++++++
>  net/bluetooth/l2cap_core.c    |    2 ++
>  2 files changed, 13 insertions(+), 0 deletions(-)

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

	Gustavo
