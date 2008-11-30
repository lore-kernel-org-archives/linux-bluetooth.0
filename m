Return-Path: <cyrus@holtmann.org>
Message-ID: <6633.83.160.35.87.1228059524.squirrel@webmail.xs4all.nl>
Date: Sun, 30 Nov 2008 16:38:44 +0100 (CET)
From: "menno van der klein" <jongerenchaos@zonnet.nl>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Bluez delayed audio with asterisk pbx chan_mobile
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
Errors-To: bluez-users-bounces@lists.sourceforge.net

I use chan_mobile for incomming and outbound calls. This works well but i
think there is a problem with the audio buffer. Some examples:

Inbound call (from cellphone):
Audio from cellphone to asterisk is delayed (with 1 second and after a
while this will be bigger and bigger)
Audio from asterisk to the cellphone is NOT delayed

Outbound call (to the cellphone) with nocallsetup=no
Audio from cellphone to asterisk is delayed (with 1 second and after a
while this will be bigger and bigger)
Audio from asterisk to the cellphone is NOT delayed

Outbound call (to the cellphone) with nocallsetup=yes
Audio from cellphone to asterisk is NOT delayed
Audio from asterisk to the cellphone is NOT delayed
But after a while (2 minutes) the audio delayed too. And the delay is
bigger and bigger if you make a long call.

I use:
- Asterisk SVN-trunk-r159475
- CSR BC4
- 2.6.27-7 ubuntu kernel
- bluez 4.19 (tar.gz version)
- L6 motorola phones


I think there is a problem with the buffer. I make the Frame size smaller
but this doesn't work. I think he can't loose the buffer and the frame
size is bigger and bigger or something.

More info:
http://bugs.digium.com/view.php?id=13995

I use this chan_mobile.c file:
http://svn.digium.com/view/asterisk-addons/trunk/channels/chan_mobile.c


Is there a solution to resolve this?


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
