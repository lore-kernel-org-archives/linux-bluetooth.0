Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimPNHrnY4Xn-oqsOQac45Z_rSr1SZtV90cna+ey@mail.gmail.com>
References: <35c90d960912081950t135e3f10m8848e54fde1e596f@mail.gmail.com>
 <1260335175.2901.20.camel@violet> <35c90d960912082213s26fb0ebse75ce85d43213d9@mail.gmail.com>
 <1260482634.2901.70.camel@violet> <35c90d960912161359u2b3f9b2fi875288896a7a8478@mail.gmail.com>
 <35c90d961003091207u66571bt789461dcc7972693@mail.gmail.com>
 <1268167524.3712.61.camel@localhost.localdomain> <AANLkTinOFG0NcADz2ewxyaPWiLpe52MFLP8GCEvFna2a@mail.gmail.com>
 <AANLkTim9qOTdeWhU1H-ove2rPR4MlEyUmQZ3zUeS75K_@mail.gmail.com> <AANLkTimPNHrnY4Xn-oqsOQac45Z_rSr1SZtV90cna+ey@mail.gmail.com>
From: Nick Pelly <npelly@google.com>
Date: Thu, 9 Dec 2010 08:55:42 -0800
Message-ID: <AANLkTinbaqh_vXsNUHR4-XKfP-50dbmvNxM3QkZvnFjv@mail.gmail.com>
Subject: Re: RFC: Allow Bluez to select flushable or non-flushable ACL packets
 with L2CAP_LM_RELIABLE
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 9, 2010 at 2:37 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
>
> Hi All,
>
> On Wed, Jun 16, 2010 at 5:15 PM, Nick Pelly <npelly@google.com> wrote:
> > On Wed, Jun 16, 2010 at 4:40 AM, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> >> Hi,
> >>
> >> On Tue, Mar 9, 2010 at 11:45 PM, Marcel Holtmann <marcel@holtmann.org>=
 wrote:
> >>> Hi Nick,
> >>>
> >>>> >>> >> Right now Bluez always requests flushable ACL packets (but do=
es not
> >>>> >>> >> set a flush timeout, so effectively they are non-flushable):
> >>>> >>> >>
> >>>> >>> >> However it is desirable to use an ACL flush timeout on A2DP p=
ackets so
> >>>> >>> >> that if the ACL packets block for some reason then the LM can=
 flush
> >>>> >>> >> them to make room for newer packets.
> >>>> >>> >>
> >>>> >>> >> Is it reasonable for Bluez to use the 0x00 ACL packet boundar=
y flag by
> >>>> >>> >> default (non-flushable packet), and let userspace request flu=
shable
> >>>> >>> >> packets on A2DP L2CAP sockets with the socket option
> >>>> >>> >> L2CAP_LM_RELIABLE.
> >>>> >>> >
> >>>> >>> > the reliable option has a different meaning. It comes back fro=
m the old
> >>>> >>> > Bluetooth 1.1 qualification days where we had to tests on L2CA=
P that had
> >>>> >>> > to confirm that we can detect malformed packets and report the=
m. These
> >>>> >>> > days it is just fine to drop them.
> >>>> >>>
> >>>> >>> Got it, how about introducing
> >>>> >>>
> >>>> >>> #define L2CAP_LM_FLUSHABLE 0x0040
> >>>> >>
> >>>> >> that l2cap_sock_setsockopt_old() sets this didn't give you a hint=
 that
> >>>> >> we might wanna deprecate this socket options ;)
> >>>> >>
> >>>> >> I need to read up on the flushable stuff, but in the end it deser=
ves its
> >>>> >> own socket option. Also an ioctl() to actually trigger Enhanced f=
lush
> >>>> >> might be needed.
> >>>> >>
> >>>> >>> struct l2cap_pinfo {
> >>>> >>> =A0 =A0...
> >>>> >>> =A0 =A0__u8 flushable;
> >>>> >>> }
> >>>> >>
> >>>> >> Sure. In the long run we need to turn this into a bitmask. We are=
 just
> >>>> >> wasting memory here.
> >>>> >
> >>>> > Attached is an updated patch, that checks the LMP features bitmask
> >>>> > before using the new non-flushable packet type.
> >>>> >
> >>>> > I am still using L2CAP_LM_FLUSHABLE socket option in
> >>>> > l2cap_sock_setsockopt_old(), which I don't think you are happy wit=
h.
> >>>> > So how about a new option:
> >>>> >
> >>>> > SOL_L2CAP, L2CAP_ACL_FLUSH
> >>>> > which has a default value of 0, and can be set to 1 to make the AC=
L
> >>>> > data sent by this L2CAP socket flushable.
> >>>> >
> >>>> > In a later commit we would then add
> >>>> > SOL_ACL, ACL_FLUSH_TIMEOUT
> >>>> > That is used to set an automatic flush timeout for the ACL link on=
 a
> >>>> > L2CAP socket. Note that SOL_ACL is new.
> >>>> >
> >>>> > But maybe this is not what you had in mind, so I'm looking for you=
r
> >>>> > advice before I implement this.
> >>>>
> >>>> Attached an updated patch for 2.6.32 kernel. We've been using this
> >>>> patch successfully on production devices.
> >>>
> >>> can see anything wrong with that patch. However we need to use
> >>> SOL_BLUETOOTH for it of course. So we need to come up with something =
to
> >>> make this simple.
>
> Nick are you going to take Marcel comments? Otherwise I could take
> care about the patch as it seems that it might help in some
> situations.

I'm not actively working on this patch.

> >>> An additional change I like to see is to use flags for booleans like
> >>> flushable in the structures. Can you work on changing that.
> >>>
> >>> Also do we have decoding support for this in hcidump. It might be nic=
e
> >>> to include some really simple examples in the commit message.
>
> At least wireshark which I use understands those packets.
>
> >> I would like to play a little bit with this, so is there any missing u=
pdates?
> >
> > Nope, that is our most recent version.
>
> Nick, do you know headset which could help to hear the real
> difference? I was trying to use Sony DR-BT22 headset which has some
> issues with A2DP but the solution did not help much.

It becomes essential in non-ideal radio bandwidth conditions such as
single antenna wifi co-existence. We also had some headsets that
exacerbated the problem (presumably they had less logic to 'catch-up'
through late packets) but I can't remember off hand.

Nick
