Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Fernando Unzu <fernando@bluexare.org>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 17 Jul 2007 13:59:17 +0200
MIME-Version: 1.0
Message-Id: <200707171359.17950.fernando@bluexare.org>
Subject: [Bluez-devel] About DBus API
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

I have some problems with my software (an application to scan and send some 
files to another devices).

Some people tell me that I must to use DBus, instead of hci commands.

DBus is more general, I think, and maybe help me..., but I don't find any DBUS 
API.

Where I can find the functions and its descriptions of DBUS??
In the bluez page I don't find that, and in other sites I haven't much more 
lucky (sourceforge, ...).

My problems are:
- Make my software compatible with two dongles (now, I only use one, and for 
the future I want to control both dongles separately).
- With another distributions of Linux I have the problem that the "manual" 
inquiry that I made, fo not works properly, and I realized that the new 
distribution scans with RSSI, and my application do not take the events 
properly.

Maybe this problems I can solve whit DBUS, is it??

Than you very much and sorry for my english
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
