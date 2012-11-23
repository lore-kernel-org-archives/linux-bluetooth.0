Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 Nov 2012 16:55:02 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Bluetooth: Implement deferred sco socket setup
Message-ID: <20121123185502.GA22663@joana>
References: <1353491473-3789-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1353491473-3789-3-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1353491473-3789-3-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

* Frédéric Dalleau <frederic.dalleau@linux.intel.com> [2012-11-21 10:51:12 +0100]:

> In order to authenticate and configure an incoming SCO connection, the
> BT_DEFER_SETUP option was added. This option is intended to defer reply
> to Connect Request on SCO sockets.
> When a connection is requested, the listening socket is unblocked but
> the effective connection setup happens only on first recv. Any send
> between accept and recv fails with -ENOTCONN.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    9 ++++---
>  net/bluetooth/hci_event.c        |   52 +++++++++++++++++++++++++++++++++++---
>  net/bluetooth/sco.c              |   35 ++++++++++++++++++++++---
>  3 files changed, 86 insertions(+), 10 deletions(-)

The 2 patches have been applied to bluetooth-next. Thanks.

	Gustavo
