Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
Date: Tue, 22 May 2007 22:53:15 +0200 (CEST)
From: =?us-ascii?Q?Zdenek=20Kunicky?= <ZdenekKunicky@seznam.cz>
Mime-Version: 1.0
Message-Id: <562.1270-19971-932509235-1179867195@seznam.cz>
Subject: [Bluez-devel] pand won't start the dev-up script when new bnepN
	interface detected
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
  I experience this bug on my Ubuntu Feisty; Even specifying the script file by --devup option won't help. (Of course, I chmod'ed the file to make it executable). Do you think the bug is Ubuntu specific or not?  The version of bluez-utils used in Ubuntu is  3.9-0ubuntu4. I would be happy to have this feature as I don't like up'ing the interface manually whenever I plug in the bluetooth adaptor. Thank you, kind regards Zdenek

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
