Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Sep 2008 17:50:55 +0100
From: "wolf@hivenetworks.net" <wolf@hivenetworks.net>
To: bluez-users@lists.sourceforge.net
Message-ID: <20080910175055.2d1586e1@mordor>
Mime-Version: 1.0
Subject: [Bluez-users] multiple OBEX PUSH connections
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

hello.

this question might reveal my ignorance of the underlying
protocol but i was wondering if (and how) i can establish 
to obexpush connections to different target devices through 
one bluetooth device.

when i have one device hci0 and try to push a file
(e.g. using ussp-push) to different devices simultanously

# ussp-push /dev/rfcomm1 foobar.jpg thanks.jpg 
# ussp-push /dev/rfcomm1 foobar.jpg thanks.jpg 

i will get:

Can' t open tty: Too many links
Error while doing OBEX_HandleInput()
__obex_connect: error=-1
Unable to connect to the server
Error

i just give ussp-push as an example here, seems to be a problem
with other tools as well.

im asking this here because i actaully wonder what is causing this 
problem hier? is it the way bluetooth works itself? or is
it a limitation i could work around on the software side?

thanks,
wolf.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
