Return-Path: <marosg@yahoo.com>
Message-ID: <20040426132331.16051.qmail@web20415.mail.yahoo.com>
Date: Mon, 26 Apr 2004 06:23:31 -0700 (PDT)
From: Marian Gasparovic <marosg@yahoo.com>
Subject: Re: [Bluez-users] bluetooth/gprs problem
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1082985281.28880.151.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

Now a question I hate to ask : How can it work under
XP ? It works there without a problem.
Marian

--- Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Marian,
> 
> > now it is very strange waht I see. First I tried
> some
> > experiments with uhci, uhci(je) and ohci, nothing
> > helped. Then I tried hcidump -w and I was able to
> surf
> > half an hour without a problem !!! Then I
> restarted a
> > computer, surfing worked, but I was aborted after
> > several minutes. Now I have hcidump output I hope
> you
> > will find something there. And another thing -
> when I
> > restart my notebook, I have to restart bluez-utils
> and
> > bluez-sdp before I can connect, otherwise pppd
> doesn't
> > connect with /dev/rfcomm0:connection refused. I
> even
> > attach my ppp chatscript and peer config files.
> 
> after getting the full dump the important part is
> this
> 
> 	> ACL data: handle 0x0006 flags 0x01 dlen 10
> 	    L2CAP(d): cid 0x40 len 329 [psm 3]
> 	      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 323 fcs
> 0x5c 
> 	> HCI Event: Disconn Complete(0x05) plen 4
> 	  00 06 00 22 
> 
> It is not a PPP error, because the remote device
> (your phone)
> disconnects the ACL link with "LMP Response Timeout"
> error. Actually
> this is because the Broadcom dongle has a buggy link
> manager or your
> phone needs a firmware update. However this is a
> firmware problem in one
> of your two device and we can actually do nothing to
> fix it.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> This SF.net email is sponsored by: The Robotic
> Monkeys at ThinkGeek
> For a limited time only, get FREE Ground shipping on
> all orders of $35
> or more. Hurry up and shop folks, this offer expires
> April 30th!
> http://www.thinkgeek.com/freeshipping/?cpg=12297
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users



	
		
__________________________________
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢
http://photos.yahoo.com/ph/print_splash
