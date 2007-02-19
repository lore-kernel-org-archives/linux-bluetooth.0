Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45DA01EC.4050007@unternet.org>
References: <45D4FB7F.6090301@unternet.org>
	<1171591223.7583.33.camel@aeonflux.holtmann.net>
	<45DA01EC.4050007@unternet.org>
Date: Mon, 19 Feb 2007 21:33:13 +0100
Message-Id: <1171917193.26567.51.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] sdpd in polling loop on disconnect
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

Hi Frank,

> > if this is bluez-utils-3.9 you might wanna try to compile it with
> > --enable-glib to use the system Glib. It might be possible that our
> > eglib has some kind of bad. In case of using the Glib system library, I
> > think you discovered a real bug in sdpd. Do you see the same issue if
> > you don't start sdpd and use hcid -s instead.
> 
> Fedora's bluez-utils is already compiled with --enable-glib:
> 
> %configure --with-bluez-libs=%{_libdir} --enable-pie --enable-debug \
>         --enable-all --disable-bcm203x --enable-alsa --enable-bccmd \
>         --enable-bccmd --enable-avctrl --enable-glib
> 
> Trying with hcid -s instead of a separate sdpd leads to the same
> behaviour: hcid loops on poll.
> 
> Looking at the code it strikes me that there are many calls to
> g_io_add_watch which only trigger on G_IO_IN or G_IO_OUT. These channels
> are configured with g_io_channel_set_close_on_unref(<channel>, TRUE) but
> that does not seem to be enough to set POLLHUP (or POLLRDHUP) on the
> listening socket. What seems to happen is that the socket is kept open 
> after the remote connection dropped and polled continuously, most likely 
> returning POLLRDHUP. The semantics of glib are a bit unclear in this 
> respect but I have found the following quote from Owen Taylor:
> 
> (http://www.mail-archive.com/gtk-devel-list@gnome.org/msg01577.html)
> 
> "In general, on systems new enough to have poll(), a socket will
> indicate HUP rather than IN when it has been closed on the other
> end. poll() and select() are about *state* rather than *events*
> so once a socket returns HUP, it will continue to return HUP.
> 
> On the other hand, if a system is emulating poll() with select() -
> which was the standard state 5 years ago and I think is still
> the case on OS X, then you'll just get IN, and have to notice the
> zero length read.
> 
> In general, if you are writing code that you want to be portable,
> what you should do is add a watch on G_IO_IN | G_IO_HUP, and
> in that callback just always do a read. If the read is zero length,
> then the socket has been closed, so cleanup, close the socket,
> and return FALSE to remove the watch."
> 
> I have patched sdpd to add G_IO_HUP|G_IO_ERR to the watched conditions 
> on the g_io_channel. This cures the polling loop behaviour. There are 
> several other places in the code where channels are being watched for 
> G_IO_IN only. Someone with good knowledge of the context in which these 
> g_io_channels are being used should check whether there is a need for 
> adding G_IO_HUP to the watched conditions. The callbacks should also be 
> changed to watch for this condition as failing to do the latter seems to 
> lead to kernel panics. This is a bug in its own right - a userspace 
> program should not be able to bring down the kernel... I have not found 
> the culprit for those panics yet.
> 
> Attached: patch for sdpd (adds G_IO_HUP|G_IO_ERR to watched conditions 
> on g_io_channels)

thanks for the patch, but that should be already fixed in the CVS. Johan
found this during the UPF testing last week.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
