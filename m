Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Nov 2012 15:50:05 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 4/4] Bluetooth: trivial: Change NO_FCS_RECV to
 RECV_NO_FCS
Message-ID: <20121130175005.GA3881@joana>
References: <20121129103405.GC26707@joana>
 <1354203968-1335-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1354203968-1335-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354203968-1335-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-11-29 17:46:08 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Make code more readable by changing CONF_NO_FCS_RECV which is read
> as "No L2CAP FCS option received" to CONF_RECV_NO_FCS which means
> "Received L2CAP option NO_FCS". This flag really means that we have
> received L2CAP FRAME CHECK SEQUENCE (FCS) OPTION with value "No FCS".
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    2 +-
>  net/bluetooth/l2cap_core.c    |   10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)

All patches have been applied to bluetooth-next. Thanks.

	Gustavo
