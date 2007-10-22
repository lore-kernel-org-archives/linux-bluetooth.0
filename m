Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <471CD91C.9080209@vsnl.com>
Date: Mon, 22 Oct 2007 22:38:44 +0530
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
From: Mohan Sundaram <mohan.tux@gmail.com>
Subject: [Bluez-users] Gutsy+Moto+BlueTooth+Wammu
Reply-To: smohan@vsnl.com, BlueZ users <bluez-users@lists.sourceforge.net>
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

My experience:
*Headset HS805:*
1. When I shifted to Gutsy, the first thing I noticed was direct headset
support. System >> Preferences >> Bluetooth headset.
2. My Moto HS805 worked first shot in pairing. Subsequent connections
took some learning.  Invoking the BT headset and check for new devices
shows the headset when headset is in pairing mode and the HS button was
clicked a couple of times. No pairing beeps as I would hear if it paired
with my Moto L6.
3. Once it appeared on the list, choosing it as the active headset made
it the second ALSA and OSS device.
4. Once done, I was able to pick the BT headset in Skype sound devices.

        Happy, thrilled and felt something was accomplished fairly fast.

*Moto L6:* Wanted to use Wammu/Kmobiletools for phonebook/ SMS etc.
1. When I installed Gutsy, I also installed the kobexclient.
Gnome-obex-server came in the gnome-bluez utils pack and got installed.
2. I set the laptop to automatic connect on my MotoL6. Obex push from PC
   worked well. Invoked gnome-obex-server on PC and obex push from phone
worked well.
3. I setup rfcomm to bind to the address and l2ping worked well. "rfcomm
connect 0" refused to connect. /dev/rfcomm0 had 600 as rights and I was
root. As I'd read someplace, I set the permissions to 666. Still pairing
did not happen.
4. /var/log/syslog showed passkey-agent registered. I set default to
0000 and still no avail. I wrote a pin_helper script that  echoed
"PIN:0000" and called it from /etc/bluetooth/hcid.conf. Still no avail.
5. Did some more RTFM and read in blueZ architecture that auth uses the
dbus architecture and a interactive dbus-send command was listed. I used
that to send a PIN to the device and it paired.
6. Went to the bluetooth paired devices config and set both the headset
and phone as trusted devices.
7. Tried rfcomm connect 0 and it worked. Fired up cutecom and tried AT+C
commands. Disconnected. Moved down from 115200 to 19200 bauds and they
worked.
8. Wammu and Kmobiletools were a breeze after this.

Hope this is useful to others. Most documents I read did not deal with
the PIN auth problem solution that I tried. Most list pin_helpers which
were deprecated in blueZ 3.0.

Pairing/bonding:
1. What I did was to create a bond. Since the PIN exchange was not 
happening, I was forced to go lower and create the bond myself. This is 
a one time exercise per device as I understand it.
2. URL http://wiki.bluez.org/wiki/HOWTO/Bonding
3. command used: dbus-send --system --type=method_call --print-reply
--dest=org.bluez /org/bluez/hci0 org.bluez.Adapter.CreateBonding
string:AA:BB:CC:DD:EE:FF

This caused the PIN box to pop up on the PC. Once keyed in, the MotoL6
asked for the same key. This was timing out pretty fast. I had to do a
one hand per device act to beat the clock. Got it after a few tries.

Mohan Sundaram

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
