Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <000701c712dc$8e44ff20$3978f052@kayleigh>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <002901c710a8$0eab3580$0100a8c0@kayleigh>
	<1164536005.25914.8.camel@aeonflux.holtmann.net>
	<002801c7125f$7197b7f0$0100a8c0@kayleigh>
	<Pine.LNX.4.63.0611281118300.29749@redbean.intranet.gw-instruments.de>
Date: Tue, 28 Nov 2006 12:01:29 +0100
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Master / Slave question
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi Peter,

Many many many thanks for your answer, I was supposing
a low level issue indeed !

I am actually using a generic Bluetooth key, the kind of
ones you can plug everywhere and which are recognised
by Microsoft Drivers. It is a HCI type 1 (Bluetooth 1.1).

So basically ... only 1 slave connection at a time for
each bluetooth adaptor ? How many bluetooth adaptors
do you think I can deal with under BlueZ in the case I
definetely want to be able to deal with concurrent incoming
connections ?

Even if I buy bluetooth 2.0 adaptors, I suppose the problem
will be the same, assuming my mobile phones are anyway
always on a lower bluetooth version ?

Many thanks again,
Oli

----- Original Message ----- 
From: "Peter Wippich" <pewi@gw-instruments.de>
To: "Olivier Le Pogam" <olepogam@free.fr>; "BlueZ development" 
<bluez-devel@lists.sourceforge.net>
Sent: Tuesday, November 28, 2006 11:24 AM
Subject: Re: [Bluez-devel] Master / Slave question


>
> Hi Olivier,
>
>>> lots of stuff deleted.....
>
> your problem is hardware / general Bluetooth / LM related.
>
> Earlier BT implementations (and may be even actual) support only one slave
> connection at a time. This is why the master slave switch was introduced !
> (I think with BT 1.0B).
> Newer implementations MAY support up to two slave connections or at least
> one Master and one Slave connection.
>
> What hardware are you using ?
>
> Ciao,
>
> Peter
>
>
>
> |       Peter Wippich                   Voice: +49 30 46776411          |
> |       G&W Instruments GmbH            fax:   +49 30 46776419          |
> |       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
> |       D-13355 Berlin  / Germany                                       |
>
>
>
>
> -- 
> No virus found in this incoming message.
> Checked by AVG Free Edition.
> Version: 7.1.409 / Virus Database: 268.14.19/555 - Release Date: 
> 27/11/2006
>
> 



-- 
No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.1.409 / Virus Database: 268.14.19/555 - Release Date: 27/11/2006


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
