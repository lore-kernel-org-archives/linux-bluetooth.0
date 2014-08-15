Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Aug 2014 20:11:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix hci_conn reference counting for
 auto-connections
Message-ID: <20140815171130.GA23001@t440s.P-661HNU-F1>
References: <1408109598-11901-1-git-send-email-johan.hedberg@gmail.com>
 <634D0508-594B-4345-8CC1-A6169034C027@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <634D0508-594B-4345-8CC1-A6169034C027@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Aug 15, 2014, Marcel Holtmann wrote:
> > 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
> > -	if (params)
> > +	if (params) {
> > 		list_del_init(&params->action);
> > +		if (params && params->conn) {
> 
> don't we already know that params is valid here?

Indeed we do. Silly copy-paste mistake from another piece of code where
we didn't already know params was != NULL. I'll send a v2.

Johan
