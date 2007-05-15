Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4649CC21.2070701@idlum.be>
Date: Tue, 15 May 2007 17:05:05 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Error.InProgress forever after DBus timeout on
	GetRemoteServiceHandles
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

I perform a call on GetRemoteServiceHandles. For some reason it fails 
with a DBus timeout. After it has happened, each subsequent call to 
GetRemoteServiceHandles about this device result in a Error.InProgress.

More precisely, my code tried it 36 times over about 7 minutes, and it 
failed that way each time.

What should I do in such a case? It should somehow effectively timeout, 
or there should be a way to cancel it. I didn't find any in the 
dbus-api.txt file.

Thanks in advance,
Best Regards


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
