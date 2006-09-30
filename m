Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <451E9080.8090408@korrnet.org>
Date: Sat, 30 Sep 2006 11:42:56 -0400
From: Kirby <kirby@korrnet.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Problems with btsco on FC5
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0823577196=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0823577196==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6BF059C5C9CC0DA50AD60B79"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6BF059C5C9CC0DA50AD60B79
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

When I set xmms up to use my headset, I get a number of errors. Firstly
when I load the snd-bt-sco module I have the following:

snd-bt-sco revision 1.12 $

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ BUG: lock recursion deadlock detected! |
------------------------------------------

modprobe/3073 is trying to acquire this lock:
 [d33796a0] {snd_card_bt_sco_probe}
=2E. held by:          modprobe: 3073 [d0cf7aa0, 117]
=2E.. acquired at:               alsa_card_bt_sco_init+0xdf/0x390 [snd_bt=
_sco]
=2E.. trying at:                 alsa_card_bt_sco_init+0x1dd/0x390
[snd_bt_sco]
------------------------------
| showing all locks held by: |  (modprobe/3073 [d0cf7aa0, 117]):
------------------------------

#001:             [d33796a0] {snd_card_bt_sco_probe}
=2E.. acquired at:               alsa_card_bt_sco_init+0xdf/0x390 [snd_bt=
_sco]


modprobe/3073's [current] stackdump:

 <c042f50f> report_deadlock+0x11b/0x135  <c042f686>
check_deadlock+0x15d/0x165
 <e0952258> alsa_card_bt_sco_init+0x1dd/0x390 [snd_bt_sco]  <c042f6aa>
debug_mutex_add_waiter+0x1c/0x2c
 <e0952258> alsa_card_bt_sco_init+0x1dd/0x390 [snd_bt_sco]  <c060222a>
__mutex_lock_slowpath+0x14f/0x439
 <e0952258> alsa_card_bt_sco_init+0x1dd/0x390 [snd_bt_sco]  <e0952258>
alsa_card_bt_sco_init+0x1dd/0x390 [snd_bt_sco]
 <e0952258> alsa_card_bt_sco_init+0x1dd/0x390 [snd_bt_sco]  <c0433a61>
sys_init_module+0x134f/0x14b2
 <c04241ab> sigprocmask+0x0/0xb1  <c0402cb3> syscall_call+0x7/0xb

