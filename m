Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: paivakil@gmail.com (Mahesh T. Pai)
Date: Wed, 31 Jan 2007 22:47:59 +0530
Message-ID: <87mz3zi08o.fsf@nandini.home>
References: <87tzy89q6p.fsf@nandini.home>
	<a481fbf0701310730n136e6bd0x2371ff37272e098f@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] 'hcitool scan' failing
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

"Raymond Ingles" <sorceror171@gmail.com> writes:

> On 1/30/07, Mahesh T. Pai <paivakil@gmail.com> wrote:

> Bus 001 Device 024: ID 1131:1001 Integrated System Solution Corp.
> KY-BT100 Bluetooth Adapter
>
> hci0:   Type: USB
>         BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 64:10
>
>  Note my BD address is also "11:11:11:11:11:11". These cheap dongles
> appear to all have the same BD address. That will cause problems if
> two of them are in range of each other; it's similar to having to

Well, I have verified that the mac addreses are different. The dongles
are from different vendors.

And, some time back, I had got `hcitool scan' to detect the dongles,
but after a reboot, they no longer get each other. The only thing I
remember doing was to reconfigure libbluetooth2.

And I cannot find the bnep0 nr rfcomm0 interfaces, though the relevant
modules are loaded in the kernel.

-- 
 Mahesh T. Pai <<>> http://paivakil.blogspot.com/
REVOLUTION, n. An abrupt change in the form of misgovernment.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
