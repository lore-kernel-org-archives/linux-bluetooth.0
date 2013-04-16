Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v6 1/6] Bluetooth: Move and rename hci_conn_accept
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1366126143-28545-2-git-send-email-frederic.dalleau@linux.intel.com>
Date: Tue, 16 Apr 2013 10:41:31 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1564BCCF-482F-49D5-89DD-BB61BB0CB1F7@holtmann.org>
References: <1366126143-28545-1-git-send-email-frederic.dalleau@linux.intel.com> <1366126143-28545-2-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Since this function is only used by sco, move it from hci_event.c to
> sco.c and rename to sco_conn_defer_accept. Make it static.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> include/net/bluetooth/hci_core.h |    1 -
> net/bluetooth/hci_event.c        |   36 ------------------------------------
> net/bluetooth/sco.c              |   38 +++++++++++++++++++++++++++++++++++++-
> 3 files changed, 37 insertions(+), 38 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

