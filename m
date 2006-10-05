Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Delgado, Monica (ERZIA)" <monica.delgado@erzia.com>
To: <bluez-users@lists.sourceforge.net>
Date: Thu, 5 Oct 2006 18:23:20 +0200
MIME-Version: 1.0
In-Reply-To: <mailman.52831.1160008210.16222.bluez-users@lists.sourceforge.net>
Message-Id: <20061005162110.A9D22209C98@mrelay2.st2.lyceu.net>
Subject: Re: [Bluez-users] PAND Network
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,
 =

 > I=92m trying to configure a PAN network and I have a problem in this
 > specific scenario:
 > =

 >             -I have one BT device  (BT1) connected to a linux PC,
 > which is configured as master
 > =

 >             -I have two BT devices more connected to another Linux PC,
 > in different USB ports ( BT2, BT3).
 > =

 > When I create a pan connection between BT2 and master (BT1) everything
 > works ok, but when I try to create a second connection to the same
 > master from the BT device BT3, I get this error
 > =

 >             =93File exists (17)=94
 > =

 > I have tried to configure first BT3 and second BT2 and I have got the
 > same error with BT2, which means that only the first pan connection is
 > configured without problems. =

 > =

 > Is it possible to create two simultaneous PAN connections from two BT
 > devices connected to the same PC? Have anyone of you ever done it?
 =

 >>>>>> yes, but you must sure to use "pand -i hciX" to use the correct   =

 >>>>>> adapter for the BNEP connection.




Thank you very much for your answer. I'm configuring the PAN connection
using the "pand" function as you say "pand -i hciX" , but I still get the
same error. In some message posted in this forum (30-09-2002) I have read
this:


"You cannot have more than one BNEP/PAN
 connection to the _same_ bd address. In other words this
          bd:ad:dr:1 --> bd:ad:dr:2 <-- bd:ad:dr:3
 is not allowed _if_ bd:ad:dr:1 and bd:ad:dr:3 are on the same machine "


This is exactly my case, I have the 2 slaves in the same machine, and they
both try to connect to the same master device. As this message is quite old,
I don't know if this is real nowadays. I'm using Fedora Core 4 in both PC's.

Thank you and best regards,   =



M=F3nica Delgado =



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
