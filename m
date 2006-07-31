Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 31 Jul 2006 16:44:27 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <Pine.LNX.4.63.0607311627330.31025@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Subject: [Bluez-devel] Refcounting problem in rfcomm
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


Hi all, 

while trying to implement a server tty which can be used without a user 
space daemon I came across a reference counting problem.  Function 
rfcomm_accept_connection() 
calls __module_get(nsock->ops->owner) but there is no corresponding
module_put(). I think for user space sockets this won't be a problem. 
However, if the owner of the socket is the rfcomm module itself the 
reference count gets wrong.    

A work around for this may be to decrement the reference count just before 
releasing the socket used for listening. 

Does anybody has some better idea ?? 

Thank you and best regards,

Peter 
 

|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
