Return-Path: <cyrus@holtmann.org>
Subject: Re: HDP proposed API(0.5)
From: Nathan Holstein <ngh@isomerica.net>
Reply-To: ngh@isomerica.net
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: Elvis =?ISO-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>,
	=?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>,
	linux-bluetooth@vger.kernel.org, jcaden@libresoft.es
In-Reply-To: <20100517232056.GC19907@vigoh>
References: <201005171654.36923.jcaden@libresoft.es>
	 <AANLkTikCmZydkLG863_MbrMhiNlWx5GecQaXitr1q0xX@mail.gmail.com>
	 <20100517213838.GB19907@vigoh>
	 <DCEDCB0F-6BA3-4100-96F9-0A33AC440F82@signove.com>
	 <20100517232056.GC19907@vigoh>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 17 May 2010 22:42:42 -0400
Message-Id: <1274150562.3559.78.camel@strawberry>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2010-05-17 at 20:20 -0300, Gustavo F. Padovan wrote:
> Hi Elvis,
> 
> * Elvis Pfützenreuter <epx@signove.com> [2010-05-17 19:02:33 -0300]:
> 
> > 
> > On 17/05/2010, at 18:38, Gustavo F. Padovan wrote:
> > 
> > > Hi,
> > > 
> > > * João Paulo Rechi Vita <jprvita@gmail.com> [2010-05-17 18:17:58 -0300]:
> > > 
> > > <snip>
> > > 
> > >> On Mon, May 17, 2010 at 11:54, José Antonio Santos Cadenas
> > >> <jcaden@libresoft.es> wrote:
> > >>> 
> > >>>                array GetDataChannelFileDescriptor(uint16 mdlid)
> > >>> 
> > >> 
> > >> Wouldn't be better to pass the fd through the LinkConnected call on
> > >> Agent? Doing it here allows any process to get the fds.
> > > 
> > > I was thinking about the MCAP in kernel implementation, my conclusion is
> > > that we can solve one of the biggest problem of HDP API if we do it in
> > > kernel: the transparency of MCAP reconnection. HDP will open an MCAP
> > > socket and pass it to the user(IEEE app). Then if we need a
> > > reconnection, MCAP will transparently reconnect changing the L2CAP
> > > channel to transmit the data without the need to change the socket
> > > opened with the userspace.
> > > 
> > > Keep the MCAP socket open means that we are keeping the MCL state for
> > > further reconnection.
> > > 
> > > Doing it inside the kernel removes a big amount of complexity of HDP and
> > > IEEE profiles, since we won't need any pipe or change of fd. That could
> > > be a killer feature to make it in the kernel.
> > > 
> > > Any comments? Is this reasonable?
> > 
> > 
> > The fd passed to the application could actually be an UNIX socket,
> so these semantics could be implemented with MCAP in user space. I
> guess the pipes only appeared in discussion because of the possibility
> of zero-copy communication.
> 
> MCAP in kernel gives zero-copy communication and just one socket to the
> HDP API. The better of both UNIX socket and pipes options.
>  
> > That semantics would be implemented in MCAP part. The HDP profile
> code itself is (or should be) free from these worries.
> > 
> > Moving MCAP to kernel hides the complexity from userspace HDP
> profile, but it continues to exist. Then I worry about more complex
> debugging, dependency on kernel version (or need to put efforts on
> backporting). MCAP sits above L2CAP, not besides it.
> 
> The complexity will exist anyway, I'm proposing a less complex option.
> Is not that complex change the L2CAP channels used by the MCL inside the
> kernel. Between all the proposed options to handle reconnection it
> looks the less complex one.

One advantage of MCAP within the kernel is the ability to reject an
invalid incoming L2CAP before a call to accept().  (An example of this
is a duplicated control channel or a data channel with incorrect
ERTM/Streaming configuration.)

> We should not care about backporting now. We are working directly
> with upstream and upstream is what really matters here. :)
> 
> You will depend on kernel version anyway since ERTM is inside the
> kernel. About backport if you backport ERTM, then backport MCAP will be
> easy.
> 
> Also MCAP will keep sitting on top of L2CAP, that won't change.
> 
> > 
> > I acknowledge that it would work, but honestly I prefer to see
> things being moved to the outside of the kernel than to the inside :)
> 
> The real question here is where MCAP will fit better. And where it adds
> less complexity to its users.

The solution I've used for MCAP utilizes the epoll family of calls to
provide a single fd which multiplexes all listening, control, and data
sockets.  The primary advantage of this approach is simple integration
into the application's main loop.  In my experience, such a model is
much easier to integrate into i.e. a JNI interface.  However, it appears
much of this complexity is hidden by the proposed HDP API

As for the proposed API itself, it looks to provide the necessary
functionality to implement a 20601 device.  One little quibble I'll add
is the choice of name "HealthAgent".  As someone who comes from the
20601 side of things, this could cause some confusion with the 20601
term "agent".  Since I believe this is a standard Bluez term, I'd just
request that this gotcha is well documented.

Has any thought been given regarding support for MCAP clock
synchronization?  IEEE-20601 is mostly agnostic to the transport, but
this is one point where transport-specific information is exposed within
the 20601 protocol (via the MDS object's Mds-Time-Info attribute).  I'm
not aware of any devices which currently support clock synch (my code
included), so I'd argue this isn't a blocking feature for the first
release.



    --nathan

