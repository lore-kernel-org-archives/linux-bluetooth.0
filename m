Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F8E3C3.70204@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] partly OT: pipe sound from Headset to soundcard
References: <41F7CEF6.1050508@webstuhl.net> <41F7D274.4030208@xmission.com> <41F82DA9.8090806@webstuhl.net>
In-Reply-To: <41F82DA9.8090806@webstuhl.net>
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
Date: Thu, 27 Jan 2005 13:51:15 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ben Pezzei wrote:
| Hi Brad,
|
| Brad Midgley schrieb:
|
|> I had the same thought.
|>
|> We have a way to send line in to a stereo headset but there is a
|> delay. (see bluetooth-alsa.sf.net)
|
|
| Yeah, but this covers A2DP only, right?
|
| Right now, I was trying to accomplish this via asound.conf:
| something like:
| pcm.foo {
|   type multi
|   <map soundcard>
|   <map headset>
| }
| pcm.bar {
|   type route
|   slave.pcm "bar"
|   <map channels card out -> hs in>
|   <map channels card in -> hs out>
| }
|
| hope the idea is understandable
|
|
http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html#pcm_plugins_route

|
|
| but I guess this won't work
|

why not, it looks as it should. But I don't know much about alsa routing...

|> You could write something similar that runs in userspace and copies
|> audio streams around using sco.
|
| C hacking? ;) well, if there is really no other way, i could
| try it. Are there some docs around to dig in or just the btsco
| sources?

I think the btsco kernel module does nearly what you are looking for
(only in kernelspace). It takes an sco socket, reads the data and writes
it to the alsa buffer and vice versa. Of course you would write it to an
alsa device, not the internal buffer :)

Should be possible to rip it apart and run it as a userspace program,
dropping all kernel stuff and keeping mostly the thread that does the
copy stuff.

You can also have a look at the btsco command line daemon that does the
connection handling. A combination of both should do what you want.
Maybe *g*

good luck, and make sure to re-destribute your sources, as it will be
quite interesting for us I think :)

best regards,
~   Lars

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

iD8DBQFB+OPCQWC6DTWkDAoRAp2zAJ9HE8vvVjbySeMS8UogZWmzMrnOeACfTugy
P/hZxd03QggSTK5mOBDUPHo=
=73yZ
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
