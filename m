Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Printer adapter w/o SDP
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Albinus <michael.albinus@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <87wu11w1e3.fsf@gmx.de>
References: <87acxxxly1.fsf@gmx.de> <1090178500.4400.25.camel@pegasus>
	 <87wu11w1e3.fsf@gmx.de>
Content-Type: text/plain
Message-Id: <1090180872.4400.36.camel@pegasus>
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
Date: Sun, 18 Jul 2004 22:01:12 +0200

Hi Michael,

> > this is not broken SDP. They use UUID32 which is fine, but actually not
> > quite the normal way.
> >
> > What libs and utils versions are you using?
> 
> magdalene:~> uname -a
> Linux magdalene 2.6.7-mh1 #1 Sun Jul 4 11:32:11 CEST 2004 i686 GNU/Linux
> 
> magdalene:~> apt-cache policy bluez-cups bluez-utils libbluetooth1
> bluez-cups:
>   Installed: 2.8-1
> bluez-utils:
>   Installed: 2.8-1
> libbluetooth1:
>   Installed: 2.8-1

so everything is as new as possible. Seems we must fix the code to work
correct with UUID32. Where do you got this printer adapter? Looks like I
have to buy one of them or is there a sponsor out there?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
