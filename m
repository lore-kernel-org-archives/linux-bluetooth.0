Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <f8e53fb0711250754n60de59f7md759b9d21f39ec53@mail.gmail.com>
Date: Sun, 25 Nov 2007 16:54:56 +0100
From: "Andrea Galbusera" <gizero@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1192630825.6184.17.camel@violet>
MIME-Version: 1.0
References: <f8e53fb0710170033u2b451d7ft34cad156e0828a49@mail.gmail.com>
	<1192630825.6184.17.camel@violet>
Subject: Re: [Bluez-users] concurrent calls to RFCOMM connect()
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,
I have been reading and thinking on this issue but need some more
clarification. After reading RFCOMM documentation on BlueZ's site I
wasn't able to get it clear, so I set up this simple experiment: usign
bluez rfcomm utility I try to connect to an unavailable (powered off)
device.

$> rfcomm connect 00:01:95:07:30:EA

It takes about 20 seconds to timeout with a reasonable "Host is down"
error. This means to me an internal bluez rfcomm socket timeout,
correct?. In the meanwhile, if I make another call to rfcomm connect,
I get "Device or resource busy". I understand this as: "there is no
way other than serializing connection attempts". Is this an intrinsic
behaviour of the rfcomm implementation or might it depend on the
specific hardware I use? I did this test on my Ubuntu 2.6.20 kernel
with rfcomm ver 3.9.

In your reply to my original post (attached) you said that newer
kernel are supposed to do some queuing on the request... Does it mean
that my test should have behaved differently?

My concern is that I have to be able to keep four devices connected
and implement some sort of reconnection scheme when I loose the rfcomm
link. It is important to understand if I have to estimate a worst case
latency on devices reconnection of about 20 seconds (the connect
timout) multiplied by the number of unavailable devices (if I just
implement some sort of round-robin reconnection attempt loop and I
happen to start from the very-wrong device in the list).

Please help me understanding if I need to update any of the involved
software components or if I'm missing any important point on the
topic. I'll be pleased to read any clarifying document on this.

TIA. Regards,
Andrea

On Oct 17, 2007 3:20 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andrea,
>
> > I'm planning to write an application handling communication with four
> > bluetooth devices, each with its own BT address. I was thinking to
> > design it with four parallel threads and use rfcomm sockets API.
> >
> > The common thread function will start connecting to the appropriate
> > remote device by allocating a socket and calling connect(). Do I have
> > to consider any particular syncronization issue between the threads?
> > Is this approach reasonable or not?
> >
> > I found posts in the archives about connect() returning EBUSY. This
> > has to be an   error code specific to RFCOMM sockets. When is it
> > supposed to be raised? Is it something I have to take into account in
> > my scenario?
>
> depending on how which kernel you use, this might work. Older kernel
> didn't queue the ACL link requests and so you saw problems.
>
> Regards
>
> Marcel
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
