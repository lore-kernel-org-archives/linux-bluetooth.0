Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Thomas Green <TGreen2@Sorenson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: More keyboard issues
Date: Sat, 27 Jan 2018 00:20:21 +0000
Message-ID: <C2BC44D770753C45AAAC42695FB5BE02012572F769@SLC-EXMB01.CORP.SRELAY.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I'm testing more keyboards with 5.48 and have found issues with two other k=
eyboards.  In this case the problem is during pairing.  The two keyboards i=
n question are the SIIG AAZ2448 and the ANKER A7221.   The current issue is=
 that during pairing of these two keyboards we are given a PIN code display=
, so I enter it on the keyboard and nothing happens, and eventually the pai=
ring times out. =20

[bluetooth]# pair 20:73:03:A4:18:4D
Attempting to pair with 20:73:03:A4:18:4D
[CHG] Device 20:73:03:A4:18:4D Connected: yes
[agent] PIN code: 851841
[Anker A7721]#
[  282.174342] WARNING: at net/bluetooth/hci_conn.c:322 hci_conn_timeout+0x=
44/0x198()
Failed to pair: org.bluez.Error.AuthenticationTimeout
[Anker A7721]#

This happens about 95% of the time.  The other 5% the pairing completes and=
 everything works fine.

I could attach btmon output and output from running bluetoothd -d -n, but n=
othing interesting happens from the time the pincode is displayed and the t=
imeout occurs.

Where do I begin to look for why the pincode isn't being transmitted back f=
rom the keyboards?  Why is it inconsistent?

As an interesting side note the Apple keyboard that I'm having the driver l=
oading trouble uses the same pairing mechanism and it works well every time=
. (and all of these keyboards worked fine in 4.101)

Thanks in advance
Tom
