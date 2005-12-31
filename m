Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <9307f5f20512310649u5f3ee7eeo8285550d506cc0f1@mail.gmail.com>
From: "P. Durante" <shackan@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Sample C++ Code
In-Reply-To: <20051231085734.52443.qmail@web33114.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051231085734.52443.qmail@web33114.mail.mud.yahoo.com>
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
Date: Sat, 31 Dec 2005 15:49:16 +0100

> Can someone send me or direct me to a sample C++ code that uses BLUEZ?

http://svn.berlios.de/viewcvs/bluetool/trunk/lib/bluetool/

a C++ wrapper for bluez, I used it together with my C++ bindings for
DBus (and my glib replacement) when writing my own dbus daemon, the
code is largely UNMANTAINED and OUTDATED since I'm rewriting a new
version from scratch, I don't even know if this old one still compiles
even, so feel free to take a look but be warned it's still alpha
stuff.

regards,
Paul


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
