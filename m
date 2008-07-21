Return-Path: <cyrus@holtmann.org>
Message-ID: <4884EE89.5010100@jlab.org>
Date: Mon, 21 Jul 2008 16:16:09 -0400
From: Chris Carlin <carlin@jlab.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Link authentication failed
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Has anyone found a solution for the "Link authentication failed: 
Connection timed out (110)" problem?

This is the problem where a device, usually a keyboard, will bond and 
pair fine, but when it goes to connect nothing happens and the logs 
contain only the following lines:

Jul 21 15:40:55 [hcid] Link authentication failed: Connection timed out 
(110)
Jul 21 15:40:55 [hcid] link_key_request (sba=00:16:B6:EE:45:5F, 
dba=00:07:61:5E:00:AE)

I've seen people mention this problem on various distributions, using 
various keyboards, various dongles, and versions of bluez. I've 
personally seen it on recent versions of bluez (currently 3.32) on 
Ubuntu and Gentoo.

For me it happens when I do something like upgrade bluez versions or 
change bluetooth dongles. Could there be some cache that needs to be 
cleared somewhere? I've tried clearing /var/lib/bluetooth but that 
doesn't help either.

If anyone has ideas I'd love to hear them. I've been seeing this problem 
for about a year and would love to get back to using my keyboards.

~Chris

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
