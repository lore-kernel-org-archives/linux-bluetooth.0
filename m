Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46988514.9000601@roosoft.ltd.uk>
Date: Sat, 14 Jul 2007 09:11:00 +0100
From: Don Alexander <bluez-dev@roosoft.ltd.uk>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Configuration for a Linux Bluetooth print Server
Reply-To: Don Alexander <bluez-dev@roosoft.ltd.uk>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi All,

I know it is perhaps breaking etiquette as this really ought to be a
user issue. But I have to say I cannot find anywhere in the code or in
the documentation how to achieve  the above task. Simply put, should
we not be able to set up the stack to emulate a Bluetooth enable
printer and be able to pass print data onto the normal printer
functions of CUPS etc. ? Now before anyone starts misunderstanding me
I am NOT talking about printing TO bluetooth printers (using the CUPS
driver) but printing TO a Linux box that identifies itself as being a
compatible bluetooth printer. Obviously the advantages of this are
enormous by converting any CUPS attached printer into being a
bluetooth enabled one.

So my question are :

1) Is this feasible to implement a printer class into the Bluez stack
or it is a userspace problem?

2) If it is the right thing to do via the stack how would it best be
implemented?

3) What extensions/ API's ought we attach to a generic printer class
so that data can be exported to the normal print subsystem.


I realise I am very new to the whole bluez codebase and so fully admit
I don't know all the specifications and capabilities of it, but
hopefully someone here can stop me from making a complete gaff if this
is already implemented and I am just too clueless to see it.

Anyway, thanks for your feedback any pointers will be greatly appreciated.

Cheers.

-- 
==

D Alexander

Technical Support

RooSoft Ltd


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
