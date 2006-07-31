Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5f30e2610607302005t5078bc45mee883053c96a804d@mail.gmail.com>
Date: Sun, 30 Jul 2006 22:05:17 -0500
From: "Jeff Wilson" <jazzbotley@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <5f30e2610607300852v675f0436od327a39c2946f9c9@mail.gmail.com>
MIME-Version: 1.0
References: <5f30e2610607300852v675f0436od327a39c2946f9c9@mail.gmail.com>
Subject: Re: [Bluez-devel] poll() on RFCOMM socket
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

Oops. I figured a couple of things out.

First of all, lots of typos in my example, typed in haste instead of
copied from tested code. That's fixed now at
http://cs.baylor.edu/~wilsonj/rfcomm-poll-example.tgz if anyone's
still interested.

Secondly, my example code works now.  Go figure. So "never mind" on that.  :-$

However, I still wonder ... does anyone have any experience with
mixing sockets of different domains to submit in a fdset to poll()?

    Cheers,
    Jeff

On 7/30/06, Jeff Wilson <jazzbotley@gmail.com> wrote:
> Hi all,
>
> I'm on 2.6.11-mh2, running bluez-libs-2.25. I can't seem to get the
> following example to work (I edited out the error checking, etc, to
> shorten the code segment)  I have a similar function that works fine
> with TCP sockets
>
> // begin code segment
> int fd = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
> /* accept(), connection setup, etc */
> fcntl(fd, F_SETFL, O_NONBLOCK);
> struct pollfd pfd;
> pfd.fd = fd;
> pfd.events = POLLIN;
> pfd.revents = 0;
> int res = 0;
> while ((res = poll(&poll_struct, 1, 5000)) < 1)
> {
>    if(res < 0) /* check errno */
>    else if(res == 0) /* handle timeout */
> }
> if (poll_struct.revents & POLLIN) {
>   /* do the read ... never gets called :( */
> }
> // end of code segment
>
>
> If I take out the fcntl() and poll() and just read() instead, it
> blocks until data arrives and then read() works as expected.
>
> Does it matter to the BlueZ implementation if I expand that fd set to
> include sockets of other domains, such as UNIX or IP?
>
>      Thanks,
>        Jeff
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
