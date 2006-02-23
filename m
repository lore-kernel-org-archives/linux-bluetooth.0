Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43FE2C18.7030306@tootai.net>
From: Administrator TOOTAI <admin@tootai.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Btsco refuse to hibernate
References: <43FB7C2C.2030203@tootai.net>	 <fd87b6160602211505n2edd9d11q9fcc6545c26edc2b@mail.gmail.com>	 <43FC9783.5050708@tootai.net> <fd87b6160602221602i3e3ea582md5f31fb4b69e5d65@mail.gmail.com>
In-Reply-To: <fd87b6160602221602i3e3ea582md5f31fb4b69e5d65@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Thu, 23 Feb 2006 22:41:44 +0100

John McCabe-Dansted a =E9crit :
> On 2/23/06, Administrator TOOTAI <admin@tootai.net> wrote:
>=20
>>John McCabe-Dansted a =E9crit :
>>
>>
>>>I found that killing all running kmix processes allowed me to shutdown=
.
>>>this can be done by typing from the command line:
>>>       killall kmix
>>>       killall -9 kmix
>>>
>>>Does this help? What desktop are you using? (E.g. KDE or Gnome)
>>>
>>>
>>
>>I killed all stuff concerning sound, it change nothing.
>=20
>=20
> Hmm, have you tryied killing virtually all processes (e.g. by going to
> runlevel 1)

No. I made <lsof | grep snd> then kill all programs showed.

>=20
> Have  you tried applying the patch below and replacing your hci_usb
> module (probably only useful if you are using a bluetooth usb dongle)?

There is no bluetooth device attached, just the module is loaded.

>=20
[...]

--=20
Daniel


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
