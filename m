Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Support for Clock offset event
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Wolfgang Heidrich <wolfgang.heidrich@esk.fhg.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3E6E22B3.8E6E87FA@esk.fhg.de>
References: <5.1.0.14.2.20030306125429.02687aa0@mail1.qualcomm.com>
	<5.1.0.14.2.20030306125429.02687aa0@mail1.qualcomm.com>
	<5.1.0.14.2.20030307165419.01bb5668@mail1.qualcomm.com>
	<3E6E22B3.8E6E87FA@esk.fhg.de>
Content-Type: text/plain
Message-Id: <1047428151.28416.8.camel@pegasus.local>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 12 Mar 2003 01:15:45 +0100

Hi Wolfgang,

> I added support for the clock offset event to bluez-kernel. The
> attached patch is very simple and applies cleanly to bluez-kernel-2.3.
> If you like, you can commit it. Then bluez gets one more step more
> complete.
> The clock information in the corresponding
> entry of the inquiry cache is updated in case of a clock offset event.
> 
> Clock offset is important for very fast connection establishment.

thanks for the patch. Can you please explain how it should help to get a
fast connection establishment. I have been through the spec. and the
clock offset event will only be generated if you request it with the
read clock offset command. This command requires a connection handle of
an ACL link and if you got the connection handle you will already have a
established connection. So I can't see how this patch will give us any
advantages.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
