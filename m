Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] simple rfcomm connect!?
From: Marcel Holtmann <marcel@holtmann.org>
To: R.Schade@tu-braunschweig.de
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <517CF7F08A05D4118C380000E869BFA4BDEDD5@emg_ntserv2>
References: <517CF7F08A05D4118C380000E869BFA4BDEDD5@emg_ntserv2>
Content-Type: text/plain
Message-Id: <1098449599.4704.54.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 22 Oct 2004 14:53:18 +0200

Hi Ralf,

> > Show them to us and also show us the full source code. The ownsock
> > variable can't be an integer, but you treat it like an integer in the
> > printf statement. So either the type is wrong or you get a bunch of
> > compiler warnings that you are ignoring.
> The ownsock-variable is the return-code from socket() and this is an
> integer?! Compiling with -Wall don't show me any warnings. Do you confuse
> ownsock with the ownaddr, a variable from type struct sockaddr_rc?

oh yes, I messed that up. Sorry for that confusion, but why don't you
use standard variable names like sk, addr, sa etc. ;)

> In a former message you suggest a look on rctest-code. I look at the code
> for learning.

And look at "hciconfig -a" to check if you are in security mode 3 or
not.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
