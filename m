Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <9e3a30280602262014j8b5301fp1d5a16760e9bc53e@mail.gmail.com>
From: "Deniz Demir" <denizdemir@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] RFCOMM Server: accept does not block
In-Reply-To: <ef9938ec0602261923k1aa23dd3re61c74198e42f4b0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e3a30280602261729u52e8b48ap5a90d422e4ddc44@mail.gmail.com>
	 <ef9938ec0602261808q7974b833j3fe199143cfa4bbf@mail.gmail.com>
	 <9e3a30280602261839n1e4b9ffby8c003316ff1d08d9@mail.gmail.com>
	 <ef9938ec0602261923k1aa23dd3re61c74198e42f4b0@mail.gmail.com>
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
Date: Sun, 26 Feb 2006 20:14:58 -0800

Thanks Albert.

It was conflicting port assigment. In fact, I had changed the port,
however, I mistyped in one place. Anyway, it is okay now.

-Deniz

On 2/26/06, Albert Huang <ashuang@gmail.com> wrote:
> one of the other socket functions probably failed.  check the return code=
s
> for all socket calls (a good practice in general) and use perror again.  =
You
> may also want to read through that entire guide if you're not familiar wi=
th
> socket programming.
>
>  -albert
>
>
> On 2/26/06, Deniz Demir <denizdemir@gmail.com> wrote:
> >
> > Thank you Albert.
> >
> > perror reports the following error message:
> >
> > socket: File descriptor in bad state
> >
> >
> > On 2/26/06, Albert Huang <ashuang@gmail.com> wrote:
> > > Use perror to find out what went wrong.
> > >
> > >  http://beej.us/guide/bgnet/output/html/errnoman.html
> > >
> > >  -albert
> > >
> > >
> > > On 2/26/06, Deniz Demir <denizdemir@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I want to run a small rfcomm server, however it does not block on
> > > > accept, and returns immediately with -1 as socket descriptor (last
> > > > line prints -1 right away).
> > > >
> > > > I have the following code:
> > > >
> > > >     // allocate socket
> > > >     s =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
> > > >
> > > >     // bind socket to port 1 of the first available
> > > >     // local bluetooth adapter
> > > >     loc_addr.rc_family =3D AF_BLUETOOTH;
> > > >     loc_addr.rc_bdaddr =3D *BDADDR_ANY;
> > > >     loc_addr.rc_channel =3D (uint8_t) 1;
> > > >     bind(s, (struct sockaddr *)&loc_addr, sizeof(loc_addr));
> > > >
> > > >     // put socket into listening mode
> > > >     listen(s, 1);
> > > >
> > > >     // accept one connection
> > > >     client =3D accept(s, (struct sockaddr *)&rem_addr, &opt);
> > > >     printf("client: %d \n", client);
> > > >
> > > > I expected it would block on accept function until a connection
> > > > request came in. I appreciate any comments.
> > > >
> > > > Thanks,
> > > > Deniz
> > > >
> > > >
> > > >
> -------------------------------------------------------
> > > > This SF.Net email is sponsored by xPML, a groundbreaking scripting
> > > language
> > > > that extends applications into web and mobile media. Attend the liv=
e
> > > webcast
> > > > and join the prime developer group breaking into this new coding
> > > territory!
> > > >
> > >
> http://sel.as-us.falkag.net/sel?cmdlnk&kid=110944&bid$1720&dat=121642
> > > > _______________________________________________
> > > > Bluez-devel mailing list
> > > > Bluez-devel@lists.sourceforge.net
> > > >
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> > > >
> > >
> > >
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by xPML, a groundbreaking scripting
> language
> > that extends applications into web and mobile media. Attend the live
> webcast
> > and join the prime developer group breaking into this new coding
> territory!
> >
> http://sel.as-us.falkag.net/sel?cmdlnk&kid=110944&bid$1720&dat=121642
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
>
>


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
