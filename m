Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jan 2012 11:39:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 10/15] Bluetooth: Add a convenience function to check for
 SSP enabled
Message-ID: <20120119093956.GA19936@x220>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
 <1326912717-6347-11-git-send-email-johan.hedberg@gmail.com>
 <20120119093021.GC20598@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120119093021.GC20598@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Jan 19, 2012, Andrei Emeltchenko wrote:
> > +static inline bool hci_conn_ssp_support(struct hci_conn *conn)
> 
> Maybe matter of taste but cold this be named hci_conn_ssp_supported ?
> Then in if condition below it would be seen more natural and similar to
> other "-ed" functions.

Based on Marcel's preference for the define names it will be called
hci_conn_ssp_enabled.

Johan
