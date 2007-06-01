Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <466032F7.1080607@idlum.be>
Date: Fri, 01 Jun 2007 16:53:43 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <20060222091231.GM19185@null.research.nokia.com>	<1140607245.4519.7.camel@localhost>	<20060222125425.GQ19185@null.research.nokia.com>	<20060224110357.GT19185@null.research.nokia.com>	<1141188501.29216.1.camel@localhost>	<1180265456.3030.9.camel@cookie.hadess.net>	<1180268229.21432.63.camel@aeonflux.holtmann.net>	<1180277003.3030.18.camel@cookie.hadess.net>	<1180283308.21432.67.camel@aeonflux.holtmann.net>	<1180304170.3030.23.camel@cookie.hadess.net>
	<1180341563.21432.97.camel@aeonflux.holtmann.net>
In-Reply-To: <1180341563.21432.97.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] Soft lockup
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello Marcel and everyone,

> That might be a little bit too much debug overhead. However all services
> can be started with -s and then they work standalone. So you can use gdb
> and valgrind with them.

Could you or anybody knowing about it please explain more about the 
funtion and usage of this "-s" parameter, which I can't find in the man 
pages? I experience various crashes of hcid on some systems, and would 
like to track the problem down as much as possible, and it seems this 
option may help me.

Thanks in advance,
Best Regards.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
