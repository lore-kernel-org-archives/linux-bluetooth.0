Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v4 1/6] Bluetooth: Move and rename hci_conn_accept
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1363716255-21332-2-git-send-email-frederic.dalleau@linux.intel.com>
Date: Tue, 26 Mar 2013 13:18:28 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3F09C6BE-52F1-47ED-8EFE-BCBEC8058B7A@holtmann.org>
References: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com> <1363716255-21332-2-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Since this function is only used by sco, move it from hci_event.c to
> sco.c and rename to sco_conn_defer_accept.

mention that you are making it static because of that.

And we need a Signed-off-by line.

> ---
> include/net/bluetooth/hci_core.h |    1 -
> net/bluetooth/hci_event.c        |   36 ------------------------------------
> net/bluetooth/sco.c              |   38 +++++++++++++++++++++++++++++++++++++-
> 3 files changed, 37 insertions(+), 38 deletions(-)

Regards

Marcel

