Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bridging bluetooth and a cellular modem
From: Marcel Holtmann <marcel@holtmann.org>
To: prem@songbirdtech.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1098262358.41762756cf86c@www.songbirdtech.com>
References: <1098262358.41762756cf86c@www.songbirdtech.com>
Content-Type: text/plain
Message-Id: <1098267631.13853.9.camel@pegasus>
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
Date: Wed, 20 Oct 2004 12:20:30 +0200

Hi Prem,

> I am fairly new to telephony and need some help with understanding the transfer
> of voice to and from a bluetooth headset.
> 
> I am developing a device which makes use of a GSM/GPRS cellular modem to
> transfer data over the Internet using GPRS. But this same modem (Siemens MC35)
> will also have to handle voice calls - that is, when a call comes in, the voice
> must be captured and transferred over a bluetooth connection to a bluetooth
> headset .. and conversely, the voice must be transferred from the bluetooth
> headset down to the modem.
> 
> I have been trying to figure out how to use the BlueZ SCO APIs to do this - is
> this possible at all and if so how is this done?

it is possible if your Bluetooth module support SCO over HCI, but then
this is still not very easy to realize. If the MC35 has an external PCM
or so then use this and connect it to the PCM of your Bluetooth module.

> Also, does BlueZ work on the MIPS processor ? I am using AMD Alchemy Au1500
> MIPS32 based processor.

The general answer is yes. However I can't give you a 100% guarantee,
because I don't have access to any kind of this platforms for testing.

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
