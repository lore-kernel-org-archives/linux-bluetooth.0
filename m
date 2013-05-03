Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 May 2013 19:25:16 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 14/14] Bluetooth: Mgmt Device Found Event
Message-ID: <20130503222516.GB2311@joana>
References: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
 <1367346580-6647-15-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367346580-6647-15-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2013-04-30 15:29:40 -0300]:

> We only want to send Mgmt Device Found Events if we are running the
> Device Discovery procedure (started by the MGMT Start Discovery
> Command). Inquiry or LE scanning triggered by HCI raw interface (e.g.
> hcitool) or kernel internals should not send Mgmt Device Found Events.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> Acked-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c | 3 +++
>  1 file changed, 3 insertions(+)

All patches have been applied to bluetooth-next. Thanks.

	Gustavo
