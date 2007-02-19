Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 19 Feb 2007 07:47:10 +0100
Message-ID: <77958D3F4480D34A99F9D8759B56D550453A85@deblnrd04msx.sielearn.net>
From: "Hofmann, Marco" <marco.hofmann@technik-akademie.de>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Bluetooth passkey and encryption
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


Dear members,

For a project in my school I need to connect a Debian Linux Server via
Bluetooth to a serial Bluetooth dongle. It is important that a
connection can be established using only the command line. I use the
bluez-utils 3.7 on a debian unstable (kernel 2.6.17).
Without enabling any security functions the connection can be
established without a problem. As soon as encryption and PIN are enabled
a connection can not be established. I have checked the settings in the
hcid.conf according to various How-Tos to enable encryption and PIN. I
always receive an Input/Output error.
Doing the pairing with a graphical tool like kbluetoothd is possible
with encryption and PIN. So it is possible and the devices work. I am
just frustrated that I am obviously missing something somewhere. If
anyone could help that would be great.

Sincerely,
Marco. 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
