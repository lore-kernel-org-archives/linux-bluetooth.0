Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-user@schaettgen.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] simple rfcomm connect!?
Cc: R.Schade@tu-braunschweig.de
References: <517CF7F08A05D4118C380000E869BFA4BDEDD1@emg_ntserv2>
In-Reply-To: <517CF7F08A05D4118C380000E869BFA4BDEDD1@emg_ntserv2>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200410220921.21766.bluez-user@schaettgen.de>
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
Date: Fri, 22 Oct 2004 09:21:21 +0200

On Friday 22 October 2004 08:36, R.Schade@tu-braunschweig.de wrote:
> Hi,
>
> I have two identical BT-Dongles and I want to make my first steps on
> programming with bluez. For the first quick and dirty I tried to connect
> these two dongles on different PCs over a RFCOMM channel. The server comes
> up and is waiting, but the client breaks the connect with "Connection
> refused". What can I do? How can I debug or find out more information about
> whats going wrong? Can I switch to verbose output for the bluez-daemons?

Did you initialize ownaddr correctly? Try hcidump.

> Both PCs are on Debian Sarge 2.4.27 with whole bluez-stuff compiled in the
> kernel and the additional bluez-packages. The "hcid.conf" and "pin" are
> identical on both PCs, for testing the security is none. "l2ping" and the
> other basic tests are working. "hciconfig -a" and "hcitool scan" looks
> good, but sdptool browse xxxx shows only "L2CAP" on protocol-lists, no
> RFCOMM (look at the end of email). All internet examples have the rfcomm on
> the protocol list ??!

Listening on a rfcomm socket won't create a SDP-record automatically. You have 
to create one yourself and register it with the sdp server. For testing you 
can use "sdptool add". But as long as you don't search for a specific service 
on the client side and connect to a hardcoded rfcomm channel, that won't make 
a difference anyway.
Your output of sdptool shows only the record for the public browse group and 
the sdp server itself. The latter is not using rfcomm, so rfcomm is not among 
the protocol descriptors for this service, neither on your system nor 
anywhere else. Try scrolling upwards a little in all those "internet 
examples" ;)

regards
Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
