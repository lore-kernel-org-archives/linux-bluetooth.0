Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42381799.4020404@sinister.cz>
From: Trekie <trekie@sinister.cz>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] MS-6871 isn't working
References: <42381514.3070701@sinister.cz> <1110971745.9818.131.camel@pegasus>
In-Reply-To: <1110971745.9818.131.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 16 Mar 2005 12:25:13 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Marcel,

Marcel Holtmann wrote:
| Hi David,
|
|
|>I can't get MS-6871 BT device (USB hub with bluetooth) working.
|>hciconfig shows:
|>
|>hci0:   Type: USB
|>~        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
|>~        DOWN
|>~        RX bytes:0 acl:0 sco:0 events:0 errors:0
|>~        TX bytes:0 acl:0 sco:0 commands:0 errors:0
|>
|>and hciconfig hci0 up:
|>
|>Can't init device hci0. Input/output error(5)
|>
|>with this in syslog:
|>
|>hci_usb_intr_rx_submit: hci0 intr rx submit failed urb c17e1514 err -28
|>
|>Do anyone know what should I do?
|
|
| is it directly connected to the USB root hub? We saw problems if another
| USB hub is involved.

Yes, it is connected directly to my notebook. I tried to plug it in
another port, but the result is same.


Regards

David
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCOBeZMcA3II2AlaIRAt6EAKCj34AdQG2LG7ju2b/pTqiL5qbDWACeI/gk
brC9/eSakijCEkMk5yPcw3Y=
=k+bj
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
