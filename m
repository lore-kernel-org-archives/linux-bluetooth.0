Return-Path: <sjoerd@spring.luon.net>
Date: Sat, 2 Oct 2004 11:13:43 +0200
From: Sjoerd Simons <sjoerd@spring.luon.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Sending files from phone to ppc machine fails
Message-ID: <20041002091343.GA16988@spring.luon.net>
References: <20040930161652.GA10170@spring.luon.net> <1096563173.4371.5.camel@notepaq> <20040930170602.GA13427@spring.luon.net> <1096641358.4265.8.camel@notepaq> <20041001181143.GB4230@spring.luon.net> <1096701500.4809.2.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1096701500.4809.2.camel@notepaq>
List-ID: <bluez-users.lists.sourceforge.net>

On Sat, Oct 02, 2004 at 09:18:20AM +0200, Marcel Holtmann wrote:
> > I've tested the cvs hidd version on my x86, but to no avail. When starting
> > hidd --server --master sending files from the phone start failing :(.
> 
> Leave the --master option out. CSR based HID input devices will trigger
> the role switch by themself. Only the Broadcom stuff (Apple) have a
> problem there.

Ah i misunderstood. I though that it should be forced to run as master to not
roleswitch :) Need to learn somewhat more about bluetooth it seems.

Without master it works perfectly on my x86 box. On my powerbook it still
sometimes fails. I will see if i can track down the difference between a
succeeded connection and a failed one..

Thanks for all the great work on bluez ;)
  Sjoerd
-- 
"If value corrupts then absolute value corrupts absolutely."
