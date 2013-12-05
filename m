Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Dec 2013 15:48:24 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv2 2/4] android/socket Use 64K buffer for socket handling
Message-ID: <20131205134822.GA13420@aemeltch-MOBL1>
References: <1386085873-21715-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1386085873-21715-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZLzirtMJresKRYi9D-rJ8d0sJEXXDoP4X8ep=sUJv+ozQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZLzirtMJresKRYi9D-rJ8d0sJEXXDoP4X8ep=sUJv+ozQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Dec 05, 2013 at 02:43:10PM +0200, Luiz Augusto von Dentz wrote:
> Hi Andrei,
> 
> On Tue, Dec 3, 2013 at 5:51 PM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > Make SOCKET_BUFFER define and use 0xFFFE instead of 1K.
> > The value 0XFFFE is what Android sends in OBEX Connect packet in
> > Maximum Packet Length field. Though OBEX specify meximum packet
> > length as 64K - 1 which is 0xFFFF.
> > ---
> >  android/socket.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/android/socket.c b/android/socket.c
> > index 9020874..9ff9019 100644
> > --- a/android/socket.c
> > +++ b/android/socket.c
> > @@ -52,6 +52,8 @@
> >
> >  #define SVC_HINT_OBEX 0x10
> >
> > +#define SOCKET_BUFFER 0xFFFE
> > +
> >  static bdaddr_t adapter_addr;
> >
> >  /* Simple list of RFCOMM server sockets */
> > @@ -487,7 +489,7 @@ static gboolean sock_stack_event_cb(GIOChannel *io, GIOCondition cond,
> >                                                                 gpointer data)
> >  {
> >         struct rfcomm_sock *rfsock = data;
> > -       unsigned char buf[1024];
> > +       unsigned char buf[SOCKET_BUFFER];
> >         int len, sent;
> >
> >         if (cond & G_IO_HUP) {
> > @@ -526,7 +528,7 @@ static gboolean sock_rfcomm_event_cb(GIOChannel *io, GIOCondition cond,
> >                                                                 gpointer data)
> >  {
> >         struct rfcomm_sock *rfsock = data;
> > -       unsigned char buf[1024];
> > +       unsigned char buf[SOCKET_BUFFER];
> >         int len, sent;
> >
> >         if (cond & G_IO_HUP) {
> > --
> > 1.8.3.2
> 
> We need to be a bit more generic here, the socket HAL is not
> restricted to OBEX only, also it doesn't seems you are adjusting the
> buffer level of the sockets, 

it is in the following patch

> the buffer itself is just to copy between
> the sockets so we have to follow how much the sockets can
> transmit/receive not the other way around.

the idea is to copy data to socket buffers and then sleep.

> So it seems to me that we should either set the maximum MTU size we
> could use with RFCOMM (UINT16_MAX?) or read the MTU once connected
> (not sure if makes sense since it is SOCK_STREAM) and then allocate
> the same amount as buffer in a field in struct rfcomm_sock, also this
> needs then to be set back to socketpair with
> setsocketopt(SO_RCVBUF/SO_SNDBUF) so we minimize context switches and
> wakeups.

This can actually make more switches since RFCOMM packet size is
relatively small (990 bytes in my case). Maximum RFCOMM L2CAP MTU is 1013.

This is what we had before.

Best regards 
Andrei Emeltchenko 

