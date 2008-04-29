Return-Path: <cyrus@holtmann.org>
Message-ID: <e378cfb20804290739j3c21e692ja6a692c086d1a3e9@mail.gmail.com>
Date: Tue, 29 Apr 2008 20:09:02 +0530
From: "Nel D" <newatlinux@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Non bluetooth base UUID
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

Hi,
   Am trying to write a SyncML client over obex  (server / client).
However i found that SyncML based profiles use a UUID that is not
based on the bluetooth base UUID.

e.g. Obex SyncMl client has the 128 bit UUID of the form
0000002-0000-1000-8000-0002ee000002.


Am sorry if am asking a trivial question, but how do i convert this
128 bit UUID in hex form ? which is required to be filled in SDP
records.


regards,
  nel

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
