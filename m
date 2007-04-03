Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 3 Apr 2007 23:46:23 +0100
Message-ID: <0DD4EA5DCF754A409C4E182C758C37F33DE1C2@tigris.empics.co.uk>
References: <0DD4EA5DCF754A409C4E182C758C37F33DE1BF@tigris.empics.co.uk><e1effdeb0704031005l56b76930id68bb98c1379e659@mail.gmail.com>
	<46128C19.3070403@xmission.com>
From: "Steve Drew" <steve.drew@paphotos.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth parings on dual-boot
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

Hi brad,

I've found a workaround, I installed bdaddr from the bluez-utils source
(it wasn't included in the SuSE rpm) which you can use to change the MAC
address of the bluetooth device:

 ./bdaddr -r -t -i hci0 NE:WM:AC:AD:RE:SS

Putting it into the init script seems to work a treat.

Cheers

steve

  

-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Brad
Midgley
Sent: 03 April 2007 18:17
To: BlueZ users
Subject: Re: [Bluez-users] Bluetooth parings on dual-boot

hey Claudio!

> This problem happens because the hcid returns the stored link key.
> It is basically the same problem that I reported in the item 6 of 
> BlueZ TODO list:
> http://wiki.bluez.org/wiki/TODO
> 
> Just remove the stored link key and pair it again.

is there a workaround for this problem so the pairing doesn't have to be
redone? like changing the adapter to use an alternate bdaddr inside
linux so the phone thinks it's a different device?

brad

------------------------------------------------------------------------
-
Take Surveys. Earn Cash. Influence the Future of IT Join
SourceForge.net's Techsay panel and you'll get the chance to share your
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
