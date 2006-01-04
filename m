Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Antti =?utf-8?b?TcOka2Vsw6Q=?= <zarhan@cs.tut.fi>
Message-ID: <loom.20060104T140703-897@post.gmane.org>
References: <loom.20051107T122754-207@post.gmane.org>  <1131371019.5824.123.camel@blade> <loom.20060104T122021-876@post.gmane.org>  <1136374995.13931.21.camel@localhost> <1136375857.13931.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: =?utf-8?b?QlQzQ19DUw==?= broken in kernel 2.6.14? [Also =?utf-8?b?d2l0aAkyLjYuMTVd?=
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 4 Jan 2006 13:09:14 +0000 (UTC)

Marcel Holtmann <marcel <at> holtmann.org> writes:
> and maybe the attached patch helps. I haven't tested it, but it compiles
> fine with my latest kernel.

  The patch worked. No more kernel oopses and hciconfig now reports that the 
card is working perfectly. I can also activate Dial-up connection with my 
mobile phone - so I would consider the patch ok :)

  Thanks!



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
