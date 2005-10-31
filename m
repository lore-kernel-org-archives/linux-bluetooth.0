Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Luca Capello <luca@pca.it>
Subject: Re: [Bluez-devel] snd-bt-sco module prevents ACPI S3
In-reply-to: <43660FED.6040000@grimmer.com>
To: bluez-devel@lists.sourceforge.net
Message-id: <8764rdhmoi.fsf@gismo.pca.it>
MIME-version: 1.0
Content-type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
 protocol="application/pgp-signature"
References: <200510301643.31873.rene.mayrhofer@gibraltar.at>
 <4365579A.4080709@xmission.com> <43660FED.6040000@grimmer.com>
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
Date: Mon, 31 Oct 2005 13:54:05 +0100


--=-=-=
Content-Transfer-Encoding: quoted-printable

Hello!

On Mon 31 Oct 2005 13:37 +0100, Lenz Grimmer wrote:
> Brad Midgley wrote:
>
>> > 1. It's name in the lsmod list is different from the module name,
>> > i.e.  modprobe and rmmod must be used with different names.
>>=20
>> Do you want to submit a patch (or at least tell us what the
>> different names are?)
>
> The module file is named "snd-bt-sco.ko", while "lsmod" displays it
> as "snd_bt_sco". Not a biggie, but weird.

AFAIK this is the normal situation for *any* ALSA driver:
=3D=3D=3D=3D=3D
gismo:/home/luca# lsmod | grep snd
snd_intel8x0           30272  0=20
snd_intel8x0m          17732  0=20
snd_ac97_codec         72444  2 snd_intel8x0,snd_intel8x0m
snd_pcm                78472  3
snd_intel8x0,snd_intel8x0m,snd_ac97_codec
snd_timer              21764  1 snd_pcm
snd                    48100  5
snd_intel8x0,snd_intel8x0m,snd_ac97_codec,snd_pcm,snd_timer
soundcore               8800  1 snd
snd_page_alloc          9604  3 snd_intel8x0,snd_intel8x0m,snd_pcm

gismo:/home/luca# modinfo snd [TAB]
snd                 snd-hpet            snd-mpu401
snd-rawmidi         snd-seq-midi        snd-timer=20=20=20=20=20=20=20=20=
=20=20=20
snd-ac97-codec      snd-hwdep           snd-mpu401-uart
snd-rtctimer        snd-seq-midi-emul   snd-usb-audio=20=20=20=20=20=20=20
snd-emu10k1         snd-intel8x0        snd-page-alloc
snd-seq             snd-seq-midi-event  snd-usb-lib=20=20=20=20=20=20=20=20=
=20
snd-emu10k1-synth   snd-intel8x0m       snd-pcm
snd-seq-device      snd-seq-oss         snd-util-mem=20=20=20=20=20=20=20=20
snd-emux-synth      snd-mixer-oss       snd-pcm-oss
snd-seq-dummy       snd-seq-virmidi=20=20=20=20=20
=3D=3D=3D=3D=3D

I don't know why, but it's so :-(

Thx, bye,
Gismo / Luca

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDZhPvVAp7Xm10JmkRAmRDAKCCIiR1/FT8sLr6L/ImzptH6qgCgACghgGN
DjyfKBPXwzgF/qJiSjGc3dk=
=p4TB
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
