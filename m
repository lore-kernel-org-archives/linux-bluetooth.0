Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 15 Jul 2007 15:18:47 -0400
From: TJ OConnor <tjoconno@unity.ncsu.edu>
To: <bluez-devel@lists.sourceforge.net>
Message-ID: <C2BFEB57.558%tjoconno@unity.ncsu.edu>
Mime-version: 1.0
Subject: Re: [Bluez-devel] Connectionless l2ping.
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

Hello,

Is it possible to use connectionless sockets with L2CAP? I tried rewriting
l2ping to use SOCK_DGRAM and sendto / recvfrom instead of SOCK_RAW,
send,recv but with no luck.

Thanks.

Respectfully,

TJ



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
