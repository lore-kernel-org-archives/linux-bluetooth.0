Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E4E105.2090004@egabriel.de>
From: ligi <ligi@egabriel.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] btsco and 2.6.10
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
Date: Wed, 12 Jan 2005 09:34:13 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello all,

I am having Problems getting btsco working with kernel 2.6.10. With
2.6.9 evrything was working fine ( wanna thank all the btsco and bluez
developers here - gpsdrive + festival + btsco brought me a lot of fun .-)

sndmagic.h can't be patched because its nowhere and its context is
lost too.

bash-2.05b# patch -p1 < kernel-2.6.7-8.24-08-04.patch

patching file drivers/bluetooth/hci_usb.c
Hunk #1 FAILED at 887.
1 out of 1 hunk FAILED -- saving rejects to file
drivers/bluetooth/hci_usb.c.rej
patching file include/sound/asound.h
Hunk #1 succeeded at 110 (offset 2 lines).
Hunk #2 succeeded at 138 (offset 2 lines).
patching file include/sound/btsco.h
can't find file to patch at input line 55
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
- --------------------------
|diff -urN linux/include/sound/sndmagic.h
linux.new/include/sound/sndmagic.h
|--- linux/include/sound/sndmagic.h     2004-08-23 18:46:43.000000000
+0200
|+++ linux.new/include/sound/sndmagic.h 2004-08-23 19:22:37.000000000
+0200
- --------------------------
File to patch:
Skip this patch? [y] y
Skipping patch.
1 out of 1 hunk ignored
patching file sound/bluetooth/btsco.c
patching file sound/bluetooth/Kconfig
patching file sound/bluetooth/Makefile
patching file sound/Kconfig
patching file sound/Makefile


- ----- searching the context ------------


bash-2.05b# grep _t_magic -r .
./sound/pci/mixart/mixart.h:#define mixart_t_magic              0xa17a3e01
./sound/pci/mixart/mixart.h:#define mixart_mgr_t_magic  0xa17a3e02
./kernel-2.6.7-8.24-08-04.patch: #define
snd_card_harmony_t_magic       0xa15a4300
./kernel-2.6.7-8.24-08-04.patch: #define
bt87x_t_magic                  0xa15a4400
./kernel-2.6.7-8.24-08-04.patch: #define
pdacf_t_magic                  0xa15a4500
./kernel-2.6.7-8.24-08-04.patch:+#define
snd_card_bt_sco_t_magic        0xa15a4600
./kernel-2.6.7-8.24-08-04.patch:+#define
snd_card_bt_sco_pcm_t_magic    0xa15a4601
./kernel-2.6.7-8.24-08-04.patch: #define
vortex_t_magic                 0xa15a4601
./kernel-2.6.7-8.24-08-04.patch: #define
atiixp_t_magic                 0xa15a4701
./kernel-2.6.7-8.24-08-04.patch: #define
amd7930_t_magic                0xa15a4801

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5OEE3NorRo/jFWIRArj3AJ9S3tgl5E2gYakdalW3GfWVYChZewCfepxR
JhtxgW9Fy9JPsF+V8RwDu2s=
=A0xE
-----END PGP SIGNATURE-----



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
