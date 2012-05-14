Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 May 2012 17:02:20 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: padovan@profusion.mobi, linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: Fix input device registration
Message-ID: <20120514200220.GB23475@joana>
References: <20120514132955.GA13369@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120514132955.GA13369@elgon.mountain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

* Dan Carpenter <dan.carpenter@oracle.com> [2012-05-14 16:30:03 +0300]:

> Hi, I am working on some new stuff for Smatch and sending bug reports
> on potential bugs I find as I go.
> 
> ----
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 3415a5fdde71: "Bluetooth: Fix input device registration" 
> from Oct 6, 2011, leads to the following Smatch complaint:
> 
> net/bluetooth/hidp/core.c:1072 hidp_add_connection()
> 	 error: we previously assumed 'session->input' could be null (see line 1049)
> 
> net/bluetooth/hidp/core.c
>   1046          if (session->hid) {
>   1047                  vendor  = session->hid->vendor;
>   1048			product = session->hid->product;
>   1049		} else if (session->input) {
>   1050			vendor  = session->input->id.vendor;
>   1051			product = session->input->id.product;
>   1052		} else {
>                 ^^^^^^^^
> If we hit this else clause then "session->input" and "session->hid" are
> both NULL.

Actually both can never be NULL at the same time here. If after call
hdip_setup_input() session->input is still NULL, the we goto purge and skip
the code below.

	Gustavo
