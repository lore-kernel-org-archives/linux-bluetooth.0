Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F3C97A.9050708@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco blocking audio mode
References: <pan.2005.01.22.15.45.57.119048@yahoo.com> <41F32C16.8000000@xmission.com>
In-Reply-To: <41F32C16.8000000@xmission.com>
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
Date: Sun, 23 Jan 2005 16:57:46 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

the problem seems to be that we are reporting "interface available" even
if it's not. Maybe there's something like an "idle state" or such thing
so that we can have an existing alsa interface, but tell the application
it's not worth sending data?

The internal problem should be that snd-bt-sco reads the input buffer
only when the hardware buffer is filled. I think it's not possible to
simple "empty" the buffer when there's not output socket available,
because this should mess up the timing of the input application.

I never tested this, but someone on the list stated that it would be
like that.

But it should be possible to test this by modifiing the input buffer
read thread of snd-bt-sco...

best regards,
~  Lars

Brad Midgley wrote:
| Paul,
|
| Do you know what the OSS and ALSA api has to say about nonblocking
| open/write? I'm a little clueless here about whether or not we are
| producing the behavior the client is asking for.
|
| I do see what you mean. Another example for which you'd want nonblocking
| writes is live streaming.
|
| Brad
|
| Paul Ionescu wrote:
|
|> Hi,
|>
|> Currently when snd-bt-sco is loaded but btsco is not connected, any
|> attempt to play something will be blocked until a btsco connection is
|> made.
|> Sometimes, a "play anyway" mode would be preferred.
|> Example:
|> If I watch a movie with mplayer with output to my headset, and I
|> disconnect the headset, the movie will stop playing, because
|> snd-bt-sco is
|> not sending positive response.
|> Can snd-bt-sco be made to send positive response even if there is no
|> headset connected ?
|> This should be user selectable.
|>
|> Thanks,
|> Paul
|>
|>
|>
|>
|> -------------------------------------------------------
|> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
|> Tool for open source databases. Create drag-&-drop reports. Save time
|> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
|> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
|> _______________________________________________
|> Bluez-devel mailing list
|> Bluez-devel@lists.sourceforge.net
|> https://lists.sourceforge.net/lists/listinfo/bluez-devel
|
|
|
| -------------------------------------------------------
| This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
| Tool for open source databases. Create drag-&-drop reports. Save time
| by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
| Download a FREE copy at http://www.intelliview.com/go/osdn_nl
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

iD8DBQFB88l5QWC6DTWkDAoRArEBAJ9Jt5lJa/tYA2QKdTFCDsa3NvzvbQCfd+ru
6GOVUnKk2QBvYtnk3QnuuN0=
=tQIw
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
