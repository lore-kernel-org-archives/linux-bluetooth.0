Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d23110170607211624r5b3c915av2acd3139388d7d0@mail.gmail.com>
Date: Fri, 21 Jul 2006 20:24:28 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1153249459.4161.3.camel@localhost.localdomain>
MIME-Version: 1.0
References: <1153205453.7078.12.camel@pc044.coreteam.oslo.opera.com>
	<1153219342.4639.5.camel@localhost>
	<1153249459.4161.3.camel@localhost.localdomain>
Subject: Re: [Bluez-users] Is the CNET CBD-220 bluetooth adapter supported?
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

Hi Per,

> OK. So maybe the Epox BT-DG07A+ is a better choice then? I'm not sure it
> uses bluecore4, but some googling suggests that. Am I correct?

I'm not sure about this one, but I do know that an Epox BT-DG06+ has a
CSR BlueCore4 chip (it's ROM and not External, though).

# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:04:61:85:CA:73 ACL MTU: 384:8 SCO MTU: 64:8
        HCI 19.2
        Chip version: BlueCore4-ROM
        Max key size: 128 bit
        SCO mapping:  HCI

Regards,

-- Ulisses

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
