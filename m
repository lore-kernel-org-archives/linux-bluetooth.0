Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <01a901c4df7a$666d4da0$6401000a@zool>
From: "Steffen Larsen" <zool@zool.dk>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
References: <00c901c4df6a$f8c11f70$6401000a@zool> <1102764489.19086.15.camel@pegasus>  <016d01c4df70$a8e297d0$6401000a@zool> <1102767035.19086.18.camel@pegasus>
Subject: Re: [Bluez-devel] piconet..
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 11 Dec 2004 13:10:26 +0100

Hi Marcel,

> > > > PS. I belive that the PSM in the L2CAP layer can serve more than one
> > > > client or am I totally wrong? otherwise I should update the PSM
> > > > everytime a new client connect..
> > >
> > > It can also serve multiple PSM on the same ACL link.
> >
> > Ok.. how do I do that?
> >

> you call listen() and then accept() for every incoming connection. It is
> the same as for TCP/IP.

Ok.. I am already doing this in my parent thread. So the problem must be
somewhere else.
I'll try to do the hciconfig -a in a brief moment and sent the output to the
list... :-)

/Steffen Larsen



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
