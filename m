Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1263366291.922.5.camel@localhost.localdomain>
References: <35c90d960911121639o8b0b0bfxde880af69adc9f95@mail.gmail.com>
	<1258082098.7715.7.camel@violet>
	<35c90d960911121931n687a2cd4ie8130f919041ee70@mail.gmail.com>
	<1258084357.7715.26.camel@violet>
	<35c90d960911131445w16076c70sa0473e9b459d7d15@mail.gmail.com>
	<35c90d961001122046o733c7e10nf28bfed9e7f5465@mail.gmail.com>
	<1263366291.922.5.camel@localhost.localdomain>
Date: Thu, 8 Jul 2010 18:07:19 +0300
Message-ID: <AANLkTil8Hloz5I7Gpnp9M-y2W3jkLKeca4wz7dgFKA0V@mail.gmail.com>
Subject: Re: What is the motivation for conn->power_save
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Nick Pelly <npelly@google.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jan 13, 2010 at 10:04 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Nick,
>
>> >>> >> If I understand correctly, conn->power_save prevents the host sta=
ck
>> >>> >> from requesting active mode if it was not the host stack that
>> >>> >> requested sniff mode.
>> >>> >>
>> >>> >> I don't understand the motivation for this. If we have ACL data t=
o
>> >>> >> send, then it seems like a good idea for the host stack to explic=
itly
>> >>> >> request active mode, regardless of the reason that we entered sni=
ff
>> >>> >> mode.
>> >>> >>
>> >>> >> We want to enter active mode more aggressively when setting up SC=
O
>> >>> >> connections, to avoid a 5 second delay with certain sniff modes. =
But
>> >>> >> the conn->power_save code is getting in the way and doesn't appea=
r to
>> >>> >> be useful in the first place.
>> >>> >
>> >>> > we have discussed this a few times. And if you lock through the co=
de
>> >>> > history then you see that initially we just took devices out of sn=
iff
>> >>> > mode if we had to send data. However with HID devices this falls f=
lat on
>> >>> > its face. They need to stay in control of sniff mode if they initi=
ated
>> >>> > it. Some of them crash and others just drain the battery. With sni=
ff
>> >>> > mode you can send small amounts of data even while in sniff and fo=
r HID
>> >>> > that is sometimes used. So the remote side better not interfere.
>> >>> >
>> >>> > What we really need is a socket option where we can control this o=
n a
>> >>> > per socket basis if we take devices out of sniff mode. And one ext=
ra
>> >>> > case might be when we try to establish a SCO channel, because then=
 it is
>> >>> > clearly not an HID device. However even A2DP has this sort of prob=
lems
>> >>> > sometimes where the stream setup takes time.
>> >>>
>> >>> Makes sense. Thanks for the explanation.
>> >>
>> >> this means you will be working on a patch for this :)
>>
>> Actually, I want to put a patch together for a socket option to not
>> use power_save (so that we *always* exit sniff mode when sending ACL
>> data). We're seeing this problem with the Plantronics Voyager 855
>> which enters sniff mode during A2DP.
>>
>> Given that power_save is just for HID devices, my preferred design is
>> to disable power_save by default, and have an L2CAP socket option to
>> turn on power_save that would be used by HID L2CAP sockets.
>> Unfortunately this would require userspace HID code to use the new
>> socket option to keep current behavior. But it seems preferable to the
>> alternative of having every single other L2CAP socket use a new socket
>> option just to disable power_save for the sake of HID.
>
> actually you still mix up the meaning of the power_save option. From the
> stack side, the automatic sniff mode is off by default. You have to
> enable via sysfs first. The power_save option is just to control when
> sniff mode is activated and the remote enters sniff mode, that we are
> not getting out of it if we have ACL data.
>
> In conclusion, I am fine with a socket option that allows to control
> sniff mode (preferable with interval details) and sniff subrate details
> so that we can use them for that ACL link.
>
> So go ahead and work on this. We can fix userspace easily since a new
> socket can be detected easily with newer kernels.

We have found that some Nokia BT headsets stop working after idle
period when they enter
"power save" mode.

Do we have any solution for this problem? So far I see good enough
patch :-)) below:

http://android.git.kernel.org/?p=3Dkernel/common.git;a=3Dblobdiff;f=3Dnet/b=
luetooth/hci_conn.c;h=3Dfa8b412205cd89546b4a325c558c68040eeaf491;hp=3D0cf25=
114a3f576fc2788a549eb96d0087dd39b44;hb=3Dd8488237646920cd71ef43e5f3ae1001c6=
f4cf7b;hpb=3D3f68e5050c5ae559f56d5da9202cb88928d42b36

-       if (conn->mode !=3D HCI_CM_SNIFF || !conn->power_save)
+       if (conn->mode !=3D HCI_CM_SNIFF /* || !conn->power_save */)

Nick have you done socket option for "power_save"?

Regards,
Andrei
