Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Fernando Unzu <fernando@bluexare.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Thu, 19 Jul 2007 12:16:54 +0200
References: <200707181232.00253.fernando@bluexare.org>
	<1ab01fb50707182139y7e3798bej80dd486f23140d8b@mail.gmail.com>
In-Reply-To: <1ab01fb50707182139y7e3798bej80dd486f23140d8b@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200707191216.54531.fernando@bluexare.org>
Subject: Re: [Bluez-devel] Obex handle?
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

Thanks for your response, Vikas.

first...? There is any problem with the mailing list in sourceforge??
I can't do any search...

Afortunately, you give me a link within I can search.
Thanks once.

But this issue talks about how to know if a dongle is free to use it or not=
...

This can help me, now what I know, but my question is where I select which =

dongle will be used with OBEX...

So... ,at one moment, I know the dongle I must to use is the "dev_id 0", ok=
; =

but..., how I say to OBEX "use the dongle "dev_id 0"".
In whic method I can select this option??

In HCI is the addr.hci_dev, and in OBEX...? handle.dev_id????

I'm not sure I'm explaning well, but I hope you understand me a little.

Thans a lot,
Fernando Unzu

El Jueves, 19 de Julio de 2007 06:39, Vikas Sinha escribi=F3:
> Go and check mailing list .. Few months ago someone asked same question.
> http://blog.gmane.org/gmane.linux.bluez.devel/month=3D20070501
>
>
> well i don't know about DBUS but with obex and hci layer I have controlled
> multiple  Dongles.
> You can find solution here
>
> On 7/18/07, Fernando Unzu <fernando@bluexare.org> wrote:
> > Hello,
> >
> > I have a question about how to select which device I want to use with my
> > program.
> >
> > I have an application that sends some content t another bluetooth
> > devices, and
> > i realize the transfer with Obex functions.
> >
> > But if I have two dongles in my PC, I would can to select between one a=
nd
> > other.
> > This is what i don't know how to do.
> >
> > The handle is created with Obex_Init, and I think it is in that moment
> > when I
> > select one of the dongles, but I don't know how.
> >
> > Or there is another way to do it?? Or it has to be done in another mome=
nt
> > with
> > another function??
> >
> > I have eard that DBus solves this problems...; anybody can help me,
> > please?
> >
> > P.D.: Although anybody gives me a DBus solution, I'm interesting in the
> > Obex
> > solution too.
> >
> > Thank you,
> > Fernando Unzu
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
