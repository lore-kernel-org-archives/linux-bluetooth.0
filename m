Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41EA9C46.2020907@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco website problems
References: <41EAA3A4.4040509@dark-reality.de> <41EA8483.8080600@xmission.com>
In-Reply-To: <41EA8483.8080600@xmission.com>
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
Date: Sun, 16 Jan 2005 17:54:30 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

great. with a bit of luck I can hack a css together to make it look
nifty and add a menu when you are done with the content. Just keep it
simple html code and we'll be fine :)

best regards,
~  Lars

Brad Midgley wrote:
| yeah, i've been thinking it needs work. i'll go push it together with
| your outline.
|
| Lars Grunewaldt wrote:
|
| Hi there,
|
| I just took a look at our website to find out why some people have setup
| problems like using the btsco for a2dp and stuff. Don't get me wrong,
| it's great that we have a page and the content is not that bad ->
| credits to the writer :)
|
| I think the problem is that the sections are not very well-named on the
| web page, so one does not know what section describes what part of the
| project (hs or a2dsp profile).
|
| Right now we have:
|
| *introduction
| Stereo Streaming!
| Alsa userspace plugin
| Build
| Discussion
| Credits
|
| with no more info in the headlines. If I - as a btsco n00b - would come
| to the site I would think that
|
| stereo streaming -> alsa -> build
|
| are all about the same topic, making the stereo streaming work.
|
| I think things would be much easier if the headlines of the sections
| would be a little more descriptive, also it might be usefull to re-order
| them.
|
| I'd propose:
|
| *introduction
| ~  (hello world, supported headsets - pretty much like the current
| version)
|
| Features
| (here we describe what parts of btsco handle what part of features and a
| bit of the technical background)
| ~ * HS profile description ("Headset support")
| ~ * a2dp description ("Stereo sound")
|
| Download
| ~  proper link into the download section and to CVS (do we have nightly
| tarballs, by the way? I think SF builds those for us, and puts them
| somewhere?)
|
| Installation
| (with remarks "building this is only for hs or a2dp" or alike)
| ~ * build process
| ~ * build provess for alsa kernel module (headset profile)
| ~ * build process for a2dp (if this is different)
|
| Usage
| ~ * hs profile, daemon
| ~ * a2dp examples
|
| If we use this structure, anyone should be able to distinguish between
| headset and stereo stuff.
|
| Too bad I don't have time right now :(
|
| If no one else as a little bit of time to write this together, it will
| have to wait until I do. I won't mind to do it, though :)
|
| best regards,
| ~  Lars
|
|
| --
| Lars Grunewaldt
| * software development
| * multimedia design
| skills: C/C++/Java/PHP/(X)HTML/Flash/audio/video
| web: http://www.dark-reality.de
| mail: lgw@dark-reality.de
|>
|>
- -------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

| -------------------------------------------------------
| The SF.Net email is sponsored by: Beat the post-holiday blues
| Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
| It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
| _______________________________________________
| Bluez-devel mailing list
| Bluez-devel@lists.sourceforge.net
| https://lists.sourceforge.net/lists/listinfo/bluez-devel



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

iD8DBQFB6pxFQWC6DTWkDAoRAjhcAJ4spT7330NM3qnUW07B3fvj2uMMBACeKEeZ
4RGWZ95VWcUq7rdQ60kOU+0=
=ZoW4
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
