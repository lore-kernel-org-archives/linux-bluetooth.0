Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41EFAE20.7010901@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetooth headset - connects but no audio
References: <41EE3974.1010604@fastwebnet.it> <41EE5112.1040502@dark-reality.de> <41EE4ACD.9070105@fastwebnet.it> <41EE66A2.1040106@dark-reality.de> <41EE69F3.1030401@fastwebnet.it> <41EE989A.7030206@dark-reality.de> <41EED6AE.1080205@fastwebnet.it> <41EF0C15.3040705@dark-reality.de> <41EF869D.8020705@fastwebnet.it>
In-Reply-To: <41EF869D.8020705@fastwebnet.it>
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
Date: Thu, 20 Jan 2005 14:12:00 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

WiseLYNX wrote:
| | well it *should* work with this setup, as it works on my system with
| | stock 2.6.10 plus mh1 patches. Anything else special, like, are you
| | using an SMP kernel?
|
| no, ? just checked and SMP is disabled. it may be some issue with other
| settings, maybe in the bluetooth section?

Don't know, things are quite straight-forward in there. Activate sco
support...

|
| | Maybe it's a problem with your dongle, do you have access to another one
| | to test this? (local setup: epox bt-dg03 + sony/eri. hbh-35 headset)
|
| it could be of course. I'll have a try with the one (other productor,
| but same chipset I fear) of a friend of mine, but it won't be before
| next week. anyway, isn't it strange that the dongle works fine with
| other applications (I'm able to connect via gprs with my phone)?

No, because headsets use the sco data transmission, while most other
services should use rfcomm data channels. So it's quite possible that
while other things work well, there's a problem with the dongle when it
comes to the sco channels.

| I'll do some more experiments on my own, and I'll let you know if I
| understand something.

Would be great. Good luck! I'm out of ideas :(

- - Lars


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

iD8DBQFB764fQWC6DTWkDAoRAgHvAJ0RlLnR67/Itmv2slWQF84yME0tbQCdGS4/
xiujbR/82e4y4vdqH7/rW8c=
=pGrr
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
