Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <517CF7F08A05D4118C380000E869BFA4BDEDD5@emg_ntserv2>
From: R.Schade@tu-braunschweig.de
To: bluez-users@lists.sourceforge.net
Subject: RE: [Bluez-users] simple rfcomm connect!?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Fri, 22 Oct 2004 14:07:45 +0200

Hi Marcus,

> From: bluez-users-admin@lists.sourceforge.net
> [mailto:bluez-users-admin@lists.sourceforge.net]On Behalf Of Marcel
> Holtmann
> 
> run "hcidump -X" as root to see the details.
Now it works here (I wrote it in an email to this list before), but I will
test my programm at home in the evening with hcidump.

> Show them to us and also show us the full source code. The ownsock
> variable can't be an integer, but you treat it like an integer in the
> printf statement. So either the type is wrong or you get a bunch of
> compiler warnings that you are ignoring.
The ownsock-variable is the return-code from socket() and this is an
integer?! Compiling with -Wall don't show me any warnings. Do you confuse
ownsock with the ownaddr, a variable from type struct sockaddr_rc?
In a former message you suggest a look on rctest-code. I look at the code
for learning.

Thank you,
Ralf


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