Showing all blocking locks in the system:
S            init:    1 [dfd88aa0, 115] (not blocked on mutex)
S     ksoftirqd/0:    2 [dfd88550, 134] (not blocked on mutex)
S      watchdog/0:    3 [dfd88000,   0] (not blocked on mutex)
S        events/0:    4 [dff5faa0, 110] (not blocked on mutex)
S         khelper:    5 [dff5f550, 110] (not blocked on mutex)
S         kthread:    6 [dff5f000, 111] (not blocked on mutex)
S       kblockd/0:    8 [dff4a550, 110] (not blocked on mutex)
S          kacpid:    9 [dff4a000, 120] (not blocked on mutex)
S           khubd:  103 [c16be000, 110] (not blocked on mutex)
S         kseriod:  105 [c16beaa0, 110] (not blocked on mutex)
S         pdflush:  161 [dfe89000, 120] (not blocked on mutex)
S         pdflush:  162 [dfe8daa0, 115] (not blocked on mutex)
S         kswapd0:  163 [dfe8d550, 125] (not blocked on mutex)
S           aio/0:  164 [dfe8d000, 120] (not blocked on mutex)
S         pccardd:  314 [dfef4aa0, 115] (not blocked on mutex)
S         pccardd:  316 [dfe6daa0, 115] (not blocked on mutex)
S       kpsmoused:  327 [dfe60550, 111] (not blocked on mutex)
S    nash-hotplug:  336 [dfe89550, 115] (not blocked on mutex)
S        kmirrord:  346 [dfea7550, 111] (not blocked on mutex)
S       kjournald:  362 [dfe60000, 110] (not blocked on mutex)
S         kauditd:  400 [dfe6d550, 110] (not blocked on mutex)
S           udevd:  425 [dfed0550, 112] (not blocked on mutex)
S       kjournald: 1223 [dee76aa0, 111] (not blocked on mutex)
S       kjournald: 1225 [dec7d550, 110] (not blocked on mutex)
S       kjournald: 1227 [df126550, 110] (not blocked on mutex)
S       kjournald: 1229 [dfefb000, 110] (not blocked on mutex)
D       kjournald: 1231 [dec7daa0, 110] (not blocked on mutex)
S        cpuspeed: 1362 [dff2aaa0, 115] (not blocked on mutex)
S          auditd: 1700 [dee26550, 112] (not blocked on mutex)
S          auditd: 1701 [deefdaa0, 113] (not blocked on mutex)
D         syslogd: 1713 [dfe55aa0, 115] (not blocked on mutex)
R           klogd: 1718 [df64d000, 116] (not blocked on mutex)
S         portmap: 1742 [df709aa0, 115] (not blocked on mutex)
S       rpc.statd: 1761 [df60c000, 116] (not blocked on mutex)
S      rpc.idmapd: 1794 [df709000, 115] (not blocked on mutex)
S     dbus-daemon: 1808 [dfea7000, 115] (not blocked on mutex)
S          smartd: 1911 [dedec000, 122] (not blocked on mutex)
S           acpid: 1920 [df60caa0, 116] (not blocked on mutex)
S           cupsd: 1930 [dfef4550, 116] (not blocked on mutex)
S            sshd: 1950 [dedec550, 121] (not blocked on mutex)
S          xinetd: 1971 [dedecaa0, 115] (not blocked on mutex)
S             gpm: 2024 [df64d550, 115] (not blocked on mutex)
S           crond: 2034 [df126aa0, 116] (not blocked on mutex)
S             xfs: 2079 [df233000, 116] (not blocked on mutex)
S             atd: 2096 [dfe89aa0, 116] (not blocked on mutex)
S cups-config-dae: 2108 [df233aa0, 125] (not blocked on mutex)
S            hald: 2118 [dfe60aa0, 116] (not blocked on mutex)
S     hald-runner: 2119 [dfef4000, 116] (not blocked on mutex)
S hald-addon-acpi: 2125 [dee76550, 123] (not blocked on mutex)
S hald-addon-keyb: 2128 [dfea7aa0, 115] (not blocked on mutex)
S hald-addon-stor: 2141 [dee26aa0, 115] (not blocked on mutex)
S           login: 2163 [dedce000, 118] (not blocked on mutex)
S        mingetty: 2164 [df60c550, 119] (not blocked on mutex)
S        mingetty: 2175 [df709550, 119] (not blocked on mutex)
S        mingetty: 2186 [dee76000, 119] (not blocked on mutex)
S        mingetty: 2187 [dfed0000, 119] (not blocked on mutex)
S        mingetty: 2188 [dfed0aa0, 119] (not blocked on mutex)
S            bash: 2224 [dfe55000, 115] (not blocked on mutex)
S            eth1: 2412 [d5cacaa0, 115] (not blocked on mutex)
S        dhclient: 2634 [df64daa0, 114] (not blocked on mutex)
S        sendmail: 2681 [d5c95000, 115] (not blocked on mutex)
S        sendmail: 2689 [dff4aaa0, 125] (not blocked on mutex)
S            ntpd: 2710 [dfe55550, 115] (not blocked on mutex)
S          startx: 2713 [dfefbaa0, 124] (not blocked on mutex)
S       ssh-agent: 2714 [dfefb550, 116] (not blocked on mutex)
S           xinit: 2730 [df233550, 117] (not blocked on mutex)
S               X: 2731 [deefd000, 115] (not blocked on mutex)
S   gnome-session: 2750 [df126000, 115] (not blocked on mutex)
S     dbus-launch: 2769 [dedceaa0, 116] (not blocked on mutex)
S     dbus-daemon: 2770 [dfe6d000, 115] (not blocked on mutex)
S        gconfd-2: 2776 [d638a550, 116] (not blocked on mutex)
S gnome-keyring-d: 2779 [dec7d000, 119] (not blocked on mutex)
S bonobo-activati: 2781 [d5c95aa0, 116] (not blocked on mutex)
S gnome-settings-: 2783 [dff2a550, 115] (not blocked on mutex)
? gnome-settings-: 2785 [deefd550, 118] (not blocked on mutex)
S        metacity: 2797 [d5c95550, 115] (not blocked on mutex)
S     gnome-panel: 2800 [dee26000, 115] (not blocked on mutex)
S     gnome-panel: 2848 [d2ae6000, 115] (not blocked on mutex)
S        nautilus: 2802 [d638aaa0, 115] (not blocked on mutex)
S        nautilus: 2808 [c16be550, 115] (not blocked on mutex)
S gnome-volume-ma: 2805 [dff2a000, 115] (not blocked on mutex)
S         eggcups: 2807 [d638a000, 115] (not blocked on mutex)
S gnome-vfs-daemo: 2810 [d5cac000, 115] (not blocked on mutex)
S gnome-vfs-daemo: 2815 [d2d7baa0, 115] (not blocked on mutex)
S       bluez-pin: 2812 [d5cac550, 115] (not blocked on mutex)
S gnome-netstatus: 2817 [d2d7b550, 115] (not blocked on mutex)
S  pam-panel-icon: 2820 [d280daa0, 115] (not blocked on mutex)
S pam_timestamp_c: 2821 [d2d7b000, 115] (not blocked on mutex)
S     trashapplet: 2829 [d2ae6aa0, 115] (not blocked on mutex)
S     trashapplet: 2840 [d2008000, 115] (not blocked on mutex)
S  cpufreq-applet: 2831 [dedce550, 115] (not blocked on mutex)
S battstat-applet: 2833 [d280d000, 115] (not blocked on mutex)
S  mapping-daemon: 2835 [d2ae6550, 115] (not blocked on mutex)
S     wnck-applet: 2837 [d2008550, 115] (not blocked on mutex)
S gweather-applet: 2851 [d23bb550, 115] (not blocked on mutex)
S      gam_server: 2856 [d23b0aa0, 115] (not blocked on mutex)
S    clock-applet: 2859 [d23b0550, 115] (not blocked on mutex)
S gnome-dictionar: 2861 [d23bb000, 115] (not blocked on mutex)
S   mixer_applet2: 2863 [d23bbaa0, 115] (not blocked on mutex)
S    xscreensaver: 2865 [d280d550, 115] (not blocked on mutex)
S         firefox: 2868 [d2008aa0, 125] (not blocked on mutex)
S  run-mozilla.sh: 2890 [cedad000, 125] (not blocked on mutex)
S     firefox-bin: 2895 [cedc0000, 115] (not blocked on mutex)
S     firefox-bin: 2896 [d23b0000, 115] (not blocked on mutex)
S     firefox-bin: 2897 [cedad550, 115] (not blocked on mutex)
X         netstat: 2899 [cedc0550, 119] (not blocked on mutex)
S  gnome-terminal: 2949 [cedc0aa0, 115] (not blocked on mutex)
?  gnome-terminal: 2952 [c900a550, 120] (not blocked on mutex)
S gnome-pty-helpe: 2950 [d0cf7550, 120] (not blocked on mutex)
S            bash: 2951 [c900aaa0, 115] (not blocked on mutex)
S              su: 2976 [c9559aa0, 118] (not blocked on mutex)
S            bash: 2979 [c9fbbaa0, 115] (not blocked on mutex)
S            hcid: 3051 [c9559000, 115] (not blocked on mutex)
S            sdpd: 3055 [c91d2000, 116] (not blocked on mutex)
S        krfcommd: 3064 [c9fbb550, 110] (not blocked on mutex)
R        modprobe: 3073 [d0cf7aa0, 117] (not blocked on mutex)
R           udevd: 3075 [d0cf7000, 118] (not blocked on mutex)
R        modprobe: 3076 [cedadaa0, 118] (not blocked on mutex)

