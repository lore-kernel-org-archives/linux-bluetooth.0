Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] simple rfcomm connect!?
From: Marcel Holtmann <marcel@holtmann.org>
To: R.Schade@tu-braunschweig.de
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <517CF7F08A05D4118C380000E869BFA4BDEDD1@emg_ntserv2>
References: <517CF7F08A05D4118C380000E869BFA4BDEDD1@emg_ntserv2>
Content-Type: text/plain
Message-Id: <1098442298.4704.30.camel@pegasus>
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
Date: Fri, 22 Oct 2004 12:51:38 +0200

Hi Ralf,

> I have two identical BT-Dongles and I want to make my first steps on
> programming with bluez. For the first quick and dirty I tried to connect
> these two dongles on different PCs over a RFCOMM channel. The server comes
> up and is waiting, but the client breaks the connect with "Connection
> refused". What can I do? How can I debug or find out more information about
> whats going wrong? Can I switch to verbose output for the bluez-daemons?

run "hcidump -X" as root to see the details.

> Both PCs are on Debian Sarge 2.4.27 with whole bluez-stuff compiled in the
> kernel and the additional bluez-packages. The "hcid.conf" and "pin" are
> identical on both PCs, for testing the security is none. "l2ping" and the
> other basic tests are working. "hciconfig -a" and "hcitool scan" looks good,
> but sdptool browse xxxx shows only "L2CAP" on protocol-lists, no RFCOMM
> (look at the end of email). All internet examples have the rfcomm on the
> protocol list ??!

Show them to us and also show us the full source code. The ownsock
variable can't be an integer, but you treat it like an integer in the
printf statement. So either the type is wrong or you get a bunch of
compiler warnings that you are ignoring.

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
