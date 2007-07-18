Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Fernando Unzu <fernando@bluexare.org>
To: bluez-devel@lists.sourceforge.net
Date: Wed, 18 Jul 2007 12:32:00 +0200
MIME-Version: 1.0
Message-Id: <200707181232.00253.fernando@bluexare.org>
Subject: [Bluez-devel] Obex handle?
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

I have a question about how to select which device I want to use with my 
program.

I have an application that sends some content t another bluetooth devices, and 
i realize the transfer with Obex functions.

But if I have two dongles in my PC, I would can to select between one and 
other.
This is what i don't know how to do.

The handle is created with Obex_Init, and I think it is in that moment when I 
select one of the dongles, but I don't know how.

Or there is another way to do it?? Or it has to be done in another moment with 
another function??

I have eard that DBus solves this problems...; anybody can help me, please?

P.D.: Although anybody gives me a DBus solution, I'm interesting in the Obex 
solution too.

Thank you,
Fernando Unzu

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
