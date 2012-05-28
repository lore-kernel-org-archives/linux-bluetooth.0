Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 May 2012 09:49:08 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH -v2 02/12] Bluetooth: Move clean up code and set of
 SOCK_ZAPPED to l2cap_sock.c
Message-ID: <20120528064906.GA31961@aemeltch-MOBL1>
References: <1337949064-26187-1-git-send-email-gustavo@padovan.org>
 <1337949064-26187-3-git-send-email-gustavo@padovan.org>
 <1338094828.15105.98.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338094828.15105.98.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel and Gustavo,

On Sun, May 27, 2012 at 07:00:28AM +0200, Marcel Holtmann wrote:
> Hi Gustavo,
> 
> > From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > 
> > This remove a bit more of socket code from l2cap core, this calls set the
> > SOCK_ZAPPED and do some clean up depending on the socket state.
> > 
> > Reported-by: Mat Martineau <mathewm@codeaurora.org>
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> the signed-off-by line indicates that this patch originally was written
> by Andrei. So I prefer he gets the authorship then. The From: line at
> the top should say his name.

This patch was so heavily reworked by Gustavo that he could remove my
Signed-off-by line.

Best regards 
Andrei Emeltchenko 
