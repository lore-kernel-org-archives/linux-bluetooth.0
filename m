Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 29 Nov 2006 13:11:24 +0100 (CET)
From: Peter Wippich <pewi@gw-instruments.de>
To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001201c712e9$3ae9cfb0$3978f052@kayleigh>
Message-ID: <Pine.LNX.4.63.0611291259350.1191@redbean.intranet.gw-instruments.de>
References: <002901c710a8$0eab3580$0100a8c0@kayleigh>
	<1164536005.25914.8.camel@aeonflux.holtmann.net>
	<002801c7125f$7197b7f0$0100a8c0@kayleigh>
	<Pine.LNX.4.63.0611281118300.29749@redbean.intranet.gw-instruments.de>
	<000701c712dc$8e44ff20$3978f052@kayleigh>
	<Pine.LNX.4.63.0611281215240.29749@redbean.intranet.gw-instruments.de>
	<001201c712e9$3ae9cfb0$3978f052@kayleigh>
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


Salut Oli,

> > For a server application like yours I would suggest to use the role
> > switch feature in a more relaxed way. So, once a connection comes in try
> > to do a role switch. If it succeed it is fine and you're able to accept an
> > additional connection. If it fails you're out of resources but at least
> > can service the current connection.
> >
> > However, if I understand it right you can not set this behaviour in
> > hcid.conf. You have to implement it in your application.
> 
> What do you mean by implementing this in my application ? Is it
> possible to manually deal with this in my server application ? Would you
> have a location with examples ?
> 
Actualy, the only sample I'm aware of for such things is hcid. I've not 
checked how it handles the case when lm master is set and the remote 
device rejects the role switch. From the documentation I assume it will 
cancel the connection, but this may be wrong. 
Marcel ?? 
If it just ignores a rejected role switch and keeps the connection you 
have the behaviour I outlined above. 
If it cancel the connection may be the easiest way is to modify hcid. 

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
