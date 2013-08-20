Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Aug 2013 11:41:14 +0200
From: Gustavo Padovan <gustavo@padovan.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@intel.com>
Subject: Re: [PATCH v11 10/10] Bluetooth: Add SCO connection fallback
Message-ID: <20130820094114.GC1908@joana>
References: <1376915043-24531-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1376915043-24531-11-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1376915043-24531-11-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2013-08-19 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:

> When initiating a transparent eSCO connection, make use of T2 settings
> at first try. T2 is the recommended settings from HFP 1.6 WideBand
> Speech. Upon connection failure, try T1 settings.
> 
> When CVSD is requested and eSCO is supported, try to establish eSCO
> connection using S3 settings. If it fails, fallback in sequence to S2,
> S1, D1, D0 settings.
> 
> To know which setting should be used, conn->attempt is used. It
> indicates the currently ongoing SCO connection attempt and can be used
> as the index for the fallback settings table.
> 
> These setting and the fallback order are described in Bluetooth HFP 1.6
> specification p. 101.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_conn.c         |   44 +++++++++++++++++++++++++++++++-------
>  net/bluetooth/hci_event.c        |    6 +++---
>  3 files changed, 40 insertions(+), 12 deletions(-)

All 10 patches have been applied to bluetooth-next. Thanks.

	Gustavo
