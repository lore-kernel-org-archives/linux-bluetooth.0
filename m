Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <alpine.LNX.1.10.0808181917120.32359@nge2.ngu.pk>
References: <alpine.LNX.1.10.0808181917120.32359@nge2.ngu.pk>
Date: Tue, 19 Aug 2008 09:02:45 +0200
Message-Id: <1219129365.7591.76.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] bluez-4.1: Pairing Broken?
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

Hi,

> I changed bluez-* to the 4.x branch. Everything went pretty smooth, despite 
> massive changes. After about 4 hours, I had everything in place. I go to test 
> the first connection/device, and ...
> 
> 
> share/dbus-1 # passkey-agent --default 0000 00:1A:45:01:F9:42 &
> 
> Can't register passkey agent
> Method "RegisterDefaultPasskeyAgent" with signature "s" on interface
> "org.bluez.Security" doesn't exist
> 
> [1] 4173
> [1]  + exit 1     passkey-agent --default 0000 00:1A:45:01:F9:42
> 
> 
> 
> bluez-4.1/src # Can't register authorization agent
> 
> Method "RegisterDefaultAuthorizationAgent" with signature "s" on interface
> "org.bluez.Security" doesn't exist

that is expected. We remove the 3.x API. I also mentioned on
www.bluez.org that bluez-gnome will break with 4.x right now.

> bluetoothd[4803]: hcid_dbus_bonding_process_complete: status=00
> bluetoothd[4803]: hcid_dbus_bonding_process_complete: no pending auth request
> bluetoothd[4803]: Accepted new client connection on unix socket (fd=22)
> bluetoothd[4803]: Audio API: received BT_GETCAPABILITIES_REQ
> bluetoothd[4803]: Audio API: sending BT_GETCAPABILITIES_RSP
> bluetoothd[4803]: Unix client disconnected (fd=22)
> 
> 
> 
> No! :-(
> 
> media/ogg # sox -t ogg ./file.ogg -t alsa pcm.bluetooth
> 
> ALSA lib pcm_bluetooth.c:1619:(bluetooth_init) BT_GETCAPABILITIES failed : 
> Input/output error(5)
> sox soxio: Can't open output file `pcm.bluetooth': cannot open audio device
> 
> -2- root@vdrl media/ogg # hcitool con
> Connections:
> 
> 
> Now all I can get are the expected authentication error type messages:

That is not a pairing issue. That is an audio service issue.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
