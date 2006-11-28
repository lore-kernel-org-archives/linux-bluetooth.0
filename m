Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 28 Nov 2006 11:24:41 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002801c7125f$7197b7f0$0100a8c0@kayleigh>
Message-ID: <Pine.LNX.4.63.0611281118300.29749@redbean.intranet.gw-instruments.de>
References: <002901c710a8$0eab3580$0100a8c0@kayleigh>
	<1164536005.25914.8.camel@aeonflux.holtmann.net>
	<002801c7125f$7197b7f0$0100a8c0@kayleigh>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Master / Slave question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Hi Olivier,

>> lots of stuff deleted.....

your problem is hardware / general Bluetooth / LM related. 

Earlier BT implementations (and may be even actual) support only one slave 
connection at a time. This is why the master slave switch was introduced !
(I think with BT 1.0B). 
Newer implementations MAY support up to two slave connections or at least 
one Master and one Slave connection. 

What hardware are you using ?

Ciao, 

Peter 



|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
