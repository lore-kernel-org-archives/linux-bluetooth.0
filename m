Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hcidump-1.6, Intellimouse, and HID Parser
From: Marcel Holtmann <marcel@holtmann.org>
To: mark <gress2k1@copper.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1078172702.2065.25.camel@localhost>
References: <1078063562.2814.4.camel@localhost>
	 <1078152704.1942.123.camel@pegasus>  <1078172702.2065.25.camel@localhost>
Content-Type: text/plain
Message-Id: <1078215951.1942.177.camel@pegasus>
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
Date: Tue, 02 Mar 2004 09:25:51 +0100

Hi Mark,

> Following that link, I read through it real quick, and that seems like
> it's going to be what I need(straight forward and not necessarily
> complex).  Thanks much.  But I don't have the uinput.o file that is
> needed.  I followed the instructions here
> http://www.bueche.ch/comp/mx900/bthid-msmouse_howto.txt which explain
> specifically for the M$ mouse, and one line specifically I followed was
> this
> 
> if you miss the device file, create it with
> 	# mknod /dev/misc/uinput c 10 223
> 
> Which gave me the uinput device I was missing.  From there, I started
> over, re-installed bluez, but I seem to be missing something.  Your
> kernel patch worked fine on 2.4.22.(or seemed to)  when I get home
> tomorrow, I'll give it a try again.  thanks for your reply.

the uinput driver is part of my kernel patches, but you have to select
and compile it. You can found the option under input subsystem.

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
