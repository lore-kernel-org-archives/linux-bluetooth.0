Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E925F4.3060907@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco crash without daemon
References: <41E91B7A.1070303@egabriel.de>
In-Reply-To: <41E91B7A.1070303@egabriel.de>
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
Date: Sat, 15 Jan 2005 15:17:24 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ligi wrote:

| that was all because i cant get the daemon working with kernle 2.6.10
| - in 2.6.9 evrything was working fine. Something very wicked is going
| on with alsa because nothing is going on in hcidump.

Why can't you get it working with 2.6.10? It works absolutly flawless
here with 2.6.10.

Maybe you should get the latest sources from CVS (module btsco) and give
it a fresh start?

Also do NOT use any kernel patches any more! The alternate setting for
hci_usb can be set by parameter when loading the module, and the
snd-bt-sco resides in the /kernel directory and can be compiled simply
by using "make" in this directory :)

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

iD8DBQFB6SXzQWC6DTWkDAoRAn9OAJ9bpuyXgTK0gDxsO7JLPlC/DRVLWwCglpWl
nP65nqPbK0qCqhCGlBKrWnU=
=eI9d
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
