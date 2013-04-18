Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Apr 2013 00:16:08 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v6 1/6] Bluetooth: Move and rename hci_conn_accept
Message-ID: <20130418031608.GA22245@joana>
References: <1366126143-28545-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1366126143-28545-2-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1366126143-28545-2-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

* Frédéric Dalleau <frederic.dalleau@linux.intel.com> [2013-04-16 17:28:58 +0200]:

> Since this function is only used by sco, move it from hci_event.c to
> sco.c and rename to sco_conn_defer_accept. Make it static.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 -
>  net/bluetooth/hci_event.c        |   36 ------------------------------------
>  net/bluetooth/sco.c              |   38 +++++++++++++++++++++++++++++++++++++-
>  3 files changed, 37 insertions(+), 38 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
