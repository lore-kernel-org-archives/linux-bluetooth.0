Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <1098262358.41762756cf86c@www.songbirdtech.com>
From: prem@songbirdtech.com
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Bridging bluetooth and a cellular modem
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
Date: Wed, 20 Oct 2004 01:52:38 -0700

I am fairly new to telephony and need some help with understanding the transfer
of voice to and from a bluetooth headset.

I am developing a device which makes use of a GSM/GPRS cellular modem to
transfer data over the Internet using GPRS. But this same modem (Siemens MC35)
will also have to handle voice calls - that is, when a call comes in, the voice
must be captured and transferred over a bluetooth connection to a bluetooth
headset .. and conversely, the voice must be transferred from the bluetooth
headset down to the modem.

I have been trying to figure out how to use the BlueZ SCO APIs to do this - is
this possible at all and if so how is this done?

Also, does BlueZ work on the MIPS processor ? I am using AMD Alchemy Au1500
MIPS32 based processor.

Would appreciate any help on this.

Thank you,
Prem Kurian Philip





-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
