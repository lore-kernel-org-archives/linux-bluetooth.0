Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40D1FA27.20407@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] question: what does this patch from snd-bt-sco
 do?
References: <40A9E6CB.4010505@dark-reality.de>	 <88307002-A8B9-11D8-A107-000A95A4D990@dcs.gla.ac.uk>	 <40A9EE51.2080102@dark-reality.de> <1084881439.5833.108.camel@pegasus>	 <40AA11AB.6010307@dark-reality.de> <1084888843.4327.1.camel@pegasus>	 <40D0CE71.2010208@dark-reality.de> <1087427168.4309.30.camel@pegasus>	 <40D0DFFE.7020701@dark-reality.de> <1087431863.4309.39.camel@pegasus>	 <E1B5DFDA-C050-11D8-9772-000A95A4D990@dcs.gla.ac.uk>	 <40D19E13.9070005@dark-reality.de> <1087487912.4309.69.camel@pegasus>
In-Reply-To: <1087487912.4309.69.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 17 Jun 2004 22:08:07 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:
| Hi Lars,
|
|
|>won't be a problem. I know what to do because I changed them before,
|>from S8 to MULAW_8 :)
|>
|>My only problem/wish is that I'd like to support all three audio
|>encodings, but I understand this is impossible right now.
|
|
| only because mulaw and alaw are 8bit.

you could as well say "an elephant won't fit into a mousewhole until it
get's a dynamic interface". Of course mulaw and alaw differ from pcm/16
bit only because they are 8bit/sample. so what. Would not work if it
would be 7 or 9 bit, either. Also it's not likely that the bit count
will change sooner or later :)

I'll have a look at the documentation and I'll try to figure out how to
improve the alsa/sco integration, but I'm very busy right now and I
don't know how fast I can come up with anything.

Suggestions are welcome. If anyone has an idea how to improve this
"alternate setting" handling, i.e. make it possible for an
application/driver to set the setting in runtime without rewriting the
whole code, that would be a great thing.

cu & thanks for listening :)
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA0fomQWC6DTWkDAoRAn5tAJ9k0E1H5I8vNZxvV8sENsMPYp90YgCgiZzM
3wDmQBpZMUmQshpVsGJSMIk=
=MK9u
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
