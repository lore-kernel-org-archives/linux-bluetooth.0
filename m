Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1268167524.3712.61.camel@localhost.localdomain>
References: <35c90d960912081950t135e3f10m8848e54fde1e596f@mail.gmail.com>
	<1260335175.2901.20.camel@violet>
	<35c90d960912082213s26fb0ebse75ce85d43213d9@mail.gmail.com>
	<1260482634.2901.70.camel@violet>
	<35c90d960912161359u2b3f9b2fi875288896a7a8478@mail.gmail.com>
	<35c90d961003091207u66571bt789461dcc7972693@mail.gmail.com>
	<1268167524.3712.61.camel@localhost.localdomain>
Date: Wed, 16 Jun 2010 14:40:00 +0300
Message-ID: <AANLkTinOFG0NcADz2ewxyaPWiLpe52MFLP8GCEvFna2a@mail.gmail.com>
Subject: Re: RFC: Allow Bluez to select flushable or non-flushable ACL packets
	with L2CAP_LM_RELIABLE
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Nick Pelly <npelly@google.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 9, 2010 at 11:45 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Nick,
>
>> >>> >> Right now Bluez always requests flushable ACL packets (but does n=
ot
>> >>> >> set a flush timeout, so effectively they are non-flushable):
>> >>> >>
>> >>> >> However it is desirable to use an ACL flush timeout on A2DP packe=
ts so
>> >>> >> that if the ACL packets block for some reason then the LM can flu=
sh
>> >>> >> them to make room for newer packets.
>> >>> >>
>> >>> >> Is it reasonable for Bluez to use the 0x00 ACL packet boundary fl=
ag by
>> >>> >> default (non-flushable packet), and let userspace request flushab=
le
>> >>> >> packets on A2DP L2CAP sockets with the socket option
>> >>> >> L2CAP_LM_RELIABLE.
>> >>> >
>> >>> > the reliable option has a different meaning. It comes back from th=
e old
>> >>> > Bluetooth 1.1 qualification days where we had to tests on L2CAP th=
at had
>> >>> > to confirm that we can detect malformed packets and report them. T=
hese
>> >>> > days it is just fine to drop them.
>> >>>
>> >>> Got it, how about introducing
>> >>>
>> >>> #define L2CAP_LM_FLUSHABLE 0x0040
>> >>
>> >> that l2cap_sock_setsockopt_old() sets this didn't give you a hint tha=
t
>> >> we might wanna deprecate this socket options ;)
>> >>
>> >> I need to read up on the flushable stuff, but in the end it deserves =
its
>> >> own socket option. Also an ioctl() to actually trigger Enhanced flush
>> >> might be needed.
>> >>
>> >>> struct l2cap_pinfo {
>> >>> =A0 =A0...
>> >>> =A0 =A0__u8 flushable;
>> >>> }
>> >>
>> >> Sure. In the long run we need to turn this into a bitmask. We are jus=
t
>> >> wasting memory here.
>> >
>> > Attached is an updated patch, that checks the LMP features bitmask
>> > before using the new non-flushable packet type.
>> >
>> > I am still using L2CAP_LM_FLUSHABLE socket option in
>> > l2cap_sock_setsockopt_old(), which I don't think you are happy with.
>> > So how about a new option:
>> >
>> > SOL_L2CAP, L2CAP_ACL_FLUSH
>> > which has a default value of 0, and can be set to 1 to make the ACL
>> > data sent by this L2CAP socket flushable.
>> >
>> > In a later commit we would then add
>> > SOL_ACL, ACL_FLUSH_TIMEOUT
>> > That is used to set an automatic flush timeout for the ACL link on a
>> > L2CAP socket. Note that SOL_ACL is new.
>> >
>> > But maybe this is not what you had in mind, so I'm looking for your
>> > advice before I implement this.
>>
>> Attached an updated patch for 2.6.32 kernel. We've been using this
>> patch successfully on production devices.
>
> can see anything wrong with that patch. However we need to use
> SOL_BLUETOOTH for it of course. So we need to come up with something to
> make this simple.
>
> An additional change I like to see is to use flags for booleans like
> flushable in the structures. Can you work on changing that.
>
> Also do we have decoding support for this in hcidump. It might be nice
> to include some really simple examples in the commit message.
>
> Regards

I would like to play a little bit with this, so is there any missing update=
s?

--=20
Luiz Augusto von Dentz
Computer Engineer
