Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Nov 2011 14:45:42 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] bluetooth: replace list_for_each with
 list_for_each_entry whenever possible
Message-ID: <20111101164542.GJ2580@joana>
References: <1320137942-25780-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320137942-25780-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-11-01 10:58:56 +0200]:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When all items in the list have the same type there is no much of a point
> to use list_for_each except if you want to use the list pointer itself.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/bnep/core.c   |   13 +++--------
>  net/bluetooth/cmtp/core.c   |   13 +++--------
>  net/bluetooth/hci_conn.c    |   14 +++---------
>  net/bluetooth/hci_core.c    |   46 +++++++++++-------------------------------
>  net/bluetooth/hci_sysfs.c   |   18 +++-------------
>  net/bluetooth/hidp/core.c   |    1 +
>  net/bluetooth/mgmt.c        |   32 +++++++++--------------------
>  net/bluetooth/rfcomm/core.c |   14 ++++--------
>  net/bluetooth/rfcomm/tty.c  |   20 ++++++------------
>  9 files changed, 51 insertions(+), 120 deletions(-)

Applied, thanks.

	Gustavo
