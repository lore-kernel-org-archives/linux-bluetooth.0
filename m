Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Fernando Unzu <fernando@bluexare.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Fri, 18 May 2007 12:19:55 +0200
References: <200705161235.51289.fernando@bluexare.org>
	<1179394491.14671.37.camel@panic>
	<1ab01fb50705170355t727d3b60s818d3a643305ad8b@mail.gmail.com>
In-Reply-To: <1ab01fb50705170355t727d3b60s818d3a643305ad8b@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200705181219.55212.fernando@bluexare.org>
Subject: Re: [Bluez-devel] How I can select between 2 bluetooth devices?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I think all you said to me will be very usefull.

Thank you very much, Colin, Vikas.

Soon I implement the new solution you propose.

Thanks a lot.


El Jueves, 17 de Mayo de 2007 12:55, Vikas Sinha escribi=F3:
> I think Collin said is right ,
> See for scanning u need to have hci layer api while for file transfer u
> need OBEX.
> for scanning bind device before calling scan function.
> hci_inquiry(iDevId, iSECOND, iMAXDEV, NULL, &inqinfo, IREQ_CACHE_FLUSH))
> This DevId is device Id(file descriptor).
>
> while for File sending u can call
> handle =3D __obex_connect(devid, addr, timeout, &err);
> here again devid is FD .
>
> so by this u can differentiate 2 dongles.
>
> On 5/17/07, Collin R. Mulliner <collin@betaversion.net> wrote:
> > you can do this in a very simple way, just do the connect by hand (bind
> > to a specific bluetooth device before connect) then pass the file
> > descriptor to the OBEX library. OBEX will run in normal FD (file
> > descriptor) mode then. For this to work you also need to do the sdp
> > lookup yourself, but this is easy.
> >
> > Collin
> >
> > On Thu, 2007-05-17 at 10:18 +0200, Fernando Unzu wrote:
> > > Hi Vikas,
> > > Yes, this is I want to achieve.
> > >
> > > I don't understand very well the code, but I uses OBEX_GetUserData,
> > > OBEX_HandleInput, OBEX_CancelRequest, OBEX_ObjectNew, OBEX_Delete,
> > > OBEX_TransportConnect and more like these, and in all of them I use a
> >
> > Handle,
> >
> > > created by OBEX_Init (OBEX_TRANS_BLUETOOTH, obex_event, 0).
> > >
> > > So I Think this is the way..., but I don't know if it is, or how to
> >
> > do...
> >
> > > in other functions I use hci_create_connection to create the handle, I
> >
> > think.
> >
> > > How you can see, I don't understand good the code.
> > >
> > > How I can separate the two dongles to doing separated functions?
> > >
> > > Thanks a lot,
> > > Fernando
> > >
> > > El Jueves, 17 de Mayo de 2007 07:05, Vikas Sinha escribi=F3:
> > > > Hi, Fernando
> > > >
> > > > If i am not wrong u have 2 Dongles and u want to use one for scan a=
nd
> >
> > other
> >
> > > > for file send... ??
> > > >
> > > > am I right ...
> > > >
> > > > On 5/16/07, Fernando Unzu <fernando@bluexare.org> wrote:
> > > > > Hello,
> > > > > I'm working in an application that scans for bluetooth devices and
> >
> > send
> >
> > > > > some
> > > > > content to they...
> > > > >
> > > > > Due to several issues, I need to separate the action scan and send
> > > > > between two
> > > > > devices...
> > > > >
> > > > > I have the code for doing this in one bluetooth device, and I don=
't
> >
> > know
> >
> > > > > very
> > > > > well how it works, but I have read it some times...
> > > > >
> > > > > But I don't find where i can select which bluetooth device I want
> > > > > to
> >
> > use
> >
> > > > > to
> > > > > doing one method or other...
> > > > >
> > > > > I have seen that "OBEX_Init" creates a handle to manage the
> >
> > conection...,
> >
> > > > > but
> > > > > it can be select which bluetooth device select for doing this
> >
> > handle?
> >
> > > > > Thank you very much and I hope somebody understand me.
> > > > >
> > > > > Fernando
> >
> > -----------------------------------------------------------------------=
--
> >
> > > > > This SF.net email is sponsored by DB2 Express
> > > > > Download DB2 Express C - the FREE version of DB2 express and take
> > > > > control of your XML. No limits. Just data. Click to get it now.
> > > > > http://sourceforge.net/powerbar/db2/
> > > > > _______________________________________________
> > > > > Bluez-devel mailing list
> > > > > Bluez-devel@lists.sourceforge.net
> > > > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> > -----------------------------------------------------------------------=
--
> >
> > > This SF.net email is sponsored by DB2 Express
> > > Download DB2 Express C - the FREE version of DB2 express and take
> > > control of your XML. No limits. Just data. Click to get it now.
> > > http://sourceforge.net/powerbar/db2/
> > > _______________________________________________
> > > Bluez-devel mailing list
> > > Bluez-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> > --
> > Collin R. Mulliner <collin@betaversion.net>
> > BETAVERSiON Systems [www.betaversion.net]
> > info/pgp: finger collin@betaversion.net
> > Life is hard, but unfair!
> >
> >
> > -----------------------------------------------------------------------=
--
> > This SF.net email is sponsored by DB2 Express
> > Download DB2 Express C - the FREE version of DB2 express and take
> > control of your XML. No limits. Just data. Click to get it now.
> > http://sourceforge.net/powerbar/db2/
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
