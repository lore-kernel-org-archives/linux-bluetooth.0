Return-Path: <cyrus@holtmann.org>
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200802051542.11330.sa@claborn.net>
References: <200801242256.33910.sa@claborn.net>
	<200802051233.33098.sa@claborn.net>
	<d89ddf300802051041j76801e4n5214d01bf01b48e3@mail.gmail.com>
	<200802051542.11330.sa@claborn.net>
Date: Wed, 06 Feb 2008 09:43:14 +0100
Message-Id: <1202287394.11812.2.camel@littletux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] How to setup a headset as an audio
	device?	Getting "Device busy" errors
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

Hello,

On mar, 2008-02-05 at 15:42 -0600, SA wrote:
> audio[3234]: /etc/bluetooth/audio.conf: /etc/bluetooth/audio.conf: No
> such 
> file or directory
> Feb  5 14:31:56 citrine syslog-ng[2307]: last message repeated 3 times
> Feb  5 14:31:56 citrine audio[3234]: Config options: DisableHFP=true, 
> SCORouting=HCI, SourceCount=1

So it should work using Hands-Free Profile,
with /etc/bluetooth/audio.conf containing at least :
DisableHFP=false

Regards,

Guillaume B.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
