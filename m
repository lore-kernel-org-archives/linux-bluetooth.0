Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Obex / Palm TT
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: James Pattinson <jamesp@hisser.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0403092101240.24697@greebo>
References: <Pine.LNX.4.44.0303121553230.9558-100000@greebo.hisser.org>
	 <1047488348.28415.117.camel@pegasus.local>
	 <Pine.LNX.4.58.0403092101240.24697@greebo>
Content-Type: text/plain
Message-Id: <1078867356.10671.70.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 09 Mar 2004 22:22:36 +0100

Hi James,

> Do you have any more info about this application? I have just revisted bluetooth 
> now I have a bt enabled handheld again. (This time it's Tungsten T3).
> 
> Everything works great - would just like a way of using obex push.
> 
> I tried opexftp over rfcomm, the connection got established however the file 
> didn't transfer:
> 
> greebo root # obexftp -d /dev/bluetooth/rfcomm/0 -p /tmp/trace.out 
> Custom transport set to 'Siemens'
> Connecting...failed: connect
> Still trying to connect

why to you think you can use a Siemens custom transport to connect to a
Palm Tungsten? Actually using the RFCOMM TTY emulation should not be
necessary. Try to make a direct connection over the RFCOMM socket. I
think obexftp supports it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
