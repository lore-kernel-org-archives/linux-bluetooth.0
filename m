Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTil8Hloz5I7Gpnp9M-y2W3jkLKeca4wz7dgFKA0V@mail.gmail.com>
References: <35c90d960911121639o8b0b0bfxde880af69adc9f95@mail.gmail.com>
	<1258082098.7715.7.camel@violet> <35c90d960911121931n687a2cd4ie8130f919041ee70@mail.gmail.com>
	<1258084357.7715.26.camel@violet> <35c90d960911131445w16076c70sa0473e9b459d7d15@mail.gmail.com>
	<35c90d961001122046o733c7e10nf28bfed9e7f5465@mail.gmail.com>
	<1263366291.922.5.camel@localhost.localdomain> <AANLkTil8Hloz5I7Gpnp9M-y2W3jkLKeca4wz7dgFKA0V@mail.gmail.com>
From: Nick Pelly <npelly@google.com>
Date: Thu, 8 Jul 2010 11:37:44 -0700
Message-ID: <AANLkTinIhVG_4CpxLR1p1OqVeNqOzXojY3stnkJJdQAp@mail.gmail.com>
Subject: Re: What is the motivation for conn->power_save
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 8, 2010 at 8:07 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi,
>
> On Wed, Jan 13, 2010 at 10:04 AM, Marcel Holtmann <marcel@holtmann.org> w=
rote:
>> Hi Nick,
>>
>>> >>> >> If I understand correctly, conn->power_save prevents the host st=
ack
>>> >>> >> from requesting active mode if it was not the host stack that
>>> >>> >> requested sniff mode.
>>> >>> >>
>>> >>> >> I don't understand the motivation for this. If we have ACL data =
to
>>> >>> >> send, then it seems like a good idea for the host stack to expli=
citly
>>> >>> >> request active mode, regardless of the reason that we entered sn=
iff
>>> >>> >> mode.
>>> >>> >>
>>> >>> >> We want to enter active mode more aggressively when setting up S=
CO
>>> >>> >> connections, to avoid a 5 second delay with certain sniff modes.=
 But
>>> >>> >> the conn->power_save code is getting in the way and doesn't appe=
ar to
>>> >>> >> be useful in the first place.
>>> >>> >
>>> >>> > we have discussed this a few times. And if you lock through the c=
ode
>>> >>> > history then you see that initially we just took devices out of s=
niff
>>> >>> > mode if we had to send data. However with HID devices this falls =
flat on
>>> >>> > its face. They need to stay in control of sniff mode if they init=
iated
>>> >>> > it. Some of them crash and others just drain the battery. With sn=
iff
>>> >>> > mode you can send small amounts of data even while in sniff and f=
or HID
>>> >>> > that is sometimes used. So the remote side better not interfere.
>>> >>> >
>>> >>> > What we really need is a socket option where we can control this =
on a
>>> >>> > per socket basis if we take devices out of sniff mode. And one ex=
tra
>>> >>> > case might be when we try to establish a SCO channel, because the=
n it is
>>> >>> > clearly not an HID device. However even A2DP has this sort of pro=
blems
>>> >>> > sometimes where the stream setup takes time.
>>> >>>
>>> >>> Makes sense. Thanks for the explanation.
>>> >>
>>> >> this means you will be working on a patch for this :)
>>>
>>> Actually, I want to put a patch together for a socket option to not
>>> use power_save (so that we *always* exit sniff mode when sending ACL
>>> data). We're seeing this problem with the Plantronics Voyager 855
>>> which enters sniff mode during A2DP.
>>>
>>> Given that power_save is just for HID devices, my preferred design is
>>> to disable power_save by default, and have an L2CAP socket option to
>>> turn on power_save that would be used by HID L2CAP sockets.
>>> Unfortunately this would require userspace HID code to use the new
>>> socket option to keep current behavior. But it seems preferable to the
>>> alternative of having every single other L2CAP socket use a new socket
>>> option just to disable power_save for the sake of HID.
>>
>> actually you still mix up the meaning of the power_save option. From the
>> stack side, the automatic sniff mode is off by default. You have to
>> enable via sysfs first. The power_save option is just to control when
>> sniff mode is activated and the remote enters sniff mode, that we are
>> not getting out of it if we have ACL data.
>>
>> In conclusion, I am fine with a socket option that allows to control
>> sniff mode (preferable with interval details) and sniff subrate details
>> so that we can use them for that ACL link.
>>
>> So go ahead and work on this. We can fix userspace easily since a new
>> socket can be detected easily with newer kernels.
>
> We have found that some Nokia BT headsets stop working after idle
> period when they enter
> "power save" mode.
>
> Do we have any solution for this problem? So far I see good enough
> patch :-)) below:
>
> http://android.git.kernel.org/?p=3Dkernel/common.git;a=3Dblobdiff;f=3Dnet=
/bluetooth/hci_conn.c;h=3Dfa8b412205cd89546b4a325c558c68040eeaf491;hp=3D0cf=
25114a3f576fc2788a549eb96d0087dd39b44;hb=3Dd8488237646920cd71ef43e5f3ae1001=
c6f4cf7b;hpb=3D3f68e5050c5ae559f56d5da9202cb88928d42b36
>
> - =A0 =A0 =A0 if (conn->mode !=3D HCI_CM_SNIFF || !conn->power_save)
> + =A0 =A0 =A0 if (conn->mode !=3D HCI_CM_SNIFF /* || !conn->power_save */=
)
>
> Nick have you done socket option for "power_save"?

No. We'll do it once we need it for HID support.

Nick
