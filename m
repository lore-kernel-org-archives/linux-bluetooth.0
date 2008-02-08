Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Feb 2008 18:08:02 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <611951.12552.qm@web8407.mail.in.yahoo.com>
Message-ID: <alpine.LNX.1.00.0802081245410.12298@nge2.ngu.pk>
References: <611951.12552.qm@web8407.mail.in.yahoo.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Headset not playing audio HELP PLEASE
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


On Fri, 8 Feb 2008, pramod gurav wrote:

-> On the console where i run the audio service I get these log
-> audio[3032]: Accepted new client connection on unix socket (fd=9) audio[3032]: Audio API: received BT_GETCAPABILITIES_REQ
-> audio[3032]: Got path /org/bluez/hci0 for adapter with address 00:0B:0D:33:9E:FB
-> audio[3032]: /org/bluez/hci0 GetRemoteName(): Not available
-> Passkey request for device 00:0F:DE:B1:02:42


Did you also start auth-agent? My headset uses both:

Passkey request for device 00:1A:45:01:F9:42 
Authorization request for device 00:1A:45:01:F9:42


-> audio[3032]: Audio service discovery completed with success
-> audio[3032]: Found Headset record
-> audio[3032]: Discovered Headset service on RFCOMM channel 1
-> audio[3032]: Selecting default device
-> audio[3032]: Audio API: sending BT_GETCAPABILITIES_RSP
-> audio[3032]: Audio API: received BT_SETCONFIGURATION_REQ
-> audio[3032]: config sbc - frequency = 0 channel_mode = 0 allocation = 0 subbands = 0 blocks = 0 bitpool = 0
-> audio[3032]: State changed /org/bluez/audio/device0: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
-> audio[3032]: /org/bluez/audio/device0: Connecting to 00:0F:DE:B1:02:42 channel 1
-> audio[3032]: State changed /org/bluez/audio/device0: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
-> audio[3032]: /org/bluez/audio/device0: Connected to 00:0F:DE:B1:02:42
-> audio[3032]: State changed /org/bluez/audio/device0: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
-> audio[3032]: Received AT*ECBP=?
-> audio[3032]: Badly formated or unrecognized command: AT*ECBP=?

I had errors like these the day before. If I remeber right, setting 
force_scofix=1 on the device's module (hci_usb) seemed to clear them up. But I 
forgot if your Bluetooth adapter is usb or not.

Did you pair the devices first? My headset had a button to press which makes 
it pair. I've heard the noise too, like the one you're getting. I upgraded to
3.25, set the force_scofix to 1 and tried a few different values in
audio.conf. After that it just worked.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
