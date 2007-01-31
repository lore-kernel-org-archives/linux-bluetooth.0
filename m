Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <a481fbf0701310730n136e6bd0x2371ff37272e098f@mail.gmail.com>
Date: Wed, 31 Jan 2007 10:30:15 -0500
From: "Raymond Ingles" <sorceror171@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <87tzy89q6p.fsf@nandini.home>
MIME-Version: 1.0
References: <87tzy89q6p.fsf@nandini.home>
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

On 1/30/07, Mahesh T. Pai <paivakil@gmail.com> wrote:
>
> I  am trying to  set up  bluetooth networking  on two  systems running
> debian  unstable. One  is an  i386 and  other is  running  amd64.  The
> OS/software is otherwise identical for both systems.

> Bus 001 Device 002: ID 1131:1001 Integrated System Solution Corp. KY-BT100 Bluetooth Adapter
[...]
> Out put of hciconfig -a is:-
>
> hci0:   Type: USB
>         BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 48:10

 Here's the corresponding output on my system:

Bus 001 Device 024: ID 1131:1001 Integrated System Solution Corp.
KY-BT100 Bluetooth Adapter

hci0:   Type: USB
        BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 64:10

 Note my BD address is also "11:11:11:11:11:11". These cheap dongles
appear to all have the same BD address. That will cause problems if
two of them are in range of each other; it's similar to having to
Ethernet cards on the same network with the same MAC address. This is
a violation of the Bluetooth spec - those IDs are supposed to be
unique. I suppose you get what you pay for.

 If the BD address is the same for both machines, I don't think it's
going to be possible to get them to talk to each other. They should be
able to talk to other devices with other, unique BD addresses, but
they will get seriously confused trying to communicate with each
other.

 Some Ethernet cards allow you to change their MAC address; anyone
know of a way to change a dongle's BD address?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
