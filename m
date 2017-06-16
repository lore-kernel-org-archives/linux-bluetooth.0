Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Troy Lanes <tlanes@geoforce.com>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_EB431F42-1E75-4C76-8C27-0A1ED6048906";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: [PATCH] Bluetooth: hci: Fix connect issue to BLE peripherals with
 long broadcast intervals
Message-Id: <EC9EA3A6-B0F1-4330-B681-B920E65104F0@geoforce.com>
Date: Fri, 16 Jun 2017 08:56:45 -0600
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_EB431F42-1E75-4C76-8C27-0A1ED6048906
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

The BLE spec allows broadcast intervals up to 10.24 seconds.  Setting =
HCI_LE_AUTOCONN_TIMEOUT to the previous 2 second value results in the =
inability to connect to peripherals with longer than 2 second broadcast =
intervals.

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fe98f0a5bef0..b25fbbfc748d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -273,7 +273,7 @@ enum {
 #define HCI_AUTO_OFF_TIMEOUT   msecs_to_jiffies(2000)  /* 2 seconds */
 #define HCI_POWER_OFF_TIMEOUT  msecs_to_jiffies(5000)  /* 5 seconds */
 #define HCI_LE_CONN_TIMEOUT    msecs_to_jiffies(20000) /* 20 seconds */
-#define HCI_LE_AUTOCONN_TIMEOUT        msecs_to_jiffies(2000)  /* 2 =
seconds */
+#define HCI_LE_AUTOCONN_TIMEOUT        msecs_to_jiffies(20000) /* 20 =
seconds */

 /* HCI data types */
 #define HCI_COMMAND_PKT                0x01


Troy E. Lanes
tlanes@geoforce.com
troy@af7hg.com



--Apple-Mail=_EB431F42-1E75-4C76-8C27-0A1ED6048906
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJZQ/GuAAoJEKpWdPJXKKkd/84P/3SM3R6pmQrzrNYSqI3qMphR
DOQNLomotbF69OrQrcosVT16b9eUtr0CL1+mwlgjEyjWtL/lEFKRnvykpYYchMAI
itNjNSA9HQBcr6y24w9TdWPd8ppb7b6fIEdhCOb2AB8JK1VItSxC6/YLLwuk/m6g
AiZco0HktR1Jn67qdNtSbzPQjkJhwK7HbioVJ1/wGYa/DsnMy0MHPrF6MZg4ZyTZ
15qTbcIC8u5gHP2aGBqhB7jWkBpbKCeAWqZAkvVtTF1PkvZcQrgKU1QpB+nJYUl6
bHfe8kRIPi3fWhjxXNfjW+ChGR+q/h2Rpxj+nd7njBonCZrVg9cQn2isf+DMtC06
zFmwfrzO53ZPT7oMnM8f7BTBB3eVmeipXhh34ltNrcKkSo9rsHsKeasNHPsNdsW/
tk45zzOfG1CG1OgPcT/TTH1teoA7XgWvDk05o+WrCYsuP/j55dPuEKxOnzJF5fx+
n47nl4N/80YDyvc4JNs1N7gFLio5R8VgDMBxKtoboJUTmsEDhVh5ueVR7U76t3rm
5G2C4LVNGDa2t5v3xjDr+YQGdjHPy9fwhB/TiJOWvOpCQ0YaRJ3KVtXDjvm+kb2j
U83mddF/U5YXK6zfI0u8/d1NLTdbZ8fp90ekSWBdaXmUZKStP53zjsvC5qGxZU9y
MeQrd5bU8aGImEbBJA9I
=y0cH
-----END PGP SIGNATURE-----

--Apple-Mail=_EB431F42-1E75-4C76-8C27-0A1ED6048906--
