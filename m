Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Debian packages updated
From: Marcel Holtmann <marcel@holtmann.org>
To: Edd Dumbill <edd@usefulinc.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1085586569.18009.7.camel@saag>
References: <1085586569.18009.7.camel@saag>
Content-Type: text/plain
Message-Id: <1085593355.8896.20.camel@pegasus>
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
Date: Wed, 26 May 2004 19:42:35 +0200

Hi Edd,

> I uploaded new experimental packages for BlueZ 2.7 to Debian
> experimental (expect them there in a week or so, as bluez-cups is NEW),
> and to the http://bluez.sf.net/download/debian/ repository.  This build
> has DBUS and CUPS enabled.  More details are available in the
> README.Debian file in the bluez-utils package.
> 
> Fuller details available on my blog at
> http://usefulinc.com/edd/blog/contents/2004/05/26-bluez/read
> 
> I'd welcome feedback from users of the older packages, particularly in
> how the 2.4 -> 2.7 upgrade goes, as the bluez-pan and bluez-sdp packages
> have all been subsumed into bluez-utils.

may you wanna add fixes for two of my stupid mistakes :(

http://cvs.sourceforge.net/viewcvs.py/bluez/libs/include/hci.h?r1=1.35&r2=1.36
http://cvs.sourceforge.net/viewcvs.py/bluez/utils/hidd/main.c?r1=1.3&r2=1.4

Please test these packages and give Edd feedback, so they can move very
soon to unstable.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
