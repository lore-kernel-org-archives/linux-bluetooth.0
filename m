Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 19 Feb 2007 10:31:13 +0100
Message-ID: <77958D3F4480D34A99F9D8759B56D550453ACB@deblnrd04msx.sielearn.net>
In-reply-to: <1171874475.26567.5.camel@violet>
From: "Hofmann, Marco" <marco.hofmann@technik-akademie.de>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth passkey and encryption
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel

I checked with hcidump and received the following message:

> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:11:B1:A1:68:2B
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:11:B1:A1:68:2B
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x06 bdaddr 00:11:B1:A1:68:2B
    Error: PIN or Key Missing
> HCI Event: Connect Complete (0x03) plen 11
    status 0x06 handle 7 bdaddr 00:11:B1:A1:68:2B type ACL encrypt 0x00
    Error: PIN or Key Missing 

I set a key under the option passkey in the hcid.conf. So if that key is
not used, where would I have to set this key?

Sincerely,
Marco.

-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Monday, February 19, 2007 9:41 AM
To: BlueZ users
Subject: Re: [Bluez-users] Bluetooth passkey and encryption

Hi Marco,

> For a project in my school I need to connect a Debian Linux Server via
> Bluetooth to a serial Bluetooth dongle. It is important that a
> connection can be established using only the command line. I use the
> bluez-utils 3.7 on a debian unstable (kernel 2.6.17).
> Without enabling any security functions the connection can be
> established without a problem. As soon as encryption and PIN are
enabled
> a connection can not be established. I have checked the settings in
the
> hcid.conf according to various How-Tos to enable encryption and PIN. I
> always receive an Input/Output error.
> Doing the pairing with a graphical tool like kbluetoothd is possible
> with encryption and PIN. So it is possible and the devices work. I am
> just frustrated that I am obviously missing something somewhere. If
> anyone could help that would be great.

check with "hcidump -X -V" and look at the syslog for errors from hcid.

Regards

Marcel



------------------------------------------------------------------------
-
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share
your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
