Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E92C83.8010406@egabriel.de>
From: ligi <ligi@egabriel.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco crash without daemon
References: <41E91B7A.1070303@egabriel.de> <41E925F4.3060907@dark-reality.de>
In-Reply-To: <41E925F4.3060907@dark-reality.de>
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
Date: Sat, 15 Jan 2005 15:45:23 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Lars Grunewaldt wrote:

| ligi wrote:
|
| | that was all because i cant get the daemon working with kernle 2.6.10
| | - in 2.6.9 evrything was working fine. Something very wicked is going
| | on with alsa because nothing is going on in hcidump.
|
| Why can't you get it working with 2.6.10? It works absolutly flawless
| here with 2.6.10.
|
i dont know - the problems occoured when btsco got rid of the
kernel-patches in my case when migrating to 2.6.10

| Maybe you should get the latest sources from CVS (module btsco) and give
| it a fresh start?
|
i use them.

| Also do NOT use any kernel patches any more!

i dont patch the kernel anymore and neither alsa

| The alternate setting for
| hci_usb can be set by parameter when loading the module,


what do you mean ?

| and the
| snd-bt-sco resides in the /kernel directory and can be compiled simply
| by using "make" in this directory :)
|
there are no problems in building - just in runnig  wont work

bash-2.05b# ./btsco 00:0E:16:01:06:ED
Device is 1:0
Error: btsco open (1-0): No such device or address



ligi



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB6Sx33NorRo/jFWIRAu/zAJ4ryw5qFId9sPtIhRI5p+6aLkocQQCfZ8QQ
Pjx4uVfXYwd7/L/b3KjwBIY=
=WLxP
-----END PGP SIGNATURE-----



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
