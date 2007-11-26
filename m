Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <474ABFD4.3070906@aircable.net>
Date: Mon, 26 Nov 2007 09:45:08 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <474181FA.2010906@aircable.net> <474594B7.2070005@aircable.net>
In-Reply-To: <474594B7.2070005@aircable.net>
Subject: Re: [Bluez-devel] Rfcomm is not buffering received data?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello everyone,

I think this mail might got lost between all the spam we are getting
those days.

I'm starting to think that some how select() is not working for tty
devices. I had switched the tty device to raw mode (by using termios
calls). And still even though there's data on the tty buffer select
keeps returning 0. So far I'm using select as an sleep function, but
that's not it's purpose, not at all. Maybe I keep missing something?

BTW how's the state for server side rfcomm services? I mean you register
a service at a certain port via dbus, and you get locked (or you get a
function callback I don't know) when a connection was established and
you get the tty device name.

Thanks,
Manuel

> Hello guys,
>
> I've been able to fix this, by switching the tty node to raw mode. But
> still something is not working well, select returns 0 even though
> there's data in the buffer.
>
> Here's the fix if anyone wants to know:
>     int fd = fileno(data->fd);
>    
>     struct termios tio;
>    
>     tcgetattr(fd, &tio);
>
>     tcflush(fd, TCIOFLUSH);
>    
>     tio.c_lflag &= ~(ECHO | ICANON | IEXTEN | ISIG);
>     tio.c_iflag &= ~(BRKINT | ICRNL | ISTRIP | IXON);
>     tio.c_cflag &= ~(CSIZE | PARENB);
>     tio.c_cflag |= CS8;
>     tio.c_oflag &= ~(OPOST);
>
>     cfmakeraw(&tio);
>    
>     tio.c_cc[VMIN] = 0;
>     tio.c_cc[VTIME] = 0;
>
> I think we should add a comment about this in the wiki, what do you think?
>
> Cheers,
> Manuel
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
