Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] apple wireless mouse on apple ibook (g4, builtin
	usb)
From: Marcel Holtmann <marcel@holtmann.org>
To: Sunnan <sunnan@handgranat.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <402D381D.1000306@handgranat.org>
References: <402D07B8.8030504@handgranat.org>
	 <1076694675.2671.191.camel@pegasus>  <402D1E8C.6020301@handgranat.org>
	 <1076702197.18588.11.camel@pegasus>  <402D381D.1000306@handgranat.org>
Content-Type: text/plain
Message-Id: <1076709007.18588.39.camel@pegasus>
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
Date: Fri, 13 Feb 2004 22:50:07 +0100

Hi Sunnan,

> 2.4-6 from Debian sid, as well as utils2 from bluez cvs. hciconfig comes 
> from that cvs checkout (though I have two version in my path, the cvs 
> version takes precedence, while hcidump comes out of Edds bluez-hcidump 
> package, version 1.5-2 for debian sid.

the version of utils2 have a big endian problem, which I have now fixed
in CVS. Try your version from bluez-utils-2.4. Better you call it with
the full path "/sbin/hciconfig -a".

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
