Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <e96e9eeb0705100523q62fde54r9bc674da0ac822f5@mail.gmail.com>
Date: Thu, 10 May 2007 15:23:54 +0300
From: "Voni Hakau" <hakauvoni@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-users] API documentation?
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

(sorry for multiple posting i had a problem)

Hello -

>Actually, I built dbus-libs and most of dbus-utils under m68knommu without too
>much trouble; Now I did have some manual hacking to do, and there were a few
>tools which did not build, but I did get hciattach, hciconfig, hcitool and
>hcid built.  I could have sworn I had the sdp and pan utils too, but my build
>environment is a bit of a mess these days.

sounds like no-fun to me. but hey, if you can post the solution for this
you will probably help a lot of people.

>This would be my response as well.  Marcel has purposely made it difficult to
>locate older versions of BlueZ in the (IMO) misguided attempt to force
>everyone to test and use the new stuff.

I think i found it :

http://bluez.sf.net/download/bluez-utils-2.10.tar.gz
http://bluez.sf.net/download/bluez-libs-2.10.tar.gz

>d-bus, but yes; it's seems to be unsuitable for light embedded systems and
>you're probably better off with another stack.  There aren't many uses for a
>message bus in small embedded systems.

hmm going for a nother stack is no option for most of the projects
because Bluez has become a standard.
but.
maybe a fork of the bluez user space application is a good solution.
get rid of the dbus dependancies.

H.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
