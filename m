Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F3E469.3020306@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Again: Problems with Dongle, Headset or btsco
References: <41F0EB0A.1020302@webstuhl.net> <41F0FE84.8030401@dark-reality.de> <41F128F4.2020006@webstuhl.net> <41F13638.1080207@dark-reality.de> <41F25C4B.6040709@webstuhl.net> <csts46$p5n$1@sea.gmane.org> <41F29274.3020909@webstuhl.net>
In-Reply-To: <41F29274.3020909@webstuhl.net>
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
Date: Sun, 23 Jan 2005 18:52:41 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ben Pezzei wrote:
| Hi Sebastian,
|
| Sebastian Roth schrieb:
|
|>> unfortunately
|>> arecord -D plughw:Headset z1.out
|>> Recording WAVE 'z1.out' : Unsigned 8 bit, Rate 8000 Hz, Mono

uhm, this is wrong. If you are using the "actual" btsco package from CVS
- - and you should be - it must record as signed 16 bit if I'm not
mistaken (possibly unsigned 16B, but in no case 8 bit)

best regards,
~  Lars

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

iD8DBQFB8+RoQWC6DTWkDAoRAo4rAJ4r9GbBnH1eUtDQ08ngF6UyXeX0lgCgpdlx
Hn7p+uz6pWQTIRA3jPF0e28=
=Wgk/
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
