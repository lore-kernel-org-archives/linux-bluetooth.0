Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 1 Aug 2008 22:26:19 +0800
MIME-Version: 1.0
Message-Id: <200808012226.20253.Jerry87905@gmail.com>
From: Li Dongyang <jerry87905@gmail.com>
Subject: [Bluez-devel] [GSoC2008]bluez-python status
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

Hi, all
  This is Li Dongyang working on bluez-python
  And What's new from the last status report:
  1.a fix that can make async call with CreatePairedDevice(), user should pass 
reply_handler and error_handler
  The reply_handler will receive a Device instance as the parameter, the 
error_handler will receive an exception(our custom dbus exception, see 
errors.py) as the parameter.
  2.add the docstrings for all the methods, based on the docs in /doc/XXX-
api.txt
  3.still some doc work, like license headers, and AUTHORS, ChangeLog, README, 
COPYING file
  and a setup script to make python package
  What to be done is the plugin, My mentor and me are discussing which is the 
best way to represent it, and make it can handler new plugins in the future.
  Feel free to tell me if you have ideas about it ;-)
Cheers,
Li Dongyang

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
