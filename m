Return-Path: <jamesp@hisser.org>
Date: Tue, 9 Mar 2004 21:02:52 +0000 (GMT)
From: James Pattinson <jamesp@hisser.org>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Obex / Palm TT
In-Reply-To: <1047488348.28415.117.camel@pegasus.local>
Message-ID: <Pine.LNX.4.58.0403092101240.24697@greebo>
References: <Pine.LNX.4.44.0303121553230.9558-100000@greebo.hisser.org>
 <1047488348.28415.117.camel@pegasus.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel

Do you have any more info about this application? I have just revisted bluetooth 
now I have a bt enabled handheld again. (This time it's Tungsten T3).

Everything works great - would just like a way of using obex push.

I tried opexftp over rfcomm, the connection got established however the file 
didn't transfer:

greebo root # obexftp -d /dev/bluetooth/rfcomm/0 -p /tmp/trace.out 
Custom transport set to 'Siemens'
Connecting...failed: connect
Still trying to connect

Thanks!

James

On Wed, 12 Mar 2003, Marcel Holtmann wrote:

> Hi James,
> 
> > 2. OBEX - I'm going to try this tonight, but don't believe it's going to 
> > work, as the only suitable application seems to be obexftp which doesn't 
> > yet support Bluetooth. Anyone got obex working over BT to a palm?
> 
> I have a program called btftp which implements the File Transfer
> Profile, but it is not complete ready at the moment. The other one
> called btobex is an implementation of the OBEX Push Profile and will
> allow you to push/pull vcards etc. and download your phonebook and
> calendar from an IrMC compatible phone. I asked Max to put it into CVS.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by:Crypto Challenge is now open! 
> Get cracking and register here for some mind boggling fun and 
> the chance of winning an Apple iPod:
> http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
