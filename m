Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 23 Nov 2006 15:26:09 +1000
MIME-Version: 1.0
Message-Id: <200611231526.09459.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] DBus SDP API
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

Three questions:

Have you given any more thought as to how the RFCOMM channels are managed by 
the DBus Service API?  The same goes for L2CAP.  From what I understand the 
current implementation depends on clients to know what is available...

Will there be a lower-level SDP registration framework for the local device?  
E.g. to be able to manually register records in binary/XML format without 
creating a service agent?

Most importantly, do you have plans for local versions of
                array{uint32} GetRemoteServiceHandles(string address, string 
match)

and

                array{byte} GetRemoteServiceRecord(string address, uint32 
handle)

?

-Denis

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
