Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E9349C.8060001@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco crash without daemon
References: <41E91B7A.1070303@egabriel.de> <41E925F4.3060907@dark-reality.de> <41E92C83.8010406@egabriel.de>
In-Reply-To: <41E92C83.8010406@egabriel.de>
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
Date: Sat, 15 Jan 2005 16:19:56 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ligi wrote:
| Lars Grunewaldt wrote:
|

| | Why can't you get it working with 2.6.10? It works absolutly flawless
| | here with 2.6.10.
| |
| i dont know - the problems occoured when btsco got rid of the
| kernel-patches in my case when migrating to 2.6.10

did you patch the kernel with the -mh10 patchset from bluez? I did, and
I don't have any problems at all...

|
| | Maybe you should get the latest sources from CVS (module btsco) and give
| | it a fresh start?
| |
| i use them.

OK :)

|
| | Also do NOT use any kernel patches any more!
|
| i dont patch the kernel anymore and neither alsa

any might have been wrong - you should use the mh10 patch from bluez, as
noted above...

|
| | The alternate setting for
| | hci_usb can be set by parameter when loading the module,
|
|
| what do you mean ?

If you don't know, you don't have to bother. This is only important for
multiple headsets (if you don't use only one headset, you have to change
this "alternate setting". If you use only one headset, you don't have to
care :)

But this (or, the absence of the module parameter) was the reason for
the btsco-kernel patch.

| | and the
| | snd-bt-sco resides in the /kernel directory and can be compiled simply
| | by using "make" in this directory :)
| |
| there are no problems in building - just in runnig  wont work
|
| bash-2.05b# ./btsco 00:0E:16:01:06:ED
| Device is 1:0
| Error: btsco open (1-0): No such device or address

yes, that's strange. I don't experience any problems here :(

regards,
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

iD8DBQFB6TSbQWC6DTWkDAoRApsfAKCPaUe4+CSv6uIxeBKidQQy+6F5OACgiGJD
sMduvdTYZQSt6nCrTjvVW6Y=
=7qhc
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
