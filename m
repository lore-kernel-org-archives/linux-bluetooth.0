Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: gfpadovan@gmail.com
In-Reply-To: <1240937363.997.47.camel@localhost.localdomain>
References: <6b53b1990904251605s75ad3478v987d3fc47e2bc318@mail.gmail.com>
	 <1240929768.3441.5866.camel@localhost.localdomain>
	 <1240933237.997.37.camel@localhost.localdomain>
	 <1240936070.3441.5901.camel@localhost.localdomain>
	 <1240937363.997.47.camel@localhost.localdomain>
Date: Tue, 28 Apr 2009 16:14:19 -0300
Message-ID: <6b53b1990904281214y304fd3dav6ca79e7905e7c5d5@mail.gmail.com>
Subject: Re: GSoC 2009: L2CAP Enhanced Retransmission mode
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: ngh@isomerica.net
Cc: linux-bluetooth@vger.kernel.org, Barry Reinhold <bbr@lampreynetworks.com>,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nathan,

Your work will be very useful on My GSoC. We can work together on
implementing ERTM. I was just starting to study how to do mode
negotiaton. I'll stop it and go look through your code to understand
it and start coding something.

I think we need a TO DO list of ERTM stuff with the things that left
to implement and the this Marcel suggested. First I think that we need
do changes suggested by Marcel to push the to upstream. After we can
concentrate on the issues left to implement. I'm planning to start
this tonight.

First I need to study your code, then we can discuss it more. I need
to learn many things about l2cap and ERTM yet =3D).

Are you around #bluez on freenode?

Regards.

On Tue, Apr 28, 2009 at 1:49 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Nathan,
>
>> > > =A0 Because our initial target is interoperability against a specifi=
c set
>> > > of medical devices from outside vendors, my work thus far has been
>> > > targeted against these devices. =A0Enhanced L2CAP is fairly complex,=
 and
>> > > has multiple parts to it. =A0To get the first round of compatibility
>> > > going, I've taken such paths as limiting the local TX window to 1
>> > > outstanding SDU.
>> > > =A0 Currently, the code is at a state where it successfully negotiat=
es
>> > > between enhanced/streaming/basic modes, opens a connection, and begi=
ns
>> > > sending data. =A0Much of the work I've done thus far has been splitt=
ing
>> > > out the send/receive paths for the separate modes. =A0There have bee=
n no
>> > > significant changes in and code path, and no need to make any major
>> > > changes to the existing data structures. =A0Major points left to imp=
lement
>> > > include:
>> > >
>> > > =A0 * =A0Support for a TX windows > 1
>> > > =A0 =A0 =A0On both send and receive, the code limits itself to only =
one
>> > > outstanding l2cap SDU at a time. =A0I have added a send and receive =
queue
>> > > of skbuffs to a socket to support this, however this is unimplemente=
d,
>> > > and quite possibly duplicates code elsewhere in the kernel.
>> >
>> > in the end the ERTM mode should behave like SOCK_STREAM (like what
>> > RFCOMM does at the moment). The Basic mode will stay as SOCK_SEQPACKET
>> > and this way we require one mode or the other.
>> >
>> > For testing purpose of course just setting the value in the existing
>> > SOCK_SEQPACKET should be enough. And also that SOCK_SEQPACKET could ru=
n
>> > with ETRM without any downside is an option anyway.
>>
>> Some of the devices I test against force Basic mode for SDP and ERTM for
>> HDP. =A0In my testing while using the kernel negotiation procedure, both
>> sdptool and our HDP implementation work transparently, using Basic and
>> ERTM modes respectively.
>
> that is fine. So our SDP client/server uses SOCK_SEQPACKET and then for
> HDP you just use SOCK_STREAM. Sounds totally sane to me.
>
> The default mode for SOCK_SEQPACKET should be basic mode and for
> SOCK_STREAM is is ERTM. Additionally you can use setsockopt() with
> L2CAP_OPTIONS to change the mode requirement.
>
>> My vision was to add an ioctl() to allow an application to specify that
>> it requires a specific mode. =A0This was due to my understanding of the
>> recvmsg() man page:
>>
>> =A0 =A0 =A0 =A0The =A0msg_flags =A0field =A0in the msghdr is set on retu=
rn of
>> =A0 =A0 =A0 =A0recvmsg(). =A0It can contain several flags:
>>
>> =A0 =A0 =A0 =A0MSG_EOR
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 indicates end-of-record; the data returned c=
ompleted a
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 record (generally used with sockets of type
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 SOCK_SEQPACKET).
>>
>> The MCAP/HDP profiles require this metadata to function properly. =A0Can
>> we tack MSG_EOR onto a SOCK_STREAM socket? =A0If so, this would be simpl=
er
>> than requiring an ioctl.
>
> As I said, the mode setting part is already there. And using an ioctl()
> for these is wrong. You use setsockopt() for these kind of things.
>
> And I think you can add an MSG_EOR on a stream socket. Not sure that it
> really is needed. Sounds to me like a messed up detail in the MCAP
> specification that would work anyway without extra flags. Have to read
> the spec. at some point.
>
>> > > =A0 Currently, the code is branched off bluetooth-testing from last =
week.
>> > > The tree is available via:
>> > >
>> > > =A0 =A0 =A0git clone git://staticfree.info/git/el2cap
>> > >
>> > > I'd like to thank my friend Steve from the MIT Mobile Experience Lab=
 for
>> > > graciously hosting the code. =A0My latest work is in the "retransmis=
sion"
>> > > branch. =A0Due to the increase in code size, I've split the files up=
 into
>> > > an l2cap sub-directory under net/bluetooth. =A0I've not yet cloned
>> > > Gustavo's repository, but I should be able to rebase the code off th=
at
>> > > as necessary.
>> > > =A0 If there are any comments on style or implementation, I'd be hap=
py to
>> > > address them in the code. =A0Hopefully, this can be used as base for
>> > > Gustavo's SOC work so we can focus upon complete implementation of t=
he
>> > > Enhanced L2CAP specification and interoperability with other devices=
.
>> >
>> > The split into l2cap.c and queue.c and move to a separate directory
>> > looks totally useless to me. I know that l2cap.c is big, but there is =
no
>> > real separation. You would have to convince why this makes sense.
>>
>> Just trying to keep things manageable. =A0Currently, I'm not using any o=
f
>> the code in queue.c anyway, so I'm tempted to just drop it.
>
> Just drop it for now. We can change the layout later if it is really
> needed. Currently it is just confusing.
>
> Regards
>
> Marcel
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Gustavo F. Padovan
http://padovan.org
