Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can't compile utils2
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?S=E9rgio?= Fernandes <sergiofernandes@clix.pt>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404112025.35020.sergiofernandes@clix.pt>
References: <200404112025.35020.sergiofernandes@clix.pt>
Content-Type: text/plain
Message-Id: <1081777198.5398.119.camel@pegasus>
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
Date: Mon, 12 Apr 2004 15:39:59 +0200

Hi Sergio,

> I followed the directions in http://www.bueche.ch/comp/mx900/mx900.html but i 
> get this error, after the ./configure. I created a new user account fetched 
> all from cvs but ..... I think i'll give up for now ....

I am going to repeat myself. The problem is that your make process tries
to link against the old -lbluetooth in /usr/lib. I don't know why, but I
also don't know anything about your system. Maybe this is a bug in the
current build system. If yes, try to fix it and send me a patch.

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