---------------------------
| showing all locks held: |
---------------------------

#001:             [ddcb8c14] {initialize_tty_struct}
=2E. held by:          mingetty: 2164 [df60c550, 119]
=2E.. acquired at:               read_chan+0x1aa/0x56e

#002:             [ddf29414] {initialize_tty_struct}
=2E. held by:          mingetty: 2175 [df709550, 119]
=2E.. acquired at:               read_chan+0x1aa/0x56e

#003:             [dd1cac14] {initialize_tty_struct}
=2E. held by:          mingetty: 2186 [dee76000, 119]
=2E.. acquired at:               read_chan+0x1aa/0x56e

#004:             [dd1ca414] {initialize_tty_struct}
=2E. held by:          mingetty: 2187 [dfed0000, 119]
=2E.. acquired at:               read_chan+0x1aa/0x56e

#005:             [dd5cbc14] {initialize_tty_struct}
=2E. held by:          mingetty: 2188 [dfed0aa0, 119]
=2E.. acquired at:               read_chan+0x1aa/0x56e

#006:             [ddbeb938] {inode_init_once}
=2E. held by:           syslogd: 1713 [dfe55aa0, 115]
=2E.. acquired at:               do_fsync+0x45/0xab

#007:             [d33796a0] {snd_card_bt_sco_probe}
=2E. held by:          modprobe: 3073 [d0cf7aa0, 117]
=2E.. acquired at:               alsa_card_bt_sco_init+0xdf/0x390 [snd_bt=
_sco]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[ turning off deadlock detection. Please report this. ]

