Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 28 Nov 2006 12:34:30 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000701c712dc$8e44ff20$3978f052@kayleigh>
Message-ID: <Pine.LNX.4.63.0611281215240.29749@redbean.intranet.gw-instruments.de>
References: <002901c710a8$0eab3580$0100a8c0@kayleigh>
	<1164536005.25914.8.camel@aeonflux.holtmann.net>
	<002801c7125f$7197b7f0$0100a8c0@kayleigh>
	<Pine.LNX.4.63.0611281118300.29749@redbean.intranet.gw-instruments.de>
	<000701c712dc$8e44ff20$3978f052@kayleigh>
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


Hi Oli, 

> I am actually using a generic Bluetooth key, the kind of
> ones you can plug everywhere and which are recognised
> by Microsoft Drivers. It is a HCI type 1 (Bluetooth 1.1).
You should try to get a newer BT 2.0 device. If I remember right the newer 
CSR devices support two slaves at a time (at least they support one slave 
and one Master connection simultaniously). 
 
> So basically ... only 1 slave connection at a time for
> each bluetooth adaptor ? How many bluetooth adaptors
> do you think I can deal with under BlueZ in the case I
> definetely want to be able to deal with concurrent incoming
> connections ?
There is no real hard limit for the number of adapters you can use with 
BlueZ. Link key managment may become a little bit confusing (on the phone 
side) because the Link key is bound to the BT address of the adaptor. So 
if a phone connects to, say adaptor 1 the first time and then to adaptor 2 
the second time it must pair again 8if your application needs security at 
all). 

> Even if I buy bluetooth 2.0 adaptors, I suppose the problem
> will be the same, assuming my mobile phones are anyway
> always on a lower bluetooth version ?

I think most phones should, in general, support Master/Slave switch. 
However, even when th Bluetooth implementation on the phone supports it, 
it is possible that a role switch request is rejected on the profile layer 
(depends on implementation). 
For a server application like yours I would suggest to use the role 
switch feature in a more relaxed way. So, once a connection comes in try 
to do a role switch. If it succeed it is fine and you're able to accept an 
additional connection. If it fails you're out of resources but at least 
can service the current connection. 

However, if I understand it right you can not set this behaviour in 
hcid.conf. You have to implement it in your application. 

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
