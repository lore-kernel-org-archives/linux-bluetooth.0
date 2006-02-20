Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Implementing the PIN helper support
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <06CCEA2EB1B80A4A937ED59005FA85519B5AA0@svits26.main.ad.rit.edu>
References: <06CCEA2EB1B80A4A937ED59005FA85519B5AA0@svits26.main.ad.rit.edu>
Content-Type: text/plain
Message-Id: <1140468728.7047.54.camel@localhost>
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
Date: Mon, 20 Feb 2006 21:52:08 +0100

Hi Christopher,

> Preferably not in python :)
> 
> Maybe I'm the oddball here but I'm implementing all of this stuff on a
> tiny little linux with only a 64MB root partition.  There is no python,
> perl, php, or anything of that sort ... A shell, and glibc.
> 
> Not sure if that answers your question (or helps in any other way).  If
> not, sorry.

any of the PIN helper will communicate over D-Bus, so you can write them
in C, C++, C#, Python, Java or whatever binding for D-Bus exists.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
