Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41F781ED.2050704@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetooth headset - connects but no audio
References: <41EE3974.1010604@fastwebnet.it> <41EE5112.1040502@dark-reality.de> <41EE4ACD.9070105@fastwebnet.it> <41EE66A2.1040106@dark-reality.de> <41EE69F3.1030401@fastwebnet.it> <41EE989A.7030206@dark-reality.de> <41EED6AE.1080205@fastwebnet.it> <41EF0C15.3040705@dark-reality.de> <41EF869D.8020705@fastwebnet.it> <41EFAE20.7010901@dark-reality.de> <41F74AC1.3010605@fastwebnet.it>
In-Reply-To: <41F74AC1.3010605@fastwebnet.it>
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
Date: Wed, 26 Jan 2005 12:41:33 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

WiseLYNX wrote:
| | | I'll do some more experiments on my own, and I'll let you know if I
| | | understand something.
| |
| | Would be great. Good luck! I'm out of ideas :(
|
| alas, you where right. it was just a dongle issue - my friend's works
| perfectly. my misfortune in buying hardware strikes back :(
|
| is there any way to "fix" the problem?
|

I asked Marcel on this list, but I did not understand his answer...:

| the Silicon Wave chips are not the best ones. They have problems and it
| seems that they are not going to fix them. Mostly because they sell ROM
| chips are these ones can't be updated by a newer firmware. However if
| this is the problem with SCO packets and handle 0 then the hci_usb
| driver should simply drop these frames, because they are not valid SCO
| payload.

...?

I'm not sure if he means that there are to many packages recieved now,
or that the packages are dropped because of the 0 handle. I think that
might be hot-fixable somehow, at least for one connection. Of course
this is ugly, but if it's optional just to make this broken chipsets work?

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

iD8DBQFB94HsQWC6DTWkDAoRAroNAJ9E6fkzvN6D+gMJ8yz7FoDt+ks6LQCglOaY
RcQ4UuGEIc2hhazxyQUbphU=
=/OYs
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
