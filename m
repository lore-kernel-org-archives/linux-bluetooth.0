Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F265E3.3020109@egabriel.de>
From: ligi <ligi@egabriel.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Again: Problems with Dongle, Headset or btsco
References: <41F0EB0A.1020302@webstuhl.net>	<41F0FE84.8030401@dark-reality.de>	<41F128F4.2020006@webstuhl.net>	<41F13638.1080207@dark-reality.de>	<41F25C4B.6040709@webstuhl.net> <20050122151959.3384d572@mirko_3>
In-Reply-To: <20050122151959.3384d572@mirko_3>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 22 Jan 2005 15:40:35 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


|>
|>
|> Last Question: Which are other methods to send/receive data
|> from/to the headset beside aplay / arecord?
|>
|> eg cat /dev/snd/pcmC1D0c > z1.out ? :)
|
you have to use snd_pcm_oss  for that.
from kernel doc:
To enable OSS digital audio (PCM) emulation (/dev/dsp*), say Y    
here and read <file:Documentation/sound/alsa/OSS-Emulation.txt>.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8mXj3NorRo/jFWIRAnJ0AJ4w5XM6K4gIDpV6I97uAJXIy9J9UACfREgR
tNjcjdUFWajYEr/e4NJh758=
=TER7
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
