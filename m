Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120126090028.GA3300@aemeltch-MOBL1>
References: <1327500571-29794-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CAA37ikbfBGGbYfyL1HkL=LGZ4Xyghns699W0eAHKWeuV_7Zw-Q@mail.gmail.com>
	<20120126090028.GA3300@aemeltch-MOBL1>
Date: Thu, 26 Jan 2012 20:30:08 -0200
Message-ID: <CAA37ikY8v2Rtg7_E1doCaYSMsOATukQOqMbcse9Z3j4a2qKPBA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Change chan_ready param from sk to chan
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Jan 26, 2012 at 7:00 AM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> Hi Ulisses,
>
> On Thu, Jan 26, 2012 at 01:04:06AM -0200, Ulisses Furquim wrote:
>> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> >
>> > Change is needed to remove dependency on sk when possible
>> > before introducing l2cap channel lock.
>>
>> What's the overall idea? We used to rely on sk lock for mutual
>> exclusion, right? (please correct me if I'm wrong) I'm seeing some
>> patches from you to change from sk to chan but introducing another
>> lock might shake things a bit so that's why I'm asking for the big
>> picture, if you have thought this through already.
>
> Basically it is known that current implementation of some higher level
> protocols like RFCOMM using kernel sockets is not the right way and shall
> be changed at some point.
>
> I've implemented basic A2MP protocol as a kernel socket and Marcel gave m=
e
> suggestion to move from sockets to internal L2CAP functions.
>
> I've done this and since everything is locked with sk and obviously we do
> not have socket I have to use following constructions:
>
> <------8<-------------------
> | =A0if (sk)
> | =A0 =A0 =A0 =A0 =A0lock_sock(sk)
> | =A0...
> | =A0if(sk)
> | =A0 =A0 =A0 =A0 =A0release_sock(sk)
> |
> <------8<-------------------
>
> which does not look nice and might be racy. Then comes idea to change
> socket lock for L2CAP protocol to e.g. l2cap_channel_{lock,unlock}.

Will you completely change one lock for the other?

> I have code which works but some parts looks like hacks so I try to polis=
h
> it a bit and send as RFC. Please give me comments if you think this might
> be done other way.

Ok, let's see your patch series on that. I haven't thought about it
and seeing your proposal might be good.

Best regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