Afterword, when I press play I get a very soft click in the hearphone
and the following errors?
Sep 30 11:41:27 notadell kernel: snd-bt-sco: playback_trigger 0
Sep 30 11:41:27 notadell kernel: snd-bt-sco: setting playback to NULL
Sep 30 11:41:27 notadell kernel: snd-bt-sco: Disposing of previous
socket count 3
Sep 30 11:41:27 notadell kernel: snd-bt-sco: file_count is 1 (expected 3)=

Sep 30 11:41:27 notadell kernel: hci_scodata_packet: hci0 SCO packet for
unknown connection handle 1
Message: fmt 5, channels: 1
Sep 30 11:41:27 notadell kernel: snd-bt-sco: playback_open
Sep 30 11:41:27 notadell kernel: snd-bt-sco: prepare ok bps: 16000 size:
8000 count: 800
Sep 30 11:41:27 notadell kernel: snd-bt-sco: prepare ok bps: 16000 size:
8000 count: 800
Sep 30 11:41:27 notadell kernel: snd-bt-sco: playback_trigger 1
Sep 30 11:41:27 notadell kernel: snd-bt-sco: setting playback to bspcm
Sep 30 11:41:27 notadell kernel: snd-bt-sco: Shift problem detected!
Fixing to 1.
Sep 30 11:41:27 notadell kernel: snd-bt-sco: Shift problem detected!
Fixing to 0.
Sep 30 11:41:27 notadell kernel: snd-bt-sco: Shift problem detected!
Fixing to 1.
Sep 30 11:41:27 notadell kernel: snd-bt-sco: Shift problem detected!
Fixing to 0.
Sep 30 11:41:27 notadell kernel: snd-bt-sco: Shift problem detected!
Fixing to 1.
Sep 30 11:41:27 notadell kernel: snd-bt-sco: Shift problem detected!
Fixing to 0.
Sep 30 11:41:27 notadell kernel: snd-bt-sco: Shift problem detected!
Fixing to 1.
Sep 30 11:41:27 notadell kernel: snd-bt-sco: Shift problem detected!
Fixing to 0.
Sep 30 11:41:27 notadell kernel: snd-bt-sco: Shift problem detected!
Fixing to 1.
Sep 30 11:41:27 notadell kernel: snd-bt-sco: Shift problem detected!
Fixing to 0.

xmms then seems to freeze

Any suggestions?


--------------enig6BF059C5C9CC0DA50AD60B79
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFHpCH6Xt+NmMbdFARAlODAJwORIdNUIUkZU28M/YHZZOlnbeOQQCfVgyO
YVKx/mEjsyxCD6cy5hPFGPw=
=mIy6
-----END PGP SIGNATURE-----

--------------enig6BF059C5C9CC0DA50AD60B79--


--===============0823577196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0823577196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0823577196==--
