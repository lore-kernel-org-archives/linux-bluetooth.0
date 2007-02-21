Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Wed, 21 Feb 2007 10:33:15 +1000
References: <45DB19E9.5080709@access-company.com>
In-Reply-To: <45DB19E9.5080709@access-company.com>
MIME-Version: 1.0
Message-Id: <200702211033.15862.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] Service API
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel,

I noticed in 3.9 the service API start/stop relies on the hcid to exec 
application that provides the service.  For external services, the start/stop 
functionality is essentially gone.  

This makes it hard to support such daemons as pand, dund, or anything that 
takes command line options, etc.  It also makes it difficult to support inetd 
style daemons which handle multiple services at once (this is a fairly 
typical use-case in the embedded world) 

Would it be useful to have such use-cases available?  For instance, KDE has 
its own inetd style framework for services.  So if starting/stopping service 
behavior is not uniform, it might lead to fragmentation.

Another point I'd like to bring up is the setting of encryption / 
authentication options.  This seems like it should be part of the service 
framework API instead of being a command line option to each individual 
daemon. 

What are your thoughts?

-Denis

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
