Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Getting in touch with libs2 and utils2
From: Marcel Holtmann <marcel@holtmann.org>
To: Charles Bueche <charles@bueche.ch>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1071695000.6361.13.camel@bluez.bueche.ch>
References: <1071436139.4356.124.camel@pegasus>
	 <1071695000.6361.13.camel@bluez.bueche.ch>
Content-Type: text/plain
Message-Id: <1071698576.21803.65.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 17 Dec 2003 23:02:57 +0100

Hi Charles,

> success !!! Works much better than the hacked bthid under gentoo
> 2.6test11.
> 
> I followed your guide below (preceded by a cvs checkout of course). I
> then ran 
> 
> - hcid (from the gentoo bluez packages)
> - /opt/bluetooth/sbin/bthid --daemon
> - moving mouse --> discover message in syslog : WORKS. YOUPI !!!

this is good to hear.

> I don't have any other Bluetooth hardware (beside my Ericsson T68 which
> isn't a HID device AFAIK), so I can't make much more tests.

I have and even 7 HID devices in one piconet are working fine.

> Apparently, gentoo creates the uinput device in /dev/misc instead of the
> usual /dev/input. Thanks to Marcel for testing both in parser.c !

It is the normal way of doing this ;)

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
