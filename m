Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <3013cac80512161037q19c19ecamafe77a379fec2ed0@mail.gmail.com>
References: <1132872886.3170.3.camel@blade>
	 <3013cac80512010855v46eeb99dk3a53094238800621@mail.gmail.com>
	 <1133471112.18554.8.camel@blade>
	 <3013cac80512070429g5fb992b7i7131d570f9023086@mail.gmail.com>
	 <20051207125556.GA13152@localhost.localdomain>
	 <1133960579.3752.17.camel@blade>
	 <3013cac80512070801o5b60cc20y7098dc36f2326458@mail.gmail.com>
	 <3013cac80512130927k1d83978ey33be0540e15a08ba@mail.gmail.com>
	 <1134511385.24447.15.camel@blade>
	 <3013cac80512141102k2dbe40c9q7b25deebb9e4fae9@mail.gmail.com>
	 <3013cac80512161037q19c19ecamafe77a379fec2ed0@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1134758431.4239.62.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 16 Dec 2005 19:40:31 +0100

Hi Eduardo,

> here is the patch for set auth enable. This patch should be applied
> after the last scan patch. Let me know if there is any problem.

we don't need to set auth or encrypt at all, because the support for
setting a device into Security Mode 3 from within the D-Bus interface is
useless.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
