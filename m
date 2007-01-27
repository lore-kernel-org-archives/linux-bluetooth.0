Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
From: "Florian Schaefer" <listbox@netego.de>
To: bluez-devel@lists.sourceforge.net
Date: Sat, 27 Jan 2007 19:39:37 +0100
Message-Id: <E1HAsSn-0000V7-5M@washu.netego.de>
Subject: [Bluez-devel] aplay freezes with headsetd
Reply-To: Florian Schaefer <listbox@netego.de>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1104413582=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1104413582==
Content-Type: multipart/signed;
	boundary="=-=---==-=-=--==-====-=====--=-===--==-=-";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Disposition: inline

--=-=---==-=-=--==-====-=====--=-===--==-=-
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm currently trying to get my "Logitech Mobile Pro II" headset connected
to my Debian box using the new and shiny headsetd. It seems that I get a
connection between my notebook and the headset when starting a test run
of aplay (the speaker of the headset is activated and emits some quiet
static sounds) but that's all that happens. Aplay will just kind of
freezes and that's it.

But now the information in more order (my CVS checkouts are from today):

root@washu:~ # hciconfig -a
hci0:	Type: USB
	BD Address: 00:02:78:3D:18:DD ACL MTU: 1017:8 SCO MTU: 64:0
	UP RUNNING PSCAN=20
	RX bytes:397591 acl:21 sco:7760 events:50 errors:0
	TX bytes:806 acl:21 sco:0 commands:30 errors:0
	Features: 0xff 0xff 0x8d 0xfe 0x9b 0xfd 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
	Link policy: RSWITCH HOLD SNIFF PARK=20
	Link mode: SLAVE ACCEPT=20
	Name: 'washu'
	Class: 0x3e0100
	Service Classes: Networking, Rendering, Capturing, Object
Transfer, Audio
	Device Class: Computer, Uncategorized
	HCI Ver: 2.0 (0x3) HCI Rev: 0x20dc LMP Ver: 2.0 (0x3) LMP Subver:
0x415c
	Manufacturer: Broadcom Corporation (15)

florian@washu:~ # /opt/bluetooth-alsa/bin/headsetd -n
headsetd[1808]: Bluetooth headset daemon version 0.5
[*** headset switched on ***]
headsetd[1808]: Incoming RFCOMM hs connection from 00:0D:44:5C:A7:69
accepted
headsetd[1808]: Changing state: Idle-->Connected
[*** aplay started ***]
headsetd[1808]: Changing state: Connected-->Ready
headsetd[1808]: Changing state: Ready-->Opening
headsetd[1808]: SCO channel opened handle=3D0x0001 mtu=3D64
headsetd[1808]: Changing state: Opening-->Streaming
[*** this is where aplay hangs ***]

florian@washu:~ # aplay -B 1000000 -Dheadset
/usr/share/sounds/alsa/Front_Left.wav=20
DEBUG(pid=3D1897): _snd_pcm_sco_open: Starting pcm_sco_headset plugin.
DEBUG(pid=3D1897): _snd_pcm_sco_open: Open mode is for Playback.
DEBUG(pid=3D1897): _snd_pcm_sco_open: opened as ioplug=3D0x805c778,
pcm=3D0x805c8b0, i
oplug->callback =3D 0xb7acc7e0
Playing WAVE '/usr/share/sounds/alsa/Noise.wav' : Signed 16 bit Little
Endian, R
ate 48000 Hz, Mono
Warning: rate is not accurate (requested =3D 48000Hz, got =3D 8000Hz)
	 please, try the plug plugin (-Dplug:headset)
DEBUG(pid=3D1897): sco_headset_hw_params: period_count =3D 200
DEBUG(pid=3D1897): sco_headset_prepare: Preparing with io->period_size =3D
24, io->b
uffer_size =3D 4800
DEBUG(pid=3D1897): sco_headset_pointer: returning bt_headset->hw_ptr=3D0
DEBUG(pid=3D1897): sco_headset_write: areas->step=3D16, areas->first=3D0,
offset=3D0, si
ze=3D24, io->nonblock=3D0
DEBUG(pid=3D1897): sco_headset_write: returning 24
DEBUG(pid=3D1897): sco_headset_pointer: returning bt_headset->hw_ptr=3D24
DEBUG(pid=3D1897): sco_headset_write: areas->step=3D16, areas->first=3D0,
offset=3D0, si
ze=3D24, io->nonblock=3D0
DEBUG(pid=3D1897): sco_headset_write: returning 24
DEBUG(pid=3D1897): sco_headset_pointer: returning bt_headset->hw_ptr=3D48
DEBUG(pid=3D1897): sco_headset_write: areas->step=3D16, areas->first=3D0,
offset=3D0, si
ze=3D24, io->nonblock=3D0
[*** many more of those lines ***]
DEBUG(pid=3D1897): sco_headset_write: returning 24
DEBUG(pid=3D1897): sco_headset_pointer: returning bt_headset->hw_ptr=3D4776
DEBUG(pid=3D1897): sco_headset_write: areas->step=3D16, areas->first=3D0,
offset=3D0, si
ze=3D24, io->nonblock=3D0
DEBUG(pid=3D1897): sco_headset_write: returning 24
DEBUG(pid=3D1897): sco_headset_pointer: returning bt_headset->hw_ptr=3D0
DEBUG(pid=3D1897): sco_headset_write: areas->step=3D16, areas->first=3D0,
offset=3D0, si
ze=3D24, io->nonblock=3D0
[*** this is where aplay hangs ***]

Here I here, that the speaker has been switched on, but all I hear is
static.

root@washu:~ # hcidump -X -V
[*** shows a lot of stuff all the time similar to: ***]
> SCO data: handle 1 dlen 48
    0000: f1 ff 57 ff 39 ff bb ff  bb ff 28 ff 0d ff 83 ff=20
=2E.W.9.....(.....
    0010: c0 ff 72 ff 4d ff b3 ff  1b 00 0e 00 cc ff 13 00=20
=2E.r.M...........
    0020: 7e 00 37 01 3d 01 30 01  46 01 59 01 37 02 00 02=20
~.7.=3D.0.F.Y.7...

The output of hcidump continued even after aplay didn't do anything
anymore.

I already tried to use the btsco method: Slightly different debug output,
but the same net result.

Any ideas?

Ciao
Florian=


--=-=---==-=-=--==-====-=====--=-===--==-=-
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Get my DSA key from: www.netego.de/hpc?p=download&l=en

iD8DBQBFu5xv+2lxodi1OoURAvb9AJ9+H3AGgsJ4Sp99RA1hPxYt2iv10gCZAdL7
K1VH+sIC14zEW67fCfBUvJw=
=BM8y
-----END PGP SIGNATURE-----

--=-=---==-=-=--==-====-=====--=-===--==-=---



--===============1104413582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1104413582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1104413582==--
