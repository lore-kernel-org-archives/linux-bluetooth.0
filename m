Return-Path: <djimenez@pobox.com>
Message-ID: <40743083.6000409@pobox.com>
Date: Wed, 07 Apr 2004 11:46:59 -0500
From: Daniel Jimenez <djimenez@pobox.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT950_CS
References: <407195F7.4020907@pobox.com>	 <200404052141.38457.cijoml@volny.cz>  <40720DAF.5040606@pobox.com> <1081348613.8755.5.camel@pegasus>
In-Reply-To: <1081348613.8755.5.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi Daniel,
> I stopped working on the bt950_cs, because it should be driven by the
> serial_cs driver and after that you can use hci_uart for it.
> 
> However at the moment I only maintain drivers that are inside the kernel
> and compiling a driver written for 2.4 with a 2.6 kernel almost fails.
> 
> Regards
> 
> Marcel

Also, I looked I can't find serial_cs in 2.6.5. What is it called?

Thanks,
-- 
Daniel Jimenez <djimenez[at]pobox[dot]com>
