Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41DE6DC3.7070903@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco under FC3
References: <5256d0b05010520461ad68ff3@mail.gmail.com>	 <1105014278.4299.19.camel@pegasus>	 <5256d0b05010622152c32d3f4@mail.gmail.com>	 <41DE36E2.5030404@xmission.com> <5256d0b0501062319209a3d3a@mail.gmail.com>
In-Reply-To: <5256d0b0501062319209a3d3a@mail.gmail.com>
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
Date: Fri, 07 Jan 2005 12:08:51 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I also think it's not needed to run btsco when you try to use a2play!

btsco is for using the headset with alsa in normal (mono) audio
applications, while a2play connects directly to the headset to play
stereo music.

So it should be either btsco *or* a2play!

best regards,
~  Lars

Peter Robinson wrote:
|>It's not a real daemon. You run it in the foreground and click the
|>connect button on the headset. Then you can send and receive audio from
|>another app.
|
|
| OK so its not suppose to exit then...
|
| P
|
|
| -------------------------------------------------------
| The SF.Net email is sponsored by: Beat the post-holiday blues
| Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
| It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
| _______________________________________________
| Bluez-devel mailing list
| Bluez-devel@lists.sourceforge.net
| https://lists.sourceforge.net/lists/listinfo/bluez-devel
|


- --
Lars Grunewaldt
* software development
* multimedia design
skills: C/C++/Java/PHP/(X)HTML/Flash/audio/video
web: http://www.dark-reality.de
mail: lgw@dark-reality.de
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB3m3DQWC6DTWkDAoRApxyAJoDSkDi4wWBVjrLF0JNZ6pyEyaPwwCfY7q+
jqtiPDRSg21KGNME6M/f1kU=
=YqzK
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
