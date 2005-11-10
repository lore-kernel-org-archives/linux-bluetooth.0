Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Khaled" <khaled@ipbill.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] bluez and asterisk
Message-ID: <HCEOIFALKKLBLJPENPNOAEELCAAA.khaled@ipbill.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1131630932.25312.14.camel@blade>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 10 Nov 2005 14:30:33 -0000

Hi Marcel,

> make sure that "hcid" is running as root

Hcid was not running, after starting it I ran rfcomm connect again but this
time it gave a Can't connect RFCOMM socket: connection refused' error, which
means pin is wrong?
How can I disable the pin feature?

Regards

Khaled



-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net]On Behalf Of Marcel
Holtmann
Sent: 10 November 2005 13:56
To: bluez-users@lists.sourceforge.net
Cc: Richard Pettitt; Victor Alvarez
Subject: RE: [Bluez-users] bluez and asterisk


Hi Khaled,

> > Check the loaded modules. Maybe only sco.ko is missing.
>
> That's just what I was reading up on; After some trial and error, I found
> out that we need to load sco, rfcomm, and start the sdp server (sdpd)
before
> asterisk will startup without error.
>
> I have one little problem with 'passcode'; I am prompted for a passcode on
> the mobile phone (6310i) - whether the right code is entered or not, it
> attempts to connect but then fails.

make sure that "hcid" is running as root. Otherwise use "hcidump X -V"
to debug it.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email
______________________________________________________________________



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
