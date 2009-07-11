Return-Path: <cyrus@holtmann.org>
Subject: DUN failure to Palm Centro hotsync
From: Keith Packard <keithp@keithp.com>
To: linux-bluetooth@vger.kernel.org
Cc: keithp@keithp.com, "Holtmann, Marcel" <marcel.holtmann@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/gfYcosCDWnV30/GFqvb"
Date: Fri, 10 Jul 2009 17:56:00 -0700
Message-Id: <1247273760.26757.9.camel@aiko.keithp.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-/gfYcosCDWnV30/GFqvb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm no longer able to connect my Palm Centro to my linux box using
2.6.31-rc2. It times out, and then I found the following in dmesg:

[ 5327.779697] PM: Adding info for No Bus:hci0:11
[ 5328.240131]
[ 5328.240135] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 5328.240142] [ INFO: inconsistent lock state ]
[ 5328.240149] 2.6.31-rc2-64 #36
[ 5328.240154] ---------------------------------
[ 5328.240160] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
[ 5328.240169] krfcommd/3613 [HC0[0]:SC0[0]:HE1:SE1] takes:
[ 5328.240175]  (slock-AF_BLUETOOTH){+.?...}, at: [<ffffffffa0321aee>] rfco=
mm_sk_state_change+0x2d/0xeb [rfcomm]
[ 5328.240203] {IN-SOFTIRQ-W} state was registered at:
[ 5328.240209]   [<ffffffff810625af>] __lock_acquire+0x6a6/0x15bc
[ 5328.240224]   [<ffffffff8106357e>] lock_acquire+0xb9/0xdd
[ 5328.240234]   [<ffffffff812a2f6c>] _spin_lock+0x2c/0x38
[ 5328.240247]   [<ffffffffa0316b27>] l2cap_conn_start+0x47/0x248 [l2cap]
[ 5328.240263]   [<ffffffffa0318098>] l2cap_recv_frame+0xdf3/0x113e [l2cap]
[ 5328.240277]   [<ffffffffa03184ae>] l2cap_recv_acldata+0xcb/0x241 [l2cap]
[ 5328.240292]   [<ffffffffa02601a2>] hci_rx_task+0x147/0x236 [bluetooth]
[ 5328.240315]   [<ffffffff81041ef2>] tasklet_action+0x80/0xdb
[ 5328.240326]   [<ffffffff8104275d>] __do_softirq+0xdb/0x1b3
[ 5328.240336]   [<ffffffff8100c0dc>] call_softirq+0x1c/0x34
[ 5328.240347]   [<ffffffff8100d4e9>] do_softirq+0x39/0x8a
[ 5328.240356]   [<ffffffff810421bb>] irq_exit+0x4e/0x88
[ 5328.240365]   [<ffffffff8100cbe5>] do_IRQ+0xa3/0xba
[ 5328.240374]   [<ffffffff8100b8d3>] ret_from_intr+0x0/0xf
[ 5328.240386]   [<ffffffffffffffff>] 0xffffffffffffffff
[ 5328.240398] irq event stamp: 311
[ 5328.240403] hardirqs last  enabled at (311): [<ffffffff8104250a>] local_=
bh_enable_ip+0xc8/0xcd
[ 5328.240415] hardirqs last disabled at (309): [<ffffffff810427f5>] __do_s=
oftirq+0x173/0x1b3
[ 5328.240425] softirqs last  enabled at (310): [<ffffffff81042826>] __do_s=
oftirq+0x1a4/0x1b3
[ 5328.240436] softirqs last disabled at (291): [<ffffffff8100c0dc>] call_s=
oftirq+0x1c/0x34
[ 5328.240446]
[ 5328.240448] other info that might help us debug this:
[ 5328.240455] 2 locks held by krfcommd/3613:
[ 5328.240460]  #0:  (rfcomm_mutex){+.+.+.}, at: [<ffffffffa031f0bc>] rfcom=
m_run+0x19b/0x1425 [rfcomm]
[ 5328.240485]  #1:  (&d->lock){+.+...}, at: [<ffffffffa031ede8>] rfcomm_dl=
c_accept+0x42/0xa9 [rfcomm]
[ 5328.240509]
[ 5328.240519] Pid: 3613, comm: krfcommd Not tainted 2.6.31-rc2-64 #36
[ 5328.240524] Call Trace:
[ 5328.240536]  [<ffffffff81060aa1>] print_usage_bug+0x1af/0x1c0
[ 5328.240547]  [<ffffffff810616e3>] ? check_usage_backwards+0x0/0x97
[ 5328.240557]  [<ffffffff81060d9d>] mark_lock+0x2eb/0x51a
[ 5328.240567]  [<ffffffff81062639>] __lock_acquire+0x730/0x15bc
[ 5328.240578]  [<ffffffff8106357e>] lock_acquire+0xb9/0xdd
[ 5328.240595]  [<ffffffffa0321aee>] ? rfcomm_sk_state_change+0x2d/0xeb [rf=
comm]
[ 5328.240606]  [<ffffffff812a2f6c>] _spin_lock+0x2c/0x38
[ 5328.240623]  [<ffffffffa0321aee>] ? rfcomm_sk_state_change+0x2d/0xeb [rf=
comm]
[ 5328.240641]  [<ffffffffa0321aee>] rfcomm_sk_state_change+0x2d/0xeb [rfco=
mm]
[ 5328.240658]  [<ffffffffa031ee01>] rfcomm_dlc_accept+0x5b/0xa9 [rfcomm]
[ 5328.240674]  [<ffffffffa031eefb>] rfcomm_check_accept+0xac/0xd2 [rfcomm]
[ 5328.240691]  [<ffffffffa031f46f>] rfcomm_run+0x54e/0x1425 [rfcomm]
[ 5328.240701]  [<ffffffff810612d2>] ? trace_hardirqs_on+0xd/0xf
[ 5328.240711]  [<ffffffff812a2e0c>] ? _spin_unlock_irq+0x2b/0x30
[ 5328.240729]  [<ffffffffa031ef21>] ? rfcomm_run+0x0/0x1425 [rfcomm]
[ 5328.240746]  [<ffffffffa031ef21>] ? rfcomm_run+0x0/0x1425 [rfcomm]
[ 5328.240758]  [<ffffffff81052656>] kthread+0x88/0x90
[ 5328.240768]  [<ffffffff8100bfda>] child_rip+0xa/0x20
[ 5328.240779]  [<ffffffff8100b97c>] ? restore_args+0x0/0x30
[ 5328.240789]  [<ffffffff810525ce>] ? kthread+0x0/0x90
[ 5328.240797]  [<ffffffff8100bfd0>] ? child_rip+0x0/0x20

Let me know what other information I can provide.

--=20
keith.packard@intel.com

--=-/gfYcosCDWnV30/GFqvb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQBKV+MgQp8BWwlsTdMRAveAAKDGbJXI8rRLllIQbQouCppo7ajvsQCg6NOk
QTce8U8c7ofjBRsXXbb3x9U=
=a1c6
-----END PGP SIGNATURE-----

--=-/gfYcosCDWnV30/GFqvb--

